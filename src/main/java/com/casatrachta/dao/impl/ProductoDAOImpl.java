package com.casatrachta.dao.impl;

import com.casatrachta.dao.definition.IProductoDao;
import com.casatrachta.model.Producto;
import com.casatrachta.config.Conexion;
import com.casatrachta.model.Seccion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAOImpl implements IProductoDao {

    private Connection connection;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;


    
    /**
     * Está funcion guarda el producto en la base de datos.
     * @param producto. Es el producto a guardar.
     * @return boolean. Devuelve true si el producto fue persistido en la base
     * de datos.
     */
    @Override
    public boolean agregar(Producto producto) {

        String query = "INSERT INTO producto(codigo,seccion_id,nombre,"
                + "precio,stock,formaVenta_id,unidadMedida_id) "
                + "VALUES (?,?,?,?,?,?,?)";
        int resultado;

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(query);

            preparedStatement.setString(1, producto.getCodigo());
            preparedStatement.setInt(2, producto.getSeccion().getId_seccion());
            preparedStatement.setString(3, producto.getNombre());
            preparedStatement.setString(4, producto.getPrecio());
            preparedStatement.setString(5, producto.getStock());
            preparedStatement.setInt(6, producto.getFormaVenta());
            preparedStatement.setInt(7, producto.getUnidadMedida());

            resultado = preparedStatement.executeUpdate();

            return resultado > 0;
          
        } catch (SQLException ex) {

            return false;

        } finally {

            try {
                preparedStatement.close();
                Conexion.closeConexion(connection);
            } catch (SQLException e) {

            }
        }

    }

    
    
    /**
     * Esta función tiene como objetivo devolver el producto buscado
     *
     * @param id. Sirve para buscar el producto en la base de datos
     * @return Producto. Devuelve el producto
     */
    @Override
    public Producto obtener(int id) {

        Producto pro = null;
        String query = " SELECT p.id_producto,p.codigo,s.id_seccion,p.nombre,"
                + "p.precio,p.stock, p.formaVenta_id, p.unidadMedida_id FROM \n"
                + "producto p INNER JOIN seccion s ON p.seccion_id = s.id_seccion WHERE p.id_producto = ? ";

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                pro = new Producto(new Seccion());
                pro.setId(resultSet.getLong(1));
                pro.setCodigo(resultSet.getString(2));
                pro.getSeccion().setId_seccion(resultSet.getInt(3));
                pro.setNombre(resultSet.getString(4));
                pro.setPrecio(resultSet.getString(5));
                pro.setStock(resultSet.getString(6));
                pro.setFormaVenta(resultSet.getInt(7));
                pro.setUnidadMedida(resultSet.getInt(8));
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
        return pro;
    }

    
    
    /**
     * Este metodo sirve para actualizar el producto en la base de datos
     * @param producto- es el producto a actualizar
     */
    @Override
    public void actualizar(Producto producto) {

        String query = "UPDATE producto SET codigo = ?, seccion_id = ?, "
                + "nombre = ?, precio = ?, stock = ?, formaVenta_id = ?, "
                + "unidadMedida_id = ? WHERE id_producto = ?";
        
        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, producto.getCodigo());
            preparedStatement.setInt(2, producto.getSeccion().getId_seccion());
            preparedStatement.setString(3, producto.getNombre());
            preparedStatement.setString(4, producto.getPrecio());
            preparedStatement.setString(5, producto.getStock());
            preparedStatement.setInt(6, producto.getFormaVenta());
            preparedStatement.setInt(7, producto.getUnidadMedida());
            preparedStatement.setLong(8, producto.getId());
            preparedStatement.executeUpdate();

        } catch (SQLException ex) {

        } finally {

            try {
                preparedStatement.close();
                Conexion.closeConexion(connection);

            } catch (SQLException e) {

            }
        }
    }

    
    
    /**
     * Esta función devuelve los productos que tengan stock con valor menores a 5.
     * @param opcion - es la opcion elegida, y sirve para saber si devolver una
     * lista completa o limitada.
     * @return lista - Retorna una lista con todos aquellos productos que tengan
     * poco stock.
     */
    @Override
    public List<Producto> listarStockBajo(String opcion) {

        String query = "SELECT nombre,stock FROM producto WHERE CONVERT(stock,signed) < 5"; // lista completa
        // en caso de que se requiera pocos registros,el query trae solo 6 registros 
        if (opcion.equals("LIMITADO")) 
            query = query + " LIMIT 6";
        
        List<Producto> productos = new ArrayList<>();
        Producto producto;

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                producto = new Producto();
                producto.setNombre(resultSet.getString(1));
                producto.setStockOriginal(resultSet.getString(2));
                productos.add(producto);
            }

        } catch (SQLException e) {

        } finally {
            try {
                preparedStatement.close();
                resultSet.close();
                Conexion.closeConexion(connection);
            } catch (SQLException sq) {

            }
        }
        return productos;
    }
    
    

    /**
     * Esta metodo elimina el producto de la base de datos.
     *
     * @param id. Es el id del producto que se va a eliminar de la base de datos
     */
    @Override
    public void eliminar(int id) {

        String query = "DELETE FROM producto WHERE id_producto = '" + id + "' ";

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.executeUpdate();
        } catch (SQLException ex) {

        } finally {

            try {
                preparedStatement.close();
                Conexion.closeConexion(connection);
            } catch (SQLException e) {

            }
        }
    }
    
    

    /**
     * Este metodo actualiza el stock del producto seleccionado.
     * @param codigo. Es el codigo identificativo del producto.
     * @param stock . Es el nuevo stock que se actualizara en dicho producto.
     */
    @Override
    public void actualizarStock(String codigo, String stock) {

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement("UPDATE producto SET stock = '" + stock + "' WHERE codigo = '" + codigo + "'");
            preparedStatement.executeUpdate();

        } catch (SQLException e) {

        } finally {
            try {
                preparedStatement.close();
                Conexion.closeConexion(connection);
            } catch (SQLException e) {
                
            }
        }
    }
    
    

    /**
     * Esta función devuelve el producto seleccionado.
     * @param codigo. Es el codigo identificativo del producto a devolver.
     * @return Devuelve el producto seleccionado.
     */
    @Override
    public Producto getProducto(String codigo) {

        Producto pro = null;
        String query = "select * FROM producto  WHERE codigo = '" + codigo + "'";

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                pro = new Producto();
                pro.setId(resultSet.getInt(1));
                pro.setCodigo(resultSet.getString(2));
                pro.setNombre(resultSet.getString(3));
                pro.setPrecio(resultSet.getString(4));
                pro.setStock(resultSet.getString(5));
                pro.setStockOriginal(resultSet.getString(5));
                pro.setFormaVenta(resultSet.getInt(6));
                pro.setUnidadMedida(resultSet.getInt(8));
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
        return pro;
    }

  
    
    /**
     * Esta funcion devuelve una lista con 5 productos, de acuerdo a la pagina elegida. 
     * @param pagina - es la pagina seleccionada por el usuario
     * @return - devuelve la lista de productos
     */
    @Override
    public ArrayList<Producto> listar(int pagina) {
        
        ArrayList<Producto> listaProductos = new ArrayList();
        Producto producto;
        String query = "SELECT p.id_producto, p.nombre, s.nombre, p.codigo, p.precio, "
                       + "p.stock FROM producto p, seccion s "
                       + "WHERE p.seccion_id = s.id_seccion LIMIT ?,5";      
        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, 5 *  (pagina-1));          
            resultSet = preparedStatement.executeQuery();
            
            while(resultSet.next()){                
                producto = new Producto(new Seccion());
                producto.setId(resultSet.getLong(1));
                producto.setNombre(resultSet.getString(2));
                producto.getSeccion().setNombre(resultSet.getString(3));
                producto.setCodigo(resultSet.getString(4));               
                producto.setPrecio(resultSet.getString(5));
                producto.setStock(resultSet.getString(6));                              
                listaProductos.add(producto);               
            }           
            
        } catch (SQLException sqlException) {
                                 
        }finally{
            
            try {             
                preparedStatement.close();
                resultSet.close();
                Conexion.closeConexion(connection);             
            } catch (SQLException e) {
                
            }
        }        
        return listaProductos;
    }
    
    
    /**
     * Esta funcion devuelve el total de paginas que tendra la tabla,diviendo la cantidad total de productos
     * persistidos en la base de datos por la cantidad de registros que se desea mostrar al usuario.
     * @return - cantidad de paginas que estaran disponibles.
     */
    @Override
    public int totalPaginas(){
      
        Double cantidad = 0.0;
        Double totalPaginasD;
        Double totalPaginas;
        int paginas = 0;
        
        try{          
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement("SELECT count(*) FROM producto");
            resultSet = preparedStatement.executeQuery();
            
            if(resultSet.next())
                   cantidad = resultSet.getDouble(1);   
            
         totalPaginasD = cantidad / 5.0;        
         totalPaginas = Math.ceil(totalPaginasD);         
         paginas = totalPaginas.intValue();
                       
        }catch(SQLException sqlException){                      
            
        }finally{
            
            try {               
                preparedStatement.close();
                resultSet.close();
                Conexion.closeConexion(connection);              
            } catch (SQLException e) {
                
            }
        }      
       return paginas;       
    }

    
    
    /**
     * Indica la cantidad total de productos dentro de la base de datos, que seran mostrado como guia
     * al usuario
     * @return - la cantidad total de productos.
     */
    @Override
    public int totalProductos() {     
        int cantidad = 0;
        
        try{         
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement("SELECT count(*) from producto");
            resultSet = preparedStatement.executeQuery();
            
            if(resultSet.next())
                   cantidad = resultSet.getInt(1);   
                        
        }catch(SQLException e){                      
            
        }finally{
            
            try {              
                preparedStatement.close();
                resultSet.close();
                Conexion.closeConexion(connection);              
            } catch (SQLException e) {
                
            }
        }
        return cantidad;
    }

}
