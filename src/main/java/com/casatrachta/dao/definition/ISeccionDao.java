
package com.casatrachta.dao.definition;

import com.casatrachta.model.Seccion;
import java.util.List;


public interface ISeccionDao {
    
    List<Seccion> listar();
    void agregar(String nombre_s);
    
}
