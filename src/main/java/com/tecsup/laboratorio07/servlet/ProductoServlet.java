package com.tecsup.laboratorio07.servlet;

import com.tecsup.laboratorio07.dao.CategoriaDAO;
import com.tecsup.laboratorio07.dao.ProductoDAO;
import com.tecsup.laboratorio07.model.Categoria;
import com.tecsup.laboratorio07.model.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

/**
 * Servlet para manejar las operaciones CRUD de Productos
 */
@WebServlet(name = "ProductoServlet", urlPatterns = {"/productos"})
public class ProductoServlet extends HttpServlet {
    
    private ProductoDAO productoDAO;
    private CategoriaDAO categoriaDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        productoDAO = new ProductoDAO();
        categoriaDAO = new CategoriaDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            switch (action != null ? action : "list") {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteProducto(request, response);
                    break;
                default:
                    listProductos(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error en operación de base de datos", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "insert":
                    insertProducto(request, response);
                    break;
                case "update":
                    updateProducto(request, response);
                    break;
                default:
                    listProductos(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error en operación de base de datos", e);
        }
    }
    
    private void listProductos(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        List<Producto> productos = productoDAO.findAll();
        request.setAttribute("productos", productos);
        request.getRequestDispatcher("/WEB-INF/views/producto/list.jsp").forward(request, response);
    }
    
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        List<Categoria> categorias = categoriaDAO.findAll();
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("/WEB-INF/views/producto/form.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Producto producto = productoDAO.findById(id);
        
        if (producto != null) {
            List<Categoria> categorias = categoriaDAO.findAll();
            request.setAttribute("producto", producto);
            request.setAttribute("categorias", categorias);
            request.getRequestDispatcher("/WEB-INF/views/producto/form.jsp").forward(request, response);
        } else {
            response.sendRedirect("productos");
        }
    }
    
    private void insertProducto(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String precioStr = request.getParameter("precio");
        String stockStr = request.getParameter("stock");
        String categoriaIdStr = request.getParameter("categoria_id");
        
        // Validaciones básicas
        if (nombre == null || nombre.trim().isEmpty()) {
            response.sendRedirect("productos?action=new&error=El nombre es requerido");
            return;
        }
        
        if (precioStr == null || precioStr.trim().isEmpty()) {
            response.sendRedirect("productos?action=new&error=El precio es requerido");
            return;
        }
        
        if (stockStr == null || stockStr.trim().isEmpty()) {
            response.sendRedirect("productos?action=new&error=El stock es requerido");
            return;
        }
        
        if (categoriaIdStr == null || categoriaIdStr.trim().isEmpty()) {
            response.sendRedirect("productos?action=new&error=La categoría es requerida");
            return;
        }
        
        try {
            BigDecimal precio = new BigDecimal(precioStr);
            int stock = Integer.parseInt(stockStr);
            int categoriaId = Integer.parseInt(categoriaIdStr);
            
            if (precio.compareTo(BigDecimal.ZERO) < 0) {
                response.sendRedirect("productos?action=new&error=El precio debe ser mayor o igual a 0");
                return;
            }
            
            if (stock < 0) {
                response.sendRedirect("productos?action=new&error=El stock debe ser mayor o igual a 0");
                return;
            }
            
            Producto producto = new Producto(nombre.trim(), descripcion, precio, stock, categoriaId);
            
            if (productoDAO.insert(producto)) {
                response.sendRedirect("productos?success=Producto creado exitosamente");
            } else {
                response.sendRedirect("productos?action=new&error=Error al crear el producto");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("productos?action=new&error=Formato de número inválido");
        }
    }
    
    private void updateProducto(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String precioStr = request.getParameter("precio");
        String stockStr = request.getParameter("stock");
        String categoriaIdStr = request.getParameter("categoria_id");
        
        // Validaciones básicas
        if (nombre == null || nombre.trim().isEmpty()) {
            response.sendRedirect("productos?action=edit&id=" + id + "&error=El nombre es requerido");
            return;
        }
        
        if (precioStr == null || precioStr.trim().isEmpty()) {
            response.sendRedirect("productos?action=edit&id=" + id + "&error=El precio es requerido");
            return;
        }
        
        if (stockStr == null || stockStr.trim().isEmpty()) {
            response.sendRedirect("productos?action=edit&id=" + id + "&error=El stock es requerido");
            return;
        }
        
        if (categoriaIdStr == null || categoriaIdStr.trim().isEmpty()) {
            response.sendRedirect("productos?action=edit&id=" + id + "&error=La categoría es requerida");
            return;
        }
        
        try {
            BigDecimal precio = new BigDecimal(precioStr);
            int stock = Integer.parseInt(stockStr);
            int categoriaId = Integer.parseInt(categoriaIdStr);
            
            if (precio.compareTo(BigDecimal.ZERO) < 0) {
                response.sendRedirect("productos?action=edit&id=" + id + "&error=El precio debe ser mayor o igual a 0");
                return;
            }
            
            if (stock < 0) {
                response.sendRedirect("productos?action=edit&id=" + id + "&error=El stock debe ser mayor o igual a 0");
                return;
            }
            
            Producto producto = new Producto(id, nombre.trim(), descripcion, precio, stock, categoriaId, null);
            
            if (productoDAO.update(producto)) {
                response.sendRedirect("productos?success=Producto actualizado exitosamente");
            } else {
                response.sendRedirect("productos?action=edit&id=" + id + "&error=Error al actualizar el producto");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("productos?action=edit&id=" + id + "&error=Formato de número inválido");
        }
    }
    
    private void deleteProducto(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        if (productoDAO.delete(id)) {
            response.sendRedirect("productos?success=Producto eliminado exitosamente");
        } else {
            response.sendRedirect("productos?error=Error al eliminar el producto");
        }
    }
}
