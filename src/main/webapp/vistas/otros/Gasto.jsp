<%-- 
    Document   : Gasto
    Created on : 01/02/2021, 01:40:34
    Author     : Roque
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <title>GASTOS</title>


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
        <link rel="stylesheet" href="recursos/build/css/mystyle.css">
    </head>
    <body class="hold-transition sidebar-mini layout-fixed" onload="asignarFocus()" >
        <div class="wrapper">

            <!-- Main Sidebar Container -->
            <aside class="main-sidebar sidebar-dark-primary elevation-4">

                <!-- Brand Logo -->
                <a href="#" class="brand-link text-center">          
                    <span class="brand-text font-weight-bold">CASA TRACHTA S.R.L</span>
                </a> 

                <!-- Sidebar Menu -->
                <div class="sidebar">
                    <nav class="mt-2">
                        <ul
                            class="nav nav-pills nav-sidebar flex-column"
                            data-widget="treeview"
                            role="menu"
                            data-accordion="false"
                            >
                            <li class="nav-header">Principal</li>
                            <li class="nav-item">
                                <a href="informe.do?opcion=inicio" class="nav-link ">
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
                                        <a href="producto.do?menu=lista-de-productos&opcion=default" class="nav-link ">
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
                                <a href="gasto.do?opcion=consumos" class="nav-link active">
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

                            <br>
                            <br>
                            <br>
                            <li class="nav-item">
                                <a class="nav-link" href="#" id="btn-guardarDB">
                                    <i class="nav-icon fas fa-shield-alt"></i>
                                    <p class="font-weight-bold">Copia de seguridad</p>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </aside>  
            <!-- /.sidebar-menu -->

            <!-- /.sidebar -->


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
                                                <input type="text" name="descripcion"
                                                       id ="desc_gasto" class="form-control" required />
                                            </div>
                                            <!-- /.input group -->
                                        </div>
                                        <!-- /.form group -->

                                        <div class="form-group">
                                            <label>Monto</label>

                                            <div class="input-group">
                                                <input
                                                    type="text"
                                                    name="monto"
                                                    class="form-control"                                           
                                                    required
                                                    />
                                            </div>
                                            <!-- /.input group -->
                                        </div>
                                        <!-- /.form group -->

                                        <button class="btn btn-success" type="submit"  name="opcion"
                                                value="GuardarGasto">
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
                                <button
                                    type="submit"
                                    class="btn btn-danger"
                                    name="opcion"
                                    value="Buscar"

                                    >
                                    <i class="zmdi zmdi-search-in-page"></i> Buscar
                                </button> 


                            </form> 
                            <br>

                            <p class="lead">${fecha_a}</p>

                            <div class="table-responsive">
                                <table class="table">

                                    <c:forEach  var="lista_gasto" items="${gastos}"> 
                                        <tr>
                                            <th style="width: 50%" >${lista_gasto.getDescripcion()}</th>
                                            <td>$ ${lista_gasto.getMonto()}</td>


                                        </tr>


                                    </c:forEach>  
                                    <tr>
                                        <th style="color: #003e80">TOTAL</th>
                                        <td class="font-weight-bold"style="color: #003e80">$${total}</td>
                                    </tr>


                                </table>
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
        <script src="recursos/dist/js/demo.js"></script>
        <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
        <script src="recursos/dist/js/pages/dashboard.js"></script>
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
