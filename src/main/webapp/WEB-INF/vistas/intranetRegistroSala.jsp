<jsp:include page="intranetValida.jsp" />
<!DOCTYPE html>
<html lang="esS" >
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

<title>Intranet</title>
</head>
<body>
<jsp:include page="intranetCabecera.jsp" />
<div class="container" style="margin-top: 4%"><h4>Registro Sala</h4></div>

<div class="container" style="margin-top: 1%">
		<form id="id_form" method="post">
			<div class="col-md-12" style="margin-top: 2%">
				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label" for="id_numero">Número</label> <input
							class="form-control" type="text" id="id_numero" name="numero"
							placeholder="Ingrese el numero de la sala">
					</div>
					<div class="form-group col-md-6">
						<label class="control-label" for="id_piso">Piso</label> <input
							class="form-control" type="number" id="id_piso" name="piso"
							placeholder="Ingrese el piso de la sala">
					</div>
					</div>
					<div class="row">
					<div class="form-group  col-sm-6">
						<label class="control-label" for="id_numAlumnos">Cantidad De Alumnos</label> 
						<input class="form-control" type="number"
							id="id_numAlumnos" name="numAlumnos"
							placeholder="Ingrese la cantidad de alumnos">
					</div>
					<div class="form-group  col-sm-6">
						<label class="control-label" for="id_recursos">Recursos</label> 
						<input class="form-control" type="text"
							id="id_recursos" name="recursos"
							placeholder="Ingrese los recursos de la sala">
					</div>
					</div>
				</div>
				<div class="row">
					
					<div class="form-group col-md-6">
						<label class="control-label" for="id_tipoSala">Tipo Sala</label> <select
							id="id_tipoSala" name="tipoSala.idDataCatalogo" class='form-control'>
							<option value=" ">[Seleccione]</option>
						</select>
					</div>
					<div class="form-group col-md-6">
						<label class="control-label" for="id_sede">Sede</label> <select
							id="id_sede" name="sede.idDataCatalogo" class='form-control'>
							<option value=" ">[Seleccione]</option>
						</select>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-12" align="center">
						<button id="id_registrar" type="button" class="btn btn-primary">Registra</button>
					</div>
				</div>
			</div>
		</form>
	</div>

	<!-- VALIDACIONES -->
	<script type="text/javascript">
	
	
	/*CARGAR CBO*/
	$.getJSON("listaTipoSala", {}, function(data){
		$.each(data, function(i,item){
			$("#id_tipoSala").append("<option value="+item.idDataCatalogo +">"+ item.descripcion +"</option>");	
			});
	});
	$.getJSON("listaSede", {}, function(data){
		$.each(data, function(index,item){
			$("#id_sede").append("<option value="+item.idDataCatalogo +">"+ item.descripcion +"</option>");
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
					url : "registraSala",
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
			$('#id_numero').val('');
			$('#id_piso').val('');
			$('#id_numAlumnos').val('');
			$('#id_recursos').val('');
			$('#id_tipoSala').val('');
			$('#id_sede').val('');
		}
		
		
		$('#id_form').bootstrapValidator({
		    message: 'This value is not valid',
		    feedbackIcons: {
		        valid: 'glyphicon glyphicon-ok',
		        invalid: 'glyphicon glyphicon-remove',
		        validating: 'glyphicon glyphicon-refresh'
		    },
		        fields: {
		            numero: {
		                selector: "#id_numero",
		                validators: {
		                    notEmpty: {
		                        message: 'El número de la sala es obligatorio'
		                    },
		                    regexp:{
		      				  regexp: /^[A-Z][0-9]{3}$/,
		      				  message:'el Número de la sala  debe contener un caracter en mayuscula y 3 dígitos'
		      			  }
	            }
	        },
	        "piso": {
	    		selector : '#id_piso',
	            validators: {
	                notEmpty: {
	                    message: 'El  campo Piso es obligatorio'
	                },
	                regexp:{
	  				  regexp: /^[0-9]{1,2}$/,
	  				  message:'el  campo Piso debe contener de 1 a 2 dígitos'
	  			  },
	            }
	        },
	        "numAlumnos": {
	    		selector : '#id_numAlumnos',
	            validators: {
	            	notEmpty: {
	                    message: 'El campo Número de Alumnos es un campo obligatorio'
	                },
	                regexp:{
	    				  regexp: /^[0-9]{1,2}$/,
	    				  message:'El campo Número de Alumnos  debe contener de 1 a 2 dígitos'
	    			  },
	            }
	        },
	        "recursos": {
	    		selector : '#id_recursos',
	            validators: {
	            	notEmpty: {
	                    message: 'El campo Recursos es un campo obligatorio'
	                },
	                stringLength :{
	                	message:'El campo Recursos puede contener de 2 a 40 caracteres',
	                	min : 2,
	                	max : 40
	                }
	                
	            }
	        },
	    
	        
	        
	        "tipoSala.idDataCatalogo": {
	    		selector : '#id_tipoSala',
	            validators: {
	            	notEmpty: {
	                    message: 'El campo Tipo de Sala es un campo obligatorio'
	                },
	            }
	        },
	        "Sede.idCatalogo": {
	    		selector : '#id_sede',
	            validators: {
	            	notEmpty: {
	                    message: 'El campo Sede es un campo obligatorio'
	                },
	            }
	        },
	    	
	    }   
	});
	</script>
</body>
