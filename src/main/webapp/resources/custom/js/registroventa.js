
$(function () {
    $(document).on("click", ".btnEliminar", function () {

        var id = $(this).attr("onclick");

        alert(id);

        var respuesta = confirm("¿Confirma eliminar la venta realizada?");

        if (respuesta) {
            $.ajax({

                url: "ventaControlador.do?opcion=EliminarVenta&id=" + id,
                type: "GET",
                datatype: "json",
                success: function (data) {

                    location.reload();

                }
            });
        }
    });


});

