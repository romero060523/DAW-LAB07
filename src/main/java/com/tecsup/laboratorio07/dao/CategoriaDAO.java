package com.tecsup.laboratorio07.dao;

import com.tecsup.laboratorio07.database.DBConexion;
import com.tecsup.laboratorio07.model.Categoria;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO para la entidad Categoría
 */
public class CategoriaDAO {
    
    private static final String SELECT_ALL = "SELECT * FROM categoria ORDER BY nombre";
    private static final String SELECT_BY_ID = "SELECT * FROM categoria WHERE id = ?";
    private static final String INSERT = "INSERT INTO categoria (nombre, descripcion) VALUES (?, ?)";
    private static final String UPDATE = "UPDATE categoria SET nombre = ?, descripcion = ? WHERE id = ?";
    private static final String DELETE = "DELETE FROM categoria WHERE id = ?";
    private static final String EXISTS_BY_NOMBRE = "SELECT COUNT(*) FROM categoria WHERE nombre = ? AND id != ?";
    
    /**
     * Obtiene todas las categorías
     */
    public List<Categoria> findAll() throws SQLException {
        List<Categoria> categorias = new ArrayList<>();
        
        try (Connection conn = DBConexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                categorias.add(mapResultSetToCategoria(rs));
            }
        }
        
        return categorias;
    }
    
    /**
     * Busca una categoría por ID
     */
    public Categoria findById(int id) throws SQLException {
        try (Connection conn = DBConexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_BY_ID)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCategoria(rs);
                }
            }
        }
        
        return null;
    }
    
    /**
     * Inserta una nueva categoría
     */
    public boolean insert(Categoria categoria) throws SQLException {
        try (Connection conn = DBConexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, categoria.getNombre());
            stmt.setString(2, categoria.getDescripcion());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        categoria.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        }
        
        return false;
    }
    
    /**
     * Actualiza una categoría existente
     */
    public boolean update(Categoria categoria) throws SQLException {
        try (Connection conn = DBConexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE)) {
            
            stmt.setString(1, categoria.getNombre());
            stmt.setString(2, categoria.getDescripcion());
            stmt.setInt(3, categoria.getId());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    /**
     * Elimina una categoría por ID
     */
    public boolean delete(int id) throws SQLException {
        try (Connection conn = DBConexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }
    
    /**
     * Verifica si existe una categoría con el mismo nombre (excluyendo el ID dado)
     */
    public boolean existsByNombre(String nombre, int excludeId) throws SQLException {
        try (Connection conn = DBConexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(EXISTS_BY_NOMBRE)) {
            
            stmt.setString(1, nombre);
            stmt.setInt(2, excludeId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        
        return false;
    }
    
    /**
     * Mapea un ResultSet a un objeto Categoria
     */
    private Categoria mapResultSetToCategoria(ResultSet rs) throws SQLException {
        Categoria categoria = new Categoria();
        categoria.setId(rs.getInt("id"));
        categoria.setNombre(rs.getString("nombre"));
        categoria.setDescripcion(rs.getString("descripcion"));
        
        Timestamp timestamp = rs.getTimestamp("fecha_creacion");
        if (timestamp != null) {
            categoria.setFechaCreacion(timestamp.toLocalDateTime());
        }
        
        return categoria;
    }
}
