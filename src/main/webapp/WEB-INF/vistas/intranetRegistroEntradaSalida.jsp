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

        body {
            padding-top: 90px;
            /* Altura de la navbar */
        }

        .navbar-fixed-top {
            height: 100px;
            /* Ajusta la altura de tu navbar seg&uacute;n sea necesario */
        }

        .checkbox-group {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            /* 3 columnas */
            gap: 10px;
            /* Espaciado entre los checkboxes */
        }

        .checkbox-group label {
            display: flex;
            align-items: center;
            border: 1px solid #78b9ff;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .checkbox-reservado {
            background-color: red;
            /* Cambia el fondo a rojo */

        }

        .checkbox-group input[type="checkbox"] {
            margin-right: 10px;
        }

        .checkbox-group label:hover {
            background-color: #076fff;
            /* Color de fondo al pasar el mouse */
        }

        h5 {
            margin-top: 20px;
            /* Espacio arriba de los t&iacute;tulos */
        }

        .espacios-container {
            display: flex;
            justify-content: space-evenly;
            /* Espacio entre los grupos de espacios */
        }
    </style>
    <title>Intranet - Solicitud de Ingreso</title>
</head>

<body>
    <jsp:include page="intranetCabecera.jsp" />
    <div class="container" style="margin-top: 4%">
        <h4>CRUD Alumno</h4>
    </div>

    <div class="container" style="margin-top: 1%">
        <form id="id_form">
            <div class="row" style="height: 70px">
                <div class="col-md-6">
                    <label class="control-label" for="id_espacio">Espacio</label>
                    <select id="id_espacio" name="paramEspacio" class='form-control'>
                        <option value="-1">[Todos]</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="control-label" for="id_tipoVehiculo">Tipo</label>
                    <select id="id_tipoVehiculo" name="paramtipoVehiculo" class='form-control'>
                        <option value="-1">[Todos]</option>
                        <option value="0">Moto</option>
                        <option value="1">Carro</option>
                    </select>
                </div>

                <div class="col-md-6">
                    <label class="control-label" for="id_fechaDesde">Fecha Desde</label>
                    <input class="form-control" type="date" id="id_fechaDesde" name="paramFechaDesde"
                        value="1900-01-01">
                </div>
                <div class="col-md-6">
                    <label class="control-label" for="id_fechaHasta">Fecha Hasta</label>
                    <input class="form-control" type="date" id="id_fechaHasta" name="paramFechaHasta"
                        value="2900-01-01">
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-primary" id="id_btn_filtra"
                        style="width: 150px">Filtrar</button>
                </div>
                <div class="col-md-2">
                    <button type="button" data-toggle='modal' data-target="#id_div_modal_registra"
                        class='btn btn-success' style="width: 150px">REGISTRA</button>
                </div>
                <div class="col-md-2">
                    <button type="button" id="id_btn_reporte" class="btn btn-danger">Reporte</button>
                </div>

            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="content">
                        <table id="id_table" class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th style="width: 8%">ID</th>
                                    <th style="width: 18%">Marca y modelo</th>
                                    <th style="width: 15%">Tipo Vehículo</th>
                                    <th style="width: 12%">Número</th>
                                    <th style="width: 10%">Hora</th>
                                    <th style="width: 15%">Fecha reserva</th>
                                    <th style="width: 7%">Actualizar</th>
                                    <th style="width: 10%">Entrada y Salida</th>
                                    <th style="width: 8%">Estado</th>

                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </form>
    </div>


    <!-- Modal para registrar -->
    <div class="modal fade" id="id_div_modal_registra">
        <div class="modal-dialog" style="width: 60%">

            <div class="modal-content">
                <div class="modal-header" style="padding: 35px 50px">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4><span class="glyphicon glyphicon-ok-sign"></span> Registro de Solicitud</h4>
                </div>
                <div class="modal-body" style="padding: 20px 10px;">
                    <form id="id_form_registra" accept-charset="UTF-8" action="insertaActualizaSolicitud"
                        class="form-horizontal" method="post">
                        <input type="hidden" id="modo" value="registrar"> <!-- Establecer el modo a actualizar -->

                        <div class="panel-group" id="steps">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title"><a data-toggle="collapse" data-parent="#steps"
                                            href="#stepOne">Datos de la solicitud</a></h4>
                                </div>
                                <div id="stepOne" class="panel-collapse collapse in">
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <label class="control-label" for="id_reg_vehiculo">Vehículo</label>
                                            <select id="id_reg_vehiculo" name="vehiculo" class='form-control' required>
                                                <option value="">[Seleccione]</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label" for="id_reg_hora">Hora</label>
                                            <input class="form-control" type="time" id="id_hora" name="hora" required>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label" for="id__reg_fecha_reserva">Fecha
                                                Reserva</label>
                                            <input class="form-control" type="date" id="id_fecha_reserva"
                                                name="fechaReserva" required>
                                        </div>
                                        <label class="control-label" for="id_Espacios">Espacios</label>
                                    </div>
                                </div>
                                <div class="espacios-container" style="margin-top: -30px;">
                                    <div>
                                        <h5>Pabellón E - Piso SS</h5>
                                        <div class="checkbox-group" id="espaciosSSCheckboxes">
                                            <!-- Los checkboxes del Pabellón E - SS se agregarán dinámicamente aquí -->
                                        </div>
                                    </div>
                                    <div>
                                        <h5>Pabellón E - Piso S1</h5>
                                        <div class="checkbox-group" id="espaciosS1Checkboxes">
                                            <!-- Los checkboxes del Pabellón E - S1 se agregarán dinámicamente aquí -->
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-9 col-lg-offset-3">
                                        <button type="button" class="btn btn-primary"
                                            id="id_registrar">REGISTRA</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para actualizar -->
    <div class="modal fade" id="id_div_modal_actualiza">
        <div class="modal-dialog" style="width: 60%">
            <div class="modal-content">
                <div class="modal-header" style="padding: 35px 50px">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4><span class="glyphicon glyphicon-ok-sign"></span> Actualización de Solicitud</h4>
                </div>
                <div class="modal-body" style="padding: 20px 10px;">
                    <form id="id_form_actualiza" accept-charset="UTF-8" action="insertaActualizaSolicitud"
                        class="form-horizontal" method="post">
                        <input type="hidden" id="modo" value="actualizar"> <!-- Establecer el modo a actualizar -->
                        <div class="panel-group" id="steps">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title"><a data-toggle="collapse" data-parent="#steps"
                                            href="#stepUpdate">Datos de la solicitud</a></h4>
                                </div>
                                <div id="stepUpdate" class="panel-collapse collapse in">
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <label class="col-lg-3 control-label" for="id_ID">ID</label>
                                            <div class="col-lg-6">
                                                <input class="form-control" id="id_ID" readonly="readonly"
                                                    name="idSolicitud" type="text" maxlength="8" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label" for="id_act_vehiculo">Vehículo</label>
                                            <select id="id_act_vehiculo" name="vehiculo" class='form-control' required>
                                                <option value="">[Seleccione]</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label" for="id_act_hora">Hora</label>
                                            <input class="form-control" type="time" id="id_act_hora" name="hora"
                                                required>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label" for="id_act_fechaReserva">Fecha
                                                Reserva</label>
                                            <input class="form-control" type="date" id="id_act_fechaReserva"
                                                name="fechaReserva" required>
                                        </div>
                                        <label class="control-label" for="id_Espacios">Espacios</label>
                                    </div>
                                </div>
                                <div class="espacio-container" style="margin-top: 20px;">
                                    <div>
                                        <h5>Pabellón E - Piso SS</h5>
                                        <div class="checkbox-group" id="espaciosSSCheckboxesActualiza">
                                            <!-- Los checkboxes del Pabellón E - SS se agregarán dinámicamente aquí -->
                                        </div>
                                    </div>
                                    <div>
                                        <h5>Pabellón E - Piso S1</h5>
                                        <div class="checkbox-group" id="espaciosS1CheckboxesActualiza">
                                            <!-- Los checkboxes del Pabellón E - S1 se agregarán dinámicamente aquí -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-9 col-lg-offset-3">
                                    <button type="button" class="btn btn-primary"
                                        id="id_btn_actualiza">ACTUALIZA</button>
                                </div>
                            </div>
                        </div>
                </div>
                </form>
            </div>
        </div>
    </div>
    </div>
    <script type="text/javascript">
        var idUsuario = <%= (session.getAttribute("idUsuario") != null) ? session.getAttribute("idUsuario") : 0 %>; // Definir idUsuario desde la sesi&oacute;n


        $(document).ready(function () {
            // Cargar datos solo una vez al inicio
            actualizarComboBox();

            $("#id_registrar").click(function () {
                var modo = $('#modo').val(); // 'registrar' o 'actualizar'
                var validator = $('#id_form_registra').data('bootstrapValidator');
                validator.validate();

                if (validator.isValid()) { // Verifica si el formulario es válido
                    var espaciosSeleccionados = [];
                    $('input[name="espacio"]:checked').each(function () {
                        espaciosSeleccionados.push($(this).val());
                    });

                    // Agregar espacios seleccionados a los datos que se envían
                    $.ajax({
                        type: "POST",
                        url: "registraSolicitud", // Cambiar a la URL correspondiente
                        data: $('#id_form_registra').serialize() + "&espacios=" + espaciosSeleccionados.join(','),
                        success: function (data) {
                            mostrarMensaje(data.MENSAJE);
                            limpiarFormulario(); // Limpiar y actualizar ComboBox
                            validator.resetForm();
                            $('#id_div_modal_registra').modal('hide');

                        },
                        error: function () {
                            mostrarMensaje("Error en la reserva. Inténtalo de nuevo.");
                        }
                    });
                }
            });
            $("#id_btn_actualiza").click(function () {
                var modo = $('#modo').val(); // 'registrar' o 'actualizar'
                var validator = $('#id_form_actualiza').data('bootstrapValidator');
                validator.validate();

                if (validator.isValid()) { // Verifica si el formulario es válido
                    var espaciosSeleccionados = [];
                    $('input[name="espacio"]:checked').each(function () {
                        espaciosSeleccionados.push($(this).val()); // Este valor debe ser el ID del espacio
                    });

                    $.ajax({
                        type: "POST",
                        url: "actualizaSolicitud", // Cambiar a la URL correspondiente para actualizar
                        data: $('#id_form_actualiza').serialize() + "&espacio=" + espaciosSeleccionados.join(','),
                        success: function (data) {
                            mostrarMensaje(data.MENSAJE);
                            validator.resetForm();
                            // Cerrar el modal después de la actualización
                            $('#id_div_modal_actualiza').modal('hide');
                        },
                        error: function () {
                            mostrarMensaje("Error en la actualización. Inténtalo de nuevo.");
                        }
                    });
                }
            });
        });
        function editar(idSolicitud, vehiculo, hora, fechaReserva, numero) {

            // Asigna los valores a los campos del modal de actualización
            $('#id_ID').val(idSolicitud);
            $('#id_act_vehiculo').val(vehiculo);
            $('#id_act_hora').val(hora);
            $('#id_act_fechaReserva').val(fechaReserva);


            // Cargar los vehículos y seleccionar el correspondiente
            actualizarComboBox(vehiculo); // Pasa el vehículo a seleccionar

            // Muestra el modal de actualización
            $('#id_div_modal_actualiza').modal("show");
        }

        function limpiarFormulario() {
            $('#id_form_registra')[0].reset();
            actualizarComboBox(); // Refresca las listas, pero solo después de limpiar el formulario
        }

        function actualizarComboBox(vehiculo) {
            $("#espaciosS1CheckboxesActualiza").empty(); // Limpiar los checkboxes S1
            $("#espaciosSSCheckboxesActualiza").empty(); // Limpiar los checkboxes SS
            $("#espaciosS1Checkboxes").empty();
            $("#espaciosSSCheckboxes").empty();
            $("#id_vehiculo").empty(); // Limpiar el select de vehículos
            $("#id_act_vehiculo").empty().append("<option value=''>[Seleccione]</option>"); // Opción predeterminada
            $.getJSON("listaEspacio", {}, function (data) {
                var espaciosSS = [];
                var espaciosS1 = [];

                // Separar espacios seg&uacute;n el pabell&oacute;n y piso
                $.each(data, function (index, item) {
                    if (item.piso === "SS") {
                        espaciosSS.push(item);
                    } else if (item.piso === "S1") {
                        espaciosS1.push(item);
                    }
                });

                // Agregar checkboxes para Pabell&oacute;n E, Piso SS
                if (espaciosSS.length > 0) {
                    $.each(espaciosSS, function (index, item) {
                        $("#espaciosSSCheckboxes").append(
                            "<label><input type='checkbox' name='espacio' value='" + item.idEspacio + "'> " + item.numero + "</label>"
                        );
                    });
                }

                // Agregar checkboxes para Pabell&oacute;n E, Piso S1
                if (espaciosS1.length > 0) {
                    $.each(espaciosS1, function (index, item) {
                        $("#espaciosS1Checkboxes").append(
                            "<label><input type='checkbox' name='espacio' value='" + item.idEspacio + "'> " + item.numero + "</label>"
                        );
                    });
                }
            });
            // Cargar lista de espacios
            $.getJSON("listaEspacios", {}, function (data) {
                var espaciosSSActualiza = [];
                var espaciosS1Actualiza = [];

                // Separar espacios según el pabellón y piso
                $.each(data, function (index, item) {
                    if (item.piso === "SS") {
                        espaciosSSActualiza.push(item);
                    } else if (item.piso === "S1") {
                        espaciosS1Actualiza.push(item);
                    }
                });

                // Agregar checkboxes para Pabellón SS
                if (espaciosSSActualiza.length > 0) {
                    $.each(espaciosSSActualiza, function (index, item) {
                        var checkbox = "<label";

                        // Si el espacio está reservado (estado_reserva = 1), añadir clase de CSS y deshabilitar el checkbox
                        if (item.estado_reserva === 1) {
                            checkbox += " class='checkbox-reservado'";
                        }

                        checkbox += "><input type='checkbox' name='espacio' value='" + item.idEspacio + "'";

                        if (item.estado_reserva === 1) {
                            checkbox += " disabled"; // Deshabilitar el checkbox si está reservado
                        }

                        checkbox += "> " + item.numero + "</label>";

                        $("#espaciosSSCheckboxesActualiza").append(checkbox);
                    });
                }

                // Agregar checkboxes para Pabellón S1
                if (espaciosS1Actualiza.length > 0) {
                    $.each(espaciosS1Actualiza, function (index, item) {
                        var checkbox = "<label";

                        // Si el espacio está reservado (estado_reserva = 1), añadir clase de CSS y deshabilitar el checkbox
                        if (item.estado_reserva === 1) {
                            checkbox += " class='checkbox-reservado'";
                        }

                        checkbox += "><input type='checkbox' name='espacio' value='" + item.idEspacio + "'";

                        if (item.estado_reserva === 1) {
                            checkbox += " disabled"; // Deshabilitar el checkbox si está reservado
                        }

                        checkbox += "> " + item.numero + "</label>";

                        $("#espaciosS1CheckboxesActualiza").append(checkbox);
                    });
                }
            });

            // Cargar los vehículos del usuario y seleccionar el vehículo correspondiente
            $.getJSON(`listaVehiculosUsuario/${idUsuario}`, function (data, item) {
                // Agregar opciones al select
                $.each(data, function (index, item) {
                    var marcavehiculo = item.marca + " " + item.modelo;
                    $("#id_act_vehiculo").append("<option value='" + item.idVehiculo + "'>" + marcavehiculo + "</option>");
                });

                // Seleccionar el vehículo correspondiente si está disponible
                if (vehiculo) {
                    $('#id_act_vehiculo').val(vehiculo); // Selecciona el vehículo
                }
            });

            // Cargar vehículos del usuario y agregar al select
            $.getJSON("listaVehiculosUsuario/" + idUsuario, {}, function (data) {
                $("#id_reg_vehiculo").empty(); // Limpiar el select antes de agregar nuevas opciones
                // Agregar la opción "Seleccione"
                $("#id_reg_vehiculo").append("<option value=''>[Seleccione]</option>");
                $.each(data, function (index, item) {
                    var marcavehiculo = item.marca + " " + item.modelo;
                    $("#id_reg_vehiculo").append("<option value='" + item.idVehiculo + "'>" + marcavehiculo + "</option>");
                });
            });
        }



        // Configuración del validador de formularios
        $('#id_form_actualiza').bootstrapValidator({
            message: 'Este valor no es válido',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                vehiculo: {
                    validators: {
                        notEmpty: {
                            message: 'Seleccione un vehículo.'
                        }
                    }
                },
                hora: {
                    validators: {
                        notEmpty: {
                            message: 'La hora es obligatoria.'
                        }
                    }
                },
                fechaReserva: {
                    validators: {
                        notEmpty: {
                            message: 'La fecha de reserva es obligatoria.'
                        }
                    }
                }
            }
        });



        $('#id_form_registra').bootstrapValidator({
            message: 'Este valor no es v&aacute;lido',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                vehiculo: {
                    validators: {
                        notEmpty: {
                            message: 'Seleccione un veh&iacute;culo.'
                        }
                    }
                },
                hora: {
                    validators: {
                        notEmpty: {
                            message: 'La hora es obligatoria.'
                        }
                    }
                },
                fechaReserva: {
                    validators: {
                        notEmpty: {
                            message: 'La fecha de reserva es obligatoria.'
                        }
                    }
                }
            }
        });




        // Cargar lista de espacios
        $.getJSON("listaEspacios", {}, function (data) {
            $.each(data, function (i, item) {
                $("#id_espacio").append("<option value=" + item.idEspacio + ">" + item.numero + "</option>");
            });
        });

        // Manejo de reporte
        $("#id_btn_reporte").click(function () {
            $("#id_form").attr('action', 'reporteSolicitudPdf');
            $("#id_form").submit();
        });

        // Filtrar datos
        $("#id_btn_filtra").click(function () {
            var varEstado = $("#id_estado").is(':checked') ? 1 : 0;
            var varEspacio = $("#id_espacio").val();
            var vartipoVehiculo = $("#id_tipoVehiculo").val(); // Tipo de veh&iacute;culo
            var varFechaDesde = $("#id_fechaDesde").val() || '1900-01-01';
            var varFechaHasta = $("#id_fechaHasta").val() || '2900-01-01';


            // Validar fechas
            if (new Date(varFechaDesde) > new Date(varFechaHasta)) {
                alert("La fecha hasta no puede ser menor que la fecha desde");
                return;
            }

            $.getJSON("consultaSolicitud", {
                "idEspacio": varEspacio,
                "tipoVehiculo": vartipoVehiculo, // Par&aacute;metro correcto
                "fecDesde": varFechaDesde,
                "fecHasta": varFechaHasta
            }, function (data) {
                agregarGrilla(data);
            });
        });


        function agregarGrilla(lista) {
            // Verificar si DataTable ya existe
            if ($.fn.DataTable.isDataTable('#id_table')) {
                $('#id_table').DataTable().clear().destroy();
            }

            $('#id_table').DataTable({
                data: lista,
                searching: false,
                ordering: true,
                processing: true,
                pageLength: 10,
                lengthChange: false,
                columns: [
                    { data: "idSolicitud" },
                    {
                        data: function (row) {
                            return row.vehiculo.marca + ' ' + row.vehiculo.modelo; // Combina marca y modelo
                        },
                        className: 'text-center'
                    },
                    {
                        data: function (row) {
                            return (row.vehiculo.tipoVehiculo == 0) ? 'Moto' : 'Carro';
                        },
                        className: 'text-center'
                    },
                    { data: "espacio.numero" },
                    { data: "hora" },
                    { data: "fechaReserva" },
                    {
                        data: function (row) {
                            // Verificar si el estado de la solicitud es 0
                            var botonEditar = row.estado === 0 ?
                                // Si el estado es 0, deshabilitar el botón
                                '<button type="button" class="btn btn-info btn-sm" disabled>Editar</button>' :
                                // Si el estado es diferente de 0, habilitar el botón
                                '<button type="button" class="btn btn-info btn-sm" onclick="editar(\'' + row.idSolicitud + '\', \'' + row.vehiculo.idVehiculo + '\', \'' + row.hora + '\', \'' + row.fechaReserva + '\', \'' + row.espacio.idEspacio + '\')">Editar</button>';

                            return botonEditar;
                        },
                        className: 'text-center'
                    },

                    {
                        data: function (row) {
                            // Mantener el estado original de entrada y salida sin cambios por actualizaciones de otros campos
                            var isEntradaRegistrada = row.entrada;  // Asegúrate de que row.entrada es constante
                            var isSalidaRegistrada = row.salida;    // Asegúrate de que row.salida es constante

                            var botonEntrada = isEntradaRegistrada ?
                                '<button type="button" class="btn btn-danger btn-sm" disabled onclick="alert(\'Registro de entrada ya realizado\')">Registrar Entrada</button>' :
                                '<button type="button" class="btn btn-danger btn-sm" onclick="registrarEntrada(\'' + row.idSolicitud + '\')">Registrar Entrada</button>';

                            var botonSalida = isSalidaRegistrada ?
                                '<button type="button" class="btn btn-danger btn-sm" disabled onclick="alert(\'Registro de salida ya realizado\')">Registrar Salida</button>' :
                                '<button type="button" class="btn btn-danger btn-sm" onclick="registrarSalida(\'' + row.idSolicitud + '\')">Registrar Salida</button>';

                            return '<div class="d-flex justify-content-center">' +
                                '<div style="margin-right: 5px;">' + botonEntrada + '</div>' +
                                '<div>' + botonSalida + '</div>' +
                                '</div>';
                        },
                        className: 'text-center'
                    },
                    {
                        data: function (row) {
                            return (row.estado == 1) ? 'Activo' : 'Inactivo';
                        },
                        className: 'text-center'
                    }
                ]
            });
        }
        function registrarEntrada(idSolicitud) {
            $.ajax({
                url: 'registrarEntradaSalida',
                type: 'POST',
                data: {
                    "idSolicitud": idSolicitud, // ID de la solicitud
                    accion: 'entrada' // Tipo de acción a realizar
                },
                success: function (response) {
                    alert("Registrado Exitosamente entrada"); // Mensaje de éxito
                    // Aquí podrías hacer algo más, como actualizar la tabla o la interfaz
                },
                error: function (xhr, status, error) {
                    alert("Error al registrar entrada: " + error); // Mensaje de error
                }
            });
        }

        // Función para registrar salida
        function registrarSalida(idSolicitud) {
            $.ajax({
                url: 'registrarEntradaSalida',
                type: 'POST',
                data: {
                    "idSolicitud": idSolicitud, // ID de la solicitud
                    accion: 'salida' // Tipo de acción a realizar
                },
                success: function (response) {
                    alert("Registrado Exitosamente salida"); // Mensaje de éxito
                    // Aquí podrías hacer algo más, como actualizar la tabla o la interfaz
                },
                error: function (xhr, status, error) {
                    alert("Error al registrar salida: " + error); // Mensaje de error
                }
            });
        }

    </script>
</body>

</html>