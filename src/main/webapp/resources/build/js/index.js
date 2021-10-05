$(function () {

    // Boton Seleccionar [VISTA REALIZAR VENTA]
    $(document).on("click", ".btn-agregar", function () {

        const parrafo = document.getElementById("warnings");

        var codigo = $("#codigo").val();
        let warnings = "";
        let entrar = false;
        parrafo.innerHTML = "";

        $.ajax({
            url: "ventaControlador.do?opcion=Seleccionar&codigo=" + codigo,
            //url: "Servidor?menu=Venta&accion=SeleccionarProducto&codigo=" + codigo,
            type: "GET",
            datatype: "json",
            success: function (data) {

                var producto = JSON.parse(data).existenciaProducto;
                var stock = JSON.parse(data).stock;
                var formaVenta = JSON.parse(data).formaventa;
                var stock_valor = JSON.parse(data).valor_stock;
                var cantidadInicial = JSON.parse(data).valorGranel;

                alert(producto);


                /* if (producto) { // Si el producto existe
                 
                 switch (formaVenta) {
                 case 2 :      //En caso de que el producto se vende a granel..
                 $(function () {
                 $("#stockGranel").val(stock_valor);
                 $("#cantidad_establecida").val(cantidadInicial);
                 $("#forma_venta").val(formaVenta);
                 $("#modal3").modal("show");
                 });
                 break;
                 
                 default:   //En caso de que el producto se vende de forma distinta de a granel...
                 location.href = "ventaControlador.do?opcion=EstablecerCantidad&cantidad_establecida=1";
                 
                 
                 }
                 } else { // Si el producto NO existe...
                 // location.href = "ventaControlador.do?opcion=default";
                 //location.reload();
                 //
                 alert("hola");
                 //location.href = "Servidor?menu=Venta&accion=default";
                 }*/




                /*  if (num == 1) {
                 
                 if (stock) {
                 
                 warnings += `STOCK superado del producto`;
                 entrar = true;
                 
                 } else {
                 location.href = "Servidor?menu=Venta&accion=default";
                 }
                 
                 } else {
                 warnings += `No existe el producto`;
                 entrar = true;
                 }
                 
                 
                 
                 if (entrar) {
                 parrafo.innerHTML = warnings;
                 $("#codigo").focus();
                 
                 
                 }*/
            }

        });

    });


    //Boton Cantidad - [VISTA REALIZAR VENTA]
    $(document).on("click", ".btnCantidad", function () {

        var id_producto = $(this).attr("onclick");



        $.ajax({
            url: "ventaControlador.do?opcion=CantidadDelProducto&id=" + id_producto,
            type: "GET",
            datatype: "json",
            success: function (data) {
                $("#cantidad").focus();

                $(function () {
                    $("#formSeccion").trigger("reset");
                    $("#id_producto").val(id_producto);
                    $("#cantidad").val(data.cantidad);

                    $("#modal2").modal("show");
                });

            }


        });


    });

    // Boton Editar [VISTA EDICION PRODUCTO]

    $(document).on("click", ".bEditar", function () {

        var id = $(this).attr("onclick");
        $.ajax({
            url: "producto.do?menu=ListaProductos&opcion=Editar&id=" + id,
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
                        document.getElementById("forma_pago").disabled = true;
                        document.getElementById("forma_pagoDos").disabled = true;
                    }
                    $("#unidad").val(data.unidad);
                    $("#id_producto").val(data.id_p);
                    $("#boton-modal").text("Guardar cambios");
                    $(".modal-header").css("background-color", "#3B83BD");
                    $(".modal-header").css("color", "white");

                    $("#modal1").modal("show");
                });
            }
        });
    });

//ELIMINAR PRODUCTO  [VISTA EDICION PRODUCTO]
    $(document).on("click", ".bBorrar", function () {

        var id = $(this).attr("onclick");


        var respuesta = confirm("¿Confirma eliminar el producto?");

        if (respuesta) {
            $.ajax({

                url: "producto.do?menu=ListaProductos&opcion=Eliminar&id=" + id,

                type: "GET",
                datatype: "json",
                success: function (data) {

                    location.reload();

                }
            });
        }
    });



});

function val_venta() {

    var form_v = document.form_venta;
    var codigo = document.getElementById("codigo");

    if (form_v.fpago.value == 0) {
        alert("Debe seleccionar una forma de pago");
        event.preventDefault();
        return false;
    }

    codigo.focus();

}

function cargar_focus() {
    var cod = document.getElementById("codigo");
    cod.focus();
}

function seleccionado() {

    var d = document.getElementById("formaventa");

    // var display = d.options[d.selectedIndex].text;

    $("#stock_new").val("");

    if (d.value == 2) {

        $("#stock_new").val('0.000');
    }



}
