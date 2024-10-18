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

    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/dataTables.bootstrap.min.css" />
    <link rel="stylesheet" href="css/bootstrapValidator.css" />

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.dataTables.min.js"></script>
    <script src="js/dataTables.bootstrap.min.js"></script>
    <script src="js/bootstrapValidator.js"></script>
    <script src="js/global.js"></script>

    <title>Reserva de Espacios</title>
</head>
<body>
    <jsp:include page="intranetCabecera.jsp" />
    
    <div class="container" style="margin-top: 4%">
        <h4>Reserva de Espacios</h4>
    </div>

    <div class="container" style="margin-top: 1%">
        <form id="id_form" method="post">
            <div class="row">
                <div class="form-group col-md-12">
                    <label class="control-label" for="id_vehiculo">Vehiculo</label>
                    <select id="id_vehiculo" name="vehiculo" class='form-control' required>
                        <option value="">[Seleccione]</option>
                    </select>
                </div>
                <div class="form-group col-sm-12">
                    <label class="control-label" for="id_hora">Hora</label>
                    <input class="form-control" type="time" id="id_hora" name="hora" required>
                </div>
                <div class="form-group col-sm-12">
                    <label class="control-label" for="id_fecha_reserva">Fecha Reserva</label>
                    <input class="form-control" type="date" id="id_fecha_reserva" name="fechaReserva" required>
                </div>
                <div class="form-group col-md-12">
                    <label class="control-label" for="id_espacio">Espacio</label>
                    <select id="id_espacio" name="espacio" class='form-control' required>
                        <option value="">[Seleccione]</option>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-md-12" align="center">
                    <button id="id_registrar" type="button" class="btn btn-primary">Registrar Reserva</button>
                </div>
            </div>
        </form>
    </div>

    <script type="text/javascript">
		
		$(document).ready(function() {
		    actualizarComboBox(); // Cargar datos solo una vez al inicio

		    $("#id_registrar").click(function() {
		        var validator = $('#id_form').data('bootstrapValidator');
		        validator.validate();

		        if (validator.isValid()) { // Verifica si el formulario es válido
		            $.ajax({
		                type: "POST",
		                url: "registraSolicitud", // Cambiar a la URL correspondiente
		                data: $('#id_form').serialize(),
		                success: function(data) {
		                    mostrarMensaje(data.MENSAJE);
		                    limpiarFormulario(); // Limpiar y actualizar ComboBox
		                    validator.resetForm();
		                },
		                error: function() {
		                    mostrarMensaje("Error en la reserva. Inténtalo de nuevo.");
		                }
		            });
		        }
		    });
		});

		function limpiarFormulario() {
		    $('#id_form')[0].reset();
		    actualizarComboBox(); // Refresca las listas, pero solo después de limpiar el formulario
		}


        function actualizarComboBox() {
			$("#id_espacio").empty().append("<option value='' selected>[Seleccione]</option>");
			   $("#id_vehiculo").empty().append("<option value='' selected>[Seleccione]</option>");

			$.getJSON("listaEspacio", {}, function(data) {
					                $.each(data, function(index, item) {
										var ubicacion =item.pabellon + "---Piso:" + item.piso+"---N&uacute;mero"+item.numero ; 

					                    $("#id_espacio").append("<option value='" + item.idEspacio + "'>" + ubicacion + "</option>");
					                });
					            });

					            $.getJSON("listaVehiculo", {}, function(data) {
					                $.each(data, function(index, item) {
					                    var marcavehiculo = item.marca + " " + item.modelo;
					                    $("#id_vehiculo").append("<option value='" + item.idVehiculo + "'>" + marcavehiculo + "</option>");
					                });
					            });
        }

        function compararHoras(horaInicio, horaFin) {
            var horaInicioDate = new Date("1970-01-01 " + horaInicio);
            var horaFinDate = new Date("1970-01-01 " + horaFin);
            return horaInicioDate < horaFinDate;
        }

        $('#id_form').bootstrapValidator({
            message: 'Este valor no es válido',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                usuario: {
                    selector: '#id_usuario',
                    validators: {
                        notEmpty: {
                            message: 'El usuario es un campo obligatorio'
                        },
                    }
                },
                espacio: {
                    selector: '#id_espacio',
                    validators: {
                        notEmpty: {
                            message: 'El espacio es un campo obligatorio'
                        },
                    }
                },
                hora: {
                    selector: "#id_horaInicio",
                    validators: {
                        notEmpty: {
                            message: 'La hora de inicio es obligatoria'
                        }
                    }
                },
                fechaReserva: {
                    selector: "#id_fechaReserva",
                    validators: {
                        notEmpty: {
                            message: 'La fecha de reserva es obligatoria'
                        }
                    }
                },
            }
        });
    </script>
</body>
</html>
