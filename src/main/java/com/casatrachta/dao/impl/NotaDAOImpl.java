package com.casatrachta.dao.impl;

import com.casatrachta.dao.definition.INotaDao;
import com.casatrachta.config.Conexion;
import com.casatrachta.model.Nota;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NotaDAOImpl implements INotaDao {

    private Connection conexion;
    private PreparedStatement ps;
    private ResultSet rs;

    private static final String INSERT_NOTA = "insert into nota(descripcion,fecha) values (?,?)";
    private static final String SELECT_NOTA = "SELECT descripcion FROM nota WHERE fecha = ? ";

    @Override
    public int getCantidad(String fecha) {

        int cantidad = 0;

        String query = "SELECT count(*) FROM nota WHERE fecha = '" + fecha + "'";

        try {
            conexion = Conexion.getConexion();
            ps = conexion.prepareStatement(query);
            rs = ps.executeQuery();

            if (rs.next()) {
                cantidad = rs.getInt(1);
            }

        } catch (SQLException sq) {

        } finally {

            try {
                ps.close();
                rs.close();
                Conexion.closeConexion(conexion);
            } catch (SQLException e) {

            }
        }

        return cantidad;

    }

     @Override
    public void guardar(String dato, String fecha) {

        String query = "insert into nota(descripcion,fecha) values ('"+dato+"', '"+fecha+"')";

        try {

            conexion = Conexion.getConexion();
            ps = conexion.prepareStatement(query);
            ps.executeUpdate();

        } catch (SQLException sq) {

        } finally {

            try {
                ps.close();
                Conexion.closeConexion(conexion);
            } catch (SQLException e) {

            }

        }

    }
    
    

    /**
     * Esta función muestra las notas escritas en la fecha seleccioanda
     * @param fecha - es la fecha elegida por parte del usuario
     * @return - devuelve la lista de todas las notas escritas
     */
    @Override
    public List<String> listar(String fecha) {

        List<String> notas = new ArrayList<>();

        String query = "SELECT descripcion FROM nota WHERE fecha = '"+fecha+"'";

        try {

            conexion = Conexion.getConexion();
            ps = conexion.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                notas.add(rs.getString(1));
            }

        } catch (SQLException sq) {

        } finally {

            try {
                ps.close();
                rs.close();
                Conexion.closeConexion(conexion);
                
            } catch (SQLException e) {

            }

        }

        return notas;

    }

}
