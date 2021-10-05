<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
      <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
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