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

    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/dataTables.bootstrap.min.css" />
    <link rel="stylesheet" href="css/bootstrapValidator.css" />

    <style>
        /* Ajuste del contenedor del formulario con un borde m&aacute;s grueso */
        .form-container {
            max-width: 2000px; /* Aumenta el ancho del formulario */
            margin: 50px auto;
            background-color: #ffffff;
            padding: 40px;
            border: 5px solid #007bff; /* Borde grueso alrededor del formulario */
            border-radius: 10px;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            box-sizing: border-box;
        }

        body {
            padding-top: 90px; /* Altura de la navbar */
            background-color: #f4f4f4;
        }

        .navbar-fixed-top {
            height: 100px; /* Ajusta la altura de tu navbar seg&uacute;n sea necesario */
        }

        h4 {
            text-align: center;
            color: #007bff; /* Color del t&iacute;tulo */
            margin-bottom: 30px;
        }

        .btn {
            width: 150px; /* Ancho fijo para los botones */
            margin: 5px;
            font-size: 1.1em;
        }

        .btn-primary {
            background-color: #003DA5;
            border-color: #003DA5;
        }

        .btn-danger {
            background-color: #C62828;
            border-color: #C62828;
        }

        .table-responsive {
            overflow-x: auto;
            margin-top: 20px;
        }

        table {
            width: 100%;
            table-layout: fixed; /* Ajuste para que las columnas respeten los anchos */
            word-wrap: break-word; /* Permitir que el texto rompa en palabras */
        }

        th {
            background-color: #007bff;
            color: #ffffff;
            font-size: 1.1em;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f2f2f2;
        }

        td {
            white-space: nowrap; /* Evitar que el texto se envuelva */
            font-size: 1em;
        }

        /* Ajustar los anchos de las columnas */
        th, td {
            padding: 8px;
            text-align: left;
        }

        /* Aumentar el ancho de las columnas */
        .col-id-solicitud {
            width: 12%; /* Aumenta el ancho de esta columna */
        }

        .col-marca-modelo {
            width: 25%;
        }

        .col-tipo-vehiculo {
            width: 18%;
        }

        .col-numero-vehiculo {
            width: 15%;
        }

        .col-hora {
            width: 10%;
        }

        .col-fecha-reserva {
            width: 10%;
        }

        .col-estado {
            width: 10%;
        }
    </style>

    <title>Intranet - Solicitud de Ingreso</title>
</head>

<body>
    <form id="id_form">
        <jsp:include page="intranetCabecera.jsp" />
        <div class="container form-container">
            <h4>Consulta de Solicitud de Ingreso</h4>
            <div class="row">
                <div class="col-md-6">
                    <label class="control-label" for="id_espacio">Espacio</label>
                    <select id="id_espacio" name="paramEspacio" class='form-control'>
                        <option value="-1">[Todos]</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="control-label" for="id_tipoVehiculo">Tipo de Veh&iacute;culo</label>
                    <select id="id_tipoVehiculo" name="paramtipoVehiculo" class='form-control'>
                        <option value="-1">[Todos]</option>
                        <option value="0">Moto</option>
                        <option value="1">Carro</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="control-label" for="id_fechaDesde">Fecha Desde</label>
                    <input class="form-control" type="date" id="id_fechaDesde" name="paramFechaDesde" value="1900-01-01">
                </div>
                <div class="col-md-6">
                    <label class="control-label" for="id_fechaHasta">Fecha Hasta</label>
                    <input class="form-control" type="date" id="id_fechaHasta" name="paramFechaHasta" value="2900-01-01">
                </div>
            </div>
            <div class="row" style="margin-top: 3%">
                <div class="col-md-12 text-center">
                    <button type="button" class="btn btn-primary" id="id_btn_filtra">FILTRAR</button>
                    <button type="button" class="btn btn-danger" id="id_btn_reporte">PDF</button>
                </div>
            </div>
            <div class="row" style="margin-top: 3%">
                <div class="col-md-12 table-responsive">
                    <table id="id_table" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th style="width: 16%">ID Solicitud </th>
                                <th style="width: 22%">Marca y Modelo</th>
                                <th style="width: 18%">Tipo Vehiculo</th>
                                <th style="width: 15%">Numero</th>
                                <th style="width: 10%">Hora</th>
                                <th style="width: 20%">Fecha reserva</th>
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
	       // Cargar lista de espacios
	       $.getJSON("listaEspacios", {}, function (data) {
	           $.each(data, function (i, item) {
	               $("#id_espacio").append("<option value=" + item.idEspacio + ">" + item.numero + "</option>");
	           });
	       });

	       // Manejo de reporte
	       $("#id_btn_reporte").click(function () {
	           $("#id_form").attr('action', 'reporteSolicitudPdf');
	           $("#id_form").submit();
	       });

	       // Filtrar datos
	       $("#id_btn_filtra").click(function () {
	           var varEstado = $("#id_estado").is(':checked') ? 1 : 0;
	           var varEspacio = $("#id_espacio").val();
	           var vartipoVehiculo = $("#id_tipoVehiculo").val(); // Tipo de veh&iacute;culo
	           var varFechaDesde = $("#id_fechaDesde").val() || '1900-01-01';
	           var varFechaHasta = $("#id_fechaHasta").val() || '2900-01-01';

	           console.log(">> varEstado >> " + varEstado);
	           console.log(">> varEspacio >> " + varEspacio);
	           console.log(">> vartipoVehiculo >> " + vartipoVehiculo); // Verifica el valor del tipo de veh&iacute;culo

	           console.log(">> varFechaDesde >> " + varFechaDesde);
	           console.log(">> varFechaHasta >> " + varFechaHasta);

	           // Validar fechas
	           if (new Date(varFechaDesde) > new Date(varFechaHasta)) {
	               alert("La fecha hasta no puede ser menor que la fecha desde");
	               return;
	           }

	           $.getJSON("consultaSolicitud", {
	               "idEspacio": varEspacio,
	               "tipoVehiculo": vartipoVehiculo, // Par&aacute;metro correcto
	               "fecDesde": varFechaDesde,
	               "fecHasta": varFechaHasta
	           }, function (data) {
	               agregarGrilla(data);
	           });
	       });

	       // Agregar datos a la tabla
	       function agregarGrilla(lista) {
	           // Verificar si DataTable ya existe
	           if ($.fn.DataTable.isDataTable('#id_table')) {
	               $('#id_table').DataTable().clear().destroy();
	           }

	           $('#id_table').DataTable({
	               data: lista,
	               searching: false,
	               ordering: true,
	               processing: true,
	               pageLength: 10,
	               lengthChange: false,
	               columns: [
	                   { data: "idSolicitud" },
	                   {
	                       data: function (row) {
	                           return row.vehiculo.marca + ' ' + row.vehiculo.modelo; // Combina marca y modelo
	                       },
	                       className: 'text-center'
	                   },
	                   {
	                       data: function (row) {
	                           return (row.vehiculo.tipoVehiculo == 0) ? 'Moto' : 'Carro';
	                       },
	                       className: 'text-center'

	                   },
	                   { data: "espacio.numero" },
	                   { data: "hora" },
	                   { data: "fechaReserva" },
	                   {
	                       data: function (row) {
	                           return (row.estado == 1) ? 'Activo' : 'Inactivo';
	                       },
	                       className: 'text-center'
	                   }
	               ]
	           });
	       }
	   </script>
</body>
</html>
