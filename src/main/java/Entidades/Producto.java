package Entidades;

public class Producto {
public int id_producto;
public String nombre;
public double precio;
public String categoria;
public int stock;
public int  estado;
public Producto() {}
public Producto(int id_producto, String nombre, double precio, String categoria, int stock, int estado) {
	this.id_producto = id_producto;
	this.nombre = nombre;
	this.precio = precio;
	this.categoria = categoria;
	this.stock = stock;
	this.estado = estado;
}
public int getId_producto() {
	return id_producto;
}
public void setId_producto(int id_producto) {
	this.id_producto = id_producto;
}
public String getNombre() {
	return nombre;
}
public void setNombre(String nombre) {
	this.nombre = nombre;
}
public double getPrecio() {
	return precio;
}
public void setPrecio(double precio) {
	this.precio = precio;
}
public String getCategoria() {
	return categoria;
}
public void setCategoria(String categoria) {
	this.categoria = categoria;
}
public int getStock() {
	return stock;
}
public void setStock(int stock) {
	this.stock = stock;
}
public int getEstado() {
	return estado;
}
public void setEstado(int estado) {
	this.estado = estado;
}

}
