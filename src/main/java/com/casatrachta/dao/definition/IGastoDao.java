package com.casatrachta.dao.definition;

import com.casatrachta.model.Gasto;
import java.util.List;

public interface IGastoDao {

    public void insertar(String desc, int monto, String fecha);
    public List<Gasto> listarGastos(String fecha);
    String establecerTotal(String fecha);

}
