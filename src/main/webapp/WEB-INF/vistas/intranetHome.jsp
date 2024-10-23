<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<jsp:include page="intranetValida.jsp" />
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Expires" content="-1" />
    <meta http-equiv="Cache-Control" content="private" />
    <meta http-equiv="Cache-Control" content="no-store" />
    <meta http-equiv="Pragma" content="no-cache" />

    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/bootstrapValidator.js"></script>

    <link rel="stylesheet" href="css/bootstrap.css"/>
    <link rel="stylesheet" href="css/dataTables.bootstrap.min.css"/>
    <link rel="stylesheet" href="css/bootstrapValidator.css"/>

    <title>Intranet Cibertec</title>

    <style>
        body {
            padding-top: 100px; /* Espacio para la barra de navegaci&oacute;n */
            background-color: #f0f2f5; /* Color de fondo gris claro */
        }

        .navbar-fixed-top {
            height: 100px; /* Altura personalizada para la barra de navegaci&oacute;n */
        }

        /* Estilo para el t&iacute;tulo principal */
        .container h3 {
            text-align: center;
            color: #0056b3; /* Azul oscuro */
            font-size: 2.5rem; /* Tamaño de fuente grande */
            font-weight: 700; /* Negrita */
            text-transform: uppercase; /* Texto en mayúsculas */
            letter-spacing: 2px; /* Espaciado entre letras */
            margin-bottom: 40px; /* Espaciado inferior */
        }

        /* Imagen de banner */
        .banner-img {
            width: 100%;
            max-height: 400px;
            object-fit: cover;
            margin-bottom: 20px;
            border-radius: 10px;
            border: 4px solid #0056b3; /* Bordes en azul oscuro */
        }

        /* Caja de bienvenida */
        .welcome-box {
            background-color: transparent; /* Fondo totalmente transparente */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); /* Sombra m&aacute;s prominente */
            margin-top: 20px;
            border-left: 5px solid #28a745; /* Borde verde a la izquierda */
        }

        h4 {
            color: #343a40; /* Gris oscuro para subt&iacute;tulos */
            margin: 10px 0; /* Espaciado vertical */
        }

        /* Lista de roles con colores de Cibertec */
        .roles-list {
            list-style-type: none;
            padding-left: 0;
        }

        .roles-list li {
            background-color: #28a745; /* Verde para los roles */
            color: white;
            padding: 10px;
            margin-bottom: 5px;
            border-radius: 4px;
            display: inline-block;
            transition: background-color 0.3s; /* Transici&oacute;n suave */
        }

        .roles-list li:hover {
            background-color: #218838; /* Verde oscuro al pasar el mouse */
        }

        /* Espacio adicional al final del contenido */
        .footer-space {
            height: 50px; /* Altura de espacio debajo del contenido */
        }
    </style>
</head>
<body>
    <!-- Incluir la cabecera -->
    <jsp:include page="intranetCabecera.jsp" />

    <!-- Contenido principal -->
    <div class="container">
        <h3>Sistema de Gesti&oacute;n de Ingreso y Salida Vehicular</h3>

        <!-- Imagen de banner -->
        <img src="https://www.cibertec.edu.pe/wp-content/uploads/2020/05/banner-independencia-2.jpg" alt="Banner Independencia" class="banner-img"/>

        <div class="welcome-box">
            <h4>Bienvenido, <strong>${sessionScope.objUsuario.nombreCompleto}</strong></h4>
            <h4>DNI: <strong>${sessionScope.objUsuario.dni}</strong></h4>
            <h4>Roles:</h4>
            <ul class="roles-list">
                <c:forEach var="x" items="${sessionScope.objRoles}">
                    <li>${x.nombre}</li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <!-- Espacio al final del contenido -->
    <div class="footer-space"></div>
</body>
</html>
