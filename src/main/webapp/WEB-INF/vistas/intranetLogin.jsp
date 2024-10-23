<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Intranet - Login</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #023859; /* Azul oscuro */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Asegura que el cuerpo cubra toda la pantalla */
            background-size: cover;
            background-position: center;
        }

        .login-container {
            background: #61788C; /* Fondo semitransparente gris claro */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.5); /* Sombra ligera */
            text-align: center;
            max-width: 400px; /* Ancho m&ntilde;;;ximo del contenedor */
            width: 100%; /* Asegura que el contenedor se ajuste a la pantalla */
            margin: 0 20px; /* Margen para evitar que el contenedor toque los bordes */
        }

        .login-container img {
            width: 80px; /* Tama&ntilde;;o del logo */
            margin-bottom: 20px;
        }

        .login-container h2 {
            color: #f0f0f0; /* Texto blanco humo */
            margin-bottom: 20px;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            background-color: rgba(255, 255, 255, 0.2); /* Fondo gris claro */
            color: #ffffff; /* Texto blanco */
            outline: none;
        }

        .login-container input[type="text"]::placeholder,
        .login-container input[type="password"]::placeholder {
            color: rgba(255, 255, 255, 0.7); /* Placeholder blanco suave */
        }

        .login-container input[type="submit"] {
            width: 80%; /* Ancho del bot&ntilde;;n ajustado */
            padding: 10px;
            background-color: #024059; /* Azul gris&ntilde;;;ceo para el bot&ntilde;;n */
            border: none;
            border-radius: 5px;
            color: #ffffff; /* Texto blanco */
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px; /* A&ntilde;;adir espacio encima del bot&ntilde;;n */
            font-weight: bold;
            font-size: 16px; /* Tama&ntilde;;o del texto para mayor visibilidad */
        }

        .login-container input[type="submit"]:hover {
            background-color: #023859; /* Color m&ntilde;;;s claro en hover */
        }

        .alert {
            margin-bottom: 20px;
            text-align: center;
            border-radius: 5px;
        }

        /* Estilos para los mensajes de error */
        .error-message {
            color: red; /* Color del mensaje de error */
            font-size: 14px; /* Tama&ntilde;;o de la fuente */
            margin-top: 5px; /* Espacio entre el campo y el mensaje */
            text-align: left; /* Alinear texto a la izquierda */
        }
    </style>
</head>
<body>

    <div class="login-container">
        <c:if test="${requestScope.mensaje != null}">
            <div class="alert alert-danger fade in" id="success-alert">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                <strong>${requestScope.mensaje}</strong>
            </div>
        </c:if>
        <img src="https://cdn-icons-png.flaticon.com/512/5264/5264565.png" alt="Logo"> <!-- Logo de la persona -->
        <h2>LOGIN</h2>
        <form id="id_form" action="login" method="post" class="login-form">
            <div class="form-group">
                <input type="text" name="login" placeholder="Ingresa el usuario" class="form-username" id="form-username" maxlength="20" required>
                <div class="error-message" id="errorLogin"></div> <!-- Mensaje de error para el usuario -->
            </div>
            <div class="form-group">
                <input type="password" name="password" placeholder="Ingresa la contrase&ntilde;a" class="form-password" id="form-password" maxlength="20" required>
                <div class="error-message" id="errorPassword"></div> <!-- Mensaje de error para la contrase&ntilde;;;a -->
            </div>
            <input type="submit" value="Ingresar">
        </form>
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bootstrapValidator.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#success-alert").fadeTo(1000, 500).slideUp(500, function(){
                $("#success-alert").slideUp(500);
            });

            $('#id_form').bootstrapValidator({
                message: 'Este valor no es v&ntilde;;;lido',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    login: {
                        validators: {
                            notEmpty: {
                                message: 'El usuario es obligatorio',
                                callback: function(value, validator, $field) {
                                    $('#errorLogin').text('El usuario es obligatorio');
                                }
                            },
                            stringLength: {
                                message: 'El usuario debe tener entre 3 y 20 caracteres',
                                min: 3,
                                max: 20
                            }
                        }
                    },
                    password: {
                        validators: {
                            notEmpty: {
                                message: 'La contrase&ntilde;;;a es obligatoria',
                                callback: function(value, validator, $field) {
                                    $('#errorPassword').text('La contrase&ntilde;a es obligatoria');
                                }
                            },
                            stringLength: {
                                message: 'La contrase&ntilde;;;a debe tener entre 3 y 20 caracteres',
                                min: 3,
                                max: 20
                            }
                        }
                    }
                },
                excluded: [':disabled'], // Ignorar campos deshabilitados
                submitButtons: 'input[type="submit"]',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                }
            }).on('success.form.bv', function(e) {
                // Limpiar mensajes de error
                $('#errorLogin').text('');
                $('#errorPassword').text('');
            }).on('error.field.bv', function(e, data) {
                // Mostrar el mensaje de error en el campo correspondiente
                if (data.field === 'login') {
                    $('#errorLogin').text(data.message);
                }
                if (data.field === 'password') {
                    $('#errorPassword').text(data.message);
                }
            });
        });
    </script>

</body>
</html>