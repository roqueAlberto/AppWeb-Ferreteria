<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>NUEVO</title>
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
  <!-- Select2 -->
  <link rel="stylesheet" href="resources/plugins/select2/css/select2.min.css" />
  <link rel="stylesheet" href="resources/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css" />
  <link rel="stylesheet" href="resources/custom/css/mystyle.css">
  <!--Plugin Toasrl-->
  <link rel="stylesheet" href="resources/custom/css/toastr.min.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed fondo-nuevo">
  <div class="wrapper">
       <jsp:include page="../../resources/custom/include/sidebar.jsp" ></jsp:include>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
      <!-- Main content -->
      <section class="content">
        <!-- Main row -->
        <div class="row">
          <div class="col-md-7 mt-4">
            <form id="form" method="POST" name="form">
              <div class="card card-primary" style="position: relative; left: 30% ;top: 0%">
                <div class="card-header ">
                  <h3 class="card-title font-weight-bold text-center">Agregar producto</h3>
                </div>

                <div class="card-body">
                  <div class="form-group col-lg-7">
                    <label class="text-gray">Código</label>
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-barcode"></i></span>
                      </div>
                      <input type="text" class="text-center form-control" name="codigo" id="codigo" />
                    </div>
                  </div>
                  <div class="form-group col-lg-6">
                    <label class="text-gray">Seccion</label>
                    <select class="form-control" name="seccion" id="seccion">
                      <c:forEach var="sec" items="${listar_seccion}">
                        <option value="${sec.getId()}">${sec.getNombre()}</option>
                      </c:forEach>
                    </select>
                  </div>

                  <div class="form-group col-lg-9">
                    <label class="text-gray">Nombre</label>
                    <div class="input-group">
                      <input type="text" class="text-center form-control" name="descripcion" id="descripcion" />
                    </div>
                  </div>
                  <!--Forma en la que se vende el producto-->
                  <div class="d-flex">
                    <div class="form-group col-lg-6 ">
                      <div class="col-sm-10">
                        <label class="text-gray">Forma de venta
                        </label>
                        <select class="form-control" id="forma_venta" name="forma_venta" onchange="seleccionado()">
                          <option value="0">-- Selecciona --</option>
                          <option value="1">Unidad</option>
                          <option value="2">A granel</option>
                          <option value="3">Pack</option>
                        </select>
                      </div>
                    </div>
                    <!--Unidades de medida-->
                    <div>
                      <label class="radio text-gray">
                        <input type="radio" value="1" checked="" id="kg" name="uni_medida" id="unidadKg" disabled="">
                        Kg
                        <span></span>
                      </label>

                      <label class="radio text-gray ml-3 mt-4">
                        <input type="radio" value="2" name="uni_medida" id="mts" disabled="">
                        m(mts.)
                        <span></span>
                      </label>
                    </div>
                  </div>

                  <div class="d-flex">
                    <div class="form-group col-lg-5">
                      <label class="text-gray">Stock</label>
                      <div class="input-group">
                        <input type="text" class="text-center form-control" name="stock" id="stock" />
                      </div>
                    </div>

                    <!-- Precio-->
                    <div class="form-group col-lg-5 ml-4">
                      <label class="text-gray">Precio</label>
                      <div class="input-group">
                        <i class="fas fa-dollar-sign fa-2x "></i><input type="text" class="ml-4 text-center form-control" name="precio" id="precio" />
                      </div>
                      <!-- /.input group -->
                    </div>
                  </div>
                  <div class="col-lg-8 text-center">
                    <button class="agregarP btn btn-primary" id="btnAgregar" type="button" name="opcion" value="agregar"> Guardar</button>
                  </div>
                </div>
              </div>
              <!-- /.card -->
            </form>
          </div>

          <div class="ml-auto mt-4">
            <button class="font-weight-bold seccionA btn bg-danger" id="btn-Seccion">
              <i class="fas fa-folder-plus"></i> Nueva seccion
            </button>
          </div>
        <jsp:include page="/resources/custom/modal/NuevoModal.jsp"></jsp:include>
        </div>      
      </section>    
    </div>
    <aside class="control-sidebar control-sidebar-dark"></aside>  
  </div>


  <!-- jQuery -->
  <script src="recursos/plugins/jquery/jquery.min.js"></script>
  <!-- jQuery UI 1.11.4 -->
  <script src="recursos/plugins/jquery-ui/jquery-ui.min.js"></script>
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
  
  <script src="resources/dist/js/pages/dashboard.js"></script>
  <!--Plugin Toasrl-->
  <script src="resources/build/js/toastr.min.js"></script>
  <!-- Select2 -->
  <script src="recursos/plugins/select2/js/select2.full.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js" integrity="sha256-t9UJPrESBeG2ojKTIcFLPGF7nHi2vEc7f5A2KpH/UBU=" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
  <!-- js nuevo-->
  <script src="resources/custom/js/nuevo.js"></script>
</body>
</html>


