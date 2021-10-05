<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ventas Realizadas</title>

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
  <link rel="stylesheet" href="resources/plugins/overlayScrollbars/css/OverlayScrollbars.min.css" />
  <!-- Daterange picker -->
  <link rel="stylesheet" href="resources/plugins/daterangepicker/daterangepicker.css" />
  <!-- summernote -->
  <link rel="stylesheet" href="resources/plugins/summernote/summernote-bs4.min.css" />
  <link rel="stylesheet" href="resources/custom/css/mystyle.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">
  <div class="wrapper">
   <jsp:include page="../../resources/custom/include/sidebar.jsp" ></jsp:include>
    <div class="content-wrapper">
      <section class="content">
        <div class="container-fluid">    
          <br />
          <div class="col-sm-8">
            <form action="informe.do?opcion=ventas-por-fecha" method="POST">
              <input type="date" value="${fecha}" name="buscarVenta" />
              <button type="submit" class="btn btn-danger" name="accion" value="Buscar">
                <i class="zmdi zmdi-search-in-page"></i> Buscar
              </button>
            </form>
          </div>
          <br>
          <div class="d-flex">
            <div class="col-sm-7 ml-1" style="overflow: scroll; height: 500px;">
              <table class="table table-hover border-1 ">
                <thead>
                  <tr>
                    <th>Producto</th>
                    <th>Cantidad</th>
                    <th>Importe</th>
                  </tr>
                </thead>

                <tbody>
                  <c:forEach var="lista" items="${listaVentas}">
                    <tr>
                      <td>${lista.getProducto().getNombre()}</td>
                      <td>${lista.getCantidad()}</td>
                      <td>$ ${lista.getImporte()}</td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>

            <div class="col-lg-4 my-3 ml-auto">
              <div class="card rounded-0">
                <div class="card-body pt-2">
                  <div class="d-flex border-bottom py-2 mb-2">
                    <div>
                      <h6 class="d-inline-block mb-0 font-weight-bold" style="color: grey">
                        Efectivo:
                      </h6>
                      <span class="text-center font-weight-bold pl-5">$ ${efectivo}</span>
                    </div>
                  </div>

                  <div class="d-flex border-bottom py-2 mb-2">
                    <div>
                      <h6 class="d-inline-block mb-0 font-weight-bold" style="color: grey">
                        T. Debito <span class="text-muted">( ${cantidadDebito} ):</span>
                      </h6>
                      <span class="text-center font-weight-bold pl-4"> $ ${debito}</span>
                    </div>
                  </div>
                  <div class="d-flex border-bottom py-2 mb-2">
                    <div>
                      <h6 class="d-inline-block mb-0 font-weight-bold" style="color: grey">
                        T. Credito <span class="text-muted">( ${cantidadCredito} ):</span>
                      </h6>
                      <span class="text-center font-weight-bold pl-3"> $ ${credito} </span>
                    </div>
                  </div>
                  <div class="card-footer ">
                    <h1 class="text-center font-weight-bold">$ ${total}</h1>
                  </div>
                </div>
              </div>
            </div>
          </div>     
        </div>     
      </section> 
    </div>
     <aside class="control-sidebar control-sidebar-dark"></aside>
  </div>
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
  <script src="resources/custom/js/registroventa.js"></script>
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

        </script>
    </body>
</html>
