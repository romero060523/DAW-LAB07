<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${not empty producto}">Editar Producto</c:when>
            <c:otherwise>Nuevo Producto</c:otherwise>
        </c:choose>
    </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" 
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <!-- Header -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="d-flex justify-content-between align-items-center">
                            <h2>
                                <i class="bi bi-box"></i>
                                <c:choose>
                                    <c:when test="${not empty producto}">Editar Producto</c:when>
                                    <c:otherwise>Nuevo Producto</c:otherwise>
                                </c:choose>
                            </h2>
                            <a href="productos" class="btn btn-secondary">
                                <i class="bi bi-arrow-left"></i> Volver
                            </a>
                        </div>
                    </div>
                </div>

                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle"></i> ${param.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="card shadow">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0">
                            <i class="bi bi-form"></i>
                            <c:choose>
                                <c:when test="${not empty producto}">Información del Producto</c:when>
                                <c:otherwise>Datos del Nuevo Producto</c:otherwise>
                            </c:choose>
                        </h5>
                    </div>
                    <div class="card-body">
                        <form action="productos" method="post" novalidate>
                            <c:if test="${not empty producto}">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${producto.id}">
                            </c:if>
                            <c:if test="${empty producto}">
                                <input type="hidden" name="action" value="insert">
                            </c:if>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="nombre" class="form-label">
                                        <i class="bi bi-tag"></i> Nombre <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="nombre" 
                                           name="nombre" 
                                           value="${producto.nombre}"
                                           required 
                                           maxlength="150"
                                           placeholder="Ingrese el nombre del producto">
                                    <div class="invalid-feedback">
                                        El nombre es requerido y debe tener máximo 150 caracteres.
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="categoria_id" class="form-label">
                                        <i class="bi bi-tags"></i> Categoría <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select" id="categoria_id" name="categoria_id" required>
                                        <option value="">Seleccione una categoría</option>
                                        <c:forEach var="categoria" items="${categorias}">
                                            <option value="${categoria.id}" 
                                                    <c:if test="${producto.categoriaId eq categoria.id}">selected</c:if>>
                                                ${categoria.nombre}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">
                                        Debe seleccionar una categoría.
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12 mb-3">
                                    <label for="descripcion" class="form-label">
                                        <i class="bi bi-text-paragraph"></i> Descripción
                                    </label>
                                    <textarea class="form-control" 
                                              id="descripcion" 
                                              name="descripcion" 
                                              rows="3" 
                                              maxlength="500"
                                              placeholder="Ingrese una descripción del producto (opcional)">${producto.descripcion}</textarea>
                                    <div class="form-text">
                                        Máximo 500 caracteres. Este campo es opcional.
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="precio" class="form-label">
                                        <i class="bi bi-currency-dollar"></i> Precio <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <input type="number" 
                                               class="form-control" 
                                               id="precio" 
                                               name="precio" 
                                               value="${producto.precio}"
                                               required 
                                               min="0" 
                                               step="0.01"
                                               placeholder="0.00">
                                    </div>
                                    <div class="invalid-feedback">
                                        El precio es requerido y debe ser mayor o igual a 0.
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="stock" class="form-label">
                                        <i class="bi bi-boxes"></i> Stock <span class="text-danger">*</span>
                                    </label>
                                    <input type="number" 
                                           class="form-control" 
                                           id="stock" 
                                           name="stock" 
                                           value="${producto.stock}"
                                           required 
                                           min="0"
                                           placeholder="0">
                                    <div class="invalid-feedback">
                                        El stock es requerido y debe ser mayor o igual a 0.
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="productos" class="btn btn-secondary me-md-2">
                                            <i class="bi bi-x-circle"></i> Cancelar
                                        </a>
                                        <button type="submit" class="btn btn-success">
                                            <i class="bi bi-check-circle"></i>
                                            <c:choose>
                                                <c:when test="${not empty producto}">Actualizar Producto</c:when>
                                                <c:otherwise>Crear Producto</c:otherwise>
                                            </c:choose>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <c:if test="${not empty producto}">
                    <div class="card mt-4">
                        <div class="card-header bg-info text-white">
                            <h6 class="mb-0"><i class="bi bi-info-circle"></i> Información Adicional</h6>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <strong>ID:</strong> ${producto.id}
                                </div>
                                <div class="col-md-4">
                                    <strong>Categoría:</strong> ${producto.categoria.nombre}
                                </div>
                                <div class="col-md-4">
                                    <strong>Fecha de Creación:</strong> 
                                    <c:choose>
                                        <c:when test="${not empty producto.fechaCreacion}">
                                            ${producto.fechaCreacion}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">No disponible</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
            crossorigin="anonymous"></script>
    
    <script>
        (function() {
            'use strict';
            window.addEventListener('load', function() {
                var forms = document.getElementsByClassName('needs-validation');
                var validation = Array.prototype.filter.call(forms, function(form) {
                    form.addEventListener('submit', function(event) {
                        if (form.checkValidity() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();
    </script>
</body>
</html>
