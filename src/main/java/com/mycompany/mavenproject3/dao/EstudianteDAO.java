package com.mycompany.mavenproject3.dao;

import com.mycompany.mavenproject3.db.DatabaseConfig;
import com.mycompany.mavenproject3.model.Estudiante;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO = Data Access Object.
 * Este objeto es el UNICO responsable de hablar con la base de datos.
 * El servlet no sabe nada de SQL. El DAO no sabe nada de HTTP.
 * Esa separacion es el patron DAO.
 */
public class EstudianteDAO {

    // ---------------------------------------------------------------
    // SELECT: traer todos los estudiantes
    // ---------------------------------------------------------------
    public List<Estudiante> listar() throws SQLException {
        List<Estudiante> lista = new ArrayList<>();

        String sql = "SELECT id, nombre, edad, nota FROM estudiantes ORDER BY id";

        try (Connection con = DatabaseConfig.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Estudiante e = new Estudiante(
                    rs.getInt("id"),
                    rs.getString("nombre"),
                    rs.getInt("edad"),
                    rs.getDouble("nota")
                );
                lista.add(e);
            }
        }

        return lista;
    }

    // ---------------------------------------------------------------
    // INSERT: guardar un nuevo estudiante
    // ---------------------------------------------------------------
    public int insertar(Estudiante estudiante) throws SQLException {
        String sql = "INSERT INTO estudiantes (nombre, edad, nota) VALUES (?, ?, ?)";

        // RETURN_GENERATED_KEYS recupera el id que asigno la BD automaticamente
        try (Connection con = DatabaseConfig.getConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, estudiante.getNombre());
            ps.setInt(2, estudiante.getEdad());
            ps.setDouble(3, estudiante.getNota());
            ps.executeUpdate();

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    return keys.getInt(1);
                }
            }
        }

        return -1;
    }

    // ---------------------------------------------------------------
    // UPDATE: modificar un estudiante existente por su id
    // ---------------------------------------------------------------
    public boolean actualizar(int id, Estudiante estudiante) throws SQLException {
        String sql = "UPDATE estudiantes SET nombre = ?, edad = ?, nota = ? WHERE id = ?";

        try (Connection con = DatabaseConfig.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, estudiante.getNombre());
            ps.setInt(2, estudiante.getEdad());
            ps.setDouble(3, estudiante.getNota());
            ps.setInt(4, id);

            // executeUpdate devuelve cuantas filas se modificaron
            return ps.executeUpdate() > 0;
        }
    }

    // ---------------------------------------------------------------
    // DELETE: eliminar un estudiante por su id
    // ---------------------------------------------------------------
    public boolean eliminar(int id) throws SQLException {
        String sql = "DELETE FROM estudiantes WHERE id = ?";

        try (Connection con = DatabaseConfig.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}
