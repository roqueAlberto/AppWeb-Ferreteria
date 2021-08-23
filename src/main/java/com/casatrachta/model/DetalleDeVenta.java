
package com.casatrachta.model;

import java.math.BigDecimal;
import java.math.RoundingMode;


public class DetalleDeVenta {
    
    private long id;
    private String importe;
    private String cantidad;
    private Producto producto;

    public DetalleDeVenta() {
        
    }
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getImporte() {
        return importe;
    }

    public void setImporte(String importe) {
        this.importe = importe;
    }

    public String getCantidad() {
        return cantidad;
    }

    public void setCantidad(String cantidad) {
        this.cantidad = cantidad;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }
    
    
    
    /**
     * Este metodo calcula el importe que tendra el producto dentro de la lista(carrito)
     */
    public void calcularImporte() {
        BigDecimal cantidadDecimal = new BigDecimal(this. cantidad);       
        cantidadDecimal = cantidadDecimal.multiply(new BigDecimal(this.getProducto().getPrecio()));
        cantidadDecimal = cantidadDecimal.setScale(2, RoundingMode.FLOOR);
        this.importe = cantidadDecimal.toString();
    }
    
    
    
    /**
     * Este metodo tiene como objetivo actualizar el stock
     * @param cantidad. Se utiliza para restar al stock actual y asi establecer un nuevo stock. 
     */   
    public void actualizarStock(BigDecimal cantidad) {
        BigDecimal stockProducto = new BigDecimal(this.getProducto().getStock());       
        stockProducto = stockProducto.subtract(cantidad); // restar la cantidad al stock
        this.getProducto().setStock(stockProducto.toString());   
    }
    
}
