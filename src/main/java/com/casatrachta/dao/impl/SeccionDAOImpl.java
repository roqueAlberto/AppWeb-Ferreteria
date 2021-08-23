package com.casatrachta.dao.impl;

import com.casatrachta.dao.definition.ISeccionDao;
import com.casatrachta.model.Seccion;
import com.casatrachta.model.Producto;
import com.casatrachta.config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class SeccionDAOImpl implements ISeccionDao {

    Connection conexion;
    PreparedStatement ps;
    ResultSet rs;
    Producto producto;
    Seccion seccion;
    
    

    /**
     * Esta función lista todas las secciones
     * @return List. Devuelve la lista de secciones
     */
    
    @Override
    public List<Seccion> listar() {

        List<Seccion> listaSeccion = new ArrayList<>();
        String sql = "SELECT * from seccion;";

        try {
            conexion = Conexion.getConexion();
            ps = conexion.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                seccion = new Seccion();
                seccion.setId_seccion(rs.getInt(1));
                seccion.setNombre(rs.getString(2));

                listaSeccion.add(seccion);
            }

        } catch (SQLException e) {

        } finally {

            try {
                ps.close();
                rs.close();
                Conexion.closeConexion(conexion);
                
            } catch (SQLException e) {
            }
        }

        return listaSeccion;

    }
    
    

    /**
     * Este metodo agrega una nueva seccion en la base de datos
     * @param seccion. Es el nombre de la seccion a persistir
     */
    
    @Override
    public void agregar(String seccion) {

        try {

            conexion = Conexion.getConexion();
            ps = conexion.prepareStatement("INSERT INTO seccion (nombre) values('"+seccion+"')");
            ps.executeUpdate();

        } catch (SQLException e) {

        } finally {

            try {
                ps.close();
                Conexion.closeConexion(conexion);
                
            } catch (SQLException e) {
                
            }

        }

    }

}
