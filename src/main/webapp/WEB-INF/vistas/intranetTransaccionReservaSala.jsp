<jsp:include page="intranetValida.jsp" />
<!DOCTYPE html>
<html lang="esS">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
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

<title>Intranet</title>
</head>
<body>
	<jsp:include page="intranetCabecera.jsp" />
	<div class="container" style="margin-top: 4%">
		<h4>Reserva Sala</h4>
	</div>
	<div class="container" style="margin-top: 1%">
		<form id="id_form" method="post">
			<div class="row">
				<div class="form-group col-md-12">
					<label class="control-label" for="id_alumno">Alumno</label> <select
						id="id_alumno" name="alumno" class='form-control'>
						<option value=" ">[Seleccione]</option>
					</select>
				</div>
				<div class="form-group  col-sm-12">
					<label class="control-label" for="id_horaInicio">Hora
						Inicio</label> <input class="form-control" type="time" id="id_horaInicio"
						name="horaInicio"
						placeholder="Ingrese la hora de inicio Creaciï¿½n" maxlength="100">
				</div>
				<div class="form-group  col-sm-12">
					<label class="control-label" for="id_horaFin">Hora Fin</label> <input
						class="form-control" type="time" id="id_horaFin" name="horaFin"
						placeholder="Ingrese la hora de fin" maxlength="100">
				</div>
				<div class="form-group  col-sm-12">
					<label class="control-label" for="id_fechaReserva">Fecha
						Reserva</label> <input class="form-control" type="date"
						id="id_fechaReserva" name="fechaReserva"
						placeholder="Ingrese la fecha de Reserva" maxlength="100">
				</div>
				<div class="form-group col-md-12">
					<label class="control-label" for="id_sala">Sala</label> <select
						id="id_sala" name="sala" class='form-control'>
						<option value=" ">[Seleccione]</option>
					</select>
				</div>
			</div>
			<div class="row"></div>
			<div class="row">
				<div class="form-group col-md-12" align="center">
					<button id="id_registrar" type="button" class="btn btn-primary">Registrar</button>
				</div>
			</div>
		</form>
	</div>


	<script type="text/javascript">
		$.getJSON("listaAlumno", {}, function(data) {
			$.each(data, function(index, item) {
				// Se crea una variable que combina los campos "nombres" y "apellidos" para formar el nombre completo
				var nombreCompleto = item.nombres + " " + item.apellidos;
				$("#id_alumno").append(
						"<option value=" + item.idAlumno + ">" + nombreCompleto
								+ "</option>");
			});
		});

		$.getJSON("listaSala", {}, function(data) {
			$.each(data, function(index, item) {
				$("#id_sala").append(
						"<option value=" + item.idSala + ">" + item.numero
								+ "</option>");
			});
		});

		function actualizarComboBox() {
		    // Limpia el combo box de salas antes de actualizarlo
		    $("#id_sala").empty();
		    
		    // Agrega una opción predeterminada para el combo box de salas
		    $("#id_sala").append("<option value='' selected>[Seleccione]</option>");

		    // Realiza la solicitud para obtener la lista actualizada de salas disponibles
		    $.getJSON("listaSala", {}, function(data) {
		        // Itera sobre la lista de salas y agrega las opciones al combo box de salas
		        $.each(data, function(i, item) {
		            $("#id_sala").append(
		                "<option value=" + item.idSala + ">" + item.numero + "</option>"
		            );
		        });
		    });

		    // Limpia el combo box de alumnos antes de actualizarlo
		    $("#id_alumno").empty();

		    // Agrega una opción predeterminada para el combo box de alumnos
		    $("#id_alumno").append("<option value='' selected>[Seleccione]</option>");

		    // Realiza la solicitud para obtener la lista actualizada de alumnos
		    $.getJSON("listaAlumno", {}, function(data) {
		        // Itera sobre la lista de alumnos y agrega las opciones al combo box de alumnos
		        $.each(data, function(index, item) {
		            // Se crea una variable que combina los campos "nombres" y "apellidos" para formar el nombre completo
		            var nombreCompleto = item.nombres + " " + item.apellidos;
		            $("#id_alumno").append(
		                "<option value=" + item.idAlumno + ">" + nombreCompleto + "</option>"
		            );
		        });
		    });
		}
		
		
		/*----------------------------------------------------------------------------------------------------------------------*/
		///inicio de la validacion de la hora 
		
		// Define la constante HORA_ERROR con el mensaje de error
		const HORA_ERROR = "La hora de fin debe ser mayor que la hora de inicio.";

		$("#id_registrar")
				.click(
						function() {
							var validator = $('#id_form').data(
									'bootstrapValidator');
							validator.validate();

							if (validator.isValid()) {
								var horaInicio = $('#id_horaInicio').val();
								var horaFin = $('#id_horaFin').val();

								if (compararHoras(horaInicio, horaFin)) {
									$.ajax({
										type : "POST",
										url : "registraReservaSala",
										data : $('#id_form').serialize(),
										success : function(data) {
											mostrarMensaje(data.MENSAJE);
											limpiarFormulario();
											validator.resetForm();
											actualizarComboBox();
										},
										error : function() {
											mostrarMensaje(MSG_ERROR);
										}
									});
								} else {
									mostrarMensaje(HORA_ERROR);
									// Resetear solo el campo de horaFin
									validator.resetField($('#id_horaFin'));
									$('#id_horaFin').val(' ');	
								}
							}
						});

		// Función para comparar dos horas (formato HH:mm)
		function compararHoras(horaInicio, horaFin) {
			var horaInicioDate = new Date("1970-01-01 " + horaInicio);
			var horaFinDate = new Date("1970-01-01 " + horaFin);
			return horaInicioDate < horaFinDate;
		}
		///fin de la validacion de la hora 
		/*----------------------------------------------------------------------------------------------------------------------*/
		
		

		function limpiarFormulario() {
			$('#id_alumno').empty();
			$('#id_horaInicio').val('');
			$('#id_horaFin').val('');
			$('#id_fechaReserva').val('');
			$('#id_tipoSala').val('');
			$('#id_sala').empty();
		}

		$('#id_form').bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {
				alumno : {
					selector : '#id_alumno',
					validators : {
						notEmpty : {
							message : 'Alumno es un campo obligatorio'
						},
					}
				},
				sala : {
					selector : '#id_sala',
					validators : {
						notEmpty : {
							message : 'Sala es un campo obligatorio'
						},
					}
				},
				horaInicio : {
					selector : "#id_horaInicio",
					validators : {
						notEmpty : {
							message : 'La hora de inicio es obligatorio'
						}
					}
				},
				horaFin : {
					selector : "#id_horaFin",
					validators : {
						notEmpty : {
							message : 'La hora de fin es obligatorio'
						}
					}
				},
				fechaReserva : {
					selector : "#id_fechaReserva",
					validators : {
						notEmpty : {
							message : 'La fecha de reserva es obligatorio'
						}
					}
				},

			}
		});
	</script>
</body>
</html>