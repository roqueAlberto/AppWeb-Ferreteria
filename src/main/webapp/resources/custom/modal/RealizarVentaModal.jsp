

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Ventana modal para establecer la cantidad requerida para el producto-->          
<div class="modal fade" tabindex="-1" id="modalAgregar" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title"></h5>
        <button type="button" class="btn btn-light" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <form id="formSeccion" method="post" action="venta.do">
        <div class="modal-body">
          <div class="d-flex">
            <div class="form-group col-lg-6">
              <label>Cantidad</label>
              <input id="cantidadSeleccionada" type="text" name="cantidad" class="form-control " required />
            </div>
            <div class="form-group col-lg-6">
              <label>Stock</label>
              <input id="stock" type="text" name="stockGranel" class="form-control " disabled />
            </div>
            <input id="formaventa" type="text" name="formaventa" class="form-control " />
          </div>
        </div>
        <div class="modal-footer">
          <button id="boton-modal2" type="submit" class="btn btn-success" data-bs-dismiss="modal" name="opcion" value="agregar" onclick="if (!comprobar())
                                                    return false">Guardar
          </button>
          <button class="btn btn-outline-info" type="submit" data-dismiss="modal">Cancelar</button>
          <input type="hidden" name="forma_venta" id="forma_venta">
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Modal editar cantidad de producto en carrito-->
<div class="modal fade" tabindex="-1" id="modalModificar" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title"></h5>
        <button type="button" class="btn btn-light" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <form id="formSeccion" method="post" action="venta.do">
        <div class="modal-body">
          <div class="d-flex">
            <div class="form-group col-lg-6">
              <label>Cantidad</label>
              <input id="cantidad" type="text" name="cantidad" class="form-control " required />
            </div>

            <div class="form-group col-lg-6">
              <label>Stock disponible</label>
              <input id="stock_disponible" type="text" name="stock_disponible" class="form-control" disabled="" />
            </div>
            <input type="hidden" name="id" id="id_producto">
            <input type="hidden" name="unidad_medida" id="unidad_medida">
          </div>
        </div>
          
        <div class="modal-footer">
          <button id="boton-modal2" type="submit" class="btn btn-success" data-bs-dismiss="modal" name="opcion" value="modificar" onclick="if (!comprobar())
                                                   return false">Guardar
          </button>
          <button class="btn btn-outline-info" type="submit" data-dismiss="modal">Cancelar</button>
        </div>
      </form>
    </div>
  </div>
</div>
