package com.mycompany.mavenproject3.dao;

import com.mycompany.mavenproject3.db.DatabaseConfig;
import com.mycompany.mavenproject3.model.MejoresChampus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO = Data Access Object para "Mejores Champús".
 * Responsable exclusivo de las operaciones CRUD en la tabla 'champus'.
 */
public class MejoresChampusDAO {

    // ---------------------------------------------------------------
    // SELECT: Traer todo el catálogo de champús
    // ---------------------------------------------------------------
    public List<MejoresChampus> listar() throws SQLException {
        List<MejoresChampus> lista = new ArrayList<>();
        String sql = "SELECT id, marca, tipo, mililitros, precio FROM champus ORDER BY id";

        try (Connection con = DatabaseConfig.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                MejoresChampus c = new MejoresChampus(
                    rs.getInt("id"),
                    rs.getString("marca"),
                    rs.getString("tipo"),
                    rs.getInt("mililitros"),
                    rs.getDouble("precio")
                );
                lista.add(c);
            }
        }
        return lista;
    }

    // ---------------------------------------------------------------
    // INSERT: Guardar un nuevo champú en la tienda
    // ---------------------------------------------------------------
    public int insertar(MejoresChampus champu) throws SQLException {
        String sql = "INSERT INTO champus (marca, tipo, mililitros, precio) VALUES (?, ?, ?, ?)";

        try (Connection con = DatabaseConfig.getConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, champu.getMarca());
            ps.setString(2, champu.getTipo());
            ps.setInt(3, champu.getMililitros());
            ps.setDouble(4, champu.getPrecio());
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
    // UPDATE: Modificar datos de un champú existente
    // ---------------------------------------------------------------
    public boolean actualizar(int id, MejoresChampus champu) throws SQLException {
        String sql = "UPDATE champus SET marca = ?, tipo = ?, mililitros = ?, precio = ? WHERE id = ?";

        try (Connection con = DatabaseConfig.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, champu.getMarca());
            ps.setString(2, champu.getTipo());
            ps.setInt(3, champu.getMililitros());
            ps.setDouble(4, champu.getPrecio());
            ps.setInt(5, id);

            return ps.executeUpdate() > 0;
        }
    }

    // ---------------------------------------------------------------
    // DELETE: Quitar un champú del catálogo
    // ---------------------------------------------------------------
    public boolean eliminar(int id) throws SQLException {
        String sql = "DELETE FROM champus WHERE id = ?";

        try (Connection con = DatabaseConfig.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}