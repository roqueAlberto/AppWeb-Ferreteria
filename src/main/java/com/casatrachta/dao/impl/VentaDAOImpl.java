package com.casatrachta.dao.impl;

import com.casatrachta.dao.definition.IVentaDao;
import com.casatrachta.model.Venta;
import com.casatrachta.config.Conexion;
import com.casatrachta.model.DetalleDeVenta;
import com.casatrachta.model.Producto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class VentaDAOImpl implements IVentaDao {

    private Connection connection;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    
    /**
     * Este metodo guarda la venta realizada en la base de datos
     * @param venta - es la venta que se guardara
     */    
    @Override
    public void guardar(Venta venta) {
        PreparedStatement preparedStatementVenta = null;
        PreparedStatement preparedStatementUltimaVenta = null;
        PreparedStatement preparedStatementDetalleVenta = null;
        PreparedStatement preparedStatementActualizar = null;

        long id_venta = 0;

        try {
            connection = Conexion.getConexion();
            connection.setAutoCommit(false);

            // guardar datos de la venta
            preparedStatementVenta = connection.prepareStatement("INSERT INTO venta(fecha,total,formaPago_id)"
                                                                 + "VALUES (?,?,?)");
            preparedStatementVenta.setString(1, Venta.getFecha());
            preparedStatementVenta.setString(2, venta.getTotal());
            preparedStatementVenta.setInt(3, venta.getMetodoPago());
            preparedStatementVenta.executeUpdate();

            // 1- Obtener el ultimo registro de venta
            preparedStatementUltimaVenta = connection.prepareStatement("SELECT id_venta FROM venta"
                                                                      + " GROUP BY id_venta DESC LIMIT 1");
            resultSet = preparedStatementUltimaVenta.executeQuery();

            if (resultSet.next()) {
                id_venta = resultSet.getLong(1);
            }

            // 2- Guardar todos los datos en la tabla descripcion venta.
            for (int i = 0; i < venta.getListaProductos().size(); i++) {

                preparedStatementDetalleVenta = connection.prepareStatement("INSERT INTO descripcion_venta"
                                                                       + "(venta_id,producto_id,cantidad,importe) "
                                                                       + "values (?,?,?,?)");
                preparedStatementDetalleVenta.setLong(1, id_venta);
                preparedStatementDetalleVenta.setLong(2, venta.getListaProductos().get(i).getProducto().getId());
                preparedStatementDetalleVenta.setString(3, venta.getListaProductos().get(i).getCantidad());
                preparedStatementDetalleVenta.setString(4, venta.getListaProductos().get(i).getImporte());
                preparedStatementDetalleVenta.executeUpdate();

            }

            // 3- Actualizar stock
            for (int j = 0; j < venta.getListaProductos().size(); j++) {
                preparedStatementActualizar = connection.prepareStatement("UPDATE producto SET stock = ? WHERE id_producto = ?");
                preparedStatementActualizar.setString(1, venta.getListaProductos().get(j).getProducto().getStock());
                preparedStatementActualizar.setLong(2, venta.getListaProductos().get(j).getProducto().getId());
                preparedStatementActualizar.executeUpdate();
            }

            connection.commit();

        } catch (SQLException e) {

            try {
                connection.rollback();
            } catch (SQLException error) {

            }

        } finally {

            try {
                resultSet.close();
                preparedStatementVenta.close();
                preparedStatementUltimaVenta.close();
                preparedStatementDetalleVenta.close();
                preparedStatementActualizar.close();
                Conexion.closeConexion(connection);
            } catch (Exception er) {

            }

        }

    }
    
    
    /**
     * Esta función lista todas las ventas que se realizaron en la fecha seleccionada.
     * @param fecha - es la fecha elegida por parte del usuario
     * @return List - devuelve una lista con todas las ventas realizadas en la jordana seleccionada.
     */   
    @Override
    public ArrayList<DetalleDeVenta> informeVenta(String fecha) {

        String sql = "SELECT d.id_descripcionVenta,p.nombre,d.cantidad,d.importe  "
                + "FROM producto p,descripcion_venta d,venta v "
                + " WHERE p.id_producto = d.producto_id AND d.venta_id = v.id_venta "
                + "AND v.fecha = ?";

        Venta venta = new Venta();
        DetalleDeVenta detalle;       
        Producto producto;

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, fecha);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {             
                detalle = new DetalleDeVenta();
                producto = new Producto();               
                detalle.setId(resultSet.getInt(1));
                producto.setNombre(resultSet.getString(2));
                detalle.setCantidad(resultSet.getString(3));
                detalle.setImporte(resultSet.getString(4));
                detalle.setProducto(producto);
                
                venta.getListaProductos().add(detalle);
            }

        } catch (SQLException e) {
            
        } finally {

            try {
                preparedStatement.close();
                resultSet.close();
                Conexion.closeConexion(connection);
            } catch (SQLException e) {

            }
        }
        return (ArrayList)venta.getListaProductos();
    }

 

    /**
     *  Función que devuelve el total recaudado en una fecha indicada.
     * @param fecha. Es la fecha indicada.
     * @return total. Devuelve el total recaudado en dicha fecha.
     */
    
    @Override
    public String getCierreDeCaja(String fecha) {
        String query = "SELECT sum(total) FROM venta WHERE fecha = '"+fecha+"' GROUP BY fecha";
        String monto = "0.00";

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) 
                monto = resultSet.getString(1);
            
        } catch (SQLException e) {

        } finally {
            try {
                preparedStatement.close();
                resultSet.close();
                Conexion.closeConexion(connection);                
            } catch (SQLException e) {
                
            }
        }        
        return monto;
    }
    
    

    /**
     * Función que contiene el total de cada forma de pago: en efectivo, tarjeta de debito y credito.
     * @param fecha. Es la fecha seleccionada.
     * @return array. Contiene el total de las 3 formas de pago.
     */
    
    @Override
    public double [] ventasFormaPago(String fecha) {
        double[] montoFormaPago = new double[3];   
        
        try {
            connection = Conexion.getConexion();

            for (int i = 0; i < 3; i++) {             
                preparedStatement = connection.prepareStatement("SELECT sum(total) FROM venta WHERE fecha = '"+fecha+"'"
                                               + " AND formaPago_id = '" + (i + 1) + "' GROUP BY '"+fecha+"'");
                resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) 
                    montoFormaPago[i] = resultSet.getDouble(1);               
            }

        } catch (SQLException e) {

        } finally {
            try {
                preparedStatement.close();
                resultSet.close();
                Conexion.closeConexion(connection);
            } catch (SQLException e) {

            }
        }
        return montoFormaPago;
    }
    
    

    /**
     * Esta función contiene la cantidad de ventas que se realizaron en una fecha
     * @param fecha. Es la fecha indicada por el usuario
     * @return cantidad. Es el total de cantidad de ventas realizadas.
     */
    
    @Override
    public String cantidadVentas(String fecha) {      
        String query = "select SUM(cantidad) from detalle_venta INNER JOIN venta "
                + "ON venta.id_venta = detalle_venta.rela_venta where fecha = '"+fecha+"' ";
        String cantidad = null;

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) 
                cantidad = resultSet.getString(1);
           
        } catch (SQLException e) {

        } finally {
            try {
                preparedStatement.close();
                resultSet.close();
                Conexion.closeConexion(connection);
            } catch (SQLException e) {

            }
        }
        return cantidad;
    }

    
    
    /**
     * Esta funcion contiene el total recaudado de cada mes del año actual
     * @return array. Devuelve un arreglo con el monto de cada mes.
     */
    
    @Override
    public String[] totalPorMes() {
        String enero = "select sum(total) from venta where substring(fecha,6,2) = '01' AND substring(fecha,1,4) = (SELECT YEAR(NOW()))";
        String febrero = "select sum(total) from venta where substring(fecha,6,2) = '02' AND substring(fecha,1,4) = (SELECT YEAR(NOW()))";
        String marzo = "select sum(total) from venta where substring(fecha,6,2) = '03' AND substring(fecha,1,4) = (SELECT YEAR(NOW()))";
        String abril = "select sum(total) from venta where substring(fecha,6,2) = '04' AND substring(fecha,1,4) = (SELECT YEAR(NOW()))";
        String mayo = "select sum(total) from venta where substring(fecha,6,2) = '05' AND substring(fecha,1,4) = (SELECT YEAR(NOW()))";
        String junio = "select sum(total) from venta where substring(fecha,6,2) = '06' AND substring(fecha,1,4) = (SELECT YEAR(NOW()))";
        String julio = "select sum(total) from venta where substring(fecha,6,2) = '07' AND substring(fecha,1,4) = (SELECT YEAR(NOW()))";
        String agosto = "select sum(total) from venta where substring(fecha,6,2) = '08' AND substring(fecha,1,4) = (SELECT YEAR(NOW()))";
        String septiembre = "select sum(total) from venta where substring(fecha,6,2) = '09' AND substring(fecha,1,4) = (SELECT YEAR(NOW()))";
        String octubre = "select sum(total) from venta where substring(fecha,6,2) = '10' AND substring(fecha,1,4) = (SELECT YEAR(NOW()))";
        String noviembre = "select sum(total) from venta where substring(fecha,6,2) = '11' AND substring(fecha,1,4) = (SELECT YEAR(NOW()))";
        String diciembre = "select sum(total) from venta where substring(fecha,6,2) = '12' AND substring(fecha,1,4) = (SELECT YEAR(NOW()))";

        String[] lista_meses = {enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre};

        String[] mes = new String[12];
        int indice = 0;

        try {
            connection = Conexion.getConexion();  
            // Se aplica en cada mes su monto correspondiente desde la Base de datos
            for (String meses : lista_meses) {
                preparedStatement = connection.prepareStatement(meses);
                resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) 
                    mes[indice] = resultSet.getString(1);           
                indice++;
            }

        } catch (SQLException e) {

        } finally {
            
            try {
                preparedStatement.close();
                resultSet.close();
                Conexion.closeConexion(connection);
            } catch (SQLException e) {

            }
        }
        return mes;
    }
    
    
    
    /**
     * Esta funcion lo que hace es contar la cantidad de veces que se vendieron en cada forma de pago.
     * @param fecha - Es la fecha seleccionada
     * @return int[] - Contiene la cantidad vendida de cada forma de pago
     */
    @Override
    public int[] contarFormasPago(String fecha) {
      
        String query = "SELECT count(formaPago_id) FROM venta WHERE fecha = '"+fecha+"' GROUP BY formaPago_id";
        
        int [] cantidades = new int [3];
        int indice = 0;
        
        try {         
            connection = Conexion.getConexion();           
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();           
            
             while(resultSet.next()){               
                cantidades[indice] = resultSet.getInt(1);                       
                 indice++;               
             }
            
        } catch (SQLException e) {
            
        }finally{
            
            try{               
                preparedStatement.close();
                resultSet.close();
                Conexion.closeConexion(connection);                
            }catch(SQLException exception){
                
            }         
        }       
       return cantidades;      
    }
}
