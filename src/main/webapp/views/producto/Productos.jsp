
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    Integer pagina = (Integer) request.getSession().getAttribute("pagina");
    Integer totalPaginas = (Integer) request.getSession().getAttribute("totalPaginas");
%>


<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>PRODUCTOS</title>
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
  <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css" />
  <!-- Daterange picker -->
  <link rel="stylesheet" href="resources/plugins/daterangepicker/daterangepicker.css" />
  <!-- summernote -->
  <link rel="stylesheet" href="resources/plugins/summernote/summernote-bs4.min.css" />

  <!-- DataTables -->
  <link rel="stylesheet" href="recursos/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css" />

  <link rel="stylesheet" href="resources/plugins/datatables-responsive/css/responsive.bootstrap4.min.css" />
  <link rel="stylesheet" href="resources/plugins/datatables-buttons/css/buttons.bootstrap4.min.css" />

  <link rel="stylesheet" href="resources/custom/css/mystyle.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">
  <div class="wrapper">
    <jsp:include page="../../resources/custom/include/sidebar.jsp" ></jsp:include>
  </div>
  <!-- /.sidebar -->
  <div class="content-wrapper">
    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <!-- Main row -->
        <div class="row">
          <div class="col-8 mt-4">
            <div class="card">
              <div class="d-flex">

                <form method="post" action="producto.do?menu=lista">
                  <div class="form-group col-lg-11 mt-4 ml-3">
                    <p class="">Código de barra</p>
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-barcode"></i></span>
                      </div>
                      <input type="text" class="text-center form-control" name="codigo" id="codigo" />
                      <button class="btn btn-outline-info ml-2" type="submit" name="opcion" value="buscar-codigo">Buscar</button>
                    </div>
                  </div>
                </form>

                <form action="producto.do?menu=lista" method="post">
                  <div class="form-group col-lg-11 ml-4 mt-4">
                    <p class="">Producto</p>
                    <div class="input-group">
                      <input type="text" class="text-center form-control" name="producto" id="producto" />
                      <button class="btn btn-outline-info ml-2" type="submit" name="opcion" value="buscar-producto">Buscar</button>
                    </div>
                  </div>
                </form>
              </div>

              <div class="card-body">
                <table class="table table-hover ">
                  <thead>
                    <tr>
                      <th>Producto</th>
                      <th>Seccion</th>
                      <th>Código</th>
                      <th>Precio</th>
                      <th>Stock</th>
                      <th>Acción</th>
                    </tr>
                  </thead>
                  <c:forEach var="producto" items="${listaProductos}">
                    <tr>
                      <td>${producto.getNombre()}</td>
                      <td>${producto.getSeccion().getNombre()}</td>
                      <td>${producto.getCodigo()}</td>
                      <td>$ ${producto.getPrecio()}</td>
                      <td>${producto.getStock()}</td>
                      <td>
                        <a class=" bEditar btn btn-primary" id="bEditar" title="Editar" onclick="${producto.getId()}"><i class="fas fa-pen"></i></a>
                        <a class="btnEliminar btn btn-danger" id="bBorrar" onclick="${producto.getId()}" title="Borrar"><i class="fas fa-trash"></i></a>
                      </td>
                    </tr>
                  </c:forEach>
                  </tbody>
                </table>
              </div>

              <div class="d-flex">
                <div clas="ml-2">
                  <form action="producto.do?menu=lista&opcion=mostrar" method="POST">
                    <input type="hidden" value="<%=pagina - 1%>" name="pagina">
                    <button <% if ((pagina - 1) < 1) { %> disabled <% }%> class="btn btn-primary"><%= pagina - 1%> <i class="fas fa-arrow-circle-left"></i></button>
                  </form>
                </div>
                <div class="ml-4">
                  <button class="btn btn-primary" type="submit"><%= pagina %></button>
                </div>

                <div class="ml-4">
                  <form action="producto.do?menu=lista&opcion=mostrar" method="post">
                    <input type="hidden" value="<%=pagina + 1%>" name="pagina">
                    <button <% if ((pagina + 1) > totalPaginas) { %> disabled <% }%> class="btn btn-primary" type="submit"><i class="fas fa-arrow-circle-right"></i> <%= pagina + 1%></button>
                  </form>
                </div>
                <h5 class="text-info mr-5 ml-auto"> ${totalProductos} productos</h5>
              </div>
            </div>       
          </div>

          <div class="card col-lg-4 mt-4">
            <form id="formProducto" method="post" action="producto.do?menu=lista">
              <div class="card-body ">
                <div class="form-group col-lg-9">
                  <label class="text-gray">Código</label>
                  <input id="codigoEditar" type="text" name="codigo" class="text-center form-control font-weight-bold" required />
                </div>
                <div class="form-group col-lg-6">
                  <label class="text-gray">Sección</label>
                  <select class="form-control" name="seccion" id="opcion">
                    <c:forEach var="seccion" items="${secciones}">
                      <option value="${seccion.getId()}">${seccion.getNombre()}</option>
                    </c:forEach>
                  </select>
                </div>
                <div class="form-group col-lg-10">
                  <label class="text-gray">Nombre</label>
                  <input id="descri" type="text" name="nombre" required class="text-center form-control font-weight-bold" />
                </div>
                <div class="d-flex">
                  <div class="form-group col-lg-7 ">
                    <div class="col-sm-10">
                      <label class="text-gray">Forma de venta :
                      </label>
                      <select class="form-control" id="formaventa" name="formaventa" onchange="seleccionado()">
                        <option value="">-- Selecciona --</option>
                        <option value="1">Unidad</option>
                        <option value="2">A granel</option>
                        <option value="3">Pack</option>
                      </select>
                    </div>
                  </div>
                  <div>
                    <label class="radio text-gray">
                      <input type="radio" value="1" checked="" name="unidades" id="kg" disabled="">
                      Kg
                    </label>
                    <label class="radio text-gray ml-3 mt-4">
                      <input type="radio" value="2" name="unidades" id="mts" disabled="">
                      m(mts.)
                    </label>
                  </div>
                </div>
                <div class="d-flex">
                  <div class="form-group col-lg-5">
                    <label class="text-gray">Stock</label>
                    <div class="input-group">
                      <input type="text" class="text-center form-control font-weight-bold" name="stock" id="stock" required />
                    </div>
                  </div>
                  <!-- Precio-->
                  <div class="form-group col-lg-5">
                    <label class="text-gray">Precio</label>

                    <div class="input-group">
                      <label>$</label><input type="text" class="text-center form-control font-weight-bold" name="precio" id="precio" required />
                    </div>                   
                  </div>
                </div>
                <input type="hidden" name="id_producto" id="id_producto">
              </div>
              <div class="card-footer pl-5">
                <button class="btn btn-outline-info" type="submit" name="opcion" value="actualizar">Guardar cambios
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>
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
  <script src="recursos/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
  <!-- ChartJS -->
  <script src="recursos/plugins/chart.js/Chart.min.js"></script>
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
  <script src="resources/custom/js/lista_productos.js"></script>

</body>
</html>
