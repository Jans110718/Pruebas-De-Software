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

    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/dataTables.bootstrap.min.css" />
    <link rel="stylesheet" href="css/bootstrapValidator.css" />

    <title>Registro Veh&iacute;culo</title>

    <style>
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
            padding-top: 90px;
        }

        .navbar-fixed-top {
            height: 100px;
        }
    </style>
</head>

<body>
    <jsp:include page="intranetCabecera.jsp" />

    <div class="container">
        <div class="form-container">
            <h4>Registro de Veh&iacute;culo</h4>
            <form id="id_form" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label class="control-label" for="id_tipoVehiculo">Tipo</label>
                    <select class="form-control" id="id_tipoVehiculo" name="tipoVehiculo" required>
                        <option value="">Seleccione</option>
                        <!-- Las opciones se llenarán aqu&iacute; mediante AJAX -->
                    </select>
                </div>

                <div class="form-group">
                    <label for="id_marca">Marca:</label>
                    <select id="id_marca" class="form-control" required name="marca">
                        <option value="">Seleccione una marca</option>
                        <!-- Las marcas se llenarán aqu&iacute; mediante AJAX -->
                    </select>
                </div>

                <div class="form-group">
                    <label for="id_modelo">Modelo:</label>
                    <select id="id_modelo" class="form-control" required name="modelo">
                        <option value="">Seleccione un modelo</option>
                        <!-- Los modelos se llenarán aqu&iacute; seg&uacute;n la marca seleccionada -->
                    </select>
                </div>

                <div class="form-group">
                    <label class="control-label" for="id_placa">Placa</label>
                    <input class="form-control" type="text" id="id_placa" name="placa" placeholder="Ingrese la placa"
                        maxlength="7">
                </div>

                <div class="form-group">
                    <label for="id_tipo">Tipo de Veh&iacute;culo:</label>
                    <input type="text" id="id_tipo" class="form-control" readonly name="tipo">
                </div>

                <div class="form-group">
                    <label class="control-label" for="id_imagen">Imagen</label>
                    <input class="form-control-file" type="file" id="id_imagen" name="file" accept="image/*" required>
                </div>

                <div class="form-group text-center">
                    <button id="id_registrar" type="button" class="btn btn-primary">Registrar</button>
                </div>
            </form>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            // Cargar tipos de veh&iacute;culo al iniciar
            cargarTiposVehiculo();

            function cargarTiposVehiculo() {
                $.ajax({
                    type: "GET",
                    url: "http://localhost:8070/api/vehiculos", // Cambiado para usar la misma API
                    success: function (data) {
                        var tiposVehiculo = new Set(); // Usar un Set para evitar duplicados
                        $.each(data, function (index, vehiculo) {
                            tiposVehiculo.add(vehiculo.transporte); // Agregar transporte al Set
                        });

                        var $tipoVehiculoSelect = $("#id_tipoVehiculo");
                        $tipoVehiculoSelect.empty();
                        $tipoVehiculoSelect.append("<option value=''>Seleccione un tipo</option>");

                        tiposVehiculo.forEach(function (tipo) {
                            $tipoVehiculoSelect.append("<option value='" + tipo + "'>" + tipo + "</option>");
                        });
                    },
                    error: function () {
                        console.error("Error al cargar los tipos de veh&iacute;culo.");
                    }
                });
            }

            // Cargar marcas seg&uacute;n el tipo de veh&iacute;culo seleccionado
            $("#id_tipoVehiculo").change(function () {
                cargarMarcas();
            });

            function cargarMarcas() {
                var tipoVehiculoSeleccionado = $("#id_tipoVehiculo").val(); // Obtener el tipo seleccionado

                $.ajax({
                    type: "GET",
                    url: "http://localhost:8070/api/vehiculos", // Usar la misma API
                    success: function (data) {
                        var $marcaSelect = $("#id_marca");
                        $marcaSelect.empty();
                        $marcaSelect.append("<option value=''>Seleccione una marca</option>");
                        var marcasUnicas = new Set(); // Usar un Set para evitar duplicados

                        // Filtrar las marcas seg&uacute;n el tipo de veh&iacute;culo seleccionado
                        $.each(data, function (index, vehiculo) {
                            if (vehiculo.transporte === tipoVehiculoSeleccionado) { // Filtrar marcas por tipo de transporte
                                marcasUnicas.add(vehiculo.marca); // Agregar marca al Set
                            }
                        });

                        // Agregar las marcas &uacute;nicas al select
                        marcasUnicas.forEach(function (marca) {
                            $marcaSelect.append("<option value='" + marca + "'>" + marca + "</option>");
                        });
                    },
                    error: function () {
                        console.error("Error al cargar las marcas.");
                    }
                });
            }

            // Cargar modelos seg&uacute;n la marca seleccionada
            $("#id_marca").change(function () {
                var marcaSeleccionada = $(this).val();
                var tipoVehiculoSeleccionado = $("#id_tipoVehiculo").val(); // Obtener el tipo seleccionado
                if (tipoVehiculoSeleccionado === "") {
                    // No se puede seleccionar un modelo si no se ha seleccionado un tipo de veh&iacute;culo
                    alert("Por favor, selecciona primero un tipo de veh&iacute;culo.");
                    $(this).val(''); // Resetea el select de marcas
                    $("#id_modelo").empty().append("<option value=''>Seleccione un modelo</option>"); // Limpia los modelos
                    return; // Salir de la funci&oacute;n
                }
                $.ajax({
                    type: "GET",
                    url: "http://localhost:8070/api/vehiculos", // Este debe ser el endpoint que devuelva los modelos relacionados
                    success: function (data) {
                        var $modeloSelect = $("#id_modelo");
                        $modeloSelect.empty();
                        $modeloSelect.append("<option value=''>Seleccione un modelo</option>");

                        $.each(data, function (index, vehiculo) {
                            // Filtrar modelos por marca
                            if (vehiculo.marca === marcaSeleccionada) {
                                $modeloSelect.append(
                                    "<option value='" + vehiculo.modelo + "' data-tipo='" + vehiculo.tipo + "'>" + vehiculo.modelo + "</option>"
                                );
                            }
                        });
                    },
                    error: function () {
                        console.error("Error al cargar los modelos.");
                    }
                });
            });

            // Actualizar tipo de veh&iacute;culo al seleccionar un modelo
            $("#id_modelo").change(function () {
                var tipoSeleccionado = $(this).find(':selected').data('tipo');
                $("#id_tipo").val(tipoSeleccionado);
            });

            // Manejo del env&iacute;o del formulario
            $("#id_registrar").click(function () {
                var validator = $('#id_form').data('bootstrapValidator');
                validator.validate();

                if (validator.isValid()) {
                    $("#id_registrar").prop('disabled', true); // Deshabilitar bot&oacute;n
                    $.ajax({
                        type: "POST",
                        url: "registraVehiculo", // Aseg&uacute;rate de que esta URL es correcta en tu configuraci&oacute;n
                        data: new FormData($('#id_form')[0]),
                        processData: false,
                        contentType: false,
                        success: function (data) {
                            if (data && data.MENSAJE) {
                                mostrarMensaje(data.MENSAJE);
                            } else {
                                mostrarMensaje("Ocurri&oacute; un error inesperado.");
                            }
                            validator.resetForm();
                            limpiarFormulario();
                        },
                        error: function () {
                            mostrarMensaje("Ocurri&oacute; un error al procesar la solicitud.");
                        },
                        complete: function () {
                            $("#id_registrar").prop('disabled', false); // Habilitar nuevamente
                        }
                    });
                }
            });

            function limpiarFormulario() {
                $('#id_marca').val('');
                $('#id_modelo').val('');
                $('#id_placa').val('');
                $('#id_tipo').val('');
                $('#id_imagen').val('');
            }

            // Validaci&oacute;n del formulario con Bootstrap Validator
            $('#id_form').bootstrapValidator({
                message: 'Este valor no es válido',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    tipoVehiculo: {
                        validators: {
                            notEmpty: {
                                message: 'El tipo de veh&iacute;culo es requerido'
                            }
                        }
                    },
                    marca: {
                        validators: {
                            notEmpty: {
                                message: 'La marca es requerida'
                            }
                        }
                    },
                    modelo: {
                        validators: {
                            notEmpty: {
                                message: 'El modelo es requerido'
                            }
                        }
                    },
                    placa: {
            validators: {
                notEmpty: {
                    message: 'La placa es requerida'
                },
                callback: {
                    message: 'El formato de la placa es incorrecto.',
                    callback: function(value, validator, $field) {
                        // Si el campo está vacío, no hacer la validación de formato
                        if (!value) {
                            return true; // Permitir valores nulos
                        }

                        // Obtener el tipo de vehículo seleccionado
                        var tipoVehiculo = $("#id_tipoVehiculo").val();
                        var regexCarro = /^[A-Z]{3}-\d{3}$/; // Formato para "carro"
                        var regexOtro = /^[A-Z]{2}-\d{4}$/;  // Formato para otros tipos

                        // Validar el formato de la placa seg&uacute;n el tipo de vehículo
                        if (tipoVehiculo === "CARRO") {
                            if (!regexCarro.test(value)) {
                                return {
                                    valid: false,
                                    message: "La placa debe tener el formato 3 letras - 3 n&uacute;meros (ejemplo: ABC-123)."
                                };
                            }
                        } else {
                            if (!regexOtro.test(value)) {
                                return {
                                    valid: false,
                                    message: "La placa debe tener el formato 2 letras - 4 n&uacute;meros (ejemplo: AB-1234)."
                                };
                            }
                        }
                        return true; // La placa cumple con el formato esperado
                    }
                }
            }
        },
                    imagen: {
                        validators: {
                            file: {
                                type: 'image/jpeg,image/png,image/gif',
                                maxSize: 2048000, // 2 MB
                                message: 'La imagen debe ser menor de 2 MB y en formato JPG, PNG o GIF'
                            },
                            notEmpty: {
                                message: 'La imagen es requerida'
                            }
                        }
                    }
                }
            });
        });

    </script>
</body>

</html>