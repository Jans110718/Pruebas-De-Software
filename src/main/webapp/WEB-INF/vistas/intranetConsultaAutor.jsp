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
<div class="container" style="margin-top: 4%"><h4>Consulta Autor</h4></div>

	<form id="id_form">

<div class="container" style="margin-top: 1%">
<!-- Agregar aquí -->

		<div class="row" style="margin-top: 3%">
			<div class="col-md-6">
				<label class="control-label" for="id_nombres">Nombres y	Apellidos</label> 
				<input class="form-control" type="text" id="id_nombres"	name="paramNomApe">
			</div>
			<div class="col-md-6">
				<label class="control-label" for="id_estado">Estado</label> 
				<input class="form-control" type="checkbox" id="id_estado" name="paramEstado" checked="checked">
			</div>
		</div>
		<div class="row" style="margin-top: 2%">
			<div class="col-md-6">
				<label class="control-label" for="id_desde">Fecha Nacimiento (Desde) </label> 
				<input class="form-control" type="date" id="id_desde" name="paramDesde" value="1908-01-01">
			</div>
			<div class="col-md-6">
				<label class="control-label" for="id_hasta">(Hasta) </label> 
				<input class="form-control" type="date" id="id_hasta" name="paramHasta" value="2900-01-01">
			</div>
		</div>
		<div class="row" style="margin-top: 2%">
			<div class="col-md-6">
				<label class="control-label" for="id_pais">País</label> 
				<select id="id_pais" name="paramPais" class='form-control'>
					<option value="-1">[ Todos ]</option>
				</select>
			</div>
		</div>
		
		<div class="row" style="margin-top: 2%">
			<div class="col-md-6">
				<label class="control-label" for="id_grado">Grado</label> 
				<select id="id_grado" name="paramGrado" class='form-control'>
					<option value="-1">[ Todos ]</option>
				</select>
			</div>
		</div>
		
		
		<div class="row" style="margin-top: 3%">
			<div class="col-md-12" align="center">
				<button type="button" class="btn btn-primary" id="id_btn_filtra">FILTRA</button>
								<button type="button" class="btn btn-primary" id="id_btn_reporte">PDF</button>
				
				
				
				
			</div>
		</div>
		<div class="row" style="margin-top: 3%">
			<div class="col-md-12">
				<table id="id_table" class="table table-striped table-bordered">
					<thead>
						<tr>
							<th style="width: 5%">Código</th>
							<th style="width: 22%">Nombre</th>
							<th style="width: 23%">Apellidos</th>
							<th style="width: 15%">Fecha Nacimiento</th>
							<th style="width: 10%">Teléfono</th>
							<th style="width: 15%">País</th>
							<th style="width: 15%">Grado</th>
							 <th style="width: 8%">Estado</th>
							
							
							
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

$.getJSON("listaPais", {}, function(data){
	$.each(data, function(i,item){
		$("#id_pais").append("<option value="+item.idPais +">"+ item.nombre +"</option>");
	});
});

$.getJSON("listaGradoAutor", {}, function(data){
	$.each(data, function(i,item){
		$("#id_grado").append("<option value="+item.idDataCatalogo  +">"+ item.descripcion +"</option>");
	});
});



/*alt 35 */

$("#id_btn_reporte").click(function(){
	$("#id_form").attr("action", "reporteAutorPdf");
	$("#id_form").submit();
});



$("#id_btn_filtra").click(function(){
	var varEstado = $("#id_estado").is(':checked') ? 1 : 0;  
	var varPais = $("#id_pais").val();
	var varGrado = $("#id_grado").val();

	var varNomApe = $("#id_nombres").val();

	var varFecDesde = $("#id_desde").val() == '' ?'1900-01-01' : $("#id_desde").val();
	var varFecHasta = $("#id_hasta").val() == '' ?'9999-01-01' : $("#id_hasta").val();
	
	console.log(">> varEstado >> " + varEstado );
	console.log(">> varPais >> " + varPais );
	console.log(">> varGrado>> " + varGrado );
	console.log(">> varNomApe >> " + varNomApe );
	console.log(">> varFecDesde >> " + varFecDesde );
	console.log(">> varFecHasta >> " + varFecHasta );
	
	if (valFechaInicioMayFechaFin("#id_desde", "#id_hasta")){
		mostrarMensaje("La fecha hasta es superior a la fecha desde");
		return;
	}
	
	$.getJSON("consultaAutor", {"estado": varEstado, 
								   "idPais": varPais, 
								   "idGrado": varGrado, 
								   "nomApe": varNomApe, 
								   "desde": varFecDesde, 
								   "hasta": varFecHasta }, function(data){
		agregarGrilla(data);
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
			pageLength: 10,
			lengthChange: false,
			columns:[
				{data: "idAutor"},
				{data: "nombres"},
				{data: "apellidos"},
				{data: "fechaNacimiento"},
				{data: "telefono"},
				{data: "pais.nombre"},
				{data: "grado.descripcion"},

				{data: function(row, type, val, meta){
					var salida = (row.estado == 1) ? 'Activo' : "Inactivo" ;
					return salida;
				},className:'text-center'},	
			]                                     
	    });
}

</script>




		
</body>
</html>