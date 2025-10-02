package com.tecsup.laboratorio07.dao;

import com.tecsup.laboratorio07.database.DBConexion;
import com.tecsup.laboratorio07.model.Producto;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO para la entidad Producto
 */
public class ProductoDAO {
    
    private static final String SELECT_ALL = """
        SELECT p.*, c.nombre as categoria_nombre 
        FROM producto p 
        JOIN categoria c ON p.categoria_id = c.id 
        ORDER BY p.nombre
        """;
    
    private static final String SELECT_BY_ID = """
        SELECT p.*, c.nombre as categoria_nombre 
        FROM producto p 
        JOIN categoria c ON p.categoria_id = c.id 
        WHERE p.id = ?
        """;
    
    private static final String INSERT = "INSERT INTO producto (nombre, descripcion, precio, stock, categoria_id) VALUES (?, ?, ?, ?, ?)";
    private static final String UPDATE = "UPDATE producto SET nombre = ?, descripcion = ?, precio = ?, stock = ?, categoria_id = ? WHERE id = ?";
    private static final String DELETE = "DELETE FROM producto WHERE id = ?";
    private static final String SELECT_BY_CATEGORIA = """
        SELECT p.*, c.nombre as categoria_nombre 
        FROM producto p 
        JOIN categoria c ON p.categoria_id = c.id 
        WHERE p.categoria_id = ?
        ORDER BY p.nombre
        """;
    
    /**
     * Obtiene todos los productos con información de categoría
     */
    public List<Producto> findAll() throws SQLException {
        List<Producto> productos = new ArrayList<>();
        
        try (Connection conn = DBConexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                productos.add(mapResultSetToProducto(rs));
            }
        }
        
        return productos;
    }
    
    /**
     * Busca un producto por ID
     */
    public Producto findById(int id) throws SQLException {
        try (Connection conn = DBConexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_BY_ID)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProducto(rs);
                }
            }
        }
        
        return null;
    }
    
    /**
     * Inserta un nuevo producto
     */
    public boolean insert(Producto producto) throws SQLException {
        try (Connection conn = DBConexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, producto.getNombre());
            stmt.setString(2, producto.getDescripcion());
            stmt.setBigDecimal(3, producto.getPrecio());
            stmt.setInt(4, producto.getStock());
            stmt.setInt(5, producto.getCategoriaId());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        producto.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        }
        
        return false;
    }
    
    /**
     * Actualiza un producto existente
     */
    public boolean update(Producto producto) throws SQLException {
        try (Connection conn = DBConexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE)) {
            
            stmt.setString(1, producto.getNombre());
            stmt.setString(2, producto.getDescripcion());
            stmt.setBigDecimal(3, producto.getPrecio());
            stmt.setInt(4, producto.getStock());
            stmt.setInt(5, producto.getCategoriaId());
            stmt.setInt(6, producto.getId());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    /**
     * Elimina un producto por ID
     */
    public boolean delete(int id) throws SQLException {
        try (Connection conn = DBConexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }
    
    /**
     * Obtiene productos por categoría
     */
    public List<Producto> findByCategoria(int categoriaId) throws SQLException {
        List<Producto> productos = new ArrayList<>();
        
        try (Connection conn = DBConexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_BY_CATEGORIA)) {
            
            stmt.setInt(1, categoriaId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    productos.add(mapResultSetToProducto(rs));
                }
            }
        }
        
        return productos;
    }
    
    /**
     * Mapea un ResultSet a un objeto Producto
     */
    private Producto mapResultSetToProducto(ResultSet rs) throws SQLException {
        Producto producto = new Producto();
        producto.setId(rs.getInt("id"));
        producto.setNombre(rs.getString("nombre"));
        producto.setDescripcion(rs.getString("descripcion"));
        producto.setPrecio(rs.getBigDecimal("precio"));
        producto.setStock(rs.getInt("stock"));
        producto.setCategoriaId(rs.getInt("categoria_id"));
        
        // Crear objeto Categoria con el nombre
        com.tecsup.laboratorio07.model.Categoria categoria = new com.tecsup.laboratorio07.model.Categoria();
        categoria.setId(rs.getInt("categoria_id"));
        categoria.setNombre(rs.getString("categoria_nombre"));
        producto.setCategoria(categoria);
        
        Timestamp timestamp = rs.getTimestamp("fecha_creacion");
        if (timestamp != null) {
            producto.setFechaCreacion(timestamp.toLocalDateTime());
        }
        
        return producto;
    }
}
