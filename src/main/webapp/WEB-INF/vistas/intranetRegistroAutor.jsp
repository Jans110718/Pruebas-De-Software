<jsp:include page="intranetValida.jsp" />
<!DOCTYPE html>
<html lang="esS" >
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
		<h4>&nbsp;&nbsp;&nbsp;Registro Autor</h4>
	</div>

	<div class="container" style="margin-top: 5px">
		<!-- Agregar aquí -->


		<form id="id_form" method="post">
			<!--  NOMBRE -->
			<div class="row" style="margin-top: 2%">
				<div class="form-group col-sm-4">
					<div class="col-sm-4">
						<label class="control-label" for="id_nombres">Nombre</label>
					</div>
					<div class="col-sm-6">
						<input class="form-control" type="text" id="id_nombres"
							name="nombres" placeholder="Ingrese el nombre del autor"
							type="text" maxlength="40">
					</div>
				</div>
					<!--  APELLIDO -->
				<div class="form-group col-sm-4">
					<div class="col-sm-4">
						<label class="control-label" for="id_apellidos">Apellido</label>
					</div>
					<div class="col-sm-6">
						<input class="form-control" id="id_apellidos" name="apellidos"
							placeholder="Ingrese el apellido del autor" type="text"
							maxlength="40" />
					</div>
				</div>
				<!--  FECHA NACIMIENTO -->
				<div class="form-group col-sm-4">
					<div class="col-sm-4">
						<label class="control-label" for="id_fechaNacimiento">Fecha
							de Nacimiento</label>
					</div>
					<div class="col-sm-6">
						<input class="form-control" type="date" id="id_fechaNacimiento"
							name="fechaNacimiento"
							placeholder="Ingrese la fecha de nacimiento del autor"
							maxlength="100">
					</div>
				</div>
			</div>
			<div class="row">
				<!--  TELEFONO -->
				<div class="form-group col-sm-4">
					<div class="col-sm-4">
						<label class="control-label" for="id_telefono">Teléfono</label>
					</div>
					<div class="col-sm-6">
						<input class="form-control" id="id_telefono" name="telefono"
							placeholder="Ingrese el télefono del autor" type="text"
							maxlength="9" />
					</div>
				</div>
				<!-- LISTA DESPLEGABLE PAIS -->
				<div class="form-group col-md-4">
					<label class="control-label col-sm-4" for="id_pais">País</label>
					<div class="col-sm-8">
						<select id="id_pais" name="pais.idPais" class="form-control">
							<option value="">[Seleccione]</option>
						</select>
					</div>
				</div>
				<!-- LISTA DESPLEGABLE GRADO -->
				<div class="form-group col-md-4">
					<label class="control-label col-sm-4" for="id_grado">Grado</label>
					<div class="col-sm-8">
						<select id="id_grado" name="grado.idDataCatalogo"
							class="form-control">
							<option value="">[Seleccione]</option>
						</select>
					</div>
				</div>
			
		 </div>
  
			<!--  BOTON -->
			<div class="row" style="margin-top: 2%" align="center">
				<button id="id_registrar" type="button" class="btn btn-primary">Registrar
				</button>
			</div>
		</form>
	</div>





	<!-- VALIDACIONES -->
	<script type="text/javascript">
	
	
	/*CARGAR CBO*/
	

	$.getJSON("listaPais", {}, function(data){
		$.each(data, function(index,item){
			$("#id_pais").append("<option value="+item.idPais +">"+ item.nombre +"</option>");
		});
	});
	/*DataCatalogo*/
	
	$.getJSON("listaGradoAutor", {}, function(data) {
	    $.each(data, function(index, item) {
	        $("#id_grado").append("<option value=" + item.idDataCatalogo + ">" + item.descripcion + "</option>");
	    });
	});
	
	
	<!-- Agregar aquí -->
		$("#id_registrar").click(function() {

			//Lanza la validacion
			var validator = $('#id_form').data('bootstrapValidator');
			validator.validate();

			//Pregunta si es valido el formulario(Si no tiene errores)
			if (validator.isValid()) {
				$.ajax({
					type : "POST",
					url : "registraAutor",
					data : $('#id_form').serialize(),
					success : function(data) {
						mostrarMensaje(data.MENSAJE);
						validator.resetForm();
						limpiarFormulario();
					},
					error : function() {
						mostrarMensaje(MSG_ERROR);
					}
				});
			}

		});

		function limpiarFormulario() {
			$('#id_nombres').val('');
			$('#id_apellidos').val('');
			$('#id_fechaNacimiento').val('');
			$('#id_telefono').val('');
			$('#id_pais').val('');
			$('#id_grado').val('');
		}
		
		
		$('#id_form').bootstrapValidator({
		    message: 'This value is not valid',
		    feedbackIcons: {
		        valid: 'glyphicon glyphicon-ok',
		        invalid: 'glyphicon glyphicon-remove',
		        validating: 'glyphicon glyphicon-refresh'
		    },
		        fields: {
		            nombres: {
		                selector: "#id_nombres",
		                validators: {
		                    notEmpty: {
		                        message: 'El nombre es obligatorio'
		                    },
		                    stringLength: {
		                        min: 2,
		                        max: 40,
		                        message: 'El nombre es de 2 a 40 caracteres'
		                   
		            }
	            }
	        },
		            apellidos: {
		                selector: "#id_apellidos",
		                validators: {
		                    notEmpty: {
		                        message: 'El apellido es obligatorio'
		                    },
		                    stringLength: {
		                        min: 2,
		                        max: 40,
		                        message: 'El apellido es de 2 a 40 caracteres'
		             
		            }
	            }
	        },
		            telefono: {
		                selector: "#id_telefono",
		                validators: {
		                    notEmpty: {
		                        message: 'El teléfono es obligatorio'
		                    },
		                    regexp: {
		                        regexp: /^[0-9]{9}$/,
		                        message: 'El teléfono debe tener 9 dígitos'
		                    },remote :{
			            	    delay: 1000,
			            	 	url: 'buscaPorTelefono',
			            	 	message: 'El teléfono ya existe'
			             	}
		                }
		            },
		            fechaNacimiento: {
		                selector: "#id_fechaNacimiento",
		                validators: {
		                    notEmpty: {
		                        message: 'La fecha de nacimiento es obligatoria'
		                    }
		                }
		            },
		            pais: {
		                selector: "#id_pais",
		                validators: {
		                    notEmpty: {
		                        message: 'Seleccione un país'
		                    }
		                }
		            },
		            grado: {
		                selector: "#id_grado",
		                validators: {
		                    notEmpty: {
		                        message: 'Seleccione un grado'
		                    },
		                }
		            },
		        }
		});
	</script>
</body>
</html>