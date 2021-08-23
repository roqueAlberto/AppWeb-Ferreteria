
package com.casatrachta.model;

import java.text.SimpleDateFormat;
import java.util.Date;


public class Nota {
    
    private String descripcion;
    private static String fecha;

    public Nota() {
        
    }
    
    
    

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
     
    public static String fecha() {
        Date date = new Date();
        SimpleDateFormat formato_diferente = new SimpleDateFormat("dd-MM-YYYY");
        fecha = formato_diferente.format(date);
        
        return fecha;
    }
    
}
