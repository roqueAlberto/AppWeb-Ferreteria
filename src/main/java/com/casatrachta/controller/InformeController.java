package com.casatrachta.controller;

import com.casatrachta.config.Conexion;

import com.casatrachta.dao.impl.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

@WebServlet(name = "InformeController", urlPatterns = {"/informe.do"})
public class InformeController extends HttpServlet {

    private ProductoDAOImpl productoDao;
    private VentaDAOImpl ventaDao;
    private GastoDAOImpl gastoDao;
    private NotaDAOImpl notaDao;

    @Override
    public void init() {
        ventaDao = new VentaDAOImpl();
        gastoDao = new GastoDAOImpl();
        productoDao = new ProductoDAOImpl();
        notaDao = new NotaDAOImpl();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String opcion = request.getParameter("opcion");
        
        try (PrintWriter out = response.getWriter()) {
            
            switch (opcion) {
                case "registros-ventas":                  
                    verVentas(request, response);
                    break;

                case "ventas-por-mes":
                    getMeses(response);                  
                    break;

                case "inicio":                   
                    getInformacion(request, response);
                    break;

                case "ventas-por-fecha":
                    buscar(request, response);                   
                    break;

                case "backupDataBase":
                    boolean databaseSave = Conexion.backup();
                    JSONObject respuesta = new JSONObject();
                    respuesta.put("backup", databaseSave);
                    out.print(respuesta);
                    out.close();
                    break;

                default:
                    request.getRequestDispatcher("/index.jsp").forward(request, response);
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

   
    private void verVentas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {      
        request.setAttribute("listaVentas", ventaDao.report(getFechaActual()));// ventas en la fecha actual 
        request.setAttribute("fecha", getFechaActual()); // fecha actual
        request.setAttribute("total", ventaDao.closeSale(getFechaActual())); // total      
        request.setAttribute("cantidadDebito", ventaDao.countPayments(getFechaActual())[1]); // cantidad ventas con tarjeta de debito            
        request.setAttribute("cantidadCredito", ventaDao.countPayments(getFechaActual())[2]); //cantidad ventas con tarjeta de credito
        request.setAttribute("efectivo", ventaDao.salePayments(getFechaActual())[0]); // total en efectivo                 
        request.setAttribute("debito", ventaDao.salePayments(getFechaActual())[1]); //total en tarjeta de debito               
        request.setAttribute("credito", ventaDao.salePayments(getFechaActual())[2]); //total en tarjeta de credito
        request.getRequestDispatcher("/vistas/venta/RegistroVenta.jsp").forward(request, response);       
    }
    
  
    private void getMeses(HttpServletResponse response) throws IOException {

        try (PrintWriter out = response.getWriter()) {

            String[] mes = ventaDao.totalForMonth();

            JSONObject jInforme = new JSONObject();           
            jInforme.put("enero", mes[0]);
            jInforme.put("febrero", mes[1]);
            jInforme.put("marzo", mes[2]);
            jInforme.put("abril", mes[3]);
            jInforme.put("mayo", mes[4]);
            jInforme.put("junio", mes[5]);
            jInforme.put("julio", mes[6]);
            jInforme.put("agosto", mes[7]);
            jInforme.put("septiembre", mes[8]);
            jInforme.put("octubre", mes[9]);
            jInforme.put("noviembre", mes[10]);
            jInforme.put("diciembre", mes[11]);
            out.print(jInforme);
        }
    }

  
    private void getInformacion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("totalCaja", ventaDao.closeSale(getFechaActual()));
        request.setAttribute("totalGasto", gastoDao.establecerTotal(getFechaActual()));
        request.setAttribute("notas", notaDao.getCantidad(getFechaActual()));
        request.setAttribute("listaLimitada", productoDao.allStockDown("LIMITADO"));
        request.setAttribute("listaCompleta", productoDao.allStockDown("COMPLETO"));
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }


    private void buscar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String fechaSeleccionada = request.getParameter("buscarVenta");
        request.setAttribute("listaVentas", ventaDao.report(fechaSeleccionada));// ventas en la fecha actual 
        request.setAttribute("fecha", fechaSeleccionada); // fecha actual
        request.setAttribute("total", ventaDao.closeSale(fechaSeleccionada)); // total      
        request.setAttribute("cantidadDebito", ventaDao.countPayments(fechaSeleccionada)[1]); // cantidad ventas con tarjeta de debito            
        request.setAttribute("cantidadCredito", ventaDao.countPayments(fechaSeleccionada)[2]); //cantidad ventas con tarjeta de credito
        request.setAttribute("efectivo", ventaDao.salePayments(fechaSeleccionada)[0]); // total en efectivo                 
        request.setAttribute("debito", ventaDao.salePayments(fechaSeleccionada)[1]); //total en tarjeta de debito               
        request.setAttribute("credito", ventaDao.salePayments(fechaSeleccionada)[2]); //total en tarjeta de credito
        request.getRequestDispatcher("/views/venta/RegistroVenta.jsp").forward(request, response); 
        request.getRequestDispatcher("views/venta/RegistroVenta.jsp").forward(request, response);
    }

   
    private String getFechaActual() {
        Date date = new Date();
        SimpleDateFormat formato = new SimpleDateFormat("YYYY-MM-dd");
        String fecha = formato.format(date);
        return fecha;
    }

}
