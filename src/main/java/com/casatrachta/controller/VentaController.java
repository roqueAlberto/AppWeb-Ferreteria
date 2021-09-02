package com.casatrachta.controller;

import com.casatrachta.model.Producto;
import com.casatrachta.dao.impl.ProductoDAOImpl;
import com.casatrachta.model.Venta;
import com.casatrachta.dao.impl.VentaDAOImpl;
import com.casatrachta.model.DetalleDeVenta;
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
    private Venta venta;
    private Producto producto;

    @Override
    public void init() {
        producto = new Producto();
        productoDao = new ProductoDAOImpl();
        ventaDao = new VentaDAOImpl();
        venta = new Venta();
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

                default:
                    request.setAttribute("listaProductos", venta.getListaProductos());
                    request.setAttribute("total_p", venta.getTotal());
                    request.getRequestDispatcher("/vistas/venta/RealizarVenta.jsp").forward(request, response);

            }

        
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

    
    
    /**
     * Este metodo busca el producto dentro de la base de datos y lo devuelve en
     * formato JSON
     *
     * @param request
     * @param response
     * @throws IOException
     */
    private void buscar(HttpServletRequest request, HttpServletResponse response) throws IOException {

        try (PrintWriter out = response.getWriter()) {

            JSONObject js = new JSONObject();
            int indice;
            String stockP;

            String codigo = request.getParameter("codigo");
            producto = productoDao.getProducto(codigo);
            
            indice = venta.buscar(producto.getId());
            
            if(indice != -1)
                
                  stockP = venta.getListaProductos().get(indice).getProducto().getStock();
            
            else
                stockP = producto.getStock();

            if (producto != null) // Si el producto existe..s
            {
                js.put("producto", true);
                js.put("stock", stockP);
                js.put("forma_de_venta", producto.getFormaVenta());
            } else {
                js.put("producto", false);
                js.put("stock", 0);
                js.put("forma_de_venta", 0);

            }

            out.print(js);

        }
    }

    /**
     * Una vez encontrado el producto, este metodo se ejecuta para agregar a la
     * lista del carrito
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    private void agregar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cantidadElegida = request.getParameter("cantidad");
        BigDecimal cantidad = venta.indicarCantidad(cantidadElegida, producto.getUnidadMedida());

        DetalleDeVenta detalleProducto = new DetalleDeVenta();
        detalleProducto.setCantidad(cantidad.toString());
        detalleProducto.setProducto(producto);

        venta.agregar(detalleProducto);
        request.getRequestDispatcher("venta.do?opcion=default").forward(request, response);
    }
    
    

    /**
     * Este metodo funciona para guardar la venta que se realizo.
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    private void generarVenta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // sí la lista de productos contiene al menos un elemento o más, guardar los datos
        if (!venta.getListaProductos().isEmpty()) {
            int forma_pago = Integer.parseInt(request.getParameter("forma_pago"));
            venta.setMetodoPago(forma_pago);

            // asignar la lista de productos del carrito
            ventaDao.guardar(venta);
            venta.limpiar();
        }

        request.getRequestDispatcher("venta.do?opcion=default").forward(request, response);
    }

    /**
     * Este metodo quita el producto dentro de la lista
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    private void quitar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        long id = Long.parseLong(request.getParameter("id"));
        venta.quitar(id);
        request.getRequestDispatcher("venta.do?opcion=default").forward(request, response);
    }

    /**
     * Este metodo imprime la cantidad del producto seleccionado
     *
     * @param request
     * @param response
     * @throws IOException
     */
    private void leerCantidad(HttpServletRequest request, HttpServletResponse response) throws IOException {

        try (PrintWriter out = response.getWriter()) {

            int id = Integer.parseInt(request.getParameter("id"));

            int posicion = venta.buscar(id);

            String cantidad = venta.getListaProductos().get(posicion).getCantidad();
            int uni_medida = venta.getListaProductos().get(posicion).getProducto().getUnidadMedida();
            String stock = venta.getListaProductos().get(posicion).getProducto().getStock();

            JSONObject jsCantidad = new JSONObject();
            jsCantidad.put("cantidad", cantidad);
            jsCantidad.put("unidad_medida", uni_medida);
            jsCantidad.put("stock_disponible", stock);
            response.addHeader("Access-Control-Allow-Origin", "*");
            response.setCharacterEncoding("utf8");
            response.setContentType("application/json");

            out.print(jsCantidad);

        }

    }

    /**
     * Este metodo modifica el producto seleccionado
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    private void modificar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));       
        String cantidad = request.getParameter("cantidad");
        int unidadMedida = Integer.parseInt(request.getParameter("unidad_medida"));
        
        int indice = venta.buscar(id);
        venta.modificar(indice, cantidad, unidadMedida);

        request.getRequestDispatcher("venta.do?opcion=default").forward(request, response);
    }

}
