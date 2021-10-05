package com.casatrachta.dao.definition;

import com.casatrachta.model.Producto;
import com.casatrachta.model.ProductoEnCarrito;

import java.util.ArrayList;

import java.util.List;

public interface IProductoDao {

    public boolean save(Producto producto);
    public Producto findById(int id);
    public ProductoEnCarrito findByCodigo(String codigo);
    public void update(Producto producto);
    public void delete(int id);
    public void updateStock(Producto producto);
    public List<Producto> allStockDown(String valor);
    public ArrayList<Producto> list(int pagina);
    public int countPages();
    public int totalProducts();
    public ArrayList<Producto> findByDescripcion(String descripcion);
  

}
