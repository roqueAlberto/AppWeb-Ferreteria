$(function () {

    // traer producto
    $(document).on("click", ".bEditar", function () {

        var id = $(this).attr("onclick");
        $.ajax({
            url: "producto.do?menu=lista-de-productos&opcion=editar&id=" + id,
            type: "GET",
            datatype: "json",
            success: function (data) {
                $(function () {
                    $(".modal-title").text("Editar producto");

                    $("#codigo").val(data.codigo);
                    $("#descri").val(data.nombre);
                    $("#precio").val(data.precio);
                    $("#stock").val(data.stock);
                    $("#opcion").val(data.seccion);
                    $("#formaventa").val(data.forma_venta);
                    if (data.forma_venta == 2) {
                        document.getElementById("forma_pago").disabled = false;
                        document.getElementById("forma_pagoDos").disabled = false;

                        if (data.unidad == 1) {
                            document.getElementById("forma_pago").checked = true;

                        } else {
                            document.getElementById("forma_pagoDos").checked = true;
                        }

                    } else {
                        document.getElementById("forma_pago").disabled = true;
                        document.getElementById("forma_pagoDos").disabled = true;
                    }

                    $("#id_producto").val(data.id_p);
                    $("#boton-modal").text("Guardar cambios");
                    $(".modal-header").css("background-color", "#3B83BD");
                    $(".modal-header").css("color", "white");

                    $("#modal1").modal("show");
                });
            }
        });
    });

    //eliminar producto
    $(document).on("click", ".bBorrar", function () {

        var id = $(this).attr("onclick");


        var respuesta = confirm("¿Confirma eliminar el producto?");

        if (respuesta) {
            $.ajax({

                url: "producto.do?menu=lista-de-productos&opcion=eliminar&id=" + id,

                type: "GET",
                datatype: "json",
                success: function (data) {

                    location.reload();

                }
            });
        }
    });

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


function seleccionado() {

    var d = document.getElementById("formaventa");



    if (d.value == 2) {


        document.getElementById("kg").disabled = false;
        document.getElementById("mts").disabled = false;
        
        ;


    } else {
        document.getElementById("kg").disabled = true;
        document.getElementById("mts").disabled = true;
    }



}

