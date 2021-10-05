package com.casatrachta.dao.impl;

import com.casatrachta.dao.definition.IVentaDao;
import com.casatrachta.model.Carrito;
import com.casatrachta.config.Conexion;
import com.casatrachta.model.ProductoEnCarrito;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class VentaDAOImpl implements IVentaDao {

    private Connection connection;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;

    Date date = new Date();
    SimpleDateFormat formato = new SimpleDateFormat("YYYY-MM-dd");
    String fecha = formato.format(date);

    private static final String INSERT_VENTA = "INSERT INTO venta(fecha,total,formaPago_id) VALUES (?,?,?)";

    @Override
    public void save(Carrito venta) {
        PreparedStatement preparedStatementVenta = null;
        PreparedStatement preparedStatementDetalleVenta = null;
        PreparedStatement preparedStatementActualizar = null;

        long id_venta = 0;

        try {
            connection = Conexion.getConexion();
            connection.setAutoCommit(false);

            // guardar datos de la venta
            preparedStatementVenta = connection.prepareStatement(INSERT_VENTA, Statement.RETURN_GENERATED_KEYS);
            preparedStatementVenta.setString(1, fecha);
            preparedStatementVenta.setBigDecimal(2, venta.getTotal());
            preparedStatementVenta.setInt(3, venta.getMetodoPago());

            preparedStatementVenta.executeUpdate();

            // 1- Obtener el ultimo registro de venta
            resultSet = preparedStatementVenta.getGeneratedKeys();

            if (resultSet.next()) {
                id_venta = resultSet.getLong(1);
            }

            // 2- Guardar todos los datos en la tabla descripcion venta.
            for (int i = 0; i < venta.getProductos().size(); i++) {

                preparedStatementDetalleVenta = connection.prepareStatement("INSERT INTO descripcion_venta"
                        + "(venta_id,producto_id,cantidad,importe) "
                        + "values (?,?,?,?)");
                preparedStatementDetalleVenta.setLong(1, id_venta);
                preparedStatementDetalleVenta.setLong(2, venta.getProductos().get(i).getId());
                preparedStatementDetalleVenta.setBigDecimal(3, venta.getProductos().get(i).getCantidad());
                preparedStatementDetalleVenta.setBigDecimal(4, venta.getProductos().get(i).getImporte());
                preparedStatementDetalleVenta.executeUpdate();

            }

            // 3- Actualizar stock
            for (int j = 0; j < venta.getProductos().size(); j++) {
                preparedStatementActualizar = connection.prepareStatement("UPDATE producto SET stock = ? WHERE id_producto = ?");
                preparedStatementActualizar.setBigDecimal(1, venta.getProductos().get(j).getStock());
                preparedStatementActualizar.setLong(2, venta.getProductos().get(j).getId());
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

                preparedStatementDetalleVenta.close();
                preparedStatementActualizar.close();
                Conexion.closeConexion(connection);
            } catch (Exception er) {

            }

        }

    }

    @Override
    public ArrayList<ProductoEnCarrito> report(String fecha) {

        String sql = "SELECT d.id_descripcionVenta,p.nombre,d.cantidad,d.importe  "
                + "FROM producto p,descripcion_venta d,venta v "
                + " WHERE p.id_producto = d.producto_id AND d.venta_id = v.id_venta "
                + "AND v.fecha = ?";

        Carrito venta = new Carrito();
        ProductoEnCarrito productoCarrito;

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, fecha);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                productoCarrito = new ProductoEnCarrito();

                productoCarrito.setId(resultSet.getInt(1));
                productoCarrito.setNombre(resultSet.getString(2));
                productoCarrito.setCantidad(resultSet.getBigDecimal(3));
                productoCarrito.setImporte(resultSet.getBigDecimal(4));

                venta.getProductos().add(productoCarrito);
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
        return (ArrayList) venta.getProductos();
    }

    @Override
    public String closeSale(String fecha) {
        String query = "SELECT sum(total) FROM venta WHERE fecha = '" + fecha + "' GROUP BY fecha";
        String monto = "0.00";

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                monto = resultSet.getString(1);
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
        return monto;
    }

    @Override
    public double[] salePayments(String fecha) {
        double[] montoFormaPago = new double[3];

        try {
            connection = Conexion.getConexion();

            for (int i = 0; i < 3; i++) {
                preparedStatement = connection.prepareStatement("SELECT sum(total) FROM venta WHERE fecha = '" + fecha + "'"
                        + " AND formaPago_id = '" + (i + 1) + "' GROUP BY '" + fecha + "'");
                resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    montoFormaPago[i] = resultSet.getDouble(1);
                }
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

    @Override
    public String countSales(String fecha) {
        String query = "select SUM(cantidad) from detalle_venta INNER JOIN venta "
                + "ON venta.id_venta = detalle_venta.rela_venta where fecha = '" + fecha + "' ";
        String cantidad = null;

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                cantidad = resultSet.getString(1);
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
        return cantidad;
    }

    @Override
    public String[] totalForMonth() {
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
                if (resultSet.next()) {
                    mes[indice] = resultSet.getString(1);
                }
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

    @Override
    public int[] countPayments(String fecha) {

        String query = "SELECT count(formaPago_id) FROM venta WHERE fecha = '" + fecha + "' GROUP BY formaPago_id";

        int[] cantidades = new int[3];
        int indice = 0;

        try {
            connection = Conexion.getConexion();
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                cantidades[indice] = resultSet.getInt(1);
                indice++;
            }

        } catch (SQLException e) {

        } finally {

            try {
                preparedStatement.close();
                resultSet.close();
                Conexion.closeConexion(connection);
            } catch (SQLException exception) {

            }
        }
        return cantidades;
    }
}
