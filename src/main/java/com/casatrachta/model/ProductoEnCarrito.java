
package com.casatrachta.model;

import java.math.BigDecimal;
import java.math.RoundingMode;


public class ProductoEnCarrito extends Producto{
    
    private BigDecimal importe;
    private BigDecimal cantidad;
  

    public ProductoEnCarrito() {}
    
  
    public BigDecimal getImporte() {
        return importe;
    }

    public void setImporte(BigDecimal importe) {     
        importe = importe.setScale(2, RoundingMode.FLOOR);
        this.importe = importe;  
    }

    public BigDecimal getCantidad() {
        return cantidad;
    }

    public void setCantidad(BigDecimal cantidad) {    
        this.cantidad = cantidad;
    }

   
       
    /**
     * Este metodo calcula el importe que tendra el producto dentro de la lista(carrito)
     */
    public void calcularImporte() {           
       this.setImporte(this.getCantidad().multiply(new BigDecimal(this.getPrecio())));     
    }
   
    
     public void actualizarStock(BigDecimal cantidad) {           
        this.setStock(this.getStock().subtract(cantidad)); // restar la cantidad al stock   
    }
     
     public void indicarCantidad() {
         
        if (this.getUnidadMedida() == 1) {
            this.setCantidad(this.getCantidad().setScale(3, RoundingMode.FLOOR)); // cantidad correspondiente a KG         
        } else if (this.getUnidadMedida() == 2) {
             this.setCantidad(this.getCantidad().setScale(2, RoundingMode.FLOOR)); // cantidad correspondiente a METROS         
        }
    }
    
}
