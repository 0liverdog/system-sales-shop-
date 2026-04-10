package Entidades;

public class DetalleVenta {
public int id_detalle;
public int cantidad;
public double subtotal;
public int id_venta;
public int id_producto;
private String nombreProducto;
private double precio;
public DetalleVenta() {}

public DetalleVenta(int id_detalle, int cantidad, double subtotal, int id_venta, int id_producto) {
	super();
	this.id_detalle = id_detalle;
	this.cantidad = cantidad;
	this.subtotal = subtotal;
	this.id_venta = id_venta;
	this.id_producto = id_producto;
}

public String getNombreProducto() {
	return nombreProducto;
}

public void setNombreProducto(String nombreProducto) {
	this.nombreProducto = nombreProducto;
}

public double getPrecio() {
	return precio;
}

public void setPrecio(double precio) {
	this.precio = precio;
}

public int getId_detalle() {
	return id_detalle;
}

public void setId_detalle(int id_detalle) {
	this.id_detalle = id_detalle;
}

public int getCantidad() {
	return cantidad;
}

public void setCantidad(int cantidad) {
	this.cantidad = cantidad;
}

public double getSubtotal() {
	return subtotal;
}

public void setSubtotal(double subtotal) {
	this.subtotal = subtotal;
}

public int getId_venta() {
	return id_venta;
}

public void setId_venta(int id_venta) {
	this.id_venta = id_venta;
}

public int getId_producto() {
	return id_producto;
}

public void setId_producto(int id_producto) {
	this.id_producto = id_producto;
}

}
