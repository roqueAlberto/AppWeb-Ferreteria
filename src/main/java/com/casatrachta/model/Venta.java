package com.casatrachta.model;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class Venta {

    private long id;
    private static String fecha;
    private int metodoPago;
    private List<DetalleDeVenta> listaProductos = new ArrayList();
    private String total = "0.00";

    public Venta() {

    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(int metodoPago) {
        this.metodoPago = metodoPago;
    }

    public static String getFecha() {
        Date date = new Date();
        SimpleDateFormat formato = new SimpleDateFormat("YYYY-MM-dd");
        fecha = formato.format(date);
        
        return fecha;
    }

    public List<DetalleDeVenta> getListaProductos() {
        return listaProductos;
    }

    public void setListaProductos(List<DetalleDeVenta> listaProductos) {
        this.listaProductos = listaProductos;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }
    
    
    /**
     * Este metodo funciona para agregar o reemplazar un producto en la lista
     * @param detalle. Es el elegido por el cliente y que se agregara o reemplazara en la lista
     */
    
    public void agregar(DetalleDeVenta detalle) {
     // se verifica si el producto ya aparece en la lista 
     int posicion = buscar(detalle.getProducto().getId());    
     // si el producto traido ya esta en la lista del carrito,reemplazar
     if (posicion >= 0)                 
           suplantar(posicion, detalle);
    // si no está, agregarlo
        else                         
            agregarNuevo(detalle);
     
      calcularTotal();     
    }
    
    
    
    /**
     * Esta función devuelve la posicion en la que se encuentra el producto en la lista, si no se encuentra
     * devuelve -1.
     * @param id. Se utiliza para comparar cada id del producto al reccorer la lista.
     * @return int. La posicion
     */
    public int buscar(long id) {      
        int posicion = -1;
        
        for (int i = 0; i < listaProductos.size(); i++) {
            if (listaProductos.get(i).getProducto().getId() == id) {
                posicion = i;
            }
        }
        return posicion;
    }
    
    
    
    /**
     * Este metodo funciona para reemplezar los datos del producto en la lista.
     * Modificando su cantidad, stock e importe.
     * @param posicion. Es el indice donde se encuentra el producto a reemplazar dentro de la lista.
     * @param detalle. Es el producto que contiene los datos a reemplazar.
     */  
    private void suplantar(int posicion, DetalleDeVenta detalle) {
        BigDecimal cantidadActual = new BigDecimal(listaProductos.get(posicion).getCantidad());
        cantidadActual = cantidadActual.add(new BigDecimal(detalle.getCantidad())); //sumar la cantidad
        listaProductos.get(posicion).setCantidad(cantidadActual.toString());                   
        listaProductos.get(posicion).calcularImporte();
        listaProductos.get(posicion).actualizarStock(new BigDecimal(detalle.getCantidad()));
    }

    
    
    /**
     * Este metodo permite agregar un nuevo producto dentro de la lista.
     * @param detalle. Es el producto que sera agregado.
     */ 
    public void agregarNuevo(DetalleDeVenta detalle) { 
        detalle.calcularImporte();
        detalle.actualizarStock(new BigDecimal(detalle.getCantidad()));
        listaProductos.add(detalle);   
    }
    

    
    /**
     * Esta funcion permite la facilidad de calcular la cantidad correspondiente del producto elegido
     * por parte del cliente.
     * @param cantidadProducto. Es la cantidad elegida, que sera modificada de acuerdo a su unidad de medida.
     * @param unidadMedida. Es la unidad de medida a la que corresponde el producto. 
     * @return bigDecimal. Retorna la cantidad modificada
     */  
    public BigDecimal indicarCantidad(String cantidadProducto, int unidadMedida) {
        BigDecimal cantidad = new BigDecimal(cantidadProducto);
      
        if(unidadMedida == 1)          
            cantidad = cantidad.setScale(3, RoundingMode.FLOOR); // cantidad correspondiente a KG         
        else if(unidadMedida == 2)
             cantidad = cantidad.setScale(2, RoundingMode.FLOOR); // cantidad correspondiente a METROS         
                           
        return cantidad;
    }
    

    
    /**
     * Este metodo permite eliminar o quitar el producto dentro de la lista.
     * @param id. Se utiliza para buscar el producto dentro de la lista.
     */
    public void quitar(long id) {
        int indice = buscar(id);
        BigDecimal totalDecimal = new BigDecimal(this.total);                   
        totalDecimal = totalDecimal.subtract(new BigDecimal(listaProductos.get(indice).getImporte()));
        this.total = totalDecimal.toString();     
        listaProductos.remove(indice);       
    }
    
    
    
    /**
     * Este metodo se utiliza para borrar todos los datos de la lista y reestablecer el total a 0.
     */
    public void limpiar() {
        this.listaProductos.clear();
        this.total = "0.00";
    }

    
    
     public void calcularTotal() {         
        BigDecimal totalDecimal = new BigDecimal("0");
        // recorremos la lista capturando el importe de cada producto para sumar al total
        for (DetalleDeVenta detalle_venta : listaProductos) 
            totalDecimal = totalDecimal.add(new BigDecimal(detalle_venta.getImporte()));   
        this.total = totalDecimal.toString();
    }

      
     
      /**
       * Este metodo tiene como objetivo modificar la cantidad, el stcok y el importe del producto elegido
       * dentro de la lista.
       * @param indice. Es la posicion en donde se encuentra el producto dentro de la lista.
       * @param cantidadModificada. Es la cantidad que se modificara.
       */  
      public void modificar(int indice, String cantidadModificada, int unidadMedida) {
        BigDecimal cantidad = indicarCantidad(cantidadModificada, unidadMedida);
        //actualizamos la cantidad y el importe del producto
        listaProductos.get(indice).setCantidad(cantidad.toString());           
        listaProductos.get(indice).calcularImporte();
        //actualizamos el stock 
        BigDecimal stock = new BigDecimal(listaProductos.get(indice).getProducto().getStockOriginal());
        stock = stock.subtract(cantidad);
        listaProductos.get(indice).getProducto().setStock(stock.toString()); 
        //calculamos el total.
        calcularTotal();
    }

}
