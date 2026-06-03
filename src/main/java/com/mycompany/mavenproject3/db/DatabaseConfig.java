package com.mycompany.mavenproject3.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Unico lugar donde viven los datos de conexion a la base de datos.
 * Si cambia el servidor, la contrasena o el nombre de la BD,
 * solo se modifica este archivo y todo lo demas sigue funcionando igual.
 */
public class DatabaseConfig {

    // Cambiar estos tres valores segun la base de datos que use el docente.
    private static final String HOST     = "zephyr.proxy.rlwy.net";
    private static final String PUERTO   = "28067";
    private static final String NOMBRE   = "railway";
    private static final String USUARIO  = "root";
    private static final String CLAVE    ="frrcBpVFjXGzTAlHQhVZHIQxzOmIxwSX";

    private static final String URL =
        "jdbc:mysql://" + HOST + ":" + PUERTO + "/" + NOMBRE
        + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";

    static {
        // Tomcat usa un classloader propio que a veces no encuentra el driver automaticamente.
        // Class.forName fuerza el registro del driver antes de cualquier conexion.
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver MySQL no encontrado. Verificar que mysql-connector-j este en el pom.xml.", e);
        }
    }

    public static Connection getConexion() throws SQLException {
        return DriverManager.getConnection(URL, USUARIO, CLAVE);
    }

    public static String getEstadoConexion() {
        try (Connection con = getConexion()) {
            return "Conexion exitosa al servidor: " + HOST;
        } catch (SQLException e) {
            return "Error al conectar: " + e.getMessage();
        }
    }
}
