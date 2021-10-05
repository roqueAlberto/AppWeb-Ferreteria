$(function () {

    $("#codigo").focus();

    var input = document.getElementById("codigo");

    input.addEventListener("keyup", function (event) {
        var codigo = $("#codigo").val();
        var precio = $("#precio").val();
        var stock = $("#stock").val();
        var seccion = $("#seccion").val();
        var descripcion = $("#descripcion").val();
        var forma_venta = $("#forma_venta").val();

        var seleccionado;

        var mts = document.getElementById('mts').checked;
        var mts_disable = document.getElementById('mts').disabled;

        var kg = document.getElementById('kg').disabled;

        if (mts && !mts_disable) {

            seleccionado = 2;
        } else if (!kg) {

            seleccionado = 1;
        } else {

            seleccionado = 3;
        }

        // tecla '13' = 'Enter'
        if (event.keyCode === 13) {
            $.ajax({
                url: "producto.do?menu=nuevo&opcion=agregar",
                type: "GET",
                data: {uni_medida: seleccion, codigo: codigo, precio: precio,
                    stock: stock, descripcion: descripcion, seccion: seccion, forma_venta: forma_venta},
                datatype: "json",
                success: function (data) {

                    var add = JSON.parse(data).agregado;



                    if (add) {
                        toastr["success"]("Producto agregado con exito", "Exito");
                        $("#codigo").val("");
                        $("#precio").val("");
                        $("#stock").val("");

                        $("#descripcion").val("");


                        $("#codigo").focus();

                    } else {
                        toastr["error"]("No se pudo agregar el producto, verifique los datos", "Denegado");
                        $("#codigo").focus();
                    }


                }


            });
        }
    });



    $("#btnAgregar").click(function () {

        var codigo = $("#codigo").val();
        var precio = $("#precio").val();
        var stock = $("#stock").val();
        var seccion = $("#seccion").val();
        var descripcion = $("#descripcion").val();
        var forma_venta = $("#forma_venta").val(); // unidad-a granel-pack

        var opcionElegida = 0;

        var mts = document.getElementById('mts').checked;
        var mts_disabled = document.getElementById('mts').disabled;

        var kg = document.getElementById('kg').disabled;

        if (mts && !mts_disabled) {
            opcionElegida = 2; // opcion mts.
        } else if (!kg) {
            opcionElegida = 1; // opcion kg.
        } else {
            opcionElegida = 3; // ninguno
        }

        $.ajax({
            url: "producto.do?menu=nuevo&opcion=agregar",
            type: "GET",
            data: {uni_medida: opcionElegida, codigo: codigo, precio: precio,
                stock: stock, descripcion: descripcion, seccion: seccion, forma_venta: forma_venta},
            datatype: "json",
            success: function (data) {

                var add = JSON.parse(data).agregado;
                if (add) {
                    toastr["success"]("Producto agregado con exito", "Exito");
                    $("#codigo").val("");
                    $("#precio").val("");
                    $("#stock").val("");
                    $("#descripcion").val("");
                    $("#codigo").focus();
                } else {
                    toastr["error"]("No se pudo agregar el producto, verifique los datos", "Denegado");
                    $("#codigo").focus();
                }
            }
        });
    });





    //NUEVA SECCION

    $("#btn-Seccion").click(function () {
        $(function () {
            $("#formSeccion").trigger("reset");
            $(".modal-header").css("background-color", "#8B0000");
            $(".modal-header").css("color", "white");
            $(".modal-title").text("Ingrese nueva sección");
            $('#modal2').modal('show');
        });
    });

    $("#btn-guardarDB").click(function () {
        $.ajax({
            url: "informe.do?opcion=backupDataBase",
            type: "GET",
            datatype: "JSON",
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
    var opcion = document.getElementById("forma_venta").value;

    if (opcion == 2) {
        document.getElementById("kg").disabled = false;
        document.getElementById("mts").disabled = false;
    } else {
        document.getElementById("kg").disabled = true;
        document.getElementById("mts").disabled = true;
    }
}


