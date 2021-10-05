
<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <!--====================Agregar una nueva SECCION=====================-->
<div class="container">
  <div class="modal fade" tabindex="-1" id="modal2" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title"></h5>
          <button type="button" class="btn btn-dark" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <form id="formSeccion" method="post" action="producto.do?menu=nuevo">
          <div class="modal-body">
            <div class="form-group col-lg-6">
              <label>Nombre para la Seccion</label>
              <input id="seccion" type="text" name="seccion" class="form-control " required />
            </div>
          </div>

          <div class="modal-footer">
            <button id="boton-modal2" type="submit" class="btn bg-dark" data-bs-dismiss="modal" name="opcion" value="agregar-seccion">Agregar seccion
            </button>
            <button class="btn btn-outline-info" type="submit" data-dismiss="modal">Cerrar</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>