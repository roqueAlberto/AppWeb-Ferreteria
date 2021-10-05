package com.casatrachta.controller;

import com.casatrachta.model.Producto;
import com.casatrachta.dao.impl.ProductoDAOImpl;
import com.casatrachta.dao.impl.SeccionDAOImpl;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
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
                    request.getRequestDispatcher("/views/producto/Nuevo.jsp").forward(request, response);
            }

        }

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

                case "buscar-codigo":
                    buscarPorCodigo(request, response);
                    break;

                case "buscar-producto":
                    buscarProducto(request, response);
                    break;

                case "mostrar":
                    listar(request, response);
                    break;
            }

        }

    
        if (menu.equals("stock")) {

            switch (opcion) {
                case "producto":
                    datosProducto(request, response);
                    break;

                case "modificar":
                    modificar(request, response);
                    break;

                default:
                    request.getRequestDispatcher("/views/producto/ActualizarStock.jsp").forward(request, response);
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

    private void agregar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        boolean productoAgregado;
        try {
            Producto p = new Producto();
            p.setUnidadMedida(Integer.parseInt(request.getParameter("uni_medida")));
            p.setCodigo(request.getParameter("codigo"));
            p.setPrecio(request.getParameter("precio"));
            p.setStock(new BigDecimal(request.getParameter("stock")));
            p.setIdSeccion(Integer.parseInt(request.getParameter("seccion")));
            p.setNombre(request.getParameter("descripcion"));
            p.setFormaVenta(Integer.parseInt(request.getParameter("forma_venta")));

            producto_dao.save(p);

            productoAgregado = true;

        } catch (Exception e) {
            productoAgregado = false;
        }

        PrintWriter out = response.getWriter();
        JSONObject jsProducto = new JSONObject();
        jsProducto.put("agregado", productoAgregado);
        out.print(jsProducto);
        out.close();
    }

    private void nuevaSeccion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String nombre = request.getParameter("seccion");
        seccion_dao.agregar(nombre);
        response.sendRedirect("producto.do?menu=nuevo&opcion=default");
    }

    private void productoSeleccionado(HttpServletRequest request, HttpServletResponse response) throws IOException {

        try (PrintWriter out = response.getWriter()) {

            int id = Integer.parseInt(request.getParameter("id"));

            Producto p = producto_dao.findById(id);

            JSONObject jsProducto = new JSONObject();
            jsProducto.put("id_p", p.getId());
            jsProducto.put("codigo", p.getCodigo());
            jsProducto.put("nombre", p.getNombre());
            jsProducto.put("seccion", p.getIdSeccion());
            jsProducto.put("precio", p.getPrecio());
            jsProducto.put("stock", p.getStock());
            jsProducto.put("forma_venta", p.getFormaVenta());
            jsProducto.put("unidad", p.getUnidadMedida());

            response.addHeader("Access-Control-Allow-Origin", "*");
            response.setCharacterEncoding("utf8");
            response.setContentType("application/json");

            out.print(jsProducto);
        }
    }

    private void actualizar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {

            Producto producto = new Producto();
            producto.setId(Integer.parseInt(request.getParameter("id_producto")));
            producto.setCodigo(request.getParameter("codigo"));
            producto.setNombre(request.getParameter("nombre"));
            producto.setIdSeccion(Integer.parseInt(request.getParameter("seccion")));
            producto.setPrecio(request.getParameter("precio"));
            producto.setStock(new BigDecimal(request.getParameter("stock")));
            producto.setFormaVenta(Integer.parseInt(request.getParameter("formaventa")));
            String uni_medida = request.getParameter("unidades");

            if (uni_medida == null) {
                uni_medida = "3";
            }
            producto.setUnidadMedida(Integer.parseInt(uni_medida));
            producto_dao.update(producto);

        } catch (Exception e) {

        }
       response.sendRedirect("producto.do?menu=lista&opcion=mostrar&pagina=1");
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        producto_dao.delete(Integer.parseInt(request.getParameter("id")));
        response.sendRedirect("producto.do?menu=lista&opcion=mostrar&pagina=1");    
    }


    private void datosProducto(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String codigo = request.getParameter("codigo");

        try (PrintWriter out = response.getWriter()) {

            Producto producto = producto_dao.findByCodigo(codigo);
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

    
    private void modificar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String codigo = request.getParameter("codigo");
        String stock = request.getParameter("stock");
        String unidad = request.getParameter("unidad");

        Producto product = new Producto();
        product.setCodigo(codigo);
        product.setUnidadMedida(Integer.parseInt(unidad));
        product.setStock(new BigDecimal(stock));

        producto_dao.updateStock(product);
        request.getRequestDispatcher("producto.do?menu=actualizar-stock&opcion=default").forward(request, response);
    }

    private void listar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int totalPaginas = producto_dao.countPages();
        int pagina = Integer.parseInt(request.getParameter("pagina"));

        if (pagina == 0) {
            pagina = 1; // queda en la  1º pagina

        } else if (pagina > totalPaginas) {
            pagina = pagina - 1;
        }

        request.setAttribute("resultado", pagina);
        request.setAttribute("pagina", pagina);
        request.setAttribute("listaProductos", producto_dao.list(pagina));
        request.setAttribute("secciones", seccion_dao.listar());
        
        request.setAttribute("totalProductos", producto_dao.totalProducts());
        
        request.getSession().setAttribute("pagina", pagina);
        request.getSession().setAttribute("totalPaginas", totalPaginas);
        request.getRequestDispatcher("/views/producto/Productos.jsp").forward(request, response);

    }

    private void buscarPorCodigo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String codigo = request.getParameter("codigo");
        Producto p = producto_dao.findByCodigo(codigo);

        ArrayList<Producto> lista = new ArrayList<>();

        if (p != null) {            
           lista.add(p);
            
        } else {
            lista  = producto_dao.list(1);        
        }

        request.setAttribute("listaProductos", lista);
        request.setAttribute("secciones", seccion_dao.listar());
        request.setAttribute("totalProductos", producto_dao.totalProducts());
        request.getRequestDispatcher("/views/producto/Productos.jsp").forward(request, response);

    }

    private void buscarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String descripcion = request.getParameter("producto");

        ArrayList<Producto> lista = producto_dao.findByDescripcion(descripcion);
   
        if (lista.isEmpty()) {
              lista = producto_dao.list(1);
        }

        request.setAttribute("listaProductos", lista);
        request.setAttribute("secciones", seccion_dao.listar());
        request.setAttribute("totalProductos", producto_dao.totalProducts());
        request.getRequestDispatcher("/views/producto/Productos.jsp").forward(request, response);
    }

}
