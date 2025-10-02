package com.tecsup.laboratorio07.servlet;

import com.tecsup.laboratorio07.dao.CategoriaDAO;
import com.tecsup.laboratorio07.model.Categoria;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Servlet para manejar las operaciones CRUD de Categorías
 */
@WebServlet(name = "CategoriaServlet", urlPatterns = {"/categorias"})
public class CategoriaServlet extends HttpServlet {
    
    private CategoriaDAO categoriaDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
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
                    deleteCategoria(request, response);
                    break;
                default:
                    listCategorias(request, response);
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
                    insertCategoria(request, response);
                    break;
                case "update":
                    updateCategoria(request, response);
                    break;
                default:
                    listCategorias(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error en operación de base de datos", e);
        }
    }
    
    private void listCategorias(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        List<Categoria> categorias = categoriaDAO.findAll();
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("/WEB-INF/views/categoria/list.jsp").forward(request, response);
    }
    
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/WEB-INF/views/categoria/form.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Categoria categoria = categoriaDAO.findById(id);
        
        if (categoria != null) {
            request.setAttribute("categoria", categoria);
            request.getRequestDispatcher("/WEB-INF/views/categoria/form.jsp").forward(request, response);
        } else {
            response.sendRedirect("categorias");
        }
    }
    
    private void insertCategoria(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        
        // Validaciones básicas
        if (nombre == null || nombre.trim().isEmpty()) {
            response.sendRedirect("categorias?action=new&error=El nombre es requerido");
            return;
        }
        
        // Verificar si ya existe una categoría con el mismo nombre
        if (categoriaDAO.existsByNombre(nombre.trim(), 0)) {
            response.sendRedirect("categorias?action=new&error=Ya existe una categoría con ese nombre");
            return;
        }
        
        Categoria categoria = new Categoria(nombre.trim(), descripcion);
        
        if (categoriaDAO.insert(categoria)) {
            response.sendRedirect("categorias?success=Categoría creada exitosamente");
        } else {
            response.sendRedirect("categorias?action=new&error=Error al crear la categoría");
        }
    }
    
    private void updateCategoria(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        
        // Validaciones básicas
        if (nombre == null || nombre.trim().isEmpty()) {
            response.sendRedirect("categorias?action=edit&id=" + id + "&error=El nombre es requerido");
            return;
        }
        
        // Verificar si ya existe otra categoría con el mismo nombre
        if (categoriaDAO.existsByNombre(nombre.trim(), id)) {
            response.sendRedirect("categorias?action=edit&id=" + id + "&error=Ya existe una categoría con ese nombre");
            return;
        }
        
        Categoria categoria = new Categoria(id, nombre.trim(), descripcion, null);
        
        if (categoriaDAO.update(categoria)) {
            response.sendRedirect("categorias?success=Categoría actualizada exitosamente");
        } else {
            response.sendRedirect("categorias?action=edit&id=" + id + "&error=Error al actualizar la categoría");
        }
    }
    
    private void deleteCategoria(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        if (categoriaDAO.delete(id)) {
            response.sendRedirect("categorias?success=Categoría eliminada exitosamente");
        } else {
            response.sendRedirect("categorias?error=Error al eliminar la categoría");
        }
    }
}
