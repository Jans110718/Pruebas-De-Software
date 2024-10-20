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
                    <label class="control-label" for="id_fechaDesde">Fecha Desde</label> 
                    <input class="form-control" type="date" id="id_fechaDesde" name="paramFechaDesde" value="1900-01-01">
                </div>
            </div>
            <div class="row" style="margin-top: 2%">
                <div class="col-md-6">
                    <label class="control-label" for="id_fechaHasta">Fecha Hasta</label> 
                    <input class="form-control" type="date" id="id_fechaHasta" name="paramFechaHasta" value="2900-01-01">
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
                                <th style="width: 15%">Espacio</th>
                                <th style="width: 15%">Fecha Desde</th>
                                <th style="width: 15%">Fecha Hasta</th>
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
   
		$.getJSON("listaEspacios", {}, function(data) {
		    $.each(data, function(i, item) {
		        $("#id_espacio").append("<option value=" + item.idEspacio + ">" + item.numero + "</option>");
		    });
		});

        // Manejo de reporte
        $("#id_btn_reporte").click(function() {
            $("#id_form").attr('action', 'reporteSolicitudIngresoPdf');
            $("#id_form").submit();
        });

        // Filtrar datos
        $("#id_btn_filtra").click(function() {
            var varEstado = $("#id_estado").is(':checked') ? 1 : 0;
            var varEspacio = $("#id_espacio").val();
            var varFechaDesde = $("#id_fechaDesde").val() || '1900-01-01';
            var varFechaHasta = $("#id_fechaHasta").val() || '2900-01-01';

            console.log(">> varEstado >> " + varEstado);
            console.log(">> varEspacio >> " + varEspacio);
            console.log(">> varFechaDesde >> " + varFechaDesde);
            console.log(">> varFechaHasta >> " + varFechaHasta);

            // Validar fechas
            if (new Date(varFechaDesde) > new Date(varFechaHasta)) {
                alert("La fecha hasta no puede ser menor que la fecha desde");
                return;
            }

            $.getJSON("consultaSolicitud", {
                "espacio": varEspacio,
                "fechaDesde": varFechaDesde,
                "fechaHasta": varFechaHasta
            }, function(data) {
                agregarGrilla(data);
            });
        });

        // Agregar datos a la tabla
        function agregarGrilla(lista) {
            $('#id_table').DataTable().clear();
            $('#id_table').DataTable().destroy();
            $('#id_table').DataTable({
                data: lista,
                searching: false,
                ordering: true,
                processing: true,
                pageLength: 10,
                lengthChange: false,
                columns: [
                    { data: "idSolicitud" },
                    { data: "espacio.descripcion" },
                    { data: "fechaDesde" },
                    { data: "fechaHasta" },
                    { 
                        data: function(row) {
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
