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
<div class="container" style="margin-top: 4%"><h4>Registro Libro</h4></div>

<div class="container" style="margin-top: 1%">
	
	<form  id="id_form" method="post"> 
	 <div class="col-md-12" style="margin-top: 2%">
			<div class="row">
				<div class="form-group col-md-6">
					<label class="control-label" for="id_titulo">Título</label>
					<input class="form-control" type="text" id="id_titulo" name="titulo" placeholder="Ingrese el Título">
				</div>
				
				<div class="form-group col-md-3">
					<label class="control-label" for="id_anio">Año</label>
					<input class="form-control" type="text" id="id_anio" name="anio" placeholder="Ingrese el Año">
				</div>
				
				<div class="form-group col-md-3">
					<label class="control-label" for="id_serie">Serie</label>
					<input class="form-control" type="text" id="id_serie" name="serie" placeholder="Ingrese la Serie">
				</div>
			</div>
			<div class="row">	
				<div class="form-group col-md-3">
					<label class="control-label" for="id_categoria">Categoría</label>
					<select id="id_categoria" name="categoriaLibro.idDataCatalogo" class='form-control'>
						<option value=" ">[Seleccione]</option>    
					</select>
			    </div>
			    
			    <div class="form-group col-md-3">
					<label class="control-label" for="id_tipo">Tipo</label>
					<select id="id_tipo" name="tipoLibro.idDataCatalogo" class='form-control'>
						<option value=" ">[Seleccione]</option>    
					</select>
			    </div>
			    
			</div>
		    <div class="row">
				<div class="form-group col-md-12" align="center">
					<button id="id_registrar" type="button" class="btn btn-primary" >Registra</button>
				</div>
			</div>
	</div>
	</form>
		
	
</div>

<script type="text/javascript">

$.getJSON("listaCategoriaDeLibro", {}, function(data) {
	$.each(data, function(index, item) {
		$("#id_categoria").append("<option value="+item.idDataCatalogo +">" + item.descripcion + "</option>");
	});
});

$.getJSON("listaTipoLibroRevista", {}, function(data) {
	$.each(data, function(index, item) {
		$("#id_tipo").append("<option value="+item.idDataCatalogo +">" + item.descripcion+ "</option>");});
});


$("#id_registrar").click(function (){ 
	var validator = $('#id_form').data('bootstrapValidator');
    validator.validate();
    
	if (validator.isValid()){
		$.ajax({
    		type: "POST",
            url: "registraLibro", 
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
	$("#id_titulo").val('');
	$("#id_anio").val(' ');
	$("#id_serie").val(' ');
	$("#id_categoria").val(' ');
	$("#id_tipo").val(' ');
}



$('#id_form').bootstrapValidator({
    message: 'This value is not valid',
    feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
    	titulo: {
    		selector : '#id_titulo',
            validators: {
                notEmpty: {
                    message: 'El título es un campo obligatorio'
                },
                stringLength :{
                	message:'El título es de 2 a 40 caracteres',
                	min : 2,
                	max : 40
                },
            }
        },
        anio:{
        	selector : '#id_anio',
        	validators:{
        		notEmpty:{
        			message: 'El Año es obligatorio'
        		},regexp: {
                    regexp: /^\d{4}$/,
                    message: 'El Año debe consistir en 4 dígitos numéricos'
                },
        		 
        	}
        },
        serie: {
        	selector: '#id_serie',
        	validators:{
        		notEmpty:{
        			message: 'La serie es obligatoria'
        		},
        		regexp: {
                    regexp: /^[A-Za-z]{2}\d{3}$/,
                    message: 'La Serie debe consistir en 2 letras seguidas de 3 números'
                },
                remote :{
                	delay: 200,
                	url: 'buscaPorSerie',
                	message: 'El numero de Serie ya existe'
                }
        	}
        },
        categoria: {
    		selector : '#id_categoria',
            validators: {
            	notEmpty: {
                    message: 'Categoría es un campo obligatorio'
                },
            }
        },
       	tipo: {
    		selector : '#id_tipo',
            validators: {
            	notEmpty: {
                    message: 'Tipo es un campo obligatorio'
                },
            }
        },
    }   
});


</script>   		
</body>
</html>