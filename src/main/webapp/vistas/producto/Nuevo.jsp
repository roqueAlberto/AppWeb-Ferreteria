<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>NUEVO</title>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="recursos/plugins/fontawesome-free/css/all.min.css" />
        <!-- Ionicons -->
        <link
            rel="stylesheet"
            href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"
            />
        <!-- Tempusdominus Bootstrap 4 -->
        <link
            rel="stylesheet"
            href="recursos/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css"
            />
        <!-- iCheck -->
        <link
            rel="stylesheet"
            href="recursos/plugins/icheck-bootstrap/icheck-bootstrap.min.css"
            />
        <!-- JQVMap -->
        <link rel="stylesheet" href="recursos/plugins/jqvmap/jqvmap.min.css" />
        <!-- Theme style -->
        <link rel="stylesheet" href="recursos/dist/css/adminlte.min.css" />
        <!-- overlayScrollbars -->
        <link
            rel="stylesheet"
            href="recursos/plugins/overlayScrollbars/css/OverlayScrollbars.min.css"
            />
        <!-- Daterange picker -->
        <link rel="stylesheet" href="recursos/plugins/daterangepicker/daterangepicker.css" />
        <!-- summernote -->
        <link rel="stylesheet" href="recursos/plugins/summernote/summernote-bs4.min.css" />

        <!-- Select2 -->
        <link rel="stylesheet" href="recursos/plugins/select2/css/select2.min.css" />
        <link
            rel="stylesheet"
            href="recursos/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css"
            />

        <link rel="stylesheet" href="recursos/build/css/mystyle.css">

        <!--Plugin Toasrl-->
        <link rel="stylesheet" href="recursos/build/css/toastr.min.css">
    </head>
    <body class="hold-transition sidebar-mini layout-fixed fondo-nuevo">
        <div class="wrapper">
            <!-- Main Sidebar Container -->
            <aside class="main-sidebar sidebar-dark-primary elevation-4">
                <!-- Brand Logo -->
                <a href="#" class="brand-link text-center">
                    <span class="brand-text font-weight-bold">CASA TRACHTA S.R.L</span>
                </a> 
                <!-- Sidebar -->
                <div class="sidebar">
                    <!-- Sidebar Menu -->
                    <nav class="mt-2">
                        <ul
                            class="nav nav-pills nav-sidebar flex-column"
                            data-widget="treeview"
                            role="menu"
                            data-accordion="false"
                            >
                            <li class="nav-header">Principal</li>
                            <li class="nav-item">
                                <a href="informe.do?opcion=inicio" class="nav-link">
                                    <i class="nav-icon fas fa-chart-bar"></i>

                                    <p>Informes</p>
                                </a>
                            </li>

                            <li class="nav-header">Gestionar</li>

                            <li class="nav-item">
                                <a href="#" class="nav-link active">
                                    <i class="nav-icon fas fa-tools"></i>

                                    <p>
                                        Productos
                                        <i class="fas fa-angle-left right"></i>
                                    </p>
                                </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item">
                                        <a href="producto.do?menu=nuevo&opcion=default" class="nav-link active">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Nuevo</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="producto.do?menu=lista-de-productos&opcion=default"opcion=Listar" class="nav-link ">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Lista de productos</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="producto.do?menu=actualizar-stock&opcion=default" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Actualizar Stock</p>
                                        </a>
                                    </li>
                                </ul>
                            </li>

                            <li class="nav-item">
                                <a href="ventaControlador.do?opcion=default" class="nav-link">
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
                    <!-- Main row -->
                    <div class="row">
                        <div class="col-md-7 mt-4">
                            <form id="form" method="POST" name="form">
                                <div
                                    class="card card-primary"
                                    style="position: relative; left: 30% ;top: 0%"
                                    >
                                    <div class="card-header ">
                                        <h3 class="card-title font-weight-bold text-center">Agregar producto</h3>

                                    </div>

                                    <div class="card-body">
                                        <div class="form-group col-lg-7">
                                            <label class="text-gray">Código</label>

                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text"
                                                          ><i class="fas fa-barcode"></i
                                                        ></span>
                                                </div>
                                                <input
                                                    type="text"
                                                    class="text-center form-control"
                                                    name="codigo"
                                                    id="codigo"                                                
                                                    />
                                            </div>
                                        </div>
                                        <div class="form-group col-lg-6">
                                            <label class="text-gray">Seccion</label>
                                            <select class="form-control"name="seccion" id="seccion">
                                                <c:forEach var="sec" items="${listar_seccion}">
                                                    <option  value="${sec.getId_seccion()}" >${sec.getNombre()}</option>
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
                                                    <label class="text-gray" 
                                                           >Forma de venta 
                                                    </label>

                                                    <select
                                                        class="form-control"
                                                        id="forma_venta"
                                                        name="forma_venta"
                                                        onchange="seleccionado()"
                                                        >
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
                                                    <input type="radio"  value="1" checked="" id="kg" name="uni_medida" id="unidadKg" disabled="" >
                                                    Kg
                                                    <span></span>
                                                </label>

                                                <label class="radio text-gray ml-3 mt-4">
                                                    <input type="radio" value="2" name="uni_medida" id="mts" disabled="" >
                                                    m(mts.)
                                                    <span></span>
                                                </label>
                                            </div>

                                        </div>
                                        
                                        <div class="d-flex">
                                           <div class="form-group col-lg-5">
                                                <label class="text-gray">Stock</label>
                                                <div class="input-group">
                                                    <input type="text" class="text-center form-control" name="stock" id="stock"  />
                                                </div>
                                            </div>

                                            <!-- Precio-->
                                            <div class="form-group col-lg-5 ml-4">
                                                <label class="text-gray">Precio</label>
                                                <div class="input-group">
                                                    <i class="fas fa-dollar-sign fa-2x "></i><input type="text" class="ml-4 text-center form-control"  name="precio" id="precio"  />
                                                </div>
                                                <!-- /.input group -->
                                            </div>
                                        </div>
                                        <button class="agregarP btn btn-primary font-weight-bold"  id="btnAgregar" type="button" name="opcion" value="agregar"><i class="fas fa-save"></i> Guardar</button>
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

                        <!--====================Agregar una nueva SECCION=====================-->
                        <div class="container">
                            <div
                                class="modal fade" tabindex="-1" id="modal2"
                                role="dialog"

                                >
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title"></h5>
                                            <button
                                                type="button"
                                                class="btn btn-dark"
                                                data-dismiss="modal"
                                                aria-label="Close"
                                                >
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <form id="formSeccion" method="post" action="producto.do?menu=nuevo">
                                            <div class="modal-body">

                                                <div class="form-group col-lg-6">
                                                    <label>Nombre para la Seccion</label>
                                                    <input id="seccion" type="text" name="seccion"  class="form-control " required />
                                                </div>
                                            </div>

                                            <div class="modal-footer">
                                                <button
                                                    id="boton-modal2"
                                                    type="submit"
                                                    class="btn bg-dark"
                                                    data-bs-dismiss="modal"
                                                    name="opcion"
                                                    value="agregar-seccion"
                                                    >Agregar seccion
                                                </button>
                                                <button  class="btn btn-outline-info" type="submit"   data-dismiss="modal" >Cerrar</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.row (main row) -->
                </section>
                <!-- /.content -->
            </div>
            <!-- /.content-wrapper -->
            <!-- Control Sidebar -->
            <aside class="control-sidebar control-sidebar-dark">
                <!-- Control sidebar content goes here -->
            </aside>
            <!-- /.control-sidebar -->
        </div>
        <!-- ./wrapper -->

        <!-- jQuery -->
        <script src="recursos/plugins/jquery/jquery.min.js"></script>
        <!-- jQuery UI 1.11.4 -->
        <script src="recursos/plugins/jquery-ui/jquery-ui.min.js"></script>
        <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
        <script>
                                                            $.widget.bridge("uibutton", $.ui.button);
        </script>
        <!-- Bootstrap 4 -->
        <script src="recursos/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- ChartJS -->
        <script src="recursos/plugins/chart.js/Chart.min.js"></script>
        <!-- Sparkline -->
        <script src="recursos/plugins/sparklines/sparkline.js"></script>
        <!-- JQVMap -->
        <script src="recursos/plugins/jqvmap/jquery.vmap.min.js"></script>
        <script src="recursos/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
        <!-- jQuery Knob Chart -->
        <script src="recursos/plugins/jquery-knob/jquery.knob.min.js"></script>
        <!-- daterangepicker -->
        <script src="recursos/plugins/moment/moment.min.js"></script>
        <script src="recursos/plugins/daterangepicker/daterangepicker.js"></script>
        <!-- Tempusdominus Bootstrap 4 -->
        <script src="recursos/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
        <!-- Summernote -->
        <script src="recursos/plugins/summernote/summernote-bs4.min.js"></script>

        <!-- AdminLTE App -->
        <script src="recursos/dist/js/adminlte.js"></script>
        <!-- AdminLTE for demo purposes -->
        <!--  <script src="recursos/dist/js/demo.js"></script>-->
        <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
        <script src="recursos/dist/js/pages/dashboard.js"></script>
        <!--Plugin Toasrl-->
        <script src="recursos/build/js/toastr.min.js"></script>
        <!-- Select2 -->
        <script src="recursos/plugins/select2/js/select2.full.min.js"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"
            integrity="sha256-t9UJPrESBeG2ojKTIcFLPGF7nHi2vEc7f5A2KpH/UBU="
            crossorigin="anonymous"
        ></script>
        <script
            src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"
            integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU"
            crossorigin="anonymous"
        ></script>
        <!-- js nuevo-->
        <script src="recursos/build/js/nuevo.js"></script>       
    </body>
</html>

