package com.casatrachta.dao.definition;

import com.casatrachta.model.Producto;
import java.util.ArrayList;

import java.util.List;

public interface IProductoDao {

    public boolean agregar(Producto producto);
    public Producto obtener(int id);
    public Producto getProducto(String codigo);
    public void actualizar(Producto producto);
    public void eliminar(int id);
    public void actualizarStock(Producto producto);
    public List<Producto> listarStockBajo(String valor);
    public ArrayList<Producto> listar(int pagina);
    public int totalPaginas();
    public int totalProductos();
    public ArrayList<Producto> buscarProducto(String descripcion);
  

}
