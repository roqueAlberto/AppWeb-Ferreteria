$(document).ready(function () {

    // == VISTA REALIZARVENTA
    $("#codigo_barra").focus();


    // Btn eliminar orden
    $(document).on("click", ".removerProducto", function () {

        var id_orden = $(this).attr("onclick");


        $("#id_orden").val(id_orden);


    });

    //  Calculo de cantidad
    $("tr #cantidad").keyup(function () {


        var fun = function () {
            location.href = "Servidor?menu=RealizarVenta&opcion=default";
        };

        var idp = $(this).parent().find("#idproducto").val();
        var cantidad = $(this).parent().find("#cantidad").val();
        var url = "Servidor?menu=RealizarVenta&opcion=ActualizarCantidad";


        $.ajax({

            type: "post",
            url: url,
            data: "idp=" + idp + "&cantidad=" + cantidad,
            success: function (data, textStatus, jqXHR) {


                //location.href = "Servidor?menu=RealizarVenta&opcion=default";

                setTimeout(fun, 1000);




            }

        });




    });



    //Editar seccion   
    $(document).on("click", ".btn-editar", function () {

        $("#edit_seccion").focus();

        var id_dep = $(this).attr("onclick");



        $.ajax({

            url: "Servidor?menu=Seccion&opcion=Editar&id_dep=" + id_dep,
            type: "GET",
            datatype: "json",
            success: function (data) {



                $("#edit_seccion").val(JSON.parse(data).nombre);

                $("#edit_seccion").focus();
                $("#id_seleccionado").val(id_dep);



            }

        });

    });

    //Eliminar Seccion
    $(document).on("click", ".btn-borrar", function () {

        var dep_eliminar = $(this).attr("onclick");


        $("#delete_dep").val(dep_eliminar);



    });


    //VISTA GESTIONVENTA
  


});

function cargarGrafico() {
    //Vista index

    var ctx = document.getElementById('myChart').getContext('2d');


    $.ajax({
        url: "Servidor?menu=Inicio&opcion=listar",
        type: "get",
        dataType: "JSON",
        success: function (data) {



            var myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
                    datasets: [{
                            label: ' Mes',
                            data: [data.enero, data.febrero, data.marzo, data.abril, data.mayo, data.junio, data.julio, data.agosto, data.septiembre, data.octubre, data.noviembre, data.diciembre],
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(255, 159, 64, 0.2)',
                                'rgba(63,24,33, 0.2)',
                                'rgba(49,127,110, 0.2)',
                                'rgba(110,49,127, 0.2)',
                                'rgba(127,110,49, 0.2)',
                                'rgba(49,66,127, 0.2)',
                                'rgba(238,228,11, 0.2)'

                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)',
                                'rgba(63,24,33, 1)',
                                'rgba(49,127,110, 1)',
                                'rgba(110,49,127, 1)',
                                'rgba(127,110,49, 1)',
                                'rgba(49,66,127,1)',
                                'rgba(238,228,11, 1)'


                            ],
                            borderWidth: 1
                        }]
                },
                options: {
                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                    }
                }
            });
        }

    });


}
;