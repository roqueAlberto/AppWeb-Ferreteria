
package com.casatrachta.controller;


import com.casatrachta.dao.impl.NotaDAOImpl;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet(name = "NotaController", urlPatterns = {"/anotacion.do"})
public class NotaController extends HttpServlet {

    NotaDAOImpl anotacion_dao = new NotaDAOImpl();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String opcion = request.getParameter("opcion");

            switch (opcion) {

                case "escribir-nota":
                    guardar(request, response);

                    break;

                case "buscar":
                    buscar(request, response);

                    break;

                case "inicio":
                    inicio(request, response);
                    
                    break;

                default:
                    request.getRequestDispatcher("/vistas/otros/Anotacion.jsp").forward(request, response);

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

    /**
     * Este metodo guarda las notas escritas por parte del usuario.
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException 
     */
    
    private void guardar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String nota = request.getParameter("anotacion");
        anotacion_dao.guardar(nota, getFechaActual());

        request.getRequestDispatcher("anotacion.do?opcion=inicio").forward(request, response);
    }

    
    /**
     * Este metodo busca a partir de una fecha establecidas las notas escritas en dicha fecha.
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException 
     */
    
    private void buscar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String fecha = request.getParameter("fecha_obtenida");

        request.setAttribute("anotaciones", anotacion_dao.listar(fecha));
        request.setAttribute("fecha", fecha);
        request.getRequestDispatcher("anotacion.do?opcion=default").forward(request, response);
    }

    
    
    /**
     * Este metodo establece datos de inicio al ingresar al menu de 'Anotar'.
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException 
     */
    private void inicio(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setAttribute("anotaciones", anotacion_dao.listar(getFechaActual()));
        request.setAttribute("fecha", getFechaActual());
        request.getRequestDispatcher("anotacion.do?opcion=default").forward(request, response);

    }
    
    
      private String getFechaActual() {

        Date date = new Date();
        SimpleDateFormat formato = new SimpleDateFormat("YYYY-MM-dd");
        String fecha = formato.format(date);

        return fecha;

    }

}
