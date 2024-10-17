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
<div class="container" style="margin-top: 4%"><h4>Registro Alumno</h4></div>

<div class="container" style="margin-top: 1%">
<form  id="id_form" method="post"> 
	 <div class="col-md-12" style="margin-top: 2%">
			<div class="row">
				<div class="form-group col-md-3">
					<label class="control-label" for="id_nombre">Nombre</label>
					<input class="form-control" type="text" id="id_nombre" name="nombres" placeholder="Ingrese el nombre">
				</div>
				<div class="form-group col-md-3">
					<label class="control-label" for="id_apellidos">Apellidos</label>
					<input class="form-control" type="text" id="id_apellidos" name="apellidos" placeholder="Ingrese el apellido">
				</div>
				<div class="form-group col-md-3">
					<label class="control-label" for="id_telefono">Teléfono</label>
					<input class="form-control" type="text" id="id_telefono" name="telefono" placeholder="Ingrese el teléfono" maxlength="9">
				</div>
				<div class="form-group col-md-3">
					<label class="control-label" for="id_dni">DNI</label>
					<input class="form-control" type="text" id="id_dni" name="dni" placeholder="Ingrese el dni" maxlength="8">
				</div>
			</div>
		</div>
	<div class="col-md-12" style="margin-top: 0%">
		<div class="row">
				<div class="form-group col-sm-3">
					<label class="control-label" for="id_correo">Correo</label>
					<input class="form-control" type="text" id="id_correo" name="correo" placeholder="Ingrese el correo" maxlength="100">
				</div>
				<div class="form-group col-sm-3">
					<label class="control-label" for="id_fecha">Fecha de Nacimiento</label>
					<input class="form-control" type="date" id="id_fecha" name="fechaNacimiento" placeholder="Ingrese la fecha" maxlength="100">
		 		</div>
				<div class="form-group col-md-3">
					<label class="control-label" for="id_pais">País</label>
					<select id="id_pais" name="pais.idPais" class='form-control'>
						<option value=" ">[Seleccione]</option>    
					</select>
			    </div>
			    <div class="form-group col-md-3">
					<label class="control-label" for="id_modalidad">Modalidad</label>
					<select id="id_modalidad" name="modalidad.idDataCatalogo" class='form-control'>
						<option value=" ">[Seleccione]</option>    
					</select>
			    </div>
			</div>
		</div>
		    <div class="row">
				<div class="form-group col-md-12" align="center">
					<button id="id_registrar" type="button" class="btn btn-primary" >Registrar</button>
				</div>
			</div>

	</form>
	
</div>

<script type="text/javascript">

$.getJSON("listaPais", {}, function(data){
	$.each(data, function(index,item){
		$("#id_pais").append("<option value="+item.idPais +">"+ item.nombre +"</option>");
	});
});

$.getJSON("listaModalidadAlumno", {}, function(data){
	$.each(data, function(index,item){
		$("#id_modalidad").append("<option value="+item.idDataCatalogo +">"+ item.descripcion +"</option>");
	});
});

$("#id_registrar").click(function (){ 
	var validator = $('#id_form').data('bootstrapValidator');
    validator.validate();
    
	if (validator.isValid()){
		$.ajax({
    		type: "POST",
            url: "registraAlumno", 
            data: $('#id_form').serialize(),
            success: function(data){
            	mostrarMensaje(data.MENSAJE);
            	validator.resetForm();
            	limpiarFormulario();
            },
            error: function(){
            	mostrarMensaje(MSG_ERROR);
            }
    	});
	}   
});

function limpiarFormulario(){
	$('#id_nombre').val('');
	$('#id_apellidos').val('');
	$('#id_telefono').val('');
	$('#id_dni').val('');
	$('#id_correo').val('');
	$('#id_fecha').val('');
	$('#id_pais').val(' ');
	$('#id_modalidad').val(' ');
}


    $('#id_form').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        		nombre:{
                    selector: "#id_nombre",
                    validators:{
                        notEmpty: {
                             message: 'El nombre es obligatorio'
                        },
                        stringLength: {
                            min: 2,
                            max: 40,
                            message: 'El nombre es de 2 a 40 caracteres'
                        },
                    }
                },
                apellidos:{
                    selector: "#id_apellidos",
                    validators:{
                        notEmpty: {
                             message: 'El apellido es obligatorio'
                        },
                        stringLength: {
                            min: 2,
                            max: 40,
                            message: 'El apellido es de 2 a 40 caracteres'
                        },
                    }
                },
                telefono:{
                    selector: "#id_telefono",
                    validators:{
                        notEmpty: {
                             message: 'El teléfono es obligatorio'
                        },
                        regexp: {
                            regexp: /^[0-9]{9}$/,
                            message: 'El teléfono es 9 dígitos'
                        }
                    }
                },
                dni:{
                    selector: "#id_dni",
                    validators:{
                        notEmpty: {
                             message: 'El DNI es obligatorio'
                        },
                        regexp: {
                            regexp: /^[0-9]{8}$/,
                            message: 'el DNI es 8 dígitos'
                        },
                        remote :{
                        	delay: 200,
                        	url: 'buscaPorDniAlumno',
                        	message: 'El DNI ya existe'
                        }
                    }
                },
                correo:{
                    selector: "#id_correo",
                    validators:{
                        notEmpty: {
                             message: 'El correo es obligatorio'
                        },
                        emailAddress: {
                            message: 'El correo no es valido'
                        }
                    }
                },
                fechaNacimiento:{
                    selector: "#id_fecha",
                    validators:{
                        notEmpty: {
                             message: 'La fecha es obligatorio'
                        }
                    }
                },
                pais:{
                    selector: "#id_pais",
                    validators:{
                        notEmpty: {
                             message: 'El país es obligatorio'
                        }
                    }
                },
                modalidad: {
            		selector : '#id_modalidad',
                    validators: {
                    	notEmpty: {
                            message: 'La modalidad es un campo obligatorio'
                        },
                    }
                },
        }   
    });

</script>   		
</body>
</html>