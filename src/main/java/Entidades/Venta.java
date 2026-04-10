package Entidades;

import java.sql.Timestamp;

public class Venta {
public int id_venta;
public Timestamp fecha;
public double total;
public int id_cliente;
public int estado;
public Venta() {}
public Venta(int id_venta, Timestamp fecha, double total, int id_cliente, int estado) {
	this.id_venta = id_venta;
	this.fecha = fecha;
	this.total = total;
	this.id_cliente = id_cliente;
	this.estado = estado;
}
public int getId_venta() {
	return id_venta;
}
public void setId_venta(int id_venta) {
	this.id_venta = id_venta;
}
public Timestamp getFecha() {
	return fecha;
}
public void setFecha(Timestamp fecha) {
	this.fecha = fecha;
}
public double getTotal() {
	return total;
}
public void setTotal(double total) {
	this.total = total;
}
public int getId_cliente() {
	return id_cliente;
}
public void setId_cliente(int id_cliente) {
	this.id_cliente = id_cliente;
}
public int getEstado() {
	return estado;
}
public void setEstado(int estado) {
	this.estado = estado;
}

}
