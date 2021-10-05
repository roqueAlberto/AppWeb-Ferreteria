
package com.casatrachta.dao.definition;

import com.casatrachta.model.ProductoEnCarrito;
import com.casatrachta.model.Carrito;
import java.util.ArrayList;


public interface IVentaDao {

    public void save(Carrito venta);
    public int[] countPayments(String fecha);
    public String[] totalForMonth();
    public ArrayList<ProductoEnCarrito> report(String fecha);   
    public String closeSale(String fecha);
    public double[] salePayments(String fecha);
    public String countSales(String fecha);
    
      

}
