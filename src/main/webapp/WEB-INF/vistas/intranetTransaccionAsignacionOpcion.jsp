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
<div class="container" style="margin-top: 4%"><h4>Asignación de Opción a Rol</h4></div>

<form id="id_form" >
	<div class="container">
		<div class="row" style="margin-top: 1%">
			<div class="col-md-6">
				<label class="control-label" for="id_rol">Rol</label> 
				<select id="id_rol" name="idRol" class='form-control'>
					<option value="-1"> [Seleccione] </option>
				</select>
			</div>
		</div>	
		<div class="row" style="margin-top: 1%">
			<div class="col-md-6">
				<label class="control-label" for="id_opcion">Opción</label> 
				<select id="id_opcion" name="idOpcion" class='form-control'>
					<option value="-1"> [Seleccione] </option>
				</select>
			</div>
		</div>
		<div class="row" style="margin-top: 3%">
			<div class="col-md-12" align="center">
				<button type="button" class="btn btn-primary" id="id_btn_agregar">Agregar</button>
			</div>
		</div>
		<div class="row" style="margin-top: 3%">
			<div class="col-md-12">
				<table id="id_table" class="table table-striped table-bordered">
					<thead>
						<tr>
							<th style="width: 10%">Código</th>
							<th style="width: 80%">Opción</th>
							<th style="width: 10%"></th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		</div>
</form>

<script type="text/javascript">
$.getJSON("listaRol", {}, function(data){
	$.each(data, function(i,item){
		$("#id_rol").append("<option value="+item.idRol +">"+ item.nombre +"</option>");
	});
});

$.getJSON("listaOpcion", {}, function(data){
	$.each(data, function(index,item){
		$("#id_opcion").append("<option value="+item.idOpcion +">"+ item.nombre +"</option>");
	});
});

$("#id_rol").change(function(){
	var var_rol = $("#id_rol").val();
	$.getJSON("listaOpcionPorRol", {"idRol":var_rol }, function(data){
		agregarGrilla(data , var_rol);
	});
});

$("#id_btn_agregar").click(function(){
	$.ajax({
        type: "POST",
        url: "registraOpcion", 
        data: $('#id_form').serialize(),
        success: function(data){
      	  agregarGrilla(data.lista, data.rol);
      	  mostrarMensaje(data.mensaje);
        },
        error: function(){
      	  mostrarMensaje(MSG_ERROR);
        }
      });
});

function agregarGrilla(lista, var_rol){
	 $('#id_table').DataTable().clear();
	 $('#id_table').DataTable().destroy();
	 $('#id_table').DataTable({
			data: lista,
			searching: false,
			ordering: true,
			processing: true,
			pageLength: 10,
			lengthChange: false,
			columns:[
				{data: "idOpcion"},
				//{data: "idRol"},
				{data: "nombre"},
				{data: function(row, type, val, meta){
				    var salida='<button type="button" style="width: 90px" class="btn btn-warning btn-sm" onclick="accionEliminar(\'' + var_rol +'\',\'' + row.idOpcion +'\')">Eliminar</button>';
					return salida;
				},className:'text-center'},	
			]                                     
	    });
}

function accionEliminar(idRol, idOpcion){
    $.ajax({
        type: "POST",
        url: "eliminaOpcion", 
        data: {"idRol": idRol, "idOpcion": idOpcion},
        success: function(data){
            // update the data table
            agregarGrilla(data.lista, data.rol);
            mostrarMensaje(data.mensaje);

            // also update the select elements
            $("#id_rol").empty();
            $("#id_opcion").empty();
            $.getJSON("listaRol", {}, function(data){
                $.each(data, function(i,item){
                    $("#id_rol").append("<option value="+item.idRol +">"+ item.nombre +"</option>");
                });
            });
            $.getJSON("listaOpcion", {}, function(data){
                $.each(data, function(i,item){
                    $("#id_opcion").append("<option value="+item.idOpcion +">"+ item.nombre +"</option>");
                });
            });
        },
        error: function(){
            mostrarMensaje(MSG_ERROR);
        }
    });
}
</script>   		
</body>
</html>