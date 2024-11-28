<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - CIBERTEC</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #003953;
            position: relative;
            overflow: hidden;
        }

        /* Dots decoration */
        .dots-bg {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            overflow: hidden;
            opacity: 0.5;
            pointer-events: none;
        }

        .dot {
            position: absolute;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            position: absolute;
        }

        .dot:nth-child(3n) {
            background: #3498db;
        }

        .dot:nth-child(3n+1) {
            background: #2ecc71;
        }

        .dot:nth-child(3n+2) {
            background: #00b8d4;
        }

        .login-container {
            background: white;
            padding: 2.5rem;
            border-radius: 20px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            margin: 1rem;
            position: relative;
            z-index: 1;
        }

        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        h1 {
            color: #003953;
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .subtitle {
            color: #64748b;
            font-size: 0.9rem;
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }

        .form-control {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 1rem;
            color: #003953;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #003953;
            box-shadow: 0 0 0 4px rgba(0, 57, 83, 0.1);
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
            padding: 0.8rem 1rem;
            color: white;
            font-weight: bold;
            width: 100%;
            border-radius: 5px;
            transition: background-color 0.3s;
            font-size: 1rem;
            text-transform: uppercase;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .alert {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo {
            width: 80px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1>Recuperar Contraseña</h1>
            <p class="subtitle">Ingresa tu correo electrónico para recibir instrucciones para restablecer tu contraseña</p>
        </div>

        <c:if test="${requestScope.mensaje != null}">
            <div class="alert alert-info" id="info-alert">
                <strong>${requestScope.mensaje}</strong>
            </div>
        </c:if>

        <form id="recuperar_form" action="/recuperar-contraseña" method="post" class="login-form">
            <div class="form-group">
                <input type="email" name="email" placeholder="Ingresa tu correo electrónico" class="form-control" id="form-email" maxlength="50" required>
            </div>
            <button type="submit" class="btn btn-primary">Recuperar Contraseña</button>
        </form>
    </div>

    <script type="text/javascript">
        // Script para manejo de alertas y validación si es necesario
        $(document).ready(function () {
            $("#info-alert").fadeTo(1000, 500).slideUp(500, function () {
                $("#info-alert").slideUp(500);
            });
        });
    </script>
</body>
</html>
