<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>INFORMES</title>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="resources/plugins/fontawesome-free/css/all.min.css" />
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

    <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-danger elevation-4">
      <!-- Brand Logo -->
      <a href="#" class="brand-link text-center">
        <span class="brand-text font-weight-bold">CASA TRACHTA S.R.L</span>
      </a>
      <!-- Sidebar -->
      <div class="sidebar">
        <!-- Sidebar Menu -->
        <nav class="mt-2">
          <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
            <li class="nav-header">Principal</li>
            <li class="nav-item">
              <a href="informe.do?opcion=inicio" class="nav-link active">
                <i class="nav-icon fas fa-chart-bar"></i>

                <p>Informes</p>
              </a>
            </li>

            <li class="nav-header">Gestionar</li>

            <li class="nav-item">
              <a href="#" class="nav-link ">
                <i class="nav-icon fas fa-tools"></i>
                <p>
                  Productos
                  <i class="fas fa-angle-left right"></i>
                </p>
              </a>
              <ul class="nav nav-treeview">
                <li class="nav-item">
                  <a href="producto.do?menu=nuevo&opcion=default" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Nuevo</p>
                  </a>
                </li>
                <li class="nav-item">
                  <a href="producto.do?menu=lista&opcion=mostrar&pagina=1" opcion=Listar" class="nav-link ">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Lista de productos</p>
                  </a>
                </li>
                <li class="nav-item">
                  <a href="producto.do?menu=stock&opcion=default" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Actualizar Stock</p>
                  </a>
                </li>
              </ul>
            </li>

            <li class="nav-item">
              <a href="venta.do?opcion=default" class="nav-link">
                <i class="fas fa-shopping-cart nav-icon"></i>
                <p>Realizar venta</p>
              </a>
            </li>

            <li class="nav-header">Otros</li>
            <li class="nav-item">
              <a href="gasto.do?opcion=consumos" class="nav-link">
                <i class="nav-icon fas fa-piggy-bank"></i>
                <p>Gastos</p>
              </a>
            </li>
            <li class="nav-item">
              <a href="anotacion.do?opcion=inicio" class="nav-link">
                <i class="nav-icon far fa-clipboard"></i>
                <p>Anotar</p>
              </a>
            </li>
            <br><br><br>
            <li class="nav-item">
              <a class="nav-link" href="#" id="btn-guardarDB">
                <i class="nav-icon fas fa-shield-alt"></i>
                <p class="font-weight-bold">Copia de seguridad</p>
              </a>
            </li>
          </ul>
        </nav>
        <!-- /.sidebar-menu -->
      </div>
      <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">

      <!-- Main content -->
      <section class="content">
        <div class="container-fluid">
          <!-- Small boxes (Stat box) -->
          <br />
          <div class="row">
            <div class="col-lg-3 col-6 ml-5">
              <!-- small box -->
              <div class="small-box bg-info">
                <div class="inner">
                  <h3>$ ${totalCaja}</h3>

                  <p>Caja</p>
                </div>
                <div class="icon">
                  <i class="ion ion-bag"></i>
                </div>
                <a href="informe.do?opcion=registros-ventas" class="small-box-footer">Mas información <i class="fas fa-arrow-circle-right"></i></a>
              </div>
            </div>
            <!-- ./col -->

            <!-- ./col -->
            <div class="col-lg-3 col-6 ml-5">
              <!-- small box -->
              <div class="small-box bg-info">
                <div class="inner">
                  <h3>$ ${totalGasto}</h3>

                  <p>Gastos del día</p>
                </div>

                <div class="icon">
                  <i class="fas fa-cart-arrow-down"></i>
                </div>
                <a href="gasto.do?opcion=consumos" class="small-box-footer">Mas información<i class="fas fa-arrow-circle-right"></i></a>
              </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-6 ml-5">
              <!-- small box -->
              <div class="small-box bg-info">
                <div class="inner">
                  <h3>${notas}</h3>

                  <p>Notas escritas</p>
                </div>
                <div class="icon">
                  <i class="fas fa-clipboard"></i>
                </div>
                <a href="anotacion.do?opcion=Inicio" class="small-box-footer">Mas información <i class="fas fa-arrow-circle-right"></i></a>
              </div>
            </div>
            <!-- ./col -->
          </div>
          <!-- /.row -->


          <div class="d-flex">
            <div class="col-lg-8 my-3">
              <div class="card rounded-0">
                <div class="card-header">
                  <h6 class="">Ingresos mensuales</h6>
                </div>

                <div class="card-body">
                  <canvas id="myChart"></canvas>
                </div>
              </div>
            </div>


            <div class="col-lg-4 my-3">
              <div class="card rounded-0">
                <div class="card-header bg-light text-center">
                  <h6 class="font-weight-light mb-0 " style="color: darkcyan">Productos con poco stock</h6>
                </div>
                <div class="card-body pt-2">
                  <c:forEach var="lista_menor" items="${listaLimitada}">
                    <div class="d-flex border-bottom py-2">
                      <div>
                        <span class="d-inline-block mb-0 font-weight-bold">${lista_menor.getNombre()}</span><span class="badge badge-success ml-2">${lista_menor.getStockOriginal()}</span>
                      </div>
                    </div>
                  </c:forEach>
                  <button class="btn btn-outline-primary w-100" id="btn-ver">Ver todos</button>
                </div>
              </div>
            </div>
          </div>

          <!--Ventana modal lista de productos con poco stock-->
          <div class="container">
            <div class="modal" tabindex="-1" id="ventana-modal" role="dialog">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title">Modal title</h5>
                  </div>
                  <div class="modal-body">
                    <div class="contenedor" style="overflow: scroll; height: 300px; ">
                      <table class="table table-hover">
                        <thead>
                          <tr>
                            <th>Producto</th>
                            <th>Stock</th>
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach var="lista" items="${listaCompleta}">
                            <tr>
                              <c:if test="${lista.getStockOriginal()=='0'}">
                                <td>${lista.getNombre()}</td>
                                <td>Sin stock</td>
                              </c:if>

                              <c:if test="${lista.getStockOriginal() != '0'}">
                                <td>${lista.getNombre()}</td>
                                <td>${lista.getStockOriginal()}</td>
                              </c:if>
                            </tr>
                          </c:forEach>
                        </tbody>
                      </table>
                    </div>
                    <br><br>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-outline-info" data-dismiss="modal">
                      Cerrar
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /.container-fluid -->
      </section>
      <!-- /.content -->
    </div>


    <!-- Control Sidebar -->
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
                $.ajax({
                    url: "informe.do?opcion=ventas-por-mes",
                    type: "get",
                    dataType: "JSON",
                    success: function (data) {
                        var ctx = document.getElementById("myChart").getContext("2d");
                        var chart = new Chart(ctx, {
                            // The type of chart we want to create
                            type: "bar",
                            // The data for our dataset
                            data: {
                                labels: [
                                    "Ene","Feb","Mar","Abr","May","Jun","Jul","Ago",
                                    "Sep","Oct","Nov","Dic"
                                ],
                                datasets: [{
                                        label: "Ingresos mensuales",
                                        backgroundColor: [
                                            'rgba(255, 99, 132, 0.2)',
                                            'rgba(54, 162, 235, 0.2)',
                                            'rgba(255, 206, 86, 0.2)',
                                            'rgba(75, 192, 192, 0.2)',
                                            'rgba(153, 102, 255, 0.2)',
                                            'rgba(255, 159, 64, 0.2)',
                                            'rgba(63,24,33, 0.2)',
                                            'rgba(49,127,110, 0.2)',
                                            'rgba(110,49,127, 0.2)',
                                            'rgba(127,110,49, 0.2)',
                                            'rgba(49,66,127, 0.2)',
                                            'rgba(238,228,11, 0.2)'
                                        ],
                                        borderColor: [
                                            'rgba(255, 99, 132, 1)',
                                            'rgba(54, 162, 235, 1)',
                                            'rgba(255, 206, 86, 1)',
                                            'rgba(75, 192, 192, 1)',
                                            'rgba(153, 102, 255, 1)',
                                            'rgba(255, 159, 64, 1)',
                                            'rgba(63,24,33, 1)',
                                            'rgba(49,127,110, 1)',
                                            'rgba(110,49,127, 1)',
                                            'rgba(127,110,49, 1)',
                                            'rgba(49,66,127,1)',
                                            'rgba(238,228,11, 1)'
                                        ],
                                        borderWidth: 1,
                                        data: [data.enero, data.febrero, data.marzo, data.abril, data.mayo, data.junio, data.julio, data.agosto, data.septiembre, data.octubre, data.noviembre, data.diciembre],
                                    }]
                            },                    
                            options: {}
                        });
                    }
                });
                $("#btn-ver").click(function () {
                    $(function () {
                        $(".modal-header").css("background-color", "#00CCCC");
                        $(".modal-header").css("color", "white");
                        $(".modal-title").text("Productos con bajo stock");
                        $('#ventana-modal').modal('show');
                    });
                });
                $("#btn-guardarDB").click(function () {
                    $.ajax({
                        url: "informe.do?opcion=backupDataBase",
                        type: "GET",
                        datatype: "json",
                        success: function (data) {                          
                           var backup = JSON.parse(data).backup;                                               
                            if(backup){
                                alert("Base de datos guardada EXITOSAMENTE!!!");
                            }else{
                                alert("Ocurrio un error al guardar la base de datos");
                            }
                        }
                    });
                });
            });
        </script>
    </body>
</html>