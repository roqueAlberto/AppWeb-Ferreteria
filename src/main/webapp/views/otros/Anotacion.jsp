
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>NOTAS</title>


  <!-- Font Awesome -->
  <link rel="stylesheet" href="resources/plugins/fontawesome-free/css/all.min.css" />
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="resources/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css" />
  <!-- iCheck -->
  <link rel="stylesheet" href="resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css" />
  <!-- JQVMap -->
  <link rel="stylesheet" href="resources/plugins/jqvmap/jqvmap.min.css" />
  <!-- Theme style -->
  <link rel="stylesheet" href="resources/dist/css/adminlte.min.css" />
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="recursos/plugins/overlayScrollbars/css/OverlayScrollbars.min.css" />
  <!-- Daterange picker -->
  <link rel="stylesheet" href="resources/plugins/daterangepicker/daterangepicker.css" />
  <!-- summernote -->
  <link rel="stylesheet" href="resources/plugins/summernote/summernote-bs4.min.css" />

  <!-- Select2 -->
  <link rel="stylesheet" href="resources/plugins/select2/css/select2.min.css" />
  <link rel="stylesheet" href="resources/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css" />

  <link rel="stylesheet" href="resources/custom/css/mystyle.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed" onload="asignarFocus()">
  <div class="wrapper">
    <!-- Preloader -->

    <jsp:include page="../../resources/custom/include/sidebar.jsp"></jsp:include>

  </div>
  <!-- /.sidebar -->

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Main content -->
    <section class="content">
      <!-- Main row -->
      <div class="row d-flex">
        <div class="col-md-6">
          <form action="anotacion.do" method="POST">
            <div class="card card-success mt-4">
              <div class="card-body">
                <div class="form-group col-lg-10">
                  <label>Escriba lo que desea guardar</label>

                  <textarea class="form-control" rows="3" placeholder="Escribir ..." name="anotacion" id="anotacion"></textarea>
                </div>
                <button class=" agregarP btn btn-success " type="submit" name="opcion" value="escribir-nota"><i class="far fa-check-circle"></i> Guardar</button>
                <!-- /.form group -->
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </form>
        </div>

        <div class="col-sm-5 mt-4">
          <p class="lead">Notas escritas en el día</p>
          <form action="anotacion.do" method="POST">
            <input type="date" value="${fecha}" name="fechaCapturada" />
            <button type="submit" class="btn btn-danger" name="opcion" value="buscar">
              <i class="zmdi zmdi-search-in-page"></i> Buscar
            </button>
          </form>

          <div class="table-responsive">
            <table class="table">
              <c:forEach var="lista" items="${anotaciones}">
                <tr>
                  <th>${lista}</th>
                </tr>
              </c:forEach>
            </table>
          </div>
        </div>
      </div>
      <!-- /.row (main row) -->
    </section>
    <!-- /.content -->
  </div>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
  
  <!-- ./wrapper -->

  <!-- jQuery -->
  <script src="resources/plugins/jquery/jquery.min.js"></script>
  <!-- jQuery UI 1.11.4 -->
  <script src="resources/plugins/jquery-ui/jquery-ui.min.js"></script>
  <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
  <script>
    $.widget.bridge("uibutton", $.ui.button);
  </script>
  <!-- Bootstrap 4 -->
  <script src="resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
  <!-- ChartJS -->
  <script src="resources/plugins/chart.js/Chart.min.js"></script>
  <!-- Sparkline -->
  <script src="resources/plugins/sparklines/sparkline.js"></script>
  <!-- JQVMap -->
  <script src="resources/plugins/jqvmap/jquery.vmap.min.js"></script>
  <script src="resources/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
  <!-- jQuery Knob Chart -->
  <script src="resources/plugins/jquery-knob/jquery.knob.min.js"></script>
  <!-- daterangepicker -->
  <script src="resources/plugins/moment/moment.min.js"></script>
  <script src="resources/plugins/daterangepicker/daterangepicker.js"></script>
  <!-- Tempusdominus Bootstrap 4 -->
  <script src="resources/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
  <!-- Summernote -->
  <script src="resources/plugins/summernote/summernote-bs4.min.js"></script>

  <!-- AdminLTE App -->
  <script src="resources/dist/js/adminlte.js"></script>
  <!-- AdminLTE for demo purposes -->
  <script src="resources/dist/js/demo.js"></script>
  <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
  <script src="resources/dist/js/pages/dashboard.js"></script>


  <!-- Select2 -->
  <script src="resources/plugins/select2/js/select2.full.min.js"></script>

    <script>

        $(function () {

            $("#btn-guardarDB").click(function () {

                $.ajax({
                    url: "informe.do?opcion=backupDataBase",
                    type: "GET",
                    datatype: "json",
                    success: function (data) {

                        var backup = JSON.parse(data).backup;

                        if (backup) {
                            alert("Base de datos guardada EXITOSAMENTE!!!")
                        } else {
                            alert("Ocurrio un error al guardar la base de datos");
                        }
                    }

                });



            });

        });

        function asignarFocus() {

            var anotar = document.getElementById("anotacion");
            anotar.focus();

        }
    </script>




</body>
</html>

