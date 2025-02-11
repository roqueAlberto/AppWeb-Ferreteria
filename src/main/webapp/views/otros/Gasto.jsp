
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>GASTOS</title>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="resources/plugins/fontawesome-free/css/all.min.css" />
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="resources/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css" />
  <!-- iCheck -->
  <link rel="stylesheet" href="recursos/plugins/icheck-bootstrap/icheck-bootstrap.min.css" />
  <!-- JQVMap -->
  <link rel="stylesheet" href="recursos/plugins/jqvmap/jqvmap.min.css" />
  <!-- Theme style -->
  <link rel="stylesheet" href="resources/dist/css/adminlte.min.css" />
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="resources/plugins/overlayScrollbars/css/OverlayScrollbars.min.css" />
  <!-- Daterange picker -->
  <link rel="stylesheet" href="resources/plugins/daterangepicker/daterangepicker.css" />
  <!-- summernote -->
  <link rel="stylesheet" href="resources/plugins/summernote/summernote-bs4.min.css" />
  <link rel="stylesheet" href="resources/custom/css/mystyle.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed" onload="asignarFocus()">
  <div class="wrapper">

    <jsp:include page="../../resources/custom/include/sidebar.jsp"></jsp:include>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
      <br />
      <br>
      <br>
      <br>

      <!-- Main content -->
      <section class="content">
        <!-- Main row -->
        <div class="row">
          <div class="col-md-5" style="position: relative; left: 5%">
            <div class="card card-success">
              <div class="card-header">
                <h3 class="card-title font-weight-bold">Gastos del día</h3>
              </div>
              <div class="card-body">
                <form action="gasto.do" method="POST" id="form_gasto" name="form_gasto">
                  <div class="form-group">
                    <label>Descripción</label>
                    <div class="input-group">
                      <input type="text" name="descripcion" id="desc_gasto" class="form-control" required />
                    </div>
                    <!-- /.input group -->
                  </div>
                  <!-- /.form group -->
                  <div class="form-group">
                    <label>Monto</label>
                    <div class="input-group">
                      <input type="text" name="monto" class="form-control" required />
                    </div>
                    <!-- /.input group -->
                  </div>
                  <!-- /.form group -->
                  <button class="btn btn-success" type="submit" name="opcion" value="GuardarGasto">
                    <i class="fas fa-bookmark"></i> Guardar
                  </button>
                  <!-- /.form group -->
                </form>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <div class="col-5" style="position: relative; left: 10%">
            <form action="gasto.do" method="POST">
              <input type="date" value="${fecha}" name="fecha_seleccionada" />
              <button type="submit" class="btn btn-danger" name="opcion" value="Buscar">
                <i class="zmdi zmdi-search-in-page"></i> Buscar
              </button>
            </form>
            <br>
            <p class="lead">${fecha_a}</p>
            <div class="table-responsive">
              <table class="table">
                <c:forEach var="lista_gasto" items="${gastos}">
                  <tr>
                    <th style="width: 50%">${lista_gasto.getDescripcion()}</th>
                    <td>$ ${lista_gasto.getMonto()}</td>
                  </tr>
                </c:forEach>
                <tr>
                  <th style="color: #003e80">TOTAL</th>
                  <td class="font-weight-bold" style="color: #003e80">$${total}</td>
                </tr>
              </table>
            </div>
          </div>
        </div>
        <!-- /.row (main row) -->
      </section>
      <!-- /.content -->
    </div>
    <aside class="control-sidebar control-sidebar-dark">
      <!-- Control sidebar content goes here -->
    </aside>
    <!-- /.control-sidebar -->
  </div>
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
  <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js" integrity="sha256-t9UJPrESBeG2ojKTIcFLPGF7nHi2vEc7f5A2KpH/UBU=" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
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
                            alert("Base de datos guardada EXITOSAMENTE!!!");
                        } else {
                            alert("Ocurrio un error al guardar la base de datos");
                        }
                    }
                });
            });
        });


        function asignarFocus() {
            var descri = document.getElementById("desc_gasto");
            descri.focus();
        }
 </script>
 </body>
</html>
