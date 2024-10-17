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
	<form id="id_form">
		<jsp:include page="intranetCabecera.jsp" />
		<div class="container">
			<h4>Consulta Sala</h4>
			<div class="row" style="margin-top: 3%">
				<div class="col-lg-6">
					<label class="control-label" for="id_numero">N&uacutemero</label> <input
						class="form-control" type="text" id="id_numero" name="paramNumero"
						placeholder="Ingrese el numero de la sala">
				</div>
				<div class="col-lg-6">
					<label class="control-label" for="id_estado">Estado</label> <input
						type="checkbox" class="form-control" id="id_estado" name="paramEstado"
						checked="checked">
				</div>
			</div>
			<div class="row" style="margin-top: 2%">
				<div class="col-lg-6">
					<label class="control-label" for="id_numAlumnos">N&uacutemero de Alumnos</label> <input
						class="form-control" type="number" id="id_numAlumnos" name="paramnumAlumnos"
						placeholder="Ingrese el numero del alumnos">
				</div>
				<div class="col-lg-6">
					<label class="control-label" for="id_tipoSala">Tipo Sala</label> <select
						id="id_tipoSala" name="paramtipoSala" class='form-control'>
						<option value="-1">[Seleccione]</option>
					</select>
				</div>
			</div>
			<div class="row" style="margin-top: 2%">
				<div class="col-lg-6">
					<label class="control-label" for="id_recursos">Recursos</label> <input
						class="form-control" type="text" id="id_recursos" name="paramRecursos"
						placeholder="Ingrese el recurso">
				</div>
				<div class="col-lg-6">
					<label class="control-label" for="id_sede">Sede</label> <select
						id="id_sede" name="paramsede" class='form-control'>
						<option value="-1">[Seleccione]</option>
					</select>
				</div>
			</div>
			<div class="row" style="margin-top: 2%">
				<div class="col-lg-6">
					<label class="control-label" for="id_piso">Piso</label> <input
						class="form-control" type="number" id="id_piso" name="paramPiso"
						placeholder="Ingrese el piso">
				</div>
			</div>
			<div class="row" style="margin-top: 3%">
				<div class="col-md-12" align="center">
					<button type="button" class="btn btn-primary" id="id_btn_filtra">FILTRAR</button>
					<button type="button" class="btn btn-danger" id="id_btn_reporte">PDF</button>
				</div>
			</div>
			<div class="row" style="margin-top: 3%">
				<div class="col-md-12">
					<table id="id_table" class="table table-striped table-bordered">
						<thead>
							<tr>
								  <th style="width: 10%" >C&oacute;digo</th>
                                <th style="width: 10%">N&uacutemero</th>
                                <th style="width: 10%">Piso</th>
                                <th style="width: 20%">N&uacutemero de Alumnos</th>
                                <th style="width: 10%">Recursos</th>
                                <th style="width: 15%">Tipo Sala</th>
                                <th style="width: 15%">Sede</th>
                                <th style="width: 10%">Estado</th>
                                
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
		$.getJSON("listaTipoSala", {}, function(data) {
			$.each(data, function(index, item) {
				$("#id_tipoSala").append("<option value="+item.idDataCatalogo +">"+ item.descripcion +"</option>");	
			});
		});
		$.getJSON("listaSede", {}, function(data){
			$.each(data, function(index,item){
				$("#id_sede").append("<option value="+item.idDataCatalogo +">"+ item.descripcion +"</option>");
				});
		});

		$("#id_btn_reporte").click(function(){
			$("#id_form").attr('action', 'reporteSalaPdf');
			$("#id_form").submit();
		});
		$("#id_btn_filtra")
				.click(
						function() {
							var varEstado = $("#id_estado").is(':checked') ? 1 : 0;
						    var varNumero = $("#id_numero").val() || "%"; // Asigna "%" si el valor es nulo
						    var varPiso = $("#id_piso").val() || -1; // Asigna -1 si el valor es nulo
						    var varNumAlumnos = $("#id_numAlumnos").val() || -1; // Asigna -1 si el valor es nulo
						    var varRecursos = $("#id_recursos").val() || "%"; // Asigna "%" si el valor es nulo
						    var varSede = $("#id_sede").val();
						    var varTipoSala = $("#id_tipoSala").val();
							
							
						

							console.log(">> varEstado >> " + varEstado);
							console.log(">> varNumero >> " + varNumero)
							console.log(">> varPiso >> " + varPiso);;
							console.log(">> varNumAlumnos >> " + varNumero);
							console.log(">> varRecursos >> " + varRecursos);
							console.log(">> varSede >> " + varSede);
							console.log(">> varTipoSala >> " + varTipoSala);
							

							
							$.getJSON("consultaSala", {
								"estado": varEstado,
							    "numero": varNumero,
							    "piso": varPiso,
							     "numAlumnos":varNumAlumnos,
							    "recursos": varRecursos,
							    "idSede": varSede,
							    "idTipoSala": varTipoSala
							    
								
							}, function(data) {
								agregarGrilla(data);
							});
						});

		function agregarGrilla(lista) {
			$('#id_table').DataTable().clear();
			$('#id_table').DataTable().destroy();
			$('#id_table').DataTable({
				data : lista,
				searching : false,
				ordering : true,
				processing : true,
				pageLength : 10,
				lengthChange : false,
				columns : [ {
					data : "idSala"
				}, {
					data : "numero"
				}, {
					data : "piso"
				}, {
					data : "numAlumnos"
				}, {
					data : "recursos"
				}, {
					data : "sede.descripcion"
				},{
					data : "tipoSala.descripcion"
				},
				{
					data : function(row, type, val, meta) {
						var salida = (row.estado == 1) ? 'Activo' : "Inactivo";
						return salida;
					},
					className : 'text-center'
				}, ]
			});
		}
	</script>
</body>
</html>
