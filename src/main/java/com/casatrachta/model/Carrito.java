package com.casatrachta.model;

import java.math.BigDecimal;

import java.util.ArrayList;

import java.util.List;

public class Carrito {
  
    
    private int metodoPago;
    private List<ProductoEnCarrito> productos = new ArrayList();
    private BigDecimal total = new BigDecimal("0.00");

    

    public int getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(int metodoPago) {
        this.metodoPago = metodoPago;
    }

   

    public List<ProductoEnCarrito> getProductos() {
        return productos;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public void agregar(ProductoEnCarrito productoCarrito) {

        int posicion = buscar(productoCarrito.getId());

        if (posicion >= 0) {
            suplantar(posicion, productoCarrito);
        } else {
            nuevo(productoCarrito);
        }

        calcularTotal();
    }

    public int buscar(long id) {
        int iterador = 0;
        int posicion = -1;

        for (ProductoEnCarrito pro : this.getProductos()) {
            if (pro.getId() == id) {
                posicion = iterador;
            }

            iterador++;
        }
        return posicion;
    }

    private void suplantar(int posicion, ProductoEnCarrito productoCarrito) {

        BigDecimal cantidadActual = this.getProductos().get(posicion).getCantidad();
        this.getProductos().get(posicion).calcularImporte();
        this.getProductos().get(posicion).actualizarStock(productoCarrito.getCantidad());
        this.getProductos().get(posicion).setCantidad(cantidadActual.add(productoCarrito.getCantidad()));
    }

    private void nuevo(ProductoEnCarrito productoCarrito) {
        productoCarrito.calcularImporte();
        productoCarrito.actualizarStock(productoCarrito.getCantidad());
        this.getProductos().add(productoCarrito);
    }

    public void quitar(long id) {
        int indice = buscar(id);
        this.setTotal(this.getTotal().subtract(this.getProductos().get(indice).getImporte()));
        this.getProductos().remove(indice);
    }

    public void limpiar() {
        this.getProductos().clear();
        this.total = new BigDecimal("0.00");
    }

    public void calcularTotal() {
        BigDecimal totalDecimal = new BigDecimal("0");

        for (ProductoEnCarrito productoCarrito : this.getProductos()) {
            totalDecimal = totalDecimal.add(productoCarrito.getImporte());
        }

        this.setTotal(totalDecimal);
    }

    public void modificar(ProductoEnCarrito producto, int indice) {     
        
        // 1) Se obtiene el stock total del producto
        BigDecimal cantidad = getProductos().get(indice).getCantidad();
        BigDecimal stock = getProductos().get(indice).getStock();      
        stock = stock.add(cantidad);       
        // 2) Se calcula el nuevo stock apartir de la cantidad elegida por el cliente
        stock = stock.subtract(producto.getCantidad());
        // 3) Se establecen los nuevos datos.
        this.getProductos().get(indice).setCantidad(producto.getCantidad());
        getProductos().get(indice).calcularImporte(); 
        getProductos().get(indice).setStock(stock);
        calcularTotal();
    }

}
