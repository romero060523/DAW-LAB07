<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" 
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-4">
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <h2><i class="bi bi-box"></i> Gestión de Productos</h2>
                    <div>
                        <a href="productos?action=new" class="btn btn-success">
                            <i class="bi bi-plus-circle"></i> Nuevo Producto
                        </a>
                        <a href="index.jsp" class="btn btn-secondary">
                            <i class="bi bi-house"></i> Inicio
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle"></i> ${param.success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle"></i> ${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>


        <div class="row">
            <div class="col-12">
                <div class="card shadow">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0"><i class="bi bi-list-ul"></i> Lista de Productos</h5>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${not empty productos}">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th>ID</th>
                                                <th>Nombre</th>
                                                <th>Descripción</th>
                                                <th>Precio</th>
                                                <th>Stock</th>
                                                <th>Categoría</th>
                                                <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="producto" items="${productos}">
                                                <tr>
                                                    <td>${producto.id}</td>
                                                    <td>
                                                        <strong>${producto.nombre}</strong>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty producto.descripcion}">
                                                                <c:choose>
                                                                    <c:when test="${fn:length(producto.descripcion) > 50}">
                                                                        ${fn:substring(producto.descripcion, 0, 50)}...
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        ${producto.descripcion}
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Sin descripción</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-primary">$${producto.precio}</span>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${producto.stock > 10}">
                                                                <span class="badge bg-success">${producto.stock}</span>
                                                            </c:when>
                                                            <c:when test="${producto.stock > 0}">
                                                                <span class="badge bg-warning">${producto.stock}</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-danger">${producto.stock}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-info">${producto.categoria.nombre}</span>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="productos?action=edit&id=${producto.id}" 
                                                               class="btn btn-sm btn-outline-primary" 
                                                               title="Editar">
                                                                <i class="bi bi-pencil"></i>
                                                            </a>
                                                            <a href="productos?action=delete&id=${producto.id}" 
                                                               class="btn btn-sm btn-outline-danger" 
                                                               title="Eliminar"
                                                               onclick="return confirm('¿Está seguro de eliminar el producto \'${producto.nombre}\'?')">
                                                                <i class="bi bi-trash"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center p-5">
                                    <i class="bi bi-inbox text-muted" style="font-size: 3rem;"></i>
                                    <h5 class="text-muted mt-3">No hay productos registrados</h5>
                                    <p class="text-muted">Comienza creando tu primer producto</p>
                                    <a href="productos?action=new" class="btn btn-success">
                                        <i class="bi bi-plus-circle"></i> Crear Producto
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
            crossorigin="anonymous"></script>
</body>
</html>
