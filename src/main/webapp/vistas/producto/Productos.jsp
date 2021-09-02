
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>PRODUCTOS</title>
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
            href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css"
            />
        <!-- Daterange picker -->
        <link rel="stylesheet" href="recursos/plugins/daterangepicker/daterangepicker.css" />
        <!-- summernote -->
        <link rel="stylesheet" href="recursos/plugins/summernote/summernote-bs4.min.css" />

        <!-- DataTables -->
        <link
            rel="stylesheet"
            href="recursos/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css"
            />

        <link
            rel="stylesheet"
            href="recursos/plugins/datatables-responsive/css/responsive.bootstrap4.min.css"
            />
        <link
            rel="stylesheet"
            href="recursos/plugins/datatables-buttons/css/buttons.bootstrap4.min.css"
            />

        <link rel="stylesheet" href="recursos/build/css/mystyle.css">
    </head>
    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper">

            <!-- Main Sidebar Container -->
            <aside class="main-sidebar sidebar-dark-primary elevation-4">

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
                            <a href="#" class="nav-link active ">
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
                                <li class="nav-item ">
                                    <a href="producto.do?menu=lista&opcion=mostrar&pagina=1"opcion=Listar" class="nav-link active">
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
            </aside>
        </div>
        <!-- /.sidebar -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <!-- Main row -->
                    <div class="row">
                        <div class="col-12 mt-4">
                            <div class="card">                                             
                               <div class="d-flex">
                                   
                                   <form method = "post" action="producto.do?menu=lista">
                                        <div class="form-group col-lg-11 mt-4 ml-3">
                                            <p class="">Código de barra</p>
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text"
                                                          ><i class="fas fa-barcode"></i
                                                        ></span>
                                                </div>
                                                <input type="text" class="text-center form-control" name="codigo" id="codigo"/>
                                                 <button class="btn btn-outline-info ml-2" type="submit" name="opcion" value="buscar-codigo">Buscar</button>
                                            </div>
                                        </div>
                                       
                                    </form>
                                    
                                    
                                   <form action="producto.do?menu=lista" method="post">
                                        <div class="form-group col-lg-11 ml-4 mt-4">
                                            <p class="">Producto</p>
                                            <div class="input-group">
                                                
                                                <input type="text" class="text-center form-control" name="producto" id="producto"/>
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
                                                    <a class=" bEditar btn btn-primary" id="bEditar"  title="Editar" onclick="${producto.getId()}" ><i class="fas fa-pen"></i></a>
                                                    <a class="bBorrar btn btn-danger" id="bBorrar" onclick="${producto.getId()}" title="Borrar" ><i class="fas fa-trash"></i></a> 
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- /.card-body -->
                            </div>
                            <!-- /.card -->
                        </div>
                    </div>
                </div>
            </section>
            <div class="d-flex">
                <a class="ml-3" href='producto.do?menu=lista&opcion=mostrar&pagina=${pagina - 1}'><i class="fas fa-arrow-circle-left"></i> Anterior</a>
                <a class="ml-3" href='producto.do?menu=lista&opcion=mostrar&pagina=${pagina + 1}'>Siguiente <i class="fas fa-arrow-circle-right"></i></a>  
                <h5 class="text-info mr-5 ml-auto"> ${totalProductos} productos</h5> 
            </div>


            <!--Ventana que muestra los datos del producto seleccionado-->
            <div class="container">
                <div
                    class="modal fade" tabindex="-1" id="modal1"
                    role="dialog" >
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title"></h5>
                                <button
                                    type="button"
                                    class="btn btn-light"
                                    data-dismiss="modal"
                                    aria-label="Close"
                                    >
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form id="formProducto" method="post" action="producto.do?menu=lista-de-productos"  >
                                <div class="modal-body">
                                    <div class="form-group col-lg-6">
                                        <label class="text-gray">Código</label>
                                        <input id="codigo" type="text" name="codigo" class="text-center form-control font-italic " required />
                                    </div>
                                    <div class="form-group col-lg-6">
                                        <label class="text-gray">Sección</label>
                                        <select class="form-control font-italic" name="seccion" id="opcion">
                                            <c:forEach var="listarSeccion" items="${lista_seccion}">
                                                <option value="${listarSeccion.getId_seccion()}" >${listarSeccion.getNombre()}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group col-lg-8">
                                        <label class="text-gray">Nombre</label>
                                        <input
                                            id="descri"
                                            type="text"
                                            name="nombre"
                                            required

                                            class="text-center form-control font-italic"
                                            />
                                    </div>
                                    <div class="d-flex">
                                        <div class="form-group col-lg-5 ">
                                            <div class="col-sm-10">
                                                <label class="text-gray"
                                                       >Forma de venta : 
                                                </label>
                                                <select
                                                    class="form-control font-italic"
                                                    id="formaventa"
                                                    name="formaventa"
                                                    onchange="seleccionado()"
                                                    >
                                                    <option value="">-- Selecciona --</option>
                                                    <option value="1">Unidad</option>
                                                    <option value="2">A granel</option>
                                                    <option value="3">Pack</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div>
                                            <label class="radio text-gray">
                                                <input type="radio"  value="1" checked="" name="unidades" id="kg" disabled="" >
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
                                                <input type="text" class="text-center form-control font-italic" name="stock" id="stock" required />
                                            </div>
                                        </div> 
                                        <!-- Precio-->
                                        <div class="form-group col-lg-5">
                                            <label class="text-gray">Precio</label>

                                            <div class="input-group">
                                                <h2>$</h2><input type="text" class="text-center form-control font-italic"  name="precio" id="precio" required />
                                            </div>
                                            <!-- /.input group -->
                                        </div>
                                    </div>
                                    <input type="hidden" name="id_producto" id="id_producto">
                                </div>
                                <div class="modal-footer">
                                    <button  id="boton-modal" class="btn btn-outline-info" type="submit" name="opcion" value="actualizar" data-bs-dismiss="modal" >
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!----FIN MODAL-->
        </div>
        <!-- /.content -->

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
    <script src="recursos/build/js/lista_productos.js"></script>
    <script>
                                                        $(function () {
                                                            
                                                              $("#codigo").focus();
                                                            
                                                                                                            
                                                        });

    </script> 
</body>
</html>
