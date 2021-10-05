package com.casatrachta.dao.impl;

import com.casatrachta.dao.definition.IProductoDao;
import com.casatrachta.model.Producto;
import com.casatrachta.config.Conexion;
import com.casatrachta.model.ProductoEnCarrito;
import com.casatrachta.model.Seccion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductoDAOImpl implements IProductoDao {

    private Connection connection;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    private static final String INSERT_PRODUCTO_SQL = "INSERT INTO producto(codigo,seccion_id,nombre,precio,stock,formaVenta_id,unidadMedida_id) VALUES (?,?,?,?,?,?,?)";
    private static final String SELECT_PRODUCTO_ID = "SELECT p.id_producto,p.codigo,s.id_seccion,p.nombre, p.precio,p.stock, p.formaVenta_id, p.unidadMedida_id FROM producto p INNER JOIN seccion s ON p.seccion_id = s.id_seccion WHERE p.id_producto = ?";
    private static final String UPDATE_PRODUCTO = "UPDATE producto SET codigo = ?, seccion_id = ?,nombre = ?, precio = ?, stock = ?, formaVenta_id = ?, unidadMedida_id = ? WHERE id_producto = ?";
    private static final String DELETE_PRODUCTO =  "DELETE FROM producto WHERE id_producto = ? ";
    private static final String UPDATE_STOCK = "UPDATE producto SET stock = ? WHERE codigo = ? ";
    private static final String SELECT_PRODUCTO_CODIGO = "SELECT * FROM producto  WHERE codigo = ?";
    private static final String SELECT_PRODUCTOS_LIMIT = "SELECT p.id_producto, p.nombre, s.nombre, p.codigo, p.precio, p.stock FROM producto p, seccion s WHERE p.seccion_id = s.id_seccion LIMIT ?,5"; 
    private static final String SELECT_COUNT_PRODUCTOS = "SELECT count(*) FROM producto";
    private static final String SELECT_PRODUCTO_LIKE = "SELECT p.id_producto, p.nombre, s.nombre, p.codigo, p.precio, p.stock FROM producto p, seccion s WHERE p.seccion_id = s.id_seccion and p.nombre LIKE ?";
    
    
    @Override
    public boolean save(Producto producto) {      
    
        int resultado;

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(INSERT_PRODUCTO_SQL);

            preparedStatement.setString(1, producto.getCodigo());
            preparedStatement.setInt(2, producto.getIdSeccion());
            preparedStatement.setString(3, producto.getNombre());
            preparedStatement.setString(4, producto.getPrecio());
            preparedStatement.setBigDecimal(5, producto.getStock());
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

    
    @Override
    public Producto findById(int id) {

        Producto pro = null;
       
        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(SELECT_PRODUCTO_ID);
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                pro = new Producto();
                pro.setId(resultSet.getLong(1));
                pro.setCodigo(resultSet.getString(2));
                pro.setIdSeccion(resultSet.getInt(3));
                pro.setNombre(resultSet.getString(4));
                pro.setPrecio(resultSet.getString(5));
                pro.setStock(resultSet.getBigDecimal(6));
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

    
    @Override
    public void update(Producto producto) {    
        
        try {
            connection = Conexion.getConexion();
            
            preparedStatement = connection.prepareStatement(UPDATE_PRODUCTO);
            preparedStatement.setString(1, producto.getCodigo());
            preparedStatement.setInt(2, producto.getIdSeccion());
            preparedStatement.setString(3, producto.getNombre());
            preparedStatement.setString(4, producto.getPrecio());
            preparedStatement.setBigDecimal(5, producto.getStock());
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

    
    
    @Override
    public List<Producto> allStockDown(String opcion) {

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
                producto.setStock(resultSet.getBigDecimal(2));
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
    
    

    @Override
    public void delete(int id) {

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(DELETE_PRODUCTO);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
            
        } catch (SQLException ex) {
            ex.printStackTrace();

        } finally {

            try {
                preparedStatement.close();
                Conexion.closeConexion(connection);
            } catch (SQLException e) {

            }
        }
    }
    
    
    
    @Override
    public void updateStock(Producto producto) {

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(UPDATE_STOCK);
            preparedStatement.setBigDecimal(1, producto.getStock());
            preparedStatement.setString(2, producto.getCodigo());
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
    
    

    @Override
    public ProductoEnCarrito findByCodigo(String codigo) {

        ProductoEnCarrito pro = null;

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(SELECT_PRODUCTO_CODIGO);
            preparedStatement.setString(1, codigo);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                pro = new ProductoEnCarrito();
                pro.setId(resultSet.getInt(1));
                pro.setCodigo(resultSet.getString(2));
                pro.setNombre(resultSet.getString(3));
                pro.setPrecio(resultSet.getString(4));
                pro.setStock(resultSet.getBigDecimal(5));
               // pro.setStockOriginal(resultSet.getString(5));
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

  
    
    @Override
    public ArrayList<Producto> list(int pagina) {
        
        ArrayList<Producto> listaProductos = new ArrayList(10);
        Producto producto;
            
        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(SELECT_PRODUCTOS_LIMIT);
            preparedStatement.setInt(1, 5 *  (pagina-1));          
            resultSet = preparedStatement.executeQuery();
            
            while(resultSet.next()){                
                producto = new Producto(new Seccion());
                producto.setId(resultSet.getLong(1));
                producto.setNombre(resultSet.getString(2));
                producto.getSeccion().setNombre(resultSet.getString(3));
                producto.setCodigo(resultSet.getString(4));               
                producto.setPrecio(resultSet.getString(5));
                producto.setStock(resultSet.getBigDecimal(6));                              
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
    
  
    
    @Override
    public int countPages(){
      
        Double cantidad = 0.0;
        Double totalPaginasD;
        Double totalPaginas;
        int paginas = 0;
        try{          
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(SELECT_COUNT_PRODUCTOS);
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

    
    

    @Override
    public int totalProducts() {     
        int cantidad = 0;
        
        try{         
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(SELECT_COUNT_PRODUCTOS);
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

    
    
    @Override
    public ArrayList<Producto> findByDescripcion(String descripcion) {
        
        ArrayList<Producto> lista = new ArrayList<>();
        Producto producto;
        
        try(Connection conect = Conexion.getConexion();
                PreparedStatement preparedStatement = conect.prepareStatement(SELECT_PRODUCTO_LIKE)){
            preparedStatement.setString(1, "%"+descripcion+"%");
            
           
            ResultSet resultSet = preparedStatement.executeQuery();
            
            while(resultSet.next()){                
                producto = new Producto(new Seccion());
                producto.setId(resultSet.getLong(1));
                producto.setNombre(resultSet.getString(2));
                producto.getSeccion().setNombre(resultSet.getString(3));
                producto.setCodigo(resultSet.getString(4));               
                producto.setPrecio(resultSet.getString(5));
                producto.setStock(resultSet.getBigDecimal(6));                              
                lista.add(producto);               
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(ProductoDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
            
        return lista;
    }


}
