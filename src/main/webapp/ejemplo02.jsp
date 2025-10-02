<%--
  Created by IntelliJ IDEA.
  User: ANDY
  Date: 2/10/2025
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Listado de Cursos</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

</head>
<body class="container mt-5">
<h2 class="mb-4">Listado de Cursos</h2>

<c:set var="listadoCursos" value="${[
    {'chrCurCodigo': 'C001', 'vchCurNombre': 'Matematicas', 'intCurCreditos':3},
    {'chrCurCodigo': 'C002', 'vchCurNombre': 'Física', 'intCurCreditos':4},
    {'chrCurCodigo': 'C003', 'vchCurNombre': 'Historia', 'intCurCreditos':2}
]}" />

<table class="table table-bordered table-striped">
    <thead class="table-dark">
    <tr>
        <th>Código</th>
        <th>Nombre</th>
        <th>Créditos</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="curso" items="${listadoCursos}">
        <tr>
            <td>${curso.chrCurCodigo}</td>
            <td>${curso.vchCurNombre}</td>
            <td>${curso.intCurCreditos}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
