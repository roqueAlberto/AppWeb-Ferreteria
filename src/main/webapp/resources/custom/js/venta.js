$(function () {
    $("#codigo").focus();
    var input = document.getElementById("codigo");
    input.addEventListener("keyup", function (event) {

        var codigo = $("#codigo").val();      
        if (event.keyCode === 13) {
            cargarProducto(codigo);
        }
    });


    $(document).on("click", ".btn-agregar", function () {
        var codigo = $("#codigo").val();
        cargarProducto(codigo);
    });


    //Boton Cantidad
    $(document).on("click", ".btnCantidad", function () {
        var id_producto = $(this).attr("onclick");
        $.ajax({
            url: "venta.do?opcion=leer&id=" + id_producto,
            type: "GET",
            datatype: "json",
            success: function (data) {
                $("#cantidad").focus();
                $(function () {
                    $("#formSeccion").trigger("reset");
                    $("#id_producto").val(id_producto);
                    $("#unidad_medida").val(data.unidad_medida);
                    $("#cantidad").val(data.cantidad);
                    $("#stock_disponible").val(data.stock_disponible);
                    $("#modalModificar").modal("show");
                });
                $("#cantidad").focus();
            }
        });
    });


    // Backup de base de datos
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

function cargarProducto(codigo) {

    $.ajax({
        url: "venta.do?opcion=buscar&codigo=" + codigo,
        type: "POST",
        datatype: "json",
        success: function (data) {


            var producto = JSON.parse(data).producto;
            var forma_venta = JSON.parse(data).forma_de_venta;
            var stock = JSON.parse(data).stock;


            if (producto) {
                switch (forma_venta) {
                    case 2 :      //En caso de que el producto se vende a granel..
                        $(function () {
                            $("#stock").val(stock);
                            $("#formaventa").val(forma_venta);
                            $("#modalAgregar").modal("show");
                        });
                        break;
                    default:   //En caso de que el producto se venda de forma distinta...
                        location.href = "venta.do?opcion=agregar&cantidad=1";

                }
            } else {

                location.href = "venta.do?opcion=default";
            }



        }


    });

}

function cargar_focus() {
    var cod = document.getElementById("codigo");
    cod.focus();
}


function comprobar() {

    var stock = $("#stock").val();
    var cantidad = $("#cantidadSeleccionada").val();



    if (parseFloat(cantidad) > parseFloat(stock)) {

        alert("La cantidad elegida supera el stock");

        return false;

    } else {
        return true;
    }


}

