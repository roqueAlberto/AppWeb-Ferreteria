package com.casatrachta.model;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class Producto {

    private long id;
    private String codigo;
    private String nombre;
    private String precio;
    private BigDecimal stock;
    private int formaVenta;
    private int unidadMedida;
    private Seccion seccion;
    private int idSeccion;

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

    public BigDecimal getStock() {
        return stock;
    }

    public void setStock(BigDecimal stock) {
        this.stock = stock;
        stockCorrespondiente();
        
    }

    public Seccion getSeccion() {
        return seccion;
    }

    public void setSeccion(Seccion seccion) {
        this.seccion = seccion;
    }

    private void stockCorrespondiente() {
        int unidad = this.getUnidadMedida();
        
        if (unidad == 1) {
            this.stock = this.stock.setScale(3, RoundingMode.FLOOR);
        } else if (unidad == 2) {
            this.stock = this.stock.setScale(2, RoundingMode.FLOOR);
        }

    }

    public int getIdSeccion() {
        return idSeccion;
    }

    public void setIdSeccion(int idSeccion) {
        this.idSeccion = idSeccion;
    }

    


}
