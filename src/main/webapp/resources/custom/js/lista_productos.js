$(function () {

    $("#codigo").focus();

    $(document).on("click", ".btnEliminar", function () {

        var id = $(this).attr("onclick");
        var respuesta = confirm("¿Confirma eliminar el producto?");

        if (respuesta) {
            $.ajax({
                url: "producto.do?menu=lista&opcion=eliminar&id=" + id,
                type: "GET",
                datatype: "json",
                success: function (data) {
                    location.reload();
                }
            });
        }
    });


    // traer producto
    $(document).on("click", ".bEditar", function () {

        var id = $(this).attr("onclick");
        $.ajax({
            url: "producto.do?menu=lista&opcion=editar&id=" + id,
            type: "GET",
            datatype: "json",
            success: function (data) {


                $("#codigoEditar").val(data.codigo);
                $("#descri").val(data.nombre);
                $("#precio").val(data.precio);
                $("#stock").val(data.stock);
                $("#opcion").val(data.seccion);
                $("#formaventa").val(data.forma_venta);

                if (data.forma_venta == 2) {
                    document.getElementById("kg").disabled = false;
                    document.getElementById("mts").disabled = false;

                    if (data.unidad == 1) {
                        document.getElementById("kg").checked = true;
                        document.getElementById("mts").checked = false;

                    } else if (data.unidad == 2) {
                        document.getElementById("mts").checked = true;
                        document.getElementById("kg").checked = false;
                    }

                } else {
                    document.getElementById("kg").disabled = true;
                    document.getElementById("mts").disabled = true;
                }

                $("#id_producto").val(data.id_p);

            }
        });
    });

});

function seleccionado() {
    var opcion = document.getElementById("formaventa").value;

    if (opcion == 2) {
        document.getElementById("kg").disabled = false;
        document.getElementById("mts").disabled = false;
    } else {
        document.getElementById("kg").disabled = true;
        document.getElementById("mts").disabled = true;
    }
}
