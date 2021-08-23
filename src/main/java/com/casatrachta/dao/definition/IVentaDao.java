
package com.casatrachta.dao.definition;

import com.casatrachta.model.DetalleDeVenta;
import com.casatrachta.model.Venta;
import java.util.ArrayList;


public interface IVentaDao {

    public void guardar(Venta venta);
    public String[] totalPorMes();
    public ArrayList<DetalleDeVenta> informeVenta(String fecha); 
    public int[] contarFormasPago(String fecha);
    public String getCierreDeCaja(String fecha);
    public double[] ventasFormaPago(String fecha);
    public String cantidadVentas(String fecha);
    
      

}
