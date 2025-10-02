<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema CRUD - Productos y Categorías</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" 
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white text-center">
                        <h2 class="mb-0">
                            <i class="bi bi-shop"></i>
                            Productos y Categorías
                        </h2>
                    </div>
                    <div class="card-body p-5">
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <div class="card h-100 border-primary">
                                    <div class="card-body text-center">
                                        <i class="bi bi-tags text-primary" style="font-size: 3rem;"></i>
                                        <h4 class="card-title mt-3">Categorías</h4>
                                        <p class="card-text">Gestiona las categorías de productos</p>
                                        <a href="categorias" class="btn btn-primary">
                                            <i class="bi bi-list-ul"></i> Ver Categorías
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4">
                                <div class="card h-100 border-success">
                                    <div class="card-body text-center">
                                        <i class="bi bi-box text-success" style="font-size: 3rem;"></i>
                                        <h4 class="card-title mt-3">Productos</h4>
                                        <p class="card-text">Gestiona el inventario de productos</p>
                                        <a href="productos" class="btn btn-success">
                                            <i class="bi bi-list-ul"></i> Ver Productos
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
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