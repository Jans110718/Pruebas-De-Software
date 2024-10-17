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
			<h4>Consulta Tesis</h4>
			<div class="row" style="margin-top: 3%">
				<div class="col-lg-6">
					<label class="control-label" for="id_titulo">Título</label> <input
						class="form-control" type="text" id="id_titulo" name="paramTitulo"
						placeholder="Ingrese el título">
				</div>
				<div class="col-lg-6">
					<label class="control-label" for="id_estado">Estado</label> <input
						type="checkbox" class="form-control" id="id_estado" name="paramEstado"
						checked="checked">
				</div>
			</div>
			<div class="row" style="margin-top: 2%">
				<div class="col-lg-6">
					<label class="control-label" for="id_tema">Tema</label> <input
						class="form-control" type="text" id="id_tema" name="paramTema"
						placeholder="Ingrese el tema">
				</div>
				<div class="col-lg-6">
					<label class="control-label" for="id_alumno">Alumno</label> <select
						id="id_alumno" name="paramIdAlumno" class='form-control'>
						<option value="-1">[Seleccione]</option>
					</select>
				</div>
			</div>
			<div class="row" style="margin-top: 2%">
				<div class="col-lg-6">
					<label class="control-label" for="id_desde">Fecha Creación
						(Desde)</label> <input type="date" class="form-control" id="id_desde"
						name="paramDesde" value="1900-01-01">
				</div>
				<div class="col-lg-6">
					<label class="control-label" for="id_hasta">(Hasta)</label> <input
						type="date" class="form-control" id="id_hasta" name="paramHasta" value="2900-01-01">
				</div>
			</div>
			<div class="row" style="margin-top: 3%">
				<div class="col-md-12" align="center">
					<button type="button" class="btn btn-primary" id="id_btn_filtra">FILTRAR</button>
					<button type="button" class="btn btn-primary" id="id_btn_reporte">PDF</button>
				</div>
			</div>
			<div class="row" style="margin-top: 3%">
				<div class="col-md-12">
					<table id="id_table" class="table table-striped table-bordered">
						<thead>
							<tr>
								<th style="width: 5%">C&oacute;digo</th>
								<th style="width: 17%">Título</th>
								<th style="width: 18%">Tema</th>
								<th style="width: 10%">Fecha Creaci&oacute;n</th>
								<th style="width: 17%">Alumno</th>
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
		$.getJSON("listaAlumno", {}, function(data) {
			$.each(data, function(index, item) {
				// Se crea una variable que combina los campos "nombres" y "apellidos" para formar el nombre completo
				var nombreCompleto = item.nombres + " " + item.apellidos;
				$("#id_alumno").append(
						"<option value=" + item.idAlumno + ">" + nombreCompleto
								+ "</option>");
			});
		});

		$("#id_btn_reporte").click(function(){
			$("#id_form").attr('action', 'reporteTesisPdf');
			$("#id_form").submit();
		});
		
		$("#id_btn_filtra")
				.click(
						function() {
							var varEstado = $("#id_estado").is(':checked') ? 1
									: 0;
							var varAlumno = $("#id_alumno").val();
							var varTitulo = $("#id_titulo").val();
							var varTema = $("#id_tema").val();
							var varFecDesde = $("#id_desde").val() == '' ? '1900-01-01'
									: $("#id_desde").val();
							var varFecHasta = $("#id_hasta").val() == '' ? '9999-01-01'
									: $("#id_hasta").val();

							console.log(">> varEstado >> " + varEstado);
							console.log(">> varAlumno >> " + varAlumno);
							console.log(">> varTitulo >> " + varTitulo);
							console.log(">> varTema >> " + varTema);
							console.log(">> varFecDesde >> " + varFecDesde);
							console.log(">> varFecHasta >> " + varFecHasta);

							if (valFechaInicioMayFechaFin("#id_desde",
									"#id_hasta")) {
								mostrarMensaje("La fecha hasta es superior a la fecha desde");
								return;
							}

							$.getJSON("consultaTesis", {
								"estado" : varEstado,
								"idAlumno" : varAlumno,
								"titulo" : varTitulo,
								"tema" : varTema,
								"desde" : varFecDesde,
								"hasta" : varFecHasta
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
					data : "idTesis"
				}, {
					data : "titulo"
				}, {
					data : "tema"
				}, {
					data : "fechaCreacion"
				}, {
	                data: function (row) {
	                    // Concatenar nombre y apellido del alumno
	                    return row.alumno.nombres + ' ' + row.alumno.apellidos;
	                }
	            }, {
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