package com.casatrachta.config;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import javax.sql.DataSource;
import org.apache.commons.dbcp2.BasicDataSource;


public class Conexion {

    private static BasicDataSource pool = null;

    
    public static DataSource getDataSource() {

        if (pool == null) {

            pool = new BasicDataSource();
            pool.setDriverClassName("com.mysql.cj.jdbc.Driver");
            pool.setUsername("root");
            pool.setPassword("");
            pool.setUrl("jdbc:mysql://localhost:3306/casa_trachta?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC");

            pool.setMaxTotal(20);
            pool.setMinIdle(5);  //CANTIDAD MINIMA DE CONEXIONES INACTIVAS
            pool.setMaxIdle(10);  //CANTIDAD MAXIMAS DE CONEXIONES INACTIVAS
            pool.setMaxWaitMillis(-1); //TIEMPO DE ESPERA PARA EL USUARIO, PARA TENER UNA CONEXION
        }

        return pool;
    }
    
    

    public static Connection getConexion() throws SQLException {

        return getDataSource().getConnection();
    }

    
    
    public static void closeConexion(Connection conexion) throws SQLException {

        conexion.close();

    }

    public static boolean backup() {
        try {
            Process proceso = Runtime.getRuntime().exec("mysqldump -u root casa_trachta");

            InputStream entrada = proceso.getInputStream();
            FileOutputStream archivo = new FileOutputStream("C:\\RespaldoMySQL\\backup-casa_trachta.sql");

            byte[] buffer = new byte[1000];

            int byteLeido = entrada.read(buffer);

            while (byteLeido > 0) {

                archivo.write(buffer, 0, byteLeido);
                byteLeido = entrada.read(buffer);

            }

            archivo.close();
            
           return true;

        } catch (Exception e) {

           
            
            return false;
        }
    }
}
