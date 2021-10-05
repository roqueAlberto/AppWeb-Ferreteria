
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String resultado = (String) request.getSession().getAttribute("mensaje"); %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>REALIZAR VENTA</title>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="resources/plugins/fontawesome-free/css/all.min.css" />
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css" />
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
  <!--Plugin Toasrl-->
  <link rel="stylesheet" href="resources/custom/css/toastr.min.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed" onload="cargar_focus()">
  <div class="wrapper">
      <jsp:include page="../../resources/custom/include/sidebar.jsp" ></jsp:include>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
      <!-- Main content -->
      <section class="content">
        <!-- Main row -->
        <div class="row">
          <div class="col-md-8 " style="position: relative;left:3%">
            <!-- <form class="form-horizontal" action="ventaControlador.do" method="POST" id="formSeleccion" >-->
            <div class="card-body">
              <div class="form-group mb-2">
                <label class="text-gray-dark ">INGRESE CÓDIGO DEL PRODUCTO</label>
              </div>
              <div class="form-group d-flex mb-4">
                <div class="col-sm-7 d-flex">
                  <input type="text" name="codigo" class="form-control" id="codigo" required />
                </div>
                <div class="form-group text-center">
                  <div class="col-sm">
                    <button type="button" name="opcion" value="seleccionar-producto" class="btn-agregar font-weight-bold btn btn-primary" id="btn_seleccionar">
                      <i class="fas fa-check"></i> Agregar producto
                    </button>
                    <input type="hidden" name="id_p" id="id_p" />
                  </div>
                </div>
              </div>
            </div>
          </div>

          <% if (resultado != null) {%>
          <div class="alert alert-success alert-dismissible" style="position: relative;left:80px;">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <%=resultado%>
          </div>
          <% request.getSession().removeAttribute("mensaje"); %>
          <%  }%>

          <div class="col-md-12 mx-lg-n1 my-10" style="position: relative;bottom: 30px">
            <div class="card">
              <!-- Tabla con productos seleccionads por el cliente-->
              <div class=" text-center" style="overflow: scroll; height: 370px; ">
                <table class="table table-hover">
                  <thead class="text-gray" style="height: 10px">
                    <tr>
                      <th>CÓDIGO</th>
                      <th>PRODUCTO</th>
                      <th>STOCK</th>
                      <th>PRECIO</th>
                      <th>CANTIDAD</th>
                      <th>IMPORTE</th>
                      <th>ACCION</th>
                    </tr>
                  </thead>

                  <tbody>
                    <c:forEach var="producto" items="${listaProductos}">
                      <tr class="font-weight-bold" style="font-size: large">
                        <td>${producto.getCodigo()}</td>
                        <td>${producto.getNombre()}</td>
                        <td>${producto.getStock()}</td>
                        <td>$ ${producto.getPrecio()}</td>
                        <td class="font-weight-bold">${producto.getCantidad()}<a class="btnCantidad ml-3" onclick="${producto.getId()}"><i class="fas fa-pen"></i></a></td>
                        <td class="font-weight-bold">$ ${producto.getImporte()}</td>
                        <td>
                          <a href="venta.do?opcion=quitar&id=${producto.getId()}" class="quitar" style="color:red"><i class="fas fa-trash"></i></a>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
              
              <form action="venta.do" name="form_venta" method="POST" onsubmit="return val_venta();">
                <div class="bg-gradient-gray-dark d-flex mt-1">
                  <div class="d-flex col-sm-0 mt-2">
                    <div>
                      <label class="radio text-white">
                        <input type="radio" value="1" checked="" name="forma_pago" id="forma_pago">
                        Efectivo
                        <span></span>
                      </label>
                    </div>
                    <div class="px-4">
                      <label class="radio text-white">
                        <input type="radio" value="2" name="forma_pago" id="forma_pago">
                        Debito
                        <span></span>

                      </label>
                    </div>

                    <div>
                      <label class="radio text-white">
                        <input type="radio" value="3" name="forma_pago" id="forma_pago">
                        Credito
                        <span></span>
                      </label>
                    </div>
                  </div>
                </div>
                <div class="mt-3  d-flex">
                  <button type="submit" class="btn btn-primary" value="vender" name="opcion" onclick="asignarFocus()"><i class="fas fa-cart-plus fa-lg mr-2"></i>Generar Venta</button>
                  <div class="ml-auto ">
                    <h1 class="total text-bold">$ ${total_p} </h1>
                  </div>
                </div>
              </form>        
            </div>
          </div>      
        </div> 
      </section>
                    <jsp:include page="../../resources/custom/modal/RealizarVentaModal.jsp"></jsp:include> 
    </div>
    <!-- /.content -->
  </div>


  
  <aside class="control-sidebar control-sidebar-dark"></aside>

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
  <!--Plugin Toasrl-->
  <script src="resources/build/js/toastr.min.js"></script>
  <!-- Venta js-->
  <script src="resources/custom/js/venta.js" type="text/javascript"></script>
</body>

</html>
