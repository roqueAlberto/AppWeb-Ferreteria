
package com.casatrachta.dao.definition;


import java.util.List;



public interface INotaDao {
    
   void guardar(String dato, String fecha);
   List<String> listar(String fecha);
   int getCantidad(String fecha);
    
}
