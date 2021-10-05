
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>ACTUALIZAR STOCK</title>
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
</head>

<body class="hold-transition sidebar-mini layout-fixed">
  <div class="wrapper">
    <jsp:include page="../../resources/custom/include/sidebar.jsp" ></jsp:include>  
    <div class="content-wrapper">  
      <section class="content">
        <div class="row">
          <div class="col-md-6 mt-5">
            <form action="producto.do?menu=actualizar-stock" method="POST">
              <div class="card card-primary" style="position: relative; left: 50% ;top: 0%">
                <div class="card-header">
                  <h3 class="card-title font-weight-bold">Producto</h3>
                </div>
                <div class="card-body">
                  <div class="form-group col-lg-8">
                    <label class="text-gray">Código</label>
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-barcode"></i></span>
                      </div>
                      <input type="text" class="form-control font-italic" name="codigo" id="codigo" />
                    </div>
                  </div>            
                  <div class="form-group col-lg-8">
                    <label class="text-gray">Nombre</label>
                    <div class="input-group">
                      <input type="text" class="form-control font-italic font-weight-bold text-center" name="nombre" id="nombre" readonly="" required />
                    </div>
                  </div>
                  <div class="form-group col-lg-5">
                    <label class="text-gray">Stock</label>
                    <div class="input-group">
                      <input type="text" class="form-control font-italic text-center" name="stock" id="stock" required />
                    </div>                  
                  </div>
                  <button class="agregarP btn btn-primary mt-1 " type="submit" name="opcion" value="modificar"><i class="fas fa-check"></i> Actualizar Stock</button>                 
                  <input type="hidden" id="unidad" name="unidad">
                </div>         
              </div>          
            </form>
          </div>
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
  <!-- AdminLTE for demo purposes -->
  <script src="resources/dist/js/demo.js"></script>
  <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
  <script src="resources/dist/js/pages/dashboard.js"></script>
  <!-- Select2 -->
  <script src="resources/plugins/select2/js/select2.full.min.js"></script>
  <!-- js actualizar stock-->
  <script src="resources/custom/js/stock_producto.js"></script>
</body>
</html>

