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

    /**
     * Metodo que describe datos acerca de las ventas realizadas.
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException 
     */
    private void verVentas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {      
        request.setAttribute("listaVentas", ventaDao.informeVenta(getFechaActual()));// ventas en la fecha actual 
        request.setAttribute("fecha", getFechaActual()); // fecha actual
        request.setAttribute("total", ventaDao.getCierreDeCaja(getFechaActual())); // total      
        request.setAttribute("cantidadDebito", ventaDao.contarFormasPago(getFechaActual())[1]); // cantidad ventas con tarjeta de debito            
        request.setAttribute("cantidadCredito", ventaDao.contarFormasPago(getFechaActual())[2]); //cantidad ventas con tarjeta de credito
        request.setAttribute("efectivo", ventaDao.ventasFormaPago(getFechaActual())[0]); // total en efectivo                 
        request.setAttribute("debito", ventaDao.ventasFormaPago(getFechaActual())[1]); //total en tarjeta de debito               
        request.setAttribute("credito", ventaDao.ventasFormaPago(getFechaActual())[2]); //total en tarjeta de credito
        request.getRequestDispatcher("/vistas/venta/RegistroVenta.jsp").forward(request, response);       
    }
    
    
   
    /**
     * Metodo que informa el total recaudado en cada mes del año.
     * @param response
     * @throws IOException 
     */
    private void getMeses(HttpServletResponse response) throws IOException {

        try (PrintWriter out = response.getWriter()) {

            String[] mes = ventaDao.totalPorMes();

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

    
    /**
     * Este metodo brinda informacion de distintas elementos.
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException 
     */
    private void getInformacion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("totalCaja", ventaDao.getCierreDeCaja(getFechaActual()));
        request.setAttribute("totalGasto", gastoDao.establecerTotal(getFechaActual()));
        request.setAttribute("notas", notaDao.getCantidad(getFechaActual()));
        request.setAttribute("listaLimitada", productoDao.listarStockBajo("LIMITADO"));
        request.setAttribute("listaCompleta", productoDao.listarStockBajo("COMPLETO"));
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }


    /**
     * Metodo para buscar las ventas realizadas en la fecha indicada
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException 
     */
    private void buscar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String fechaSeleccionada = request.getParameter("buscarVenta");
        request.setAttribute("listaVentas", ventaDao.informeVenta(fechaSeleccionada));// ventas en la fecha actual 
        request.setAttribute("fecha", fechaSeleccionada); // fecha actual
        request.setAttribute("total", ventaDao.getCierreDeCaja(fechaSeleccionada)); // total      
        request.setAttribute("cantidadDebito", ventaDao.contarFormasPago(fechaSeleccionada)[1]); // cantidad ventas con tarjeta de debito            
        request.setAttribute("cantidadCredito", ventaDao.contarFormasPago(fechaSeleccionada)[2]); //cantidad ventas con tarjeta de credito
        request.setAttribute("efectivo", ventaDao.ventasFormaPago(fechaSeleccionada)[0]); // total en efectivo                 
        request.setAttribute("debito", ventaDao.ventasFormaPago(fechaSeleccionada)[1]); //total en tarjeta de debito               
        request.setAttribute("credito", ventaDao.ventasFormaPago(fechaSeleccionada)[2]); //total en tarjeta de credito
        request.getRequestDispatcher("/vistas/venta/RegistroVenta.jsp").forward(request, response); 
        request.getRequestDispatcher("vistas/venta/RegistroVenta.jsp").forward(request, response);
    }

    /**
     * Esta función devuelve la fecha actual
     * @return - fecha actual
     */
    private String getFechaActual() {
        Date date = new Date();
        SimpleDateFormat formato = new SimpleDateFormat("YYYY-MM-dd");
        String fecha = formato.format(date);
        return fecha;
    }

}
