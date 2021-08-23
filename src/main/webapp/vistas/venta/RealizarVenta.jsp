
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>REALIZAR VENTA</title>
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
            href="plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css"
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

        <!--Plugin Toasrl-->
        <link rel="stylesheet" href="recursos/build/css/toastr.min.css">

    </head>
    <body
        class="hold-transition sidebar-mini layout-fixed"
        onload="cargar_focus()"
        >
        <div class="wrapper">


            <!-- Main Sidebar Container -->
            <aside class="main-sidebar sidebar-dark-primary elevation-4">

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
                                <a href="#" class="nav-link">
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
                                        <a href="producto.do?menu=lista&opcion=mostrar" class="nav-link">
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
                                <a href="venta.do?opcion=default" class="nav-link active">
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

                        <div class="col-md-8 " style="position: relative;left:3%">
                            <!-- <form class="form-horizontal" action="ventaControlador.do" method="POST" id="formSeleccion" >-->
                            <div class="card-body">

                                <div class="form-group mb-2">
                                    <label class="text-gray-dark ">INGRESE CÓDIGO DEL PRODUCTO</label>
                                </div>
                                <div class="form-group d-flex mb-4">
                                    <div class="col-sm-7 d-flex">

                                        <input
                                            type="text"
                                            name="codigo"
                                            class="form-control"
                                            id="codigo"
                                            required
                                            />
                                    </div>
                                    <div class="form-group text-center">
                                        <div class="col-sm">
                                            <button
                                                type="button"
                                                name="opcion"
                                                value="seleccionar-producto"
                                                class="btn-agregar font-weight-bold btn btn-primary"
                                                id="btn_seleccionar">
                                                <i class="fas fa-check"></i> Agregar producto
                                            </button>

                                            <input type="hidden" name="id_p" id="id_p"/>
                                        </div>
                                    </div>

                                </div>

                            </div>
                            <!-- </form>-->
                        </div>

                        <div class="col-md-12 mx-lg-n1 my-10" style="position: relative;bottom: 30px">
                            <div class="card">
                                <!-- Tabla con productos seleccionads por el cliente-->
                                <div class=" text-center"  style="overflow: scroll; height: 370px; ">
                                    <table class="table table-hover" >
                                        <thead  class="text-gray"style="height: 10px">
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
                                            <c:forEach var="detalle" items="${listaProductos}">
                                                <tr  class="font-weight-bold" style="font-size: large">
                                                    <td>${detalle.getProducto().getCodigo()}</td>
                                                    <td>${detalle.getProducto().getNombre()}</td>
                                                    <td>${detalle.getProducto().getStock()}</td>
                                                    <td>$ ${detalle.getProducto().getPrecio()}</td>
                                                    <td class="font-weight-bold">${detalle.getCantidad()}<a class="btnCantidad ml-3"  onclick="${detalle.getProducto().getId()}"><i class="fas fa-edit"></i></a></td>
                                                    <td class="font-weight-bold">$ ${detalle.getImporte()}</td>
                                                    <td>
                                                        <a
                                                            href="venta.do?opcion=quitar&id=${detalle.getProducto().getId()}"
                                                            class="quitar btn btn-danger"
                                                            ><i class="fas fa-trash"></i> Quitar</a
                                                        >
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                </div>
                                <!-- /.card-body -->
                                <form action="venta.do" name="form_venta" method="POST" onsubmit="return val_venta();"> 
                                    <div class="bg-gradient-gray-dark d-flex mt-1">
                                        <div class="d-flex col-sm-0 mt-2">
                                            <div>
                                                <label class="radio text-white">
                                                    <input type="radio"  value="1" checked="" name="forma_pago" id="forma_pago" >
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
                                                <label  class="radio text-white" >
                                                    <input type="radio" value="3" name="forma_pago" id="forma_pago">
                                                    Credito
                                                    <span></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mt-3  d-flex">                                 
                                        <button type="submit" class="btn btn-primary" value="vender"  name="opcion"  onclick="asignarFocus()"><i class="fas fa-cart-plus fa-lg mr-2"></i>Generar Venta</button>
                                        <div class="ml-auto ">
                                            <h1 class="total text-bold" >$ ${total_p} </h1>
                                        </div>

                                    </div>
                                </form>            
                                <!-- /.card -->
                           </div>
                        </div>
                        <!-- /.row (main row) -->
                    </div>
                    <!-- FIN DATOS DEL PRODUCTO-->
                </section>  

                 <!-- Ventana para modificar la cantidad del producto en el carrito de compra-->
               
                <div
                    class="modal fade" tabindex="-1" id="modalModificar"
                    role="dialog"
                    >
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

                            <form id="formSeccion" method="post" action="venta.do">
                                <div class="modal-body">
                                    <div class="d-flex">
                                        <div class="form-group col-lg-6">
                                            <label>Cantidad</label>
                                            <input id="cantidad" type="text" name="cantidad"  class="form-control "  required />
                                        </div>

                                        <div class="form-group col-lg-6">
                                            <label>Stock disponible</label>
                                            <input id="stock_disponible" type="text" name="stock_disponible"  class="form-control" disabled=""  />
                                        </div>                                       
                                          <input type="hidden" name="id" id="id_producto">
                                          <input type="hidden" name="unidad_medida" id="unidad_medida">
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <button
                                        id="boton-modal2"
                                        type="submit"
                                        class="btn btn-success"
                                        data-bs-dismiss="modal"
                                        name="opcion"
                                        value="modificar"
                                        onclick="if(!comprobar()) return false"


                                        >Guardar

                                    </button>
                                    <button  class="btn btn-outline-info" type="submit"   data-dismiss="modal" >Cancelar</button>
                                   
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

 <!-- Ventana modal para establecer la cantidad requerida para el producto-->
                
                <div
                    class="modal fade" tabindex="-1" id="modalAgregar"
                    role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title"></h5>
                                <button
                                    type="button"
                                    class="btn btn-light"
                                    data-dismiss="modal"
                                    aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>



                            <form id="formSeccion" method="post" action="venta.do">
                                <div class="modal-body">

                                    <div class="d-flex">

                                        <div class="form-group col-lg-6">
                                            <label>Cantidad</label>
                                            <input id="cantidadSeleccionada" type="text" name="cantidad"  class="form-control " required />

                                        </div>

                                        <div class="form-group col-lg-6">
                                            <label>Stock</label>
                                            <input id="stock" type="text" name="stockGranel"  class="form-control " disabled />
                                        </div>
                                        <input id="formaventa" type="text" name="formaventa"  class="form-control "  />
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <button
                                        id="boton-modal2"
                                        type="submit"
                                        class="btn btn-success"
                                        data-bs-dismiss="modal"
                                        name="opcion"
                                        value="agregar"
                                        onclick="if(!comprobar()) return false"


                                        >Guardar

                                    </button>
                                    <button  class="btn btn-outline-info" type="submit"   data-dismiss="modal" >Cancelar</button>

                                    <input type="hidden" name="forma_venta" id="forma_venta">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>  
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->
        <footer class="main-footer">
            <strong>
                <a href="https://www.instagram.com/sistemas_servijav/">ServiJav</a
                >.</strong
            >

            <div class="float-right d-none d-sm-inline-block">
                <b>Version</b> 2.0
            </div>
        </footer>

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
    <!--Plugin Toasrl-->
    <script src="recursos/build/js/toastr.min.js"></script>
    <!-- Venta js-->
   <script src="recursos/build/js/venta.js" type="text/javascript"></script>
</body>
</html>
