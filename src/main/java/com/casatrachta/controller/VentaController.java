package com.casatrachta.controller;

import com.casatrachta.dao.impl.ProductoDAOImpl;
import com.casatrachta.model.Carrito;
import com.casatrachta.dao.impl.VentaDAOImpl;
import com.casatrachta.model.ProductoEnCarrito;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

@WebServlet(name = "VentaController", urlPatterns = {"/venta.do"})
public class VentaController extends HttpServlet {

    private ProductoDAOImpl productoDao;
    private VentaDAOImpl ventaDao;
    private Carrito carrito;
    private ProductoEnCarrito producto;

    @Override
    public void init() {
        producto = new ProductoEnCarrito();
        productoDao = new ProductoDAOImpl();
        ventaDao = new VentaDAOImpl();
        carrito = new Carrito();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
      
            String opcion = request.getParameter("opcion");

            switch (opcion) {
                case "buscar":
                    buscar(request, response);
                    break;

                case "agregar":
                    agregar(request, response);
                    break;

                case "vender":
                    generarVenta(request, response);
                    break;

                case "quitar":
                    quitar(request, response);
                    break;

                case "leer":
                    leerCantidad(request, response);
                    break;

                case "modificar":
                    modificar(request, response);
                    break;
                    
                case "prueba":                   
                    response.sendRedirect("informe.do?opcion=inicio");                   
                    break;

                default:
                    request.setAttribute("listaProductos", carrito.getProductos());
                    request.setAttribute("total_p", carrito.getTotal());
                    request.getRequestDispatcher("/views/venta/RealizarVenta.jsp").forward(request, response);
            }      
    }
  
    private void buscar(HttpServletRequest request, HttpServletResponse response) throws IOException {

        try (PrintWriter out = response.getWriter()) {
            BigDecimal stockProducto;
            String codigo = request.getParameter("codigo");
            producto = productoDao.findByCodigo(codigo);
            
            int indice = carrito.buscar(producto.getId()); // 1)Buscar si el producto ya se encuentra en el carrito  
            if (indice<0) {                             // 2)
                 stockProducto = producto.getStock(); //  Si el producto no se encuentra, capturar el stock del nuevo producto agregado
            }else{
                stockProducto = carrito.getProductos().get(indice).getStock();  // Si se encuentra, capturar el stock actual que tiene el producto dentro del carrito. 
            }
            
                   
            JSONObject js = new JSONObject(); 
            
            
            if (producto != null) // Si el producto existe..s
            {
                js.put("producto", true);
                js.put("stock", stockProducto);
                js.put("forma_de_venta", producto.getFormaVenta());
            } else {
                js.put("producto", false);
                js.put("stock", 0);
                js.put("forma_de_venta", 0);

            }

            out.print(js);

        }
    }

 
    private void agregar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String cantidadElegida = request.getParameter("cantidad");
  

        producto.setCantidad(new BigDecimal(cantidadElegida));
        producto.indicarCantidad();
        
        carrito.agregar(producto);
        
        request.getSession().setAttribute("mensaje", "Producto agregado con exito");
        response.sendRedirect("venta.do?opcion=default");
       
    }
    
   
    private void generarVenta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
        if (!carrito.getProductos().isEmpty()) {
            int forma_pago = Integer.parseInt(request.getParameter("forma_pago"));
            carrito.setMetodoPago(forma_pago); 
            ventaDao.save(carrito);
            carrito.limpiar();
        }

       response.sendRedirect("venta.do?opcion=default");
    }

 
    private void quitar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long id = Long.parseLong(request.getParameter("id"));
        carrito.quitar(id);
        response.sendRedirect("venta.do?opcion=default");
    }

  
    private void leerCantidad(HttpServletRequest request, HttpServletResponse response) throws IOException {

        try (PrintWriter out = response.getWriter()) {

            int id = Integer.parseInt(request.getParameter("id"));
            int indice = carrito.buscar(id);

            ProductoEnCarrito pro = carrito.getProductos().get(indice);
           
            JSONObject jsCantidad = new JSONObject();
            jsCantidad.put("cantidad", pro.getCantidad());
            jsCantidad.put("unidad_medida", pro.getUnidadMedida());
            jsCantidad.put("stock_disponible", pro.getStock());
            response.addHeader("Access-Control-Allow-Origin", "*");
            response.setCharacterEncoding("utf8");
            response.setContentType("application/json");
            out.print(jsCantidad);
        }

    }

    
    
    private void modificar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));       
        String cantidad = request.getParameter("cantidad");
        int unidadMedida = Integer.parseInt(request.getParameter("unidad_medida"));
        
        ProductoEnCarrito productoCarrito = new ProductoEnCarrito();
        productoCarrito.setId(id);
        productoCarrito.setUnidadMedida(unidadMedida);
        productoCarrito.setCantidad(new BigDecimal(cantidad));
        productoCarrito.indicarCantidad();
              
        
        int indice = carrito.buscar(id);
        carrito.modificar(productoCarrito,indice);

        response.sendRedirect("venta.do?opcion=default");
    }

     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
    
}
