 $(function () {

                var codigo = document.getElementById("codigo");
                codigo.focus();

               
                $("#codigo").keyup(function () {
                    var valor = $("#codigo").val();

                    $.ajax({

                        url: "producto.do?menu=actualizar-stock&opcion=producto&codigo=" + valor,
                        type: "GET",
                        
                        dataType: "JSON",
                        success: function (data) {

                            $("#nombre").val(data.nombre);
                            $("#stock").val(data.stock);
                            $("#unidad").val(data.unidad);
                        }

                    });
                });
                
                
                $("#btn-guardarDB").click(function () {

                    $.ajax({
                        url: "informe.do?opcion=backupDataBase",
                        type: "GET",
                        datatype: "json",
                        success: function (data) {
                            
                            var backup = JSON.parse(data).backup;

                            if(backup){
                                alert("Base de datos guardada EXITOSAMENTE!!!");
                            }else{
                                alert("Ocurrio un error al guardar la base de datos");
                            }
                        }

                    });



                });

            });


