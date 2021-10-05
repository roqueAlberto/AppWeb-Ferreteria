package com.casatrachta.dao.impl;

import com.casatrachta.dao.definition.IGastoDao;
import com.casatrachta.config.Conexion;
import com.casatrachta.model.Gasto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class GastoDAOImpl implements IGastoDao {

    private Connection connection;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    private static final String INSERT_CONSUMO = "INSERT INTO consumo(descripcion,monto,fecha) VALUES (?,?,?)";
    private static final String SELECT_CONSUMOS = "SELECT descripcion,monto FROM consumo WHERE fecha = ? ";
    private static final String SELECT_MONTO = "SELECT sum(monto) FROM consumo WHERE fecha = ?";

  
    @Override
    public String establecerTotal(String fecha) {

        String total_gasto = "0.00";
        try {

            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(SELECT_MONTO);
            preparedStatement.setString(1, fecha);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                total_gasto = resultSet.getString(1);
            }

        } catch (SQLException sq) {

        } finally {

            try {
                preparedStatement.close();
                resultSet.close();
                Conexion.closeConexion(connection);
            } catch (SQLException e) {

            }

        }
        return total_gasto;
    }

     @Override
    public void insertar(String descripcion, int monto, String fecha) {

        String sql = "INSERT INTO consumo(descripcion,monto,fecha) VALUES (?,?,?)";

        try {

            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, descripcion);
            preparedStatement.setInt(2, monto);
            preparedStatement.setString(3, fecha);
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
     * Esta función lista todos los gastos realizados en la fecha requerida
     * @param fecha. Fecha en la que se quiere buscar
     * @return Devuelve una lista con todos los gastos realizados en dicha fecha
     */
    @Override
    public ArrayList<Gasto> listarGastos(String fecha) {

        ArrayList<Gasto> listaGastos = new ArrayList();
        Gasto gasto;

        String sql = "SELECT descripcion,monto FROM consumo WHERE fecha = '"+fecha+"'";

        try {

            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(sql);       
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                gasto = new Gasto();
                gasto.setDescripcion(resultSet.getString(1));
                gasto.setMonto(resultSet.getString(2));
                listaGastos.add(gasto);
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

        return listaGastos;

    }

}
