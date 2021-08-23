
package com.casatrachta.model;

import java.text.SimpleDateFormat;
import java.util.Date;


public class Gasto {

    private String descripcion;
    private String monto;
    private static String fecha;
    
     
    public Gasto() {
               
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
   
    
    public String getMonto() {
        return monto;
    }

    public void setMonto(String monto) {
        this.monto = monto;
    }

    public static String getFecha() {
        Date date = new Date();
        SimpleDateFormat formato_diferente = new SimpleDateFormat("dd-MM-YYYY");
        fecha = formato_diferente.format(date);
        
        return fecha;
    }
    
    

}
