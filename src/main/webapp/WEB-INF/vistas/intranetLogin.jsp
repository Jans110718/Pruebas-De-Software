<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

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

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/bootstrapValidator.css">

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bootstrapValidator.js"></script>

    <title>Intranet</title>
    <style>
        body {
            background: linear-gradient(to right, #003366, #00ff66); /* Degradado de azul oscuro a verde fosforescente */
            font-family: 'Roboto', sans-serif;
            color: #333;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-box {
            background: white;
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            max-width: 300px; /* Ancho reducido */
            width: 100%;
            text-align: center;
        }

        .form-top {
            margin-bottom: 10px; /* Espacio reducido entre el t&iacutetulo y el formulario */
        }

        .form-top h3 {
            margin-bottom: 5px; /* Menos espacio debajo del t&iacutetulo */
            font-size: 28px;
            color: #003366; /* Color del t&iacutetulo */
            font-weight: 500;
            text-align: center; /* Centra el texto */
        }

        .form-bottom {
            position: relative;
        }

        .form-control {
            border-radius: 5px;
            border: 1px solid #ddd;
            padding: 15px; /* Aumenta el padding para más espacio */
            transition: border-color 0.3s, box-shadow 0.3s;
            font-size: 16px; /* Aumenta el tamaño de la fuente */
            margin-bottom: 10px; /* Espacio entre campos de texto */
        }

        .form-control:focus {
            border-color: #00ff66; /* Color del borde al enfocar */
            box-shadow: 0 0 5px rgba(0, 255, 102, 0.5);
        }

        .btn-primary {
            background-color: #007bff; /* Color de fondo del botón */
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            color: white; /* Color del texto del botón */
            font-weight: bold; /* Negrita para el texto del botón */
            text-transform: uppercase; /* Texto en mayúsculas */
            transition: background-color 0.3s, transform 0.2s;
            width: 100%; /* Botón a ancho completo */
            font-size: 16px; /* Aumenta el tamaño de la fuente del botón */
        }

        .btn-primary:hover {
            background-color: #0056b3; /* Color de fondo al pasar el ratón */
            transform: translateY(-2px);
        }

        .alert {
            margin-bottom: 20px;
            text-align: center;
            border-radius: 5px;
        }

        .logo {
            width: 80px; /* Ajusta el tamaño según tus necesidades */
            margin-bottom: 20px; /* Espacio entre el logo y el t&iacutetulo */
        }

        /* Estilos para los mensajes de error */
        .error-message {
            color: red; /* Color del mensaje de error */
            font-size: 14px; /* Tamaño de la fuente */
            margin-top: 5px; /* Espacio entre el campo y el mensaje */
            text-align: left; /* Alinear texto a la izquierda */
        }
    </style>
</head>
<body>

    <div class="container">
        <c:if test="${requestScope.mensaje != null}">
            <div class="alert alert-danger fade in" id="success-alert">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                <strong>${requestScope.mensaje}</strong>
            </div>
        </c:if>
        <div class="form-box">
            <img src="https://e7.pngegg.com/pngimages/178/595/png-clipart-user-profile-computer-icons-login-user-avatars-monochrome-black-thumbnail.png" alt="Logo" class="logo"> <!-- Logo de la persona -->
            <div class="form-top">
                <h3>LOGIN</h3>
            </div>
            <div class="form-bottom">
                <form id="id_form" action="login" method="post" class="login-form">
                    <div class="form-group">
                        <input type="text" name="login" placeholder="Ingresa el usuario" class="form-username form-control" id="form-username" maxlength="20" >
                        <div class="error-message" id="errorLogin"></div> <!-- Mensaje de error para el usuario -->
                    </div>
                    <div class="form-group">
                        <input type="password" name="password" placeholder="Ingresa la contrase&ntilde;a" class="form-password form-control" id="form-password" maxlength="20" >
                        <div class="error-message" id="errorPassword"></div> <!-- Mensaje de error para la contrase&ntilde;a -->
                    </div>
                    <button type="submit" class="btn btn-primary">Ingresar</button>
                </form>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#success-alert").fadeTo(1000, 500).slideUp(500, function(){
                $("#success-alert").slideUp(500);
            });

            $('#id_form').bootstrapValidator({
                message: 'Este valor no es válido',
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
                                message: 'La contrase&ntilde;a es obligatoria',
                                callback: function(value, validator, $field) {
                                    $('#errorPassword').text('La contrase&ntilde;a es obligatoria');
                                }
                            },
                            stringLength: {
                                message: 'La contrase&ntilde;a debe tener entre 3 y 20 caracteres',
                                min: 3,
                                max: 20
                            }
                        }
                    }
                },
                excluded: [':disabled'], // Ignorar campos deshabilitados
                submitButtons: 'button[type="submit"]',
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

            $('#validateBtn').click(function() {
                $('#id_form').bootstrapValidator('validate');
            });
        });
    </script>

</body>
</html>
