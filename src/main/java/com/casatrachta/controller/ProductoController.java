
package com.casatrachta.controller;

import com.casatrachta.model.Producto;
import com.casatrachta.dao.impl.ProductoDAOImpl;
import com.casatrachta.dao.impl.SeccionDAOImpl;
import com.casatrachta.model.Seccion;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;


@WebServlet(name = "ProductoController", urlPatterns = {"/producto.do"})
public class ProductoController extends HttpServlet {

    private ProductoDAOImpl producto_dao;
    private SeccionDAOImpl seccion_dao;
   

    @Override
    public void init() {      
        producto_dao = new ProductoDAOImpl();
        seccion_dao = new SeccionDAOImpl();
        
    }

 

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

            String menu = request.getParameter("menu");
            String opcion = request.getParameter("opcion");
            
           // menu seleccionado : "Nuevo"
            if (menu.equals("nuevo")) { 

                switch (opcion) {

                    case "agregar":
                        agregar(request, response);
                        break;

                    case "agregar-seccion":

                        nuevaSeccion(request, response);

                        break;

                    default:
                        request.setAttribute("listar_seccion", seccion_dao.listar());
                        request.getRequestDispatcher("/vistas/producto/Nuevo.jsp").forward(request, response);

                }

            }
       
            // menu seleccionado : "Lista de Productos"
            if (menu.equals("lista")) { 

                switch (opcion) {

                    case "editar":
                          productoSeleccionado(request, response);

                        break;

                    case "actualizar":
                          actualizar(request, response);

                        break;

                    case "eliminar":
                          eliminar(request, response);

                        break;
                                                                                      
                     case "mostrar":
                        
                         int pagina;
                         int totalPaginas = producto_dao.totalPaginas();
                         pagina = Integer.parseInt(request.getParameter("pagina"));
                         
                         
                         if(pagina > 0  && pagina <= totalPaginas){                            
                              request.setAttribute("resultado", pagina);
                              request.setAttribute("pagina", pagina);
                              request.setAttribute("listaProductos", producto_dao.listar(pagina));
                              request.setAttribute("lista_seccion", seccion_dao.listar());
                              request.setAttribute("totalProductos", producto_dao.totalProductos());
                         }else if (pagina == 0){ // si la pagina elegida es 0                           
                             pagina = 1; // queda en la  1º pagina
                              request.setAttribute("resultado", pagina);
                              request.setAttribute("pagina", pagina);
                              request.setAttribute("listaProductos", producto_dao.listar(pagina));
                              request.setAttribute("lista_seccion", seccion_dao.listar());
                              request.setAttribute("totalProductos", producto_dao.totalProductos());
                         }else if(pagina > totalPaginas){ // si supera la cantidad total de paginas                            
                             pagina = pagina - 1; // quedar en la ultima pagina.
                              request.setAttribute("resultado", pagina);
                              request.setAttribute("pagina", pagina);
                              request.setAttribute("listaProductos", producto_dao.listar(pagina));
                              request.setAttribute("lista_seccion", seccion_dao.listar());
                              request.setAttribute("totalProductos", producto_dao.totalProductos());
                             
                         }     
                          
                          request.getRequestDispatcher("/vistas/producto/Productos.jsp").forward(request, response);
                        
                        break;              

                }

            }

            // menu seleccionado : "Actualizar Stock"
            if (menu.equals("stock")) { 

                switch (opcion) {

                    case "producto":
                        
                          datosProducto(request, response);

                        break;

                    case "modificar":
                        
                          modificar(request, response);

                        break;
                        
                    default:
                        request.getRequestDispatcher("/vistas/producto/ActualizarStock.jsp").forward(request, response);

                }

            }

       
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String setStockAdecuado(String uni_medida, String stock) {

        if (uni_medida == null) {

            uni_medida = "null";
        }

        String stock_adecuado = "";

        BigDecimal modificado = new BigDecimal(stock);
        switch (uni_medida) {

            case "1":
                modificado = modificado.setScale(3, RoundingMode.FLOOR);
                stock_adecuado = modificado.toString();
                break;

            case "2":
                modificado = modificado.setScale(2, RoundingMode.FLOOR);
                stock_adecuado = modificado.toString();
                break;

            case "null":

                stock_adecuado = stock;

                break;

            case "3":
                stock_adecuado = stock;
                break;

        }

        return stock_adecuado;

    }
    
    
    

    /**
     * Este metodo es utilizado para agregar un nuevo producto y a la vez envia una 
     * respuesta sí el producto fue agregado en la base de dato.
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException 
     */
    
    private void agregar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        
        boolean confirmacion;
        JSONObject jsProducto = new JSONObject();
        
        try {
            Producto p = new Producto(new Seccion());
            p.setUnidadMedida(Integer.parseInt(request.getParameter("uni_medida")));
            p.setCodigo(request.getParameter("codigo"));
            p.setPrecio(request.getParameter("precio"));
            p.setStockAdecuado(request.getParameter("stock"),request.getParameter("uni_medida"));
            p.getSeccion().setId_seccion(Integer.parseInt(request.getParameter("seccion")));
            p.setNombre(request.getParameter("descripcion"));
            p.setFormaVenta(Integer.parseInt(request.getParameter("forma_venta")));
            confirmacion = producto_dao.agregar(p);

        } catch (Exception e) {
            confirmacion = false;
        }
        
        jsProducto.put("agregado", confirmacion);
        out.print(jsProducto);
        out.close();
    }
    
    

    /**
     * Este metodo funciona para agregar una nueva seccion en la base de dato.
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException 
     */
    
    private void nuevaSeccion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String seccion = request.getParameter("seccion");
        
        seccion_dao.agregar(seccion);
        request.getRequestDispatcher("producto.do?menu=nuevo&opcion=default").forward(request, response);
    }

    
    
    /**
     * Este metodo devuelve en formato JSON el producto buscado atraves de su primary key.
     * @param request
     * @param response
     * @throws IOException 
     */
    
    private void productoSeleccionado(HttpServletRequest request, HttpServletResponse response) throws IOException {

        try (PrintWriter out = response.getWriter()) {

            int id = Integer.parseInt(request.getParameter("id"));

            Producto p = producto_dao.obtener(id);

            JSONObject json = new JSONObject();
            json.put("id_p", p.getId());
            json.put("codigo", p.getCodigo());
            json.put("nombre", p.getNombre());
            json.put("seccion", p.getSeccion().getId_seccion());
            json.put("precio", p.getPrecio());
            json.put("stock", p.getStock());
            json.put("forma_venta", p.getFormaVenta());
            json.put("unidad", p.getUnidadMedida());

            response.addHeader("Access-Control-Allow-Origin", "*");
            response.setCharacterEncoding("utf8");
            response.setContentType("application/json");

            out.print(json);
        }
    }
    
    
    
    /**
     * Este metodo actualiza el producto con los datos rellenados por el usuario.
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException 
     */

    private void actualizar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
        Producto producto = new Producto(new Seccion());
        
        try {
            
            
            
            producto.setId(Integer.parseInt(request.getParameter("id_producto")));
            producto.setCodigo(request.getParameter("codigo"));
            producto.setNombre(request.getParameter("nombre"));
            producto.getSeccion().setId_seccion(Integer.parseInt(request.getParameter("seccion")));
            producto.setPrecio(request.getParameter("precio"));
            producto.setStockAdecuado(request.getParameter("stock"), request.getParameter("unidades"));
            producto.setFormaVenta(Integer.parseInt(request.getParameter("formaventa")));

            String uni_medida = request.getParameter("unidades");

            if (uni_medida == null) {
                uni_medida = "3";
            }

            producto.setUnidadMedida(Integer.parseInt(uni_medida));

            producto_dao.actualizar(producto);
        } catch (Exception e) {

            producto = null;
        }

        request.getRequestDispatcher("producto.do?menu=lista-de-productos&opcion=default").forward(request, response);
    }
  

    
    /**
     * Este metodo funciona para eliminar el producto seleccionado.
     * @param request
     * @param response 
     */
    
    private void eliminar(HttpServletRequest request, HttpServletResponse response) {
      
        producto_dao.eliminar(Integer.parseInt(request.getParameter("id")));       
    }

    
    
    
    /**
     * Este metodo trae el producto atraves de su codigo identificativo y lo envia a la vista en formato JSON
     * @param request
     * @param response
     * @throws IOException 
     */
    private void datosProducto(HttpServletRequest request, HttpServletResponse response) throws IOException {
       
        String codigo = request.getParameter("codigo");

        try (PrintWriter out = response.getWriter()) {

            Producto producto = producto_dao.getProducto(codigo);
            
            JSONObject js = new JSONObject();
            js.put("nombre", producto.getNombre());
            js.put("stock", producto.getStock());
            js.put("unidad", producto.getUnidadMedida());

            response.addHeader("Access-Control-Allow-Origin", "*");
            response.setCharacterEncoding("utf8");
            response.setContentType("application/json");

            out.print(js);
        }
    }

    
    
    
    /**
     * Este metodo tiene como objetivo modificar el stock del producto seleccionado.
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException 
     */
    
    private void modificar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String codigo = request.getParameter("codigo");
        String stock = request.getParameter("stock");
        String unidad = request.getParameter("unidad");

        stock = setStockAdecuado(unidad, stock);

        producto_dao.actualizarStock(codigo, stock);

        request.getRequestDispatcher("producto.do?menu=actualizar-stock&opcion=default").forward(request, response);
    }

}
