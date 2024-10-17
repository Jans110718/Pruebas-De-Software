<jsp:include page="intranetValida.jsp" />
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<div class="container " style="margin-top: 4%"><h4>Devolución de Libro</h4></div>

<div class="container" style="margin-top: 1%">
<!-- Agregar aquí­ -->

<form id="id_form" accept-charset="UTF-8" action="boleta" class="form-horizontal" method="post">

    <div class="panel-group d-flex justify-content-center" id="steps">

        <!-- Panel 1: Prestamo -->
        <div class="panel panel-default " >
            <div class="panel-heading text-center">DEVOLUCIÓN</div>
            <div class="panel-body " >

                <div class="form-group col-md-5">
                    <label class="col-lg-2 control-label">Alumno</label>
                    <div class="col-lg-8">
                        <input type="text" id="id_alumno_nombre" class="form-control" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-group col-md-4">
                    <div class="col-lg-6">
                        <button type="button" id="id_btnAlumno" data-toggle='modal' class='btn btn-primary' style="width: 170px">BUSCA ALUMNO</button>
                        <input type="hidden" name="idAlumno" id="id_alumno_id" class="form-control" value="-1"/>
                    </div>
                </div>

                <div class="form-group  col-sm-3">
                    <label class="control-label" for="id_alumno_fechaDevolucion">Fecha de Devolución:</label>
    				<input class="form-control" type="date" id="id_fechaDevolucion" name="fechaDevolucion" placeholder="Ingrese la fecha de devolucion" maxlength="100" min="2022-12-03">
                </div>




                <div class="form-group  col-md-5">
                    <label class="col-lg-2 control-label">Libros</label>
                    <div class="col-lg-8">
                        <input type="text" name="titulo" id="id_libro_nombre" class="form-control" readonly="readonly"/>
                    </div>
                </div>

                <div class="form-group  col-md-4" >
                    <div class="col-lg-6">
                        <button type="button" id="id_btnLibro" data-toggle='modal' class='btn btn-primary' style="width: 170px">BUSCA LIBROS</button>
                        <input type="hidden" name="idLibro" id="id_libro_id" class="form-control" value="-1"/>									
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-lg-9 col-lg-offset-5">
                        <div class="col-lg-9 col-lg-offset-3">
                            <button type="button" id="id_btnAgregar" class="btn btn-primary" style="width: 170px">AGREGAR LIBRO</button>
                            <button type="button" id="id_btnRegistrar"  class="btn btn-primary" style="width: 170px">DEVOLVER</button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
     
        

        <!-- Panel 2: Detalle de la devolucion -->
        <div class="panel panel-default" >
           <div class="panel-heading text-center">DETALLE DE LA DEVOLUCIÓN</div>
            <div class="panel-body">
               
                
                <div class="form-group" >
                    <div class="col-lg-12">
                        <table id="id_table_boleta" class="table table-striped table-bordered" >
                            <thead>
                                <tr>
                                  				<th style="width: 10%">Código</th>
												<th style="width: 25%">Título</th>
												<th style="width: 10%"></th>
                               
                               
                                </tr> 
                            </thead>
                            <tbody id="id_table_boleta_body"></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>


<!-- El formulario de busqueda de Alumno (Modal) -->

  	 <div class="modal fade" id="idBuscaAlumno" >
			<div class="modal-dialog" style="width: 60%">

				<div class="modal-content">
				<div class="modal-header" style="padding: 35px 50px">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4><span class="glyphicon glyphicon-ok-sign"></span> Busqueda de Alumno</h4>
				</div>
				<div class="modal-body" style="padding: 20px 10px;">
						    <div class="panel-group" id="steps">
		                        <div class="panel panel-default">
											<div class="form-group">
													<label class="col-lg-3 control-label">
														Alumno 
													</label>   
													<div class="col-lg-5">
														<input id="id_txtAlumno" class="form-control" name="Alumno" type="text" />
													</div>
											</div>
											<div class="form-group">
												<div class="col-lg-12">
												<table id="id_table_alumno" class="table table-striped table-bordered">
														<thead>
															<tr>
																<th style="width: 15%">Código</th>
																<th style="width: 40%">Nombre</th>
																<th style="width: 35%">Apellido</th>
																<th style="width: 10%"></th>
															</tr>
														</thead>
														<tbody>

														</tbody>				
												</table>
												</div>
											</div>
			                        </div>
		                    </div>
					</div>
			</div>
			</div>
		</div>

<!-- El formulario de busqueda de Libro (Modal) -->

  	 <div class="modal fade" id="idBuscaLibro" >
			<div class="modal-dialog" style="width: 60%">

				<div class="modal-content">
				<div class="modal-header" style="padding: 35px 50px">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4><span class="glyphicon glyphicon-ok-sign"></span> Busqueda de Libro</h4>
				</div>
				<div class="modal-body" style="padding: 20px 10px;">
						    <div class="panel-group" id="steps">
		                        <div class="panel panel-default">
											<div class="form-group">
													<label class="col-lg-3 control-label">
														Libro 
													</label>   
													<div class="col-lg-5">
														<input id="id_txtLibro" class="form-control" name="libro" type="text" />
													</div>
											</div>
							<div class="form-group">
												<div class="col-lg-12">
												<table id="id_table_libro" class="table table-striped table-bordered" >
														<thead>
															<tr>
																<th style="width: 40%">Código</th>
																<th style="width: 50%">Título</th>
																<th style="width: 35%">Estado</th>
																
																<th style="width: 10%"></th>
														</thead>
														<tbody>

														</tbody>				
												</table>
												</div>
											</div>
		                        </div>
		                    </div>
				</div>
			</div>
			</div>
		</div>


	<!-- Modal Mensaje -->	
		  <div class="modal fade" id="idMensaje" >
			<div class="modal-dialog" style="width: 60%">

				<div class="modal-content">
				<div class="modal-header" style="padding: 20px 20px">
				
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4><span class="glyphicon glyphicon-ok-sign"></span> Mensaje</h4>
				</div>
				<div  id="idMensajeTexto" class="modal-body text-center " style="padding: 30px 30px;align-content: center;">

			    </div>
			</div>
			</div>
		</div>

</form>

</div>




<script type="text/javascript">
	$(document).ready(function() {
		
		$.getJSON("listaSeleccionDevolucion",{}, function (data){
			$.each(data, function(index, item){
				$('#id_table_boleta_body').append("<tr><td>" +item.idLibro + "</td><td>" +item.titulo + "</td><td><button type='button' onclick='f_elimina_seleccion(" + item.idAlumno +");' class='btn btn-default' aria-label='Left Align' ><span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button></td></tr>");
			});
		});
		
	});

	window.onload = function(){
    document.getElementById('id_fechaDevolucion').min = new Date().toISOString().split('T')[0];
}


	
	
	
	//Al pulsar el boton alumno
	$("#id_btnAlumno").click(function (){
		muestraAlumno();
		$("#idBuscaAlumno").modal("show");
	});

	//Al pulsar el botn libro
	$("#id_btnLibro").click(function (){
		muestraLibro();
		$("#idBuscaLibro").modal("show");
	});

	//Al escribir en la caja de texto del alumno
	$("#id_txtAlumno").keyup( function (e){
		muestraAlumno();
	});

	//Al escribir en la caja de texto del libro
	$("#id_txtLibro").keyup( function (e){
		muestraLibro();
	});

	//Se anula el enter
	$(document).on("keypress", "form", function(event) { 
	    return event.keyCode != 13;
	});

	
$("#id_btnAgregar").click(function (){
    var var_id = $("#id_libro_id").val();
    var var_nom_com = $("#id_alumno_nombre").val();
    var var_titulo = $("#id_libro_nombre").val();
    var var_fech = $("#id_fechaDevolucion").val();
    
    // Validar duplicados
    var yaExiste = false;
    $("#id_table_boleta_body tr").each(function() {
        if($(this).find('td:eq(0)').html() == var_id){
            yaExiste = true;
        }
    });
    
    if (var_nom_com == '' ){
        $("#idMensajeTexto").text("Seleccione un alumno");
        $("#idMensaje").modal("show");
    }
    else if ( var_titulo == '' ){
        $("#idMensajeTexto").text("Seleccione un Libro");
        $("#idMensaje").modal("show");
    } else if (var_fech == '' ){
        $("#idMensajeTexto").text("Seleccione una fecha");
        $("#idMensaje").modal("show");
    } else if (yaExiste){
        $("#idMensajeTexto").text("Existe el libro elegido");
        $("#idMensaje").modal("show");
    } else {
    	
    	
    	
    	var var_titulo = $("#id_libro_nombre").val();
	
    	
		//limpiar la tabla
		$("#id_table_boleta_body").empty();
        
        
        var jsonParam = {"idLibro": var_id, "titulo": var_titulo};
        
        $.ajax({
            url: 'agregarSeleccionDevolucion',
            type: 'POST',
            dataType: 'json',
            data: jsonParam,
            success: function(data) {
                console.log(data);
                if (data != null) {
                	$.each(data, function(index, item){
                		
                    // Agregar la nueva fila sin limpiar la tabla
                    $('#id_table_boleta_body').append("<tr><td>" + item.idLibro + "</td><td>" + item.titulo + "</td><td><button type='button' onclick='f_elimina_seleccion(" + item.idLibro + ");' class='btn btn-default' aria-label='Left Align' ><span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button></td></tr>");
               
                	});
                	} else {
                    swal("Error al agregar la selección del libro", "", "error");
                    return false;
                }
            },
            error: function(jqXhr) {
                swal("Error en la conexión", "", "error");
            }
        });
        
        
        // Limpiar las cajas de texto después de agregar
        $("#id_libro_id").val("-1");
        $("#id_libro_nombre").val("");
    }
});

	
	//Al pulsar el boton registrar
	$("#id_btnRegistrar").click(function (){
	var var_alu = $("#id_alumno_id").val();
	var var_idLibro = $("#id_libro_id").val();
	var var_Libro =$("#id_libro_nombre").val("");

	var var_alum_nombre = $("#id_alumno_nombre").val();
	var var_fecha_devolucion = $("#id_fechaDevolucion").val();


	if (var_alu == "-1"){
		$("#idMensajeTexto").text("Seleccione un alumno");
		$("#idMensaje").modal("show");
	}else if (var_fecha_devolucion == "-1"){
		$("#idMensajeTexto").text("Seleccione un libro");
		$("#idMensaje").modal("show");
	}else{

		var jsonParam = {"idAlumno":var_alu,"nombres":var_alum_nombre, "fechaPrestamo":var_fecha_devolucion,"fechaDevolucion":var_fecha_devolucion };

		$.ajax({
			url:  'registraDevolucion',
			type: 'POST',
			dataType:'json',
			data: jsonParam,
			success:function(data){
				if(data.texto != "-1"){
					console.log(data.texto);
					$("#idMensajeTexto").html(data.texto);
					$("#idMensaje").modal("show");
					$("#id_table_boleta_body").empty();
					$("#id_libro_id").val("-1");
					$("#id_alumno_nombre").val("");
				    $("#id_fechaDevolucion").val("");

				}else
					swal("Error al agregar la Boleta","","error");
					return false;
				},
			error: function (jqXhr) { 
				swal("Error en la conexion","","error");
			}
	   });	
		   
	}
});



/////////// muestra alumno

	function muestraAlumno(){
	
	var var_alumno = $("#id_txtAlumno").val();
		
		//limpiar la tabla
		$("#id_table_alumno tbody").empty();
		
		console.log("Funcion muestraAlumno() llamada");
		//Se añade los alumnos a la tabla
		$.getJSON("listaAlumnoDevolucion",{"filtro":var_alumno}, function (data){
			$.each(data, function(index, item){
				$('#id_table_alumno').append("<tr><td>" +item.idAlumno + "</td><td>" +item.nombres + "</td><td>" +item.apellidos + "</td><td><button type='button' class='btn btn-default' aria-label='Left Align' onclick=\"f_seleccione_alumno('"+ item.idAlumno+"','"+ item.nombres+"','"+ item.apellidos+"');\" ><span class='glyphicon glyphicon-ok' aria-hidden='true'></span></button></td></tr>");
			});
		});
	}


// muestra Libro


	function muestraLibro(){
		var var_libro = $("#id_txtLibro").val();

		//limpiar la tabla
		$("#id_table_libro tbody").empty();
		
	    console.log("Funcion muestraLibro() llamada ");
		//Se añade los libros a la tabla
		$.getJSON("listaLibroDevolucion",{"filtro":var_libro}, function (data){
			$.each(data, function(index, item){
			    $('#id_table_libro').append("<tr><td>" +item.idLibro + "</td><td>" +item.titulo + "</td><td>"    + item.estadoPrestamo.descripcion + "</td><td><button type='button' class='btn btn-default' aria-label='Left Align' onclick=\"f_seleccione_libro('"+ item.idLibro+"','"+ item.titulo +"','"+  item.estadoPrestamo.descripcion +"');\" ><span class='glyphicon glyphicon-ok' aria-hidden='true'></span></button></td></tr>");
			});
		});
	}



	//Al pulsar selecciona alumno
	function f_seleccione_alumno(idAlumno,nombres,apellidos){
		$("#id_alumno_nombre").val(nombres + ' ' + apellidos);
		$("#id_alumno_id").val(idAlumno);
		$("#idBuscaAlumno").modal("hide");
	}
	
	//Al pulsar selecciona libro
	function f_seleccione_libro(idLibro,titulo,estadoPrestamo){
		$("#id_libro_nombre").val(titulo);
		$("#id_libro_id").val(idLibro);
		$("#idBuscaLibro").modal("hide");
	}

	
	
	//Al pulsar el boton eliminar
	function f_elimina_seleccion(id){	
		//limpiar la tabla
		$("#id_table_boleta_body").empty();
			
		//Se aÃ±ade los clientes a la tabla
		$.getJSON("eliminaSeleccionDevolucion",{"idLibro":id}, function (data){
			$.each(data, function(index, item){
				$('#id_table_boleta_body').append("<tr><td>" +item.idLibro + "</td><td>" +item.titulo + "</td><td><button type='button' onclick='f_elimina_seleccion(" + item.idLibro +");' class='btn btn-default' aria-label='Left Align' ><span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button></td><tr>");
			});
		});
		//limpia las cajas de texto
		$("#id_libro_id").val("-1");
		$("#id_libro_nombre").val("");
	}
	
	

</script>   		
</body>
</html>