<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tu T&iacutetulo</title>
    <style>
       
        body {
            font-family: Arial, sans-serif; 
        }

        .navbar-custom {
            background-color: #020732; 
            width: 100%;
            margin: 0 auto;
            padding: 30px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            color: white;
        }

        .navbar-custom .navbar-header {
            width: 80%;
        }

        .navbar-custom .navbar-collapse {
            width: 100%;
        }

   
        .navbar-custom .navbar-left a {
            font-size: 24px; 
            font-weight: bold; 
            color: white; 
            text-decoration: none; 
        }

      
        .navbar-custom .dropdown-menu {
            background-color: #a2fe1d; 
            border: 1px solid #ccc; 
            display: none; 
            position: absolute; 
            z-index: 1000;
        }

        .navbar-custom .dropdown:hover .dropdown-menu {
            display: block; 
        }

        .navbar-custom .dropdown-menu a {
            font-family: Arial, sans-serif; 
            color: black; 
            display: block;
            padding: 10px 15px; 
            text-decoration: none; 
        }

        .navbar-custom .dropdown-menu a:hover {
            background-color: #f3f0f0; 
            color: black; 
        }

      
        .navbar-custom .nav > li {
            margin-left: 30px; 
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="navbar navbar-inverse navbar-fixed-top navbar-custom">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>

                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-left">
                        <li><a href="verIntranetHome">CiberCocher</a></li> <!-- Texto del logo -->
                    </ul>

                    <ul class="nav navbar-nav">
                        <!-- Opciones de Registros para el tipo 1 Profesor -->
                        <c:if test="${!empty sessionScope.objMenusTipo1}">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    Profesor <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu">
                                    <c:forEach var="x" items="${sessionScope.objMenusTipo1}">
                                        <li>
                                            <a href="${x.ruta}">${x.nombre}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:if>

                        <!-- Opciones para Alumno -->
                        <c:if test="${!empty sessionScope.objMenusTipo2}">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    Alumno <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu">
                                    <c:forEach var="x" items="${sessionScope.objMenusTipo2}">
                                        <li>
                                            <a href="${x.ruta}">${x.nombre}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:if>

                        <!-- Opciones para seguridad -->
                        <c:if test="${!empty sessionScope.objMenusTipo3}">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    Seguridad <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu">
                                    <c:forEach var="x" items="${sessionScope.objMenusTipo3}">
                                        <li>
                                            <a href="${x.ruta}">${x.nombre}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:if>

                        <!-- Opciones para proveedor -->
                        <c:if test="${!empty sessionScope.objMenusTipo4}">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    Proveedores <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu">
                                    <c:forEach var="x" items="${sessionScope.objMenusTipo4}">
                                        <li>
                                            <a href="${x.ruta}">${x.nombre}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:if>

                    </ul>

                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="logout">Salir</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
