<%--
  Created by IntelliJ IDEA.
  User: ANDY
  Date: 2/10/2025
  Time: 14:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>


<html>
<head>
    <title>Calculadora JSP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body class="container mt-5">
<h2 class="mb-4">Calculadora JSP con JSTL</h2>

<form action="" method="post" class="mb-4">
    <div class="row mb-3">
        <div class="col">
            <input type="number" name="num1" class="form-control" placeholder="Número 1" required />
        </div>
        <div class="col">
            <input type="number" name="num2" class="form-control" placeholder="Número 2" required />
        </div>
        <div class="col">
            <select name="operacion" class="form-select" required>
                <option value="sumar">Sumar</option>
                <option value="restar">Restar</option>
                <option value="multiplicar">Multiplicar</option>
                <option value="dividir">Dividir</option>
            </select>
        </div>
        <div class="col">
            <button type="submit" class="btn btn-primary">Calcular</button>
        </div>
    </div>
</form>

<c:set var="n1" value="${param.num1}" />
<c:set var="n2" value="${param.num2}" />
<c:set var="op" value="${param.operacion}" />

<c:if test="${not empty n1 and not empty n2 and not empty op}">
    <c:set var="resultado" value="0" />

    <c:choose>
        <c:when test="${op eq 'sumar'}">
            <c:set var="resultado" value="${n1 + n2}" />
        </c:when>

        <c:when test="${op eq 'restar'}">
            <c:set var="resultado" value="${n1 - n2}" />
        </c:when>

        <c:when test="${op eq 'multiplicar'}">
            <c:set var="resultado" value="${n1 * n2}" />
        </c:when>

        <c:when test="${op eq 'dividir'}">
            <c:if test="${n2 ne 0}">
                <c:set var="resultado" value="${n1 / n2}" />
            </c:if>
        </c:when>
    </c:choose>

    <div class="alert alert-success">
        <strong>Resultado:</strong>
            ${n1}
        <c:choose>
            <c:when test="${op eq 'sumar'}"> + </c:when>
            <c:when test="${op eq 'restar'}"> - </c:when>
            <c:when test="${op eq 'multiplicar'}"> x </c:when>
            <c:when test="${op eq 'dividir'}"> / </c:when>
        </c:choose>
            ${n2} = <strong>${resultado}</strong>
    </div>

    <c:if test="${op eq 'dividir' and n2 eq 0}">
        <div class="alert alert-danger">No se puede dividir entre cero</div>
    </c:if>


</c:if>
</body>
</html>
