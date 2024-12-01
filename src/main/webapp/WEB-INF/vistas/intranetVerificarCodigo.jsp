<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/bootstrapValidator.js"></script>
        <script type="text/javascript" src="js/global.js"></script>

        <link rel="stylesheet" href="css/bootstrap.css" />
        <link rel="stylesheet" href="css/dataTables.bootstrap.min.css" />
        <link rel="stylesheet" href="css/bootstrapValidator.css" />
        <title>Verificar Código de Recuperación</title>

        <!-- Estilos personalizados -->
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

            .check-icon {
                color: green;
                font-size: 1.5rem;
                display: none;
            }

            .form-group .btn-verificar {
                margin-left: 10px;
            }
        </style>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> <!-- SweetAlert para mensajes -->
    </head>

    <body>
        <div class="login-container">
            <!-- Fondo de puntos -->
            <div class="dots-bg">
                <div class="dot" style="top: 20%; left: 30%;"></div>
                <div class="dot" style="top: 60%; left: 60%;"></div>
                <div class="dot" style="top: 10%; left: 80%;"></div>
                <!-- Añadir más puntos según sea necesario -->
            </div>

            <div class="login-header">
                <h1>Verificar Código de Recuperación</h1>
                <p class="subtitle">Ingresa el código de recuperación enviado a tu correo.</p>
            </div>

            <!-- Formulario de verificación de código -->
            <form id="id_form" method="post">
                <input type="hidden" id="correo" name="correo" value="${correo}">
                <div class="form-group">
                    <label for="id_codigo">Código de Verificación:</label>
                    <input type="text" class="form-control" id="id_codigo" name="codigoIngresado"
                        placeholder="Ingrese el código de verificación" required>
                </div>

                <div class="form-group text-center">
                    <button id="id_verificar" type="button" class="btn btn-primary">Verificar</button>
                </div>
            </form>


        </div>

        <script type="text/javascript">
            $(document).ready(function () {
                $("#id_verificar").click(function () {
                    var correo = $("#correo").val();  // Obtener el correo desde el formulario

                    var validator = $('#id_form').data('bootstrapValidator');
                    validator.validate();

                    if (validator.isValid()) {
                        $("#id_verificar").prop('disabled', true);
                        $.ajax({
                            type: "POST",
                            url: "validarCodigo",  // URL del controlador para procesar la verificación
                            data: {
                                correo: $("#correo").val(),  // Ahora con el id correcto
                                codigoIngresado: $("#id_codigo").val() // El código ingresado // Incluye el código ingresado
                            },   // Enviar los datos del formulario
                            success: function (data) {
                                // Imprimir los datos enviados en la consola
                                console.log("Datos enviados: ", $('#id_form').serialize());
                                console.log("Respuesta del servidor: ", data);

                                // Mostrar el mensaje
                                if (data && data.MENSAJE) {
                                    mostrarMensaje(data.MENSAJE);

                                    // Verifica si la clave REDIRECCIONAR está presente
                                    if (data.REDIRECCIONAR) {
                                        console.log("Redirigiendo a:", data.REDIRECCIONAR);  // Verifica la URL de redirección
                                        // Aquí, agregamos el correo a la URL de redirección
                                        window.location.href = data.REDIRECCIONAR + "?correo=" + correo;  // Redirige a la página especificada con el correo
                                    }  // Mostrar el mensaje del servidor
                                } else {
                                    mostrarMensaje("Ocurrió un error inesperado.");
                                }
                                validator.resetForm();  // Resetear formulario si es necesario
                            },
                            error: function () {
                                mostrarMensaje("Ocurrió un error al procesar la solicitud.");
                            },
                            complete: function () {
                                $("#id_verificar").prop('disabled', false);
                            }
                        });
                    }
                });

                function mostrarMensaje(mensaje) {
                    $('#mensaje').text(mensaje);  // Mostrar mensaje en el contenedor con id 'mensaje'
                }

                // Bootstrap Validator configuración
                $('#id_form').bootstrapValidator({
                    feedbackIcons: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        codigo: {
                            validators: {
                                notEmpty: {
                                    message: 'El código de verificación es obligatorio'
                                },
                                stringLength: {
                                    min: 6,
                                    message: 'El código debe tener al menos 6 caracteres'
                                }
                            }
                        }
                    }
                });
            });
        </script>

    </body>

    </html>