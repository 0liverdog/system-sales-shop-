package servlets;

import Dao.Dao;
import DataBase.BaseDatos;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/GenerarVentas")
public class GenerarVentas extends HttpServlet {

    BaseDatos bd = new BaseDatos();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idCliente = Integer.parseInt(request.getParameter("idCliente"));
        String[] idProductos = request.getParameterValues("idProducto");
        String[] cantidades = request.getParameterValues("cantidad");

        double total = 0;

        try (Connection cn = bd.Conectar()) {

            for (int i = 0; i < idProductos.length; i++) {
                int cant = Integer.parseInt(cantidades[i]);

                if (cant > 0) {
                    String sqlPrecio = "SELECT precio FROM producto WHERE id_producto = ?";
                    try (PreparedStatement ps = cn.prepareStatement(sqlPrecio)) {
                        ps.setInt(1, Integer.parseInt(idProductos[i]));
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) {
                            total += rs.getDouble("precio") * cant;
                        }
                    }
                }
            }

            // 2️⃣ INSERTAR VENTA
            String sqlVenta = """
                INSERT INTO venta (fecha, total, id_cliente, estado)
                VALUES (NOW(), ?, ?, 1)
            """;

            PreparedStatement psVenta = cn.prepareStatement(sqlVenta, PreparedStatement.RETURN_GENERATED_KEYS);
            psVenta.setDouble(1, total);
            psVenta.setInt(2, idCliente);
            psVenta.executeUpdate();

            ResultSet rsVenta = psVenta.getGeneratedKeys();
            int idVenta = 0;
            if (rsVenta.next()) {
                idVenta = rsVenta.getInt(1);
            }

            // 3️⃣ INSERTAR DETALLE + ACTUALIZAR STOCK
            for (int i = 0; i < idProductos.length; i++) {
                int cant = Integer.parseInt(cantidades[i]);

                if (cant > 0) {
                    int idProd = Integer.parseInt(idProductos[i]);

                    // precio
                    double precio = 0;
                    String sqlPrecio = "SELECT precio FROM producto WHERE id_producto = ?";
                    PreparedStatement psPrecio = cn.prepareStatement(sqlPrecio);
                    psPrecio.setInt(1, idProd);
                    ResultSet rs = psPrecio.executeQuery();
                    if (rs.next()) {
                        precio = rs.getDouble("precio");
                    }

                    // detalle
                    String sqlDetalle = """
                        INSERT INTO detalle_venta
                        (cantidad, subtotal, id_venta, id_producto)
                        VALUES (?, ?, ?, ?)
                    """;
                    PreparedStatement psDetalle = cn.prepareStatement(sqlDetalle);
                    psDetalle.setInt(1, cant);
                    psDetalle.setDouble(2, cant * precio);
                    psDetalle.setInt(3, idVenta);
                    psDetalle.setInt(4, idProd);
                    psDetalle.executeUpdate();

                    // stock
                    String sqlStock = """
                        UPDATE producto
                        SET stock = stock - ?
                        WHERE id_producto = ?
                    """;
                    PreparedStatement psStock = cn.prepareStatement(sqlStock);
                    psStock.setInt(1, cant);
                    psStock.setInt(2, idProd);
                    psStock.executeUpdate();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("listadoVentas.jsp");
    }
}
