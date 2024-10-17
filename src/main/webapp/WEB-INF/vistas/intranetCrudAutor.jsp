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

<title>Intranet</title>
</head>
<body>
<jsp:include page="intranetCabecera.jsp" />
<div class="container" style="margin-top: 4%"><h4>CRUD Autor</h4></div>
<div class="container" style="margin-top: 1%">
<div class="row" style="height: 70px">
    <div class="col-md-3">
        <input class="form-control" id="id_txt_filtro" name="filtro" placeholder="Ingrese el nombre o apellidos" type="text" maxlength="30"/>
    </div>
    <div class="col-md-2">
        <button type="button" class="btn btn-primary" id="id_btn_filtrar" style="width: 150px">FILTRA</button>
    </div>
    <div class="col-md-2">
        <button type="button" data-toggle='modal' data-target="#id_div_modal_registra" class='btn btn-success' style="width: 150px">REGISTRA</button>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div class="content">
            <table id="id_table" class="table table-striped table-bordered" >
                <thead>
                    <tr>
                        <th style="width: 5%">C&oacute;digo</th>
                        <th style="width: 10%">Nombres</th>
                        <th style="width: 10%">Apellidos</th>
                        <th style="width: 15%">Fecha de Nacimiento</th>
                        <th style="width: 9%">Teléfono</th>
                        <th style="width: 10%">País</th>
                        <th style="width: 10%">Grado</th>
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

<div class="modal fade" id="id_div_modal_registra">
    <div class="modal-dialog" style="width: 60%">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header" style="padding: 35px 50px">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4><span class="glyphicon glyphicon-ok-sign"></span> Registro autor</h4>
            </div>
            <div class="modal-body" style="padding: 20px 10px;">
                <form id="id_form_registra" accept-charset="UTF-8" action="registraActualizaCrudAutor" class="form-horizontal" method="post">
                    <div class="panel-group" id="steps">
                        <!-- Step 1 -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><a data-toggle="collapse" data-parent="#steps" href="#stepOne">Datos del Autor</a></h4>
                            </div>
                           
                           
                            <div id="stepOne" class="panel-collapse collapse in">

                                <div class="panel-body">
                                    <div class="form-group">
                                        <label class="col-lg-3 control-label" for="id_reg_nombre">Nombres</label>
                                        <div class="col-lg-8">
                                            <input class="form-control" id="id_reg_nombre" name="nombres" placeholder="Ingrese el Nombre" type="text" maxlength="40"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-lg-3 control-label" for="id_reg_apellido">Apellidos</label>
                                        <div class="col-lg-3">
                                            <input class="form-control" id="id_reg_apellido" name="apellidos" placeholder="Ingrese el apellido" type="text" maxlength="40"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-lg-3 control-label" for="id_reg_fechaNaci">Fecha Nacimiento</label>
                                        <div class="col-lg-3">
                                            <input class="form-control" type="date" id="id_reg_fechaNaci" name="fechaNacimiento" placeholder="Ingrese la fecha de nacimiento del autor" maxlength="100">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-lg-3 control-label" for="id_reg_telefono">Teléfono</label>
                                        <div class="col-lg-3">
                                            <input class="form-control" id="id_reg_telefono" name="telefono" placeholder="Ingrese el teléfono del autor" type="text" maxlength="9"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-lg-3 control-label" for="id_reg_pais">País</label>
                                        <div class="col-lg-8">
                                            <select id="id_reg_pais" name="pais" class='form-control'>
                                                <option value=" ">[Seleccione]</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-lg-3 control-label" for="id_reg_grado">Grado</label>
                                        <div class="col-lg-3">
                                            <select id="id_reg_grado" name="grado" class='form-control'>
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
					<h4><span class="glyphicon glyphicon-ok-sign"></span> Actualiza Autor</h4>
				</div>
				
				
			<div class="modal-body" style="padding: 20px 10px;">
						<form id="id_form_actualiza" accept-charset="UTF-8" action="registraActualizaCrudAutor" class="form-horizontal"     method="post">
		                    <div class="panel-group" id="steps">
		                        <!-- Step 1 -->
		                        <div class="panel panel-default">
		                            <div class="panel-heading">
		                                <h4 class="panel-title"><a data-toggle="collapse" data-parent="#steps" href="#stepOne">Datos del Autor</a></h4>
		                            </div>
		                            </div>	
								<div id="stepOne" class="panel-collapse collapse in">
										<div class="panel-body">
											<div class="form-group">
												<label class="col-lg-3 control-label" for="id_ID">Código de Autor</label>
												<div class="col-lg-8">
													<input class="form-control" id="id_ID" readonly="readonly"
														name="idAutor" type="text" maxlength="8" />
												</div>
											</div>		                              
		                                <div class="panel-body">
		                                     <div class="form-group">
		                                        <label class="col-lg-3 control-label" for="id_act_nombre">Nombres</label>
		                                        <div class="col-lg-8">
													<input class="form-control" id="id_act_nombre" name="nombres" placeholder="Ingrese el Nombre" type="text" maxlength="40"/>
		                                        </div>
		                                    </div>
		                                    
		                                    <div class="form-group">
		                                        <label class="col-lg-3 control-label" for="id_act_apellido">Apellidos</label>
		                                        <div class="col-lg-3">
													<input class="form-control" id="id_act_apellido" name="apellidos" placeholder="Ingrese el apellido" type="text" maxlength="40"/>
		                                        </div>
		                                    </div>
		                                    
		                                    <div class="form-group">
		                                        <label class="col-lg-3 control-label" for="id_act_fechaNaci">Fecha Nacimiento</label>
		                                        <div class="col-lg-3">
													<input class="form-control" type="date" id="id_act_fechaNaci" name="fechaNacimiento" placeholder="Ingrese la fecha de nacimiento del autor" maxlength="100">
		                                        </div>
		                                    </div>		  
		                                    
		                                    
		                                    <div class="form-group">
		                                        <label class="col-lg-3 control-label" for="id_act_telefono">Teléfono</label>
		                                        <div class="col-lg-3">
													<input class="form-control" id="id_act_telefono" name="telefono" placeholder="Ingrese el teléfono del autor" type="text" maxlength="9"/>
		                                        </div>
		                                    </div>   
		               
		               
		                   				  <div class="form-group">
		                                        <label class="col-lg-3 control-label" for="id_act_pais">País</label>
		                                        <div class="col-lg-8">
													<select id="id_act_pais" name="pais" class='form-control'>
														<option value=" ">[Seleccione]</option>
													</select>
		                                        </div>
		                                    </div>    
		               
		               
		                                    <div class="form-group">
		                                        <label class="col-lg-3 control-label" for="id_act_grado">Grado</label>
		                                        <div class="col-lg-3">
														<select id="id_act_grado" name="grado" class='form-control'>
														<option value=" ">[Seleccione]</option>
													</select>
											 </div>
		                                </div>   
		                                    
		                               
		                                    
		                                    <div class="form-group">
		                                        <div class="col-lg-9 col-lg-offset-3">
		                                        	<button type="button" class="btn btn-primary" id="id_btn_actualiza">ACTUALIZAR</button>
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
$.getJSON("listaPais", {}, function(data) {
    $.each(data, function(i, item) {
        $("#id_reg_pais").append(
            "<option value="+item.idPais +">" + item.nombre
            + "</option>");
        $("#id_act_pais").append(
            "<option value="+item.idPais +">" + item.nombre
            + "</option>");
    });
});
$.getJSON("listaGradoAutor", {}, function(data) {
    $.each(data, function(i, item) {
        $("#id_reg_grado").append(
            "<option value="+item.idDataCatalogo +">" + item.descripcion
            + "</option>");
        $("#id_act_grado").append(
            "<option value="+item.idDataCatalogo +">" + item.descripcion
            + "</option>");
    });
});

$("#id_btn_filtrar").click(function(){
    var fil=$("#id_txt_filtro").val();
    $.getJSON("consultaCrudAutor",{"filtro":fil}, function (lista){
        agregarGrilla(lista);
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
            {data: "idAutor"},
            {data: "nombres"},
            {data: "apellidos"},
            {data: "fechaNacimiento"},
            {data: "telefono"},
            {data: "pais.nombre"},
            {data: "grado.descripcion"}, // Utiliza "grado.descripcion" en lugar de "autor.idDataCatalogo.descripcion" es recomendable
            {data: function(row, type, val, meta){
                var salida = '<button type="button" style="width: 90px" class="btn btn-info btn-sm" onclick="editar(\'' + row.idAutor + '\',\'' + row.nombres + '\',\'' + row.apellidos + '\',\'' + row.fechaNacimiento + '\',\'' + row.telefono + '\',\''  +  row.pais.idPais + '\',\'' + row.grado.idDataCatalogo + '\')">Editar</button>';
                return salida;
            }, className: 'text-center'},
            {data: function(row, type, val, meta){
                var salida = '<button type="button" style="width: 90px" class="btn btn-warning btn-sm" onclick="eliminar(\'' + row.idAutor + '\')">' + (row.estado == 1 ? "Activo" : "Inactivo") + '</button>';
                return salida;
            }, className: 'text-center'},
        ]
    });
}





function editar(id, nombres, apellidos, fechaNacimiento, telefono, idPais, idGrado) {
	
    $('#id_ID').val(id);
    $('#id_act_nombre').val(nombres);
    $('#id_act_apellido').val(apellidos);
    $('#id_act_fechaNaci').val(fechaNacimiento);
    $('#id_act_telefono').val(telefono);
    $('#id_act_pais').val(idPais);
    $('#id_act_grado').val(idGrado);

    // Abre el modal
    $('#id_div_modal_actualiza').modal("show");
}




$("#id_btn_actualiza").click(function() {

	var validator = $('#id_form_actualiza').data('bootstrapValidator');
	validator.validate();
	if (validator.isValid()) {
		$.ajax({
			type : "POST",
			url : "actualizaCrudAutor",
			data : $('#id_form_actualiza').serialize(),
			success : function(data) {
				agregarGrilla(data.lista);
				$('#id_div_modal_actualiza').modal("hide");
				mostrarMensaje(data.mensaje);
			
	        	  validator.resetForm();


			},
			error : function() {
				mostrarMensaje(MSG_ERROR);
			}
		});
	}
});








$("#id_btn_registra").click(function() {
	var validator = $('#id_form_registra').data('bootstrapValidator');
	validator.validate();

	if (validator.isValid()) {
		$.ajax({
			type : "POST",
			url : "registraCrudAutor",
			data : $('#id_form_registra').serialize(),
			success : function(data) {
				agregarGrilla(data.lista);
				$('#id_div_modal_registra').modal("hide");
				mostrarMensaje(data.mensaje);
			 	  limpiarFormulario();
	        	  validator.resetForm();
	        	  },
			error : function() {
				mostrarMensaje(MSG_ERROR);
			}
		});

	}
});









function limpiarFormulario() {
	$('#id_reg_nombre').val(' ');
	$('#id_reg_apellido').val(' ');
	$('#id_reg_fechaNaci').val(' ');
	$('#id_reg_telefono').val(' ');
	$('#id_reg_pais').val(' ');
	$('#id_reg_grado').val(' ');
}





function eliminar(id){	
    $.ajax({
          type: "POST",
          url: "eliminaCrudAutor", 
          data: {"id":id},
          success: function(data){
        	  agregarGrilla(data.lista);
          },
          error: function(){
        	  mostrarMensaje(MSG_ERROR);
          }
     });
}



</script>


<script type="text/javascript">




    $('#id_form_registra').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            'nombres': {
                selector: "#id_reg_nombre",
                validators: {
                    notEmpty: {
                        message: 'El nombre es obligatorio'
                    },
                    stringLength: {
                        min: 2,
                        max: 40,
                        message: 'El nombre es de 2 a 40 caracteres'
                    },
                    remote: {
                        delay: 1000,
                        url: 'buscaAutorNombreApellidoRegistro',
                        message: 'El Autor ya existe',
                        data: {
                            'nombres': function() {
                                return $('#id_reg_nombre').val();
                            },
                            'apellidos': function() {
                                return $('#id_reg_apellido').val();
                            }
                        }
                    }
                }
            },
            'apellidos': {
                selector: "#id_reg_apellido",
                validators: {
                    notEmpty: {
                        message: 'El apellido es obligatorio'
                    },
                    stringLength: {
                        min: 2,
                        max: 40,
                        message: 'El apellido es de 2 a 40 caracteres'
                    },
                    remote: {
                        delay: 1000,
                        url: 'buscaAutorNombreApellidoRegistro',
                        message: 'El Autor ya existe',
                        data: {
                            'nombres': function() {
                                return $('#id_reg_nombre').val();
                            },
                            'apellidos': function() {
                                return $('#id_reg_apellido').val();
                            }
                            
                        }
                    }
                }
            },
            'telefono': {
                selector: "#id_reg_telefono",
                validators: {
                    notEmpty: {
                        message: 'El teléfono es obligatorio'
                    },
                    regexp: {
                        regexp: /^[0-9]{9}$/,
                        message: 'El teléfono debe tener 9 dígitos'
                    },
                    remote: {
                        delay: 1000,
                        url: 'buscaPorTelefono',
                        message: 'El teléfono ya existe'
                    }
                }
            },
            'fechaNacimiento': {
                selector: "#id_reg_fechaNaci",
                validators: {
                    notEmpty: {
                        message: 'La fecha de nacimiento es obligatoria'
                    },
                    remote :{
                    	delay   : 1000,
                    	url     : 'buscaAutorMayorEdad',
                    	message : 'El Autor debe ser mayor de edad'
                    }
                }
            },
              
            'pais.idPais': {
                selector: "#id_reg_pais",
                validators: {
                    notEmpty: {
                        message: 'Seleccione un país'
                    }
                }
            },
            'grado.idCatalogo': {
                selector: "#id_reg_grado",
                validators: {
                    notEmpty: {
                        message: 'Seleccione un grado'
                    },
                }
            },
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
            'nombres': {
                selector: "#id_act_nombre",
                validators: {
                    notEmpty: {
                        message: 'El nombre es obligatorio'
                    },
                    stringLength: {
                        min: 2,
                        max: 40,
                        message: 'El nombre es de 2 a 40 caracteres'
                    },
                    
                    remote: {
                        delay: 1000,
                        url: 'buscaAutorNombreApellidoActualiza',
                        message: 'El Autor ya existe',
                        data: {
                            'nombres': function() {
                                return $('#id_act_nombre').val();
                            },
                            'apellidos': function() {
                                return $('#id_act_apellido').val();
                            },
                            'id': function() {
                                return $('#id_ID').val();
                            }
                        }
                    }
                }
            },
            'apellidos': {
                selector: "#id_act_apellido",
                validators: {
                    notEmpty: {
                        message: 'El apellido es obligatorio'
                    },
                    stringLength: {
                        min: 2,
                        max: 40,
                        message: 'El apellido es de 2 a 40 caracteres'
                    },
               
                    remote: {
                        delay: 1000,
                        url: 'buscaAutorNombreApellidoActualiza',
                        message: 'El Autor ya existe',
                        data: {
                            'nombres': function() {
                                return $('#id_act_nombre').val();
                            },
                            'apellidos': function() {
                                return $('#id_act_apellido').val();
                            },
                            'id': function() {
                                return $('#id_ID').val();
                            }
                        }
                    }
                }
            },
            'telefono': {
                selector: "#id_act_telefono",
                validators: {
                    notEmpty: {
                        message: 'El teléfono es obligatorio'
                    },
                    regexp: {
                        regexp: /^[0-9]{9}$/,
                        message: 'El teléfono debe tener 9 dígitos'
                    },
                    remote: {
                        delay: 1000,
                        url: 'buscaAutorTelefonoIgualActualiza',
                        message: 'El teléfono ya existe',
                        data: {
                            'telefono': function() {
                                return $('#id_act_telefono').val();
                            },
                            'id': function() {
                                return $('#id_ID').val();
                            }
                        }
                    }
                }
            },
            'fechaNacimiento': {
                selector: "#id_act_fechaNaci", 
                validators: {
                    notEmpty: {
                        message: 'La fecha de nacimiento es obligatoria'
                    },
                    remote :{
                    	delay   : 1000,
                    	url     : 'buscaAutorMayorEdad',
                    	message : 'El Autor debe ser mayor de edad'
                    }
                }
            },
              
            'pais.idPais': {
                selector: "#id_act_pais",
                validators: {
                    notEmpty: {
                        message: 'Seleccione un país'
                    }
                }
            },
            'grado.idCatalogo': {
                selector: "#id_act_grado",
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
