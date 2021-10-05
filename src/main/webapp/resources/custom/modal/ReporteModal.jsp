
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--Ventana modal lista de productos con poco stock-->
<div class="container">
  <div class="modal" tabindex="-1" id="ventana-modal" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Modal title</h5>
        </div>
        <div class="modal-body">
          <div class="contenedor" style="overflow: scroll; height: 300px; ">
            <table class="table table-hover">
              <thead>
                <tr>
                  <th>Producto</th>
                  <th>Stock</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="lista" items="${listaCompleta}">
                  <tr>
                    <c:if test="${lista.getStockOriginal()=='0'}">
                      <td>${lista.getNombre()}</td>
                      <td>Sin stock</td>
                    </c:if>

                    <c:if test="${lista.getStockOriginal() != '0'}">
                      <td>${lista.getNombre()}</td>
                      <td>${lista.getStockOriginal()}</td>
                    </c:if>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
          <br><br>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-outline-info" data-dismiss="modal">
            Cerrar
          </button>
        </div>
      </div>
    </div>
  </div>
</div>