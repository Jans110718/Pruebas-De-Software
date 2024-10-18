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

    <title>Registro Veh&iacute;culo</title>

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
    </style>
</head>
<body>
    <jsp:include page="intranetCabecera.jsp" />

    <div class="container">
        <div class="form-container">
            <h4>Registro de Veh&iacute;culo</h4>
            <form id="id_form" method="post">
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

                <div class="form-group text-center">
                    <button id="id_registrar" type="button" class="btn btn-primary">Registrar</button>
                </div>
            </form>
        </div>
    </div>

    <script type="text/javascript">
        // Validación y env&iacute;o del formulario
        $("#id_registrar").click(function() {
            var validator = $('#id_form').data('bootstrapValidator');
            validator.validate();

            if (validator.isValid()) {
                $.ajax({
                    type: "POST",
                    url: "registraVehiculo",
                    data: $('#id_form').serialize(),
                    success: function(data) {
                        mostrarMensaje(data.MENSAJE);
                        validator.resetForm();
                        limpiarFormulario();
                    },
                    error: function() {
                        mostrarMensaje(MSG_ERROR);
                    }
                });
            }
        });

        function limpiarFormulario() {
            $('#id_marca').val('');
            $('#id_modelo').val('');
            $('#id_placa').val('');
            $('#id_color').val('');
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