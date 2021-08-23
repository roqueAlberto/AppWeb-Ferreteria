package com.casatrachta.model;

import java.math.BigDecimal;
import java.math.RoundingMode;


public class Producto {

    private long id;
    private String codigo;
    private String nombre;
    private String precio;
    private String stock;
    private int formaVenta;
    private String stockOriginal;
    private int unidadMedida;
    private Seccion seccion;

    public Producto() {
        
    }

    public Producto(Seccion seccion) {
        this.seccion = seccion;
    }
       
    public int getUnidadMedida() {
        return unidadMedida;
    }

    public void setUnidadMedida(int unidadMedida) {
        this.unidadMedida = unidadMedida;
    }

    public String getStockOriginal() {
        return stockOriginal;
    }

    public void setStockOriginal(String stockOriginal) {
        this.stockOriginal = stockOriginal;
    }
   
    public int getFormaVenta() {
        return formaVenta;
    }

    public void setFormaVenta(int formaVenta) {
        this.formaVenta = formaVenta;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPrecio() {
        return precio;
    }

    public void setPrecio(String precio) {
        this.precio = precio;
    }

    public String getStock() {
        return stock;
    }

    public void setStock(String stock) {
        this.stock = stock;
    }
    
    public Seccion getSeccion() {
        return seccion;
    }

    public void setSeccion(Seccion seccion) {
        this.seccion = seccion;
    }
    
    
    public void setStockAdecuado(String uni_medida, String stock) {
        if (uni_medida == null) 
            uni_medida = "null";
        
        BigDecimal modificado = new BigDecimal(stock);
        switch (uni_medida) {

            case "1":
                modificado = modificado.setScale(3, RoundingMode.FLOOR);
                this.stock = modificado.toString();
                break;
            case "2":
                modificado = modificado.setScale(2, RoundingMode.FLOOR);
                this.stock = modificado.toString();
                break;
            case "null":
                this.stock = stock;
                break;
            case "3":
                this.stock = stock;
                break;
        }
     
    }
    


}
