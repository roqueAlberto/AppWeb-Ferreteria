
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>ACTUALIZAR STOCK</title>     
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
    </head>
    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">          
            <!-- Main Sidebar Container -->
            <aside class="main-sidebar sidebar-dark-primary elevation-4">
                <!-- Sidebar -->            
                    <!-- Brand Logo -->
                    <a href="#" class="brand-link text-center">
                        <span class="brand-text font-weight-bold">CASA TRACHTA S.R.L</span>                       
                    </a> 
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
                                        <a href="producto.do?menu=nuevo&opcion=default" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Nuevo</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="producto.do?menu=lista-de-productos&opcion=default" class="nav-link ">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Lista de productos</p>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="producto.do?menu=actualizar-stock&opcion=default" class="nav-link active">
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
                <!-- /.sidebar -->
            </aside>
            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <!-- Main content -->
                <section class="content">
                    <!-- Main row -->
                    <div class="row">
                        <div class="col-md-6 mt-5">
                            <form action="producto.do?menu=actualizar-stock" method="POST">  
                                <div
                                    class="card card-primary"
                                    style="position: relative; left: 50% ;top: 0%"
                                    >
                                    <div class="card-header">
                                        <h3 class="card-title font-weight-bold">Producto</h3>
                                    </div>
                                    <div class="card-body">
                                        <div class="form-group col-lg-8">
                                            <label class="text-gray">Código</label>
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text"
                                                          ><i class="fas fa-barcode"></i
                                                        ></span>
                                                </div>
                                                <input
                                                    type="text"
                                                    class="form-control font-italic"
                                                    name="codigo"
                                                    id="codigo"
                                                    />
                                            </div>
                                            <!-- /.input group -->
                                        </div>
                                        <!-- /.form group -->
                                        <div class="form-group col-lg-8">
                                            <label class="text-gray">Nombre</label>

                                            <div class="input-group">
                                                <input type="text" class="form-control font-italic font-weight-bold text-center" name="nombre" id="nombre" readonly="" required/>
                                            </div>
                                        </div>
                                        <div class="form-group col-lg-5">
                                            <label class="text-gray">Stock</label>
                                            <div class="input-group">
                                                <input type="text" class="form-control font-italic text-center"  name="stock" id="stock" required />
                                            </div>
                                            <!-- /.input group -->
                                        </div>
                                        <button class="agregarP btn btn-primary mt-1 " type="submit" name="opcion" value="modificar"><i class="fas fa-check"></i> Actualizar Stock</button>
                                        <!-- /.form group -->
                                      <!-- Informacion de la unidad-->                                  
                                      <input type="hidden" id="unidad" name="unidad">
                                    </div>
                                    <!-- /.card-body -->
                                </div>
                                <!-- /.card -->
                            </form>    
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
        <script src="recursos/dist/js/demo.js"></script>
        <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
        <script src="recursos/dist/js/pages/dashboard.js"></script>
        <!-- Select2 -->
        <script src="recursos/plugins/select2/js/select2.full.min.js"></script>
        <!-- js actualizar stock-->
        <script src="recursos/build/js/stock_producto.js"></script>
    </body>
</html>

