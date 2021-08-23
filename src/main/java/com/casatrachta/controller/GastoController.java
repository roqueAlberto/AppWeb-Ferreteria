package com.casatrachta.controller;

import com.casatrachta.dao.impl.GastoDAOImpl;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "GastoController", urlPatterns = {"/gasto.do"})
public class GastoController extends HttpServlet {

    private GastoDAOImpl gastoDao;

    @Override
    public void init() {
        gastoDao = new GastoDAOImpl();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
            String opcion = request.getParameter("opcion");

            switch (opcion) {

                case "GuardarGasto":
                    guardarGasto(request, response);
                    break;

                case "Buscar":
                    buscarGasto(request, response);
                    break;

                case "consumos":
                    informacion(request, response);
                    break;

                default:
                    request.getRequestDispatcher("/vistas/otros/Gasto.jsp").forward(request, response);

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
     * Este metodo guarda los gastos realizados por parte del usuario    
     */
    private void guardarGasto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String descripcion = request.getParameter("descripcion");
        int monto = Integer.parseInt(request.getParameter("monto"));
        gastoDao.insertar(descripcion, monto, getFechaActual());
        request.getRequestDispatcher("gasto.do?opcion=consumos").forward(request, response);
    }
    
    
    /**
      Este metodo brinda información acerca de los gastos, su monto y la fecha en que se realizo
     */
    private void informacion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("gastos", gastoDao.listarGastos(getFechaActual()));//listar los gastos del día
        request.setAttribute("fecha", getFechaActual()); // envio fecha actual             
        request.setAttribute("total", gastoDao.establecerTotal(getFechaActual())); // monto total de gastos
        request.getRequestDispatcher("gasto.do?opcion=default").forward(request, response);

    }

    
    /**
     * Este metodo busca y devuelve los gastos realizados en la fecha seleccionada 
     */
    private void buscarGasto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fecha = request.getParameter("fecha_seleccionada");
        request.setAttribute("fecha", fecha);
        request.setAttribute("gastos", gastoDao.listarGastos(fecha));
        request.setAttribute("total", gastoDao.establecerTotal(fecha));
        request.getRequestDispatcher("gasto.do?opcion=default").forward(request, response);

    }

    private String getFechaActual() {
        Date date = new Date();
        SimpleDateFormat formato = new SimpleDateFormat("YYYY-MM-dd");
        String fecha = formato.format(date);
        return fecha;

    }

}
