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
<div class="container" style="margin-top: 4%"><h4>CRUD Sala</h4></div>
<div class="container" style="margin-top: 1%">
    <div class="row" style="height: 70px">
        <div class="col-md-3" >
                <input class="form-control" id="id_txt_filtro"  name="filtro" placeholder="Ingrese el  número del aula" type="text" maxlength="30"/>
        </div>
        <div class="col-md-2" >
            <button type="button" class="btn btn-primary" id="id_btn_filtrar" style="width: 150px">FILTRA</button>
        </div>
        <div class="col-md-2">
            <button type="button" data-toggle='modal'  data-target="#id_div_modal_registra"  class='btn btn-success' style="width: 150px">REGISTRA</button>
            </div>
        </div>
        <div class="row" > 
            <div class="col-md-12">
                    <div class="content" >
            
                        <table id="id_table" class="table table-striped table-bordered" >
                            <thead>
                                <tr>
                                    <th style="width: 10%" >C&oacute;digo</th>
                                <th style="width: 10%">N&uacutemero</th>
                                <th style="width: 10%">Piso</th>
                                <th style="width: 20%">N&uacutemero de Alumnos</th>
                                <th style="width: 10%">Recursos</th>
                                <th style="width: 10%">Tipo Sala</th>
                                <th style="width: 10%">Sede</th>
                                <th style="width: 10%">Actualiza</th>
                                <th style="width: 10%">Elimina</th>
                                </tr>
                            </thead>
                                <tbody>
                                </tbody>
                            </table>
                    </div>	
            </div>
        </div>
        
    </div>
    
    <div class="modal fade" id="id_div_modal_registra" >
        <div class="modal-dialog" style="width: 60%">
    
            <!-- Modal content-->
            <div class="modal-content">
            <div class="modal-header" style="padding: 35px 50px">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4><span class="glyphicon glyphicon-ok-sign"></span> Registro de Sala</h4>
            </div>
            <div class="modal-body" style="padding: 20px 10px;">
                <form id="id_form_registra" accept-charset="UTF-8" action="registraActualizaCrudSala" class="form-horizontal"     method="post">
                       <div class="panel-group" id="steps">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><a data-toggle="collapse" data-parent="#steps" href="#stepOne">Datos de la Sala</a></h4>
                            </div>
                            <div id="stepOne" class="panel-collapse collapse in">
                                <div class="panel-body">
                                     <div class="form-group">
                                        <label class="col-lg-3 control-label" for="id_reg_numero">N&uacutemero</label>
                                        <div class="col-lg-6">
											<input class="form-control" id="id_reg_numero" name="numero" placeholder="Ingrese el Número de la Sala" type="text" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-3 control-label" for="id_reg_piso">Piso</label>
                                        <div class="col-lg-6">
											<input class="form-control" id="id_reg_piso" name="piso" placeholder="Ingrese el Número del Piso de la Sala" type="number"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-3 control-label" for="id_reg_numAlumnos">N&uacutemero de Alumnos</label>
                                        <div class="col-lg-6">
											<input class="form-control" id="id_reg_numAlumnos" name="numAlumnos" placeholder="Ingrese el Número de alumnos" type="number" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-3 control-label" for="id_reg_recursos">Recursos</label>
                                        <div class="col-lg-6">
											<input class="form-control" id="id_reg_recursos" name="recursos" placeholder="Ingrese el recurso" type="text" />
                                        </div>
                                    </div>
                                  		   
                                    <div class="form-group">
                                        <label class="col-lg-3 control-label" for="id_reg_tipoSala">Tipo de sala</label>
                                        <div class="col-lg-4">
											 <select id="id_reg_tipoSala" name="tipoSala" class='form-control'>
					                            	<option value=" ">[Seleccione]</option>    
					                         </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-3 control-label" for="id_reg_sede">Sede</label>
                                        <div class="col-lg-4">
											 <select id="id_reg_sede" name="sede" class='form-control'>
					                            	<option value=" ">[Seleccione]</option>    
					                         </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-lg-9 col-lg-offset-3">
                                        	<button type="button" class="btn btn-primary" id="id_btn_registra">REGISTRA</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </form>   
            
            </div>
        </div>
    </div>
        
    </div>

    <div class="modal fade" id="id_div_modal_actualiza" >
        <div class="modal-dialog" style="width: 60%">
    
            <div class="modal-content">
            <div class="modal-header" style="padding: 35px 50px">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4><span class="glyphicon glyphicon-ok-sign"></span> Actualiza Sala</h4>
            </div>
            <div class="modal-body" style="padding: 20px 10px;">
                <form id="id_form_actualiza" accept-charset="UTF-8" action="registraActualizaCrudSala" class="form-horizontal"     method="post">
                    <div class="panel-group" id="steps">
                     <div class="panel panel-default">
                         <div class="panel-heading">
                             <h4 class="panel-title"><a data-toggle="collapse" data-parent="#steps" href="#stepOne">Datos de la Sala</a></h4>
                         </div>
                         <div id="stepOne" class="panel-collapse collapse in">
                             <div class="panel-body">
                                <div class="form-group">
                                    <label class="col-lg-3 control-label" for="id_act_Sala">ID</label>
                                    <div class="col-lg-6">
                                       <input class="form-control" id="id_act_Sala" readonly="readonly" name="idSala" type="text" />
                                    </div>
                                 </div>
                                  <div class="form-group">
                                     <label class="col-lg-3 control-label" for="id_act_numero">N&uacutemero</label>
                                     <div class="col-lg-6">
                                         <input class="form-control" id="id_act_numero" name="numero" placeholder="Ingrese el Número de la Sala" type="text" />
                                     </div>
                                 </div>
                                 <div class="form-group">
                                     <label class="col-lg-3 control-label" for="id_act_piso">Piso</label>
                                     <div class="col-lg-6">
                                         <input class="form-control" id="id_act_piso" name="piso" placeholder="Ingrese el Número del Piso de la Sala" type="number" />
                                     </div>
                                 </div>
                                 <div class="form-group">
                                     <label class="col-lg-3 control-label" for="id_act_numAlumnos">N&uacutemero de Alumnos</label>
                                     <div class="col-lg-6">
                                         <input class="form-control" id="id_act_numAlumnos" name="numAlumnos" placeholder="Ingrese el Número de Alumnos" type="number" />
                                     </div>
                                 </div>
                                 <div class="form-group">
                                     <label class="col-lg-3 control-label" for="id_act_recursos">Recursos</label>
                                     <div class="col-lg-6">
                                         <input class="form-control" id="id_act_recursos" name="recursos" placeholder="Ingrese el recurso" type="text" />
                                     </div>
                                 </div>
                                          
                                 <div class="form-group">
                                     <label class="col-lg-3 control-label" for="id_act_tipoSala">Tipo de Sala</label>
                                     <div class="col-lg-4">
                                          <select id="id_act_tipoSala" name="tipoSala" class='form-control'>
                                                 <option value=" ">[Seleccione]</option>    
                                          </select>
                                     </div>
                                 </div>
                                 <div class="form-group">
                                     <label class="col-lg-3 control-label" for="id_act_sede">Sede</label>
                                     <div class="col-lg-4">
                                          <select id="id_act_sede" name="sede" class='form-control'>
                                                 <option value=" ">[Seleccione]</option>    
                                          </select>
                                     </div>
                                 </div>
                                 <div class="form-group">
                                     <div class="col-lg-9 col-lg-offset-3">
                                         <button type="button" class="btn btn-primary" id="id_btn_actualiza">Actualiza</button>
                                     </div>
                                 </div>
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
<!-- Agregar aquï¿½ -->
$("#id_btn_filtrar").click(function(){
	var fil=$("#id_txt_filtro").val();
	$.getJSON("consultaCrudSala",{"filtro":fil}, function (lista){
		agregarGrilla(lista);
	});
});

$.getJSON("listaTipoSala", {}, function(data){
	$.each(data, function(i,item){
		$("#id_reg_tipoSala").append("<option value="+item.idDataCatalogo +">"+ item.descripcion +"</option>");	
		$("#id_act_tipoSala").append("<option value="+item.idDataCatalogo +">"+ item.descripcion +"</option>");	
		});
});
$.getJSON("listaSede", {}, function(data){
	$.each(data, function(index,item){
		$("#id_reg_sede").append("<option value="+item.idDataCatalogo +">"+ item.descripcion +"</option>");
		$("#id_act_sede").append("<option value="+item.idDataCatalogo +">"+ item.descripcion +"</option>");
		});
});


function agregarGrilla(lista){
	 $('#id_table').DataTable().clear();
	 $('#id_table').DataTable().destroy();
	 $('#id_table').DataTable({
			data: lista,
			searching: false,
			ordering: true,
			processing: true,
			pageLength: 5,
			lengthChange: false,
			columns:[
				{data: "idSala"},
				{data: "numero"},
				{data: "piso"},
				{data: "numAlumnos"},
				{data: "recursos"},
				{data: "tipoSala.descripcion"},
				{data: "sede.descripcion"},
				{data: function(row, type, val, meta){
					var salida='<button type="button" style="width: 90px" class="btn btn-info btn-sm" onclick="editar(\''+row.idSala + '\',\'' + row.numero +'\',\'' + row.piso +'\',\''+ row.numAlumnos +'\',\''+ row.recursos +'\',\'' + row.tipoSala.idDataCatalogo + '\',\'' + row.sede.idDataCatalogo + '\')">Editar</button>';
					return salida;
				},className:'text-center'},	
				{data: function(row, type, val, meta){
				    var salida='<button type="button" style="width: 90px" class="btn btn-warning btn-sm" onclick="accionEliminar(\'' + row.idSala + '\')">'+ (row.estado == 1? 'Activo':'Inactvo') +  '</button>';
					return salida;
				},className:'text-center'},													
			]                                     
	    });
}

function accionEliminar(id){	
    $.ajax({
          type: "POST",
          url: "eliminaCrudSala", 
          data: {"id":id},
          success: function(data){
        	  agregarGrilla(data.lista);
          },
          error: function(){
        	  mostrarMensaje(MSG_ERROR);
          }
     });
}
function limpiarFormulario(){	
	$('#id_reg_numero').val('');
	$('#id_reg_piso').val('');
	$('#id_reg_numAlumnos').val('');
	$('#id_reg_recursos').val(' ');
	$('#id_reg_tipoSala').val(' ');
	$('#id_reg_sede').val(' ');
}

function editar(idSala,numero,piso,numAlumnos,recursos,tipoSala,sede){	
	    $('#id_act_Sala').val(idSala);
		$('#id_act_numero').val(numero);
		$('#id_act_piso').val(piso);
		$('#id_act_numAlumnos').val(numAlumnos);
		$('#id_act_recursos').val(recursos);
		$('#id_act_tipoSala').val(tipoSala);
		$('#id_act_sede').val(sede);
		$('#id_div_modal_actualiza').modal("show");
	}
$("#id_btn_actualiza").click(function() {

	var validator = $('#id_form_actualiza').data('bootstrapValidator');
	validator.validate();
	if (validator.isValid()) {
		$.ajax({
			type : "POST",
			url : "actualizaCrudSala",
			data : $('#id_form_actualiza').serialize(),
			success : function(data) {
				agregarGrilla(data.lista);
				$('#id_div_modal_actualiza').modal("hide");
				mostrarMensaje(data.mensaje);
			
	        	 


			},
			error : function() {
				mostrarMensaje(MSG_ERROR);
			}
		});
	}
});




$('#id_form_registra').bootstrapValidator({
    message: 'This value is not valid',
    feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
    	"numero": {
    		selector : '#id_reg_numero',
            validators: {
                notEmpty: {
                    message: 'El Número de la sala es un campo obligatorio'
                },
                regexp:{
    				  regexp: /^[A-Z][0-9]{3}$/,
    				  message:'el Número de la sala  debe contener un caracter en mayuscula y 3 dígitos'
    			  },
    			  remote :{

                  	delay   : 100,

                  	url     : 'buscaModalidadPorNumeroRegistra',

                  	message : 'El Número de Sala ya a sido registrada',

                  	data: {

  		                numeros: function() {

  		                    return $('#id_reg_numero').val();

  		                },

  		        	},

                  }
            }
        },
        "piso": {
    		selector : '#id_reg_piso',
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
    		selector : '#id_reg_numAlumnos',
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
    		selector : '#id_reg_recursos',
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
    		selector : '#id_reg_tipoSala',
            validators: {
            	notEmpty: {
                    message: 'El campo Tipo de Sala es un campo obligatorio'
                },
            }
        },
        "Sede.idCatalogo": {
    		selector : '#id_reg_sede',
            validators: {
            	notEmpty: {
                    message: 'El campo Sede es un campo obligatorio'
                },
            }
        },
    	
    }   
});

$("#id_btn_registra").click(function(){
	var validator = $('#id_form_registra').data('bootstrapValidator');
    validator.validate();
	
    if (validator.isValid()) {
        $.ajax({
          type: "POST",
          url: "registraCrudSala", 
          data: $('#id_form_registra').serialize(),
          success: function(data){
        	  agregarGrilla(data.lista);
        	  $('#id_div_modal_registra').modal("hide");
        	  mostrarMensaje(data.mensaje);
        	  limpiarFormulario();
        	  validator.resetForm();
          },
          error: function(){
        	  mostrarMensaje(MSG_ERROR);
          }
        });
        
    }
});
</script> 
<script type="text/javascript">
$('#id_form_actualiza').bootstrapValidator({
    message: 'This value is not valid',
    feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
    	"numero": {
    		selector : '#id_act_numero',
            validators: {
                notEmpty: {
                    message: 'El campo Número es un campo obligatorio'
                },
                regexp:{
  				  regexp: /^[A-Z][0-9]{3}$/,
  				  message:'El campo Número  debe contener un caracter en mayuscula y 3 dígitos'
  			  },
  			remote :{

            	delay   : 10,

            	url     : 'buscaModalidadPorNumeroActualiza',

            	message : 'El Número de Sala ya existe o ya a sido registrado',

            	data: {

	                numero: function() {

	                    return $('#id_act_numero').val();

	                },
	                id:function(){
	                	return $('#id_act_Sala').val();
	                },
	                
	        	}

            },
            }
        },
        "piso": {
    		selector : '#id_act_piso',
            validators: {
                notEmpty: {
                    message: 'El campo Piso es un campo obligatorio'
                },
                regexp:{
    				  regexp: /^[0-9]{1,2}$/,
    				  message:'El campo Piso  debe contener de 1 a 2 dígitos'
    			  },
            }
        },
        "numAlumnos": {
    		selector : '#id_act_numAlumnos',
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
    		selector : '#id_act_recursos',
            validators: {
            	notEmpty: {
                    message: 'El campo Recursos  es un campo obligatorio'
                },
            }
        },
    
        
        
        "tipoSala.idDataCatalogo": {
    		selector : '#id_act_tipoSala',
            validators: {
            	notEmpty: {
                    message: 'El campo Tipo de Sala  un campo obligatorio'
                },
            }
        },
        "Sede.idCatalogo": {
    		selector : '#id_act_sede',
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
</html>