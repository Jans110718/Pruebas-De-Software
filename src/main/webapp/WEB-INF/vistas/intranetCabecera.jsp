<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<div class="container">
    <div class="navbar navbar-inverse navbar-fixed-top">
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
                    <li><a href="verIntranetHome">Home</a></li>
                </ul>

                <ul class="nav navbar-nav">

                    <!-- Opciones de Registros para el tipo 1 (profesores) -->
                    <c:if test="${!empty sessionScope.objMenusTipo1}">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                Profesores <b class="caret"></b>
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

                    <!-- Opciones para alumnos (tipo 2) -->
                    <c:if test="${!empty sessionScope.objMenusTipo2}">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                Alumnos<b class="caret"></b>
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

                    <!-- Opciones para miembros de seguridad (tipo 3) -->
                    <c:if test="${!empty sessionScope.objMenusTipo3}">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                Seguridad<b class="caret"></b>
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

                    <!-- Opciones para proveedores (tipo 4) -->
                    <c:if test="${!empty sessionScope.objMenusTipo4}">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                Proveedores<b class="caret"></b>
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