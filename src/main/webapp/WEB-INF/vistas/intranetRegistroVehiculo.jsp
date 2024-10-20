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
    <script type="text/javascript" src="js/global.js"></script>

    <link rel="stylesheet" href="css/bootstrap.css"/>
    <link rel="stylesheet" href="css/dataTables.bootstrap.min.css"/>
    <link rel="stylesheet" href="css/bootstrapValidator.css"/>

    <title>Registro Vehículo</title>

    <style>
        /* Estilos para centrar el formulario */
        .form-container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #f9f9f9;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        h4 {
            text-align: center;
            margin-bottom: 20px;
        }
        body {
        padding-top: 90px; /* Altura de la navbar */
    }

    .navbar-fixed-top {
        height: 100px; /* Ajusta la altura de tu navbar según sea necesario */
    }
    </style>
</head>
<body>
    <jsp:include page="intranetCabecera.jsp" />

    <div class="container">
        <div class="form-container">
            <h4>Registro de Vehículo</h4>
            <form id="id_form" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label class="control-label" for="id_marca">Marca</label>
                    <input class="form-control" type="text" id="id_marca" name="marca" placeholder="Ingrese la marca">
                </div>

                <div class="form-group">
                    <label class="control-label" for="id_modelo">Modelo</label>
                    <input class="form-control" type="text" id="id_modelo" name="modelo" placeholder="Ingrese el modelo">
                </div>

                <div class="form-group">
                    <label class="control-label" for="id_placa">Placa</label>
                    <input class="form-control" type="text" id="id_placa" name="placa" placeholder="Ingrese la placa" maxlength="7">
                </div>

                <div class="form-group">
                    <label class="control-label" for="id_color">Color</label>
                    <input class="form-control" type="text" id="id_color" name="color" placeholder="Ingrese el color" maxlength="50">
                </div>
                
                <div class="form-group">
                    <label class="control-label" for="id_imagen">Imagen</label>
                    <input class="form-control-file" type="file" id="id_imagen" name="file" accept="image/*">
                </div>

                <div class="form-group text-center">
                    <button id="id_registrar" type="button" class="btn btn-primary">Registrar</button>
                </div>
            </form>
        </div>
    </div>

    <script type="text/javascript">
        // Validación y envío del formulario
        $("#id_registrar").click(function() {
            var validator = $('#id_form').data('bootstrapValidator');
            validator.validate();

            if (validator.isValid()) {
                $("#id_registrar").prop('disabled', true); // Deshabilitar botón
                $.ajax({
                    type: "POST",
                    url: "registraVehiculo",
                    data: new FormData($('#id_form')[0]), // Enviar FormData
                    processData: false,
                    contentType: false,
                    success: function(data) {
                        if(data && data.MENSAJE) {
                            mostrarMensaje(data.MENSAJE);
                        } else {
                            mostrarMensaje("Ocurrió un error inesperado.");
                        }
                        validator.resetForm();
                        limpiarFormulario();
                    },
                    error: function() {
                        mostrarMensaje("Ocurrió un error al procesar la solicitud.");
                    },
                    complete: function() {
                        $("#id_registrar").prop('disabled', false); // Habilitar nuevamente
                    }
                });
            }
        });

        function limpiarFormulario() {
            $('#id_marca').val('');
            $('#id_modelo').val('');
            $('#id_placa').val('');
            $('#id_color').val('');
            $('#id_imagen').val(''); // Limpiar campo de imagen
        }

        // Validación del formulario con Bootstrap Validator
        $('#id_form').bootstrapValidator({
            message: 'Este valor no es válido',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                marca: {
                    validators: {
                        notEmpty: {
                            message: 'La marca es obligatoria'
                        },
                        stringLength: {
                            min: 2,
                            max: 40,
                            message: 'La marca debe tener entre 2 y 40 caracteres'
                        }
                    }
                },
                modelo: {
                    validators: {
                        notEmpty: {
                            message: 'El modelo es obligatorio'
                        },
                        stringLength: {
                            min: 2,
                            max: 40,
                            message: 'El modelo debe tener entre 2 y 40 caracteres'
                        }
                    }
                },
                placa: {
                    validators: {
                        notEmpty: {
                            message: 'La placa es obligatoria'
                        },
                        stringLength: {
                            min: 7,
                            max: 7,
                            message: 'La placa debe tener 7 caracteres'
                        }
                    }
                },
                color: {
                    validators: {
                        notEmpty: {
                            message: 'El color es obligatorio'
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>
