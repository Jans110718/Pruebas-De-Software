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
        /* Estilos para centrar el formulario */
        .form-container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #f9f9f9;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        body {
            padding-top: 90px;
            /* Altura de la navbar */
        }

        .navbar-fixed-top {
            height: 100px;
            /* Ajusta la altura de tu navbar según sea necesario */
        }
    </style>
    <title>Intranet - Solicitud de Ingreso</title>
</head>

<body>
    <form id="id_form">
        <jsp:include page="intranetCabecera.jsp" />
        <div class="container" style="margin-top: 5%">
            <h4>Consulta de Solicitud de Ingreso</h4>
        </div>
        <div class="container">
            <div class="row" style="margin-top: 2%">
                <div class="col-md-6">
                    <label class="control-label" for="id_espacio">Espacio</label>
                    <select id="id_espacio" name="paramEspacio" class='form-control'>
                        <option value="-1">[Todos]</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="control-label" for="id_tipoVehiculo">Tipo</label>
                    <select id="id_tipoVehiculo" name="paramtipoVehiculo" class='form-control'>
                        <option value="-1">[Todos]</option>
                        <option value="0">Moto</option>
                        <option value="1">Carro</option>
                    </select>
                </div>

                <div class="col-md-6">
                    <label class="control-label" for="id_fechaDesde">Fecha Desde</label>
                    <input class="form-control" type="date" id="id_fechaDesde" name="paramFechaDesde"
                        value="1900-01-01">
                </div>
            </div>
            <div class="row" style="margin-top: 2%">
                <div class="col-md-6">
                    <label class="control-label" for="id_fechaHasta">Fecha Hasta</label>
                    <input class="form-control" type="date" id="id_fechaHasta" name="paramFechaHasta"
                        value="2900-01-01">
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
                                <th style="width: 10%">ID</th>
                                <th style="width: 15%">Marca y Modelo</th> <!-- Modificado -->
                                <th style="width: 15%">Tipo Vehiculo</th>
                                <th style="width: 15%">Numero</th>
                                <th style="width: 15%">Hora</th>
                                <th style="width: 15%">Fecha reserva</th>

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
            var vartipoVehiculo = $("#id_tipoVehiculo").val(); // Tipo de vehículo
            var varFechaDesde = $("#id_fechaDesde").val() || '1900-01-01';
            var varFechaHasta = $("#id_fechaHasta").val() || '2900-01-01';

            console.log(">> varEstado >> " + varEstado);
            console.log(">> varEspacio >> " + varEspacio);
            console.log(">> vartipoVehiculo >> " + vartipoVehiculo); // Verifica el valor del tipo de vehículo

            console.log(">> varFechaDesde >> " + varFechaDesde);
            console.log(">> varFechaHasta >> " + varFechaHasta);

            // Validar fechas
            if (new Date(varFechaDesde) > new Date(varFechaHasta)) {
                alert("La fecha hasta no puede ser menor que la fecha desde");
                return;
            }

            $.getJSON("consultaSolicitud", {
                "idEspacio": varEspacio,
                "tipoVehiculo": vartipoVehiculo, // Parámetro correcto
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