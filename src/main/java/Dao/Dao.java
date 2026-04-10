package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import DataBase.BaseDatos;
import Entidades.Cliente;
import Entidades.DetalleVenta;
import Entidades.Producto;
import Entidades.Proveedor;
import Entidades.Usuario;
import Entidades.Venta;

public class Dao {

    private Connection cn;
    private PreparedStatement ps;
    private ResultSet rs;

    BaseDatos basedatos = new BaseDatos();

 //basic user login authentication
    public Usuario login(String username, String password) {

        Usuario u = null;
        String sql = """
            SELECT id_usuario, username, rol, estado
            FROM usuario
            WHERE username = ?
              AND password = ?
              AND estado = 1
        """;
        try {
            cn = basedatos.Conectar();
            ps = cn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            
            rs = ps.executeQuery();

            if (rs.next()) {
                u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setUsername(rs.getString("username"));
                u.setRol(rs.getString("rol"));
                u.setEstado(rs.getInt("estado"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrar();
        }
        return u;
    }

   //list products by state (if is 1 the state is active, if 0 is deactivated)
    public ArrayList<Producto> listarProductoPorEstado(int estado) {

        ArrayList<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM producto WHERE estado = ?";

        try {
            cn = basedatos.Conectar();
            ps = cn.prepareStatement(sql);
            ps.setInt(1, estado);
            rs = ps.executeQuery();

            while (rs.next()) {
                Producto p = new Producto();
                p.setId_producto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setPrecio(rs.getDouble("precio"));
                p.setCategoria(rs.getString("categoria"));
                p.setStock(rs.getInt("stock"));
                p.setEstado(rs.getInt("estado"));
                lista.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrar();
        }
        return lista;
    }
    
    //list client by status (same as above)
    public ArrayList<Cliente> listarClientePorEstado(int estado) {
        ArrayList<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM cliente WHERE estado = ?";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, estado);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cliente c = new Cliente();
                c.setId_cliente(rs.getInt("id_cliente"));
                c.setNombre(rs.getString("nombre"));
                c.setDni(rs.getString("dni"));
                c.setTelefono(rs.getString("telefono"));
                c.setEstado(rs.getInt("estado"));
                lista.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

  //list provider for state (same the top)
    public ArrayList<Proveedor> listarProveedorPorEstado(int estado) {
        ArrayList<Proveedor> lista = new ArrayList<>();
        String sql = "SELECT * FROM proveedor WHERE estado = ?";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, estado);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Proveedor p = new Proveedor();
                p.setId_proveedor(rs.getInt("id_proveedor"));
                p.setNombre(rs.getString("nombre"));
                p.setRuc(rs.getString("ruc"));
                p.setTelefono(rs.getString("telefono"));
                p.setEstado(rs.getInt("estado"));
                lista.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

  //List sales by status (same as above)
    public ArrayList<Venta> listarVentaPorEstado(int estado) {
        ArrayList<Venta> lista = new ArrayList<>();

        String sql = """
            SELECT v.id_venta, v.fecha, v.total, v.id_cliente, v.estado
            FROM venta v
            WHERE v.estado = ?
        """;

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, estado);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Venta v = new Venta();
                v.setId_venta(rs.getInt("id_venta"));
                v.setFecha(rs.getTimestamp("fecha"));
                v.setTotal(rs.getDouble("total"));
                v.setId_cliente(rs.getInt("id_cliente"));
                v.setEstado(rs.getInt("estado"));
                lista.add(v);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    //list detail sale 
    public ArrayList<DetalleVenta> listarDetalleVenta(int idVenta) {

        ArrayList<DetalleVenta> lista = new ArrayList<>();
        String sql = """
            SELECT d.id_detalle, d.cantidad, d.subtotal,
                   p.id_producto, p.nombre, p.precio
            FROM detalle_venta d
            JOIN producto p ON d.id_producto = p.id_producto
            WHERE d.id_venta = ?
        """;

        try {
            cn = basedatos.Conectar();
            ps = cn.prepareStatement(sql);
            ps.setInt(1, idVenta);
            rs = ps.executeQuery();

            while (rs.next()) {
                DetalleVenta d = new DetalleVenta();
                d.setId_detalle(rs.getInt("id_detalle"));
                d.setCantidad(rs.getInt("cantidad"));
                d.setSubtotal(rs.getDouble("subtotal"));
                d.setId_producto(rs.getInt("id_producto"));
                d.setNombreProducto(rs.getString("nombre"));
                d.setPrecio(rs.getDouble("precio"));
                lista.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrar();
        }
        return lista;
    }

    private void cerrar() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (cn != null) cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    //change status (i don't remember which state it changes xd)
    public void cambiarEstado(String tabla, String campoId, int id, int estado) {

        String sql = "UPDATE " + tabla + " SET estado = ? WHERE " + campoId + " = ?";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, estado);
            ps.setInt(2, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    //insert product in the product table 
    public boolean insertarProducto(Producto p) {
        String sql = """
            INSERT INTO producto (nombre, precio, categoria, stock, estado)
            VALUES (?, ?, ?, ?, 1)
        """;

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setDouble(2, p.getPrecio());
            ps.setString(3, p.getCategoria());
            ps.setInt(4, p.getStock());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    //Delete product 
    public boolean eliminarProducto(Producto p) {
    	String sql ="DELETE FROM producto WHERE id_producto = ?";
   
    	try (Connection cn = basedatos.Conectar();
                PreparedStatement ps = cn.prepareStatement(sql)) {
    	
    	ps.setInt(1, p.getId_producto());

    	return ps.executeUpdate()>0;
    }catch (Exception e) {
    	e.printStackTrace();
    }   
    	return false;
    }
    
    //Delete provider
    public boolean eliminarProveedor(Proveedor p) {
    	String sql="DELETE FROM proveedor WHERE id_proveedor = ?";
    	
    	try (Connection cn = basedatos.Conectar();
    				PreparedStatement ps = cn.prepareStatement(sql)){
    			
    	ps.setInt(1, p.getId_proveedor());
    	
    	return ps.executeUpdate()>0;
    }catch (Exception e) {
    	e.printStackTrace();
    }
    	return false;
    }
    
    //Delete client
    public boolean eliminarCliente(Cliente c) {
    	String sql ="DELETE FROM cliente WHERE id_cliente = ?";
    	try (Connection cn = basedatos.Conectar();
    			PreparedStatement ps = cn.prepareStatement(sql)){
    		
    		ps.setInt(1, c.getId_cliente());
    		
    		return ps.executeUpdate()>0;
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	return false;
    }
    
    //Delete sale
    public boolean eliminarVenta(Venta v) {
    	String sqlDetalle_Venta="DELETE FROM detalle_venta WHERE id_venta =? ";
    	String sqlVenta="DELETE FROM venta WHERE id_venta=? ";
    	try(Connection cn = basedatos.Conectar()){
    			PreparedStatement ps1 = cn.prepareStatement(sqlDetalle_Venta);
    		ps1.setInt(1, v.getId_venta());
    		ps1.executeUpdate();
    		
    		PreparedStatement ps2 = cn.prepareStatement(sqlVenta);
    		ps2.setInt(1, v.getId_venta());
    		
    		return ps2.executeUpdate()>0;
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	return false;
    }
    
    //insert client 
    public boolean insertarCliente(Cliente c) {
        String sql = """
            INSERT INTO cliente (nombre, dni, telefono, estado)
            VALUES (?, ?, ?, 1)
        """;

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, c.getNombre());
            ps.setString(2, c.getDni());
            ps.setString(3, c.getTelefono());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    //insert provider
    public boolean insertarProveedor(Proveedor p) {
        String sql = """
            INSERT INTO proveedor (nombre, ruc, telefono, estado)
            VALUES (?, ?, ?, 1)
        """;

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getRuc());
            ps.setString(3, p.getTelefono());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
   
    //insert user
    public boolean insertarUsuario(Usuario u) {
        String sql = """
            INSERT INTO usuario (username, password, rol, estado)
            VALUES (?, ?, ?, 1)
        """;

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getRol());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    //search product by id
    public Producto buscarProductoPorId(int id) {

        Producto p = null;
        String sql = "SELECT * FROM producto WHERE id_producto = ?";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                p = new Producto();
                p.setId_producto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setPrecio(rs.getDouble("precio"));
                p.setCategoria(rs.getString("categoria"));
                p.setStock(rs.getInt("stock"));
                p.setEstado(rs.getInt("estado"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return p;
    }
    
    //search provider by id
    public Proveedor buscarProveedorPorId(int id) {

        Proveedor p = null;
        String sql = "SELECT * FROM proveedor WHERE id_proveedor = ?";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                p = new Proveedor();
                p.setId_proveedor(rs.getInt("id_proveedor"));
                p.setNombre(rs.getString("nombre"));
                p.setRuc(rs.getString("ruc"));
                p.setTelefono(rs.getString("telefono"));
                p.setEstado(rs.getInt("estado"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return p;
    }
    
    //search client by id
    public Cliente buscarClientePorId(int id) {

        Cliente c = null;
        String sql = "SELECT * FROM cliente WHERE id_cliente = ?";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                c = new Cliente();
                c.setId_cliente(rs.getInt("id_cliente"));
                c.setNombre(rs.getString("nombre"));
                c.setDni(rs.getString("dni"));
                c.setTelefono(rs.getString("telefono"));
                c.setEstado(rs.getInt("estado"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return c;
    }
    
    //update product
    public void actualizarProducto(Producto p) {
        String sql = "UPDATE producto SET nombre=?, precio=?, stock=? WHERE id_producto=?";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setDouble(2, p.getPrecio());
            ps.setInt(3, p.getStock());
            ps.setInt(4, p.getId_producto());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
       
    }
    
    //update client 
    public void actualizarCliente(Cliente c) {
        String sql = "UPDATE cliente SET nombre=?, dni=?, telefono=? WHERE id_cliente=?";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, c.getNombre());
            ps.setString(2, c.getDni());
            ps.setString(3, c.getTelefono());
            ps.setInt(4, c.getId_cliente());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    //update provider
    public void actualizarProveedor(Proveedor p) {
        String sql = "UPDATE proveedor SET nombre=?, ruc=?, telefono=? WHERE id_proveedor=?";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getRuc());
            ps.setString(3, p.getTelefono());
            ps.setInt(4, p.getId_proveedor());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    //obtain grand total of sales
    public double obtenerTotalGeneralVentas() {
        double total = 0;
        String sql = "SELECT SUM(total) FROM venta WHERE estado = 1";

        try (Connection cn = basedatos.Conectar();
	             PreparedStatement ps = cn.prepareStatement(sql)){
        	ResultSet rs = ps.executeQuery();
        	
            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }
    
    //list user by state
    public ArrayList<Usuario> listarUsuarioPorEstado(int estado) {
        ArrayList<Usuario> lista = new ArrayList<>();
        String sql = "SELECT id_usuario, username, rol, estado FROM usuario WHERE estado = ?";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, estado);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setUsername(rs.getString("username"));
                u.setRol(rs.getString("rol"));
                u.setEstado(rs.getInt("estado"));
                lista.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    //search user 
    public ArrayList<Usuario> buscarUsuario(String texto) {
        ArrayList<Usuario> lista = new ArrayList<>();
        String sql = """
            SELECT id_usuario, username, rol, estado
            FROM usuario
            WHERE estado = 1
              AND username LIKE ?
        """;

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, "%" + texto + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setUsername(rs.getString("username"));
                u.setRol(rs.getString("rol"));
                u.setEstado(rs.getInt("estado"));
                lista.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    //search product by name
    public ArrayList<Producto> buscarProductoPorNombre(String nombre) {
        ArrayList<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM producto WHERE nombre LIKE ? AND estado = 1";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, "%" + nombre + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Producto p = new Producto();
                p.setId_producto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setPrecio(rs.getDouble("precio"));
                p.setCategoria(rs.getString("categoria"));
                p.setStock(rs.getInt("stock"));
                p.setEstado(rs.getInt("estado"));
                lista.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    //search client 
    public ArrayList<Cliente> buscarCliente(String nombre) {
        ArrayList<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM cliente WHERE dni LIKE ? AND estado = 1";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, "%" + nombre + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cliente c = new Cliente();
                c.setId_cliente(rs.getInt("id_cliente"));
                c.setNombre(rs.getString("nombre"));
                c.setDni(rs.getString("dni"));
                c.setTelefono(rs.getString("telefono"));
                c.setEstado(rs.getInt("estado"));
                lista.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    //search provider
    public ArrayList<Proveedor> buscarProveedor(String nombre) {
        ArrayList<Proveedor> lista = new ArrayList<>();
        String sql = "SELECT * FROM proveedor WHERE ruc LIKE ? AND estado = 1";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, "%" + nombre + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Proveedor p = new Proveedor();
                p.setId_proveedor(rs.getInt("id_proveedor"));
                p.setNombre(rs.getString("nombre"));
                p.setRuc(rs.getString("ruc"));
                p.setTelefono(rs.getString("telefono"));
                p.setEstado(rs.getInt("estado"));
                lista.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    //search sale by id
    public ArrayList<Venta> buscarVentaPorId(int idVenta) {
        ArrayList<Venta> lista = new ArrayList<>();
        String sql = """
            SELECT id_venta, fecha, total, id_cliente, estado
            FROM venta
            WHERE estado = 1
              AND id_venta = ?
        """;

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, idVenta);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Venta v = new Venta();
                v.setId_venta(rs.getInt("id_venta"));
                v.setFecha(rs.getTimestamp("fecha"));
                v.setTotal(rs.getDouble("total"));
                v.setId_cliente(rs.getInt("id_cliente"));
                v.setEstado(rs.getInt("estado"));
                lista.add(v);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
    
   //search user by id
    public Usuario buscarUsuarioPorId(int id) {
        Usuario u = null;
        String sql = "SELECT id_usuario, username, rol, estado FROM usuario WHERE id_usuario = ?";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setUsername(rs.getString("username"));
                u.setRol(rs.getString("rol"));
                u.setEstado(rs.getInt("estado"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }
    
    //update user
    public void actualizarUsuario(Usuario u) {
        String sql = "UPDATE usuario SET username=?, rol=? WHERE id_usuario=?";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, u.getUsername());
            ps.setString(2, u.getRol());
            ps.setInt(3, u.getId_usuario());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    //count products and show in notifications
    public int contarProductos() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total FROM producto";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                total = rs.getInt("total");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }
  //count clients and show in notifications
    public int contarClientes() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total FROM cliente";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                total = rs.getInt("total");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }
    
  //count provider and show in notifications
    public int contarProveedores() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total FROM proveedor";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                total = rs.getInt("total");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }
    
  //count sales and show in notifications
    public int contarVentas() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total FROM venta";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                total = rs.getInt("total");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

 // obtain last products added
    public ArrayList<Producto> obtenerUltimosProductos(int limite) {
        ArrayList<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM producto ORDER BY id_producto DESC LIMIT ?";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, limite);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Producto p = new Producto();
                p.setId_producto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setPrecio(rs.getDouble("precio"));
                p.setCategoria(rs.getString("categoria"));
                p.setStock(rs.getInt("stock"));
                p.setEstado(rs.getInt("estado"));
                lista.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
        
    }

    // obtain last clients added 
    public ArrayList<Cliente> obtenerUltimosClientes(int limite) {
        ArrayList<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM cliente ORDER BY id_cliente DESC LIMIT ?";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, limite);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cliente c = new Cliente();
                c.setId_cliente(rs.getInt("id_cliente"));
                c.setNombre(rs.getString("nombre"));
                c.setDni(rs.getString("dni"));
                c.setTelefono(rs.getString("telefono"));
                c.setEstado(rs.getInt("estado"));
                lista.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    // obtain last provider added 
    public ArrayList<Proveedor> obtenerUltimosProveedores(int limite) {
        ArrayList<Proveedor> lista = new ArrayList<>();
        String sql = "SELECT * FROM proveedor ORDER BY id_proveedor DESC LIMIT ?";

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, limite);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Proveedor p = new Proveedor();
                p.setId_proveedor(rs.getInt("id_proveedor"));
                p.setNombre(rs.getString("nombre"));
                p.setRuc(rs.getString("ruc"));
                p.setTelefono(rs.getString("telefono"));
                p.setEstado(rs.getInt("estado"));
                lista.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    // obtain last sales 
    public ArrayList<Venta> obtenerUltimasVentas(int limite) {
        ArrayList<Venta> lista = new ArrayList<>();
        String sql = """
            SELECT * FROM venta ORDER BY id_venta DESC LIMIT ?
        """;

        try (Connection cn = basedatos.Conectar();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, limite);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Venta v = new Venta();
                v.setId_venta(rs.getInt("id_venta"));
                v.setFecha(rs.getTimestamp("fecha"));
                v.setTotal(rs.getDouble("total"));
                v.setId_cliente(rs.getInt("id_cliente"));
                v.setEstado(rs.getInt("estado"));
                lista.add(v);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public static class VentaMes {
        private String mes;
        private double total;
        private double porcentaje;
        
        public VentaMes(String mes, double total, double porcentaje) {
            this.mes = mes;
            this.total = total;
            this.porcentaje = porcentaje;
        }
        
        public String getMes() { return mes; }
        public double getTotal() { return total; }
        public double getPorcentaje() { return porcentaje; }
        
        public void setPorcentaje(double porcentaje) {
            this.porcentaje = porcentaje;
        }
    }
    
    public static class VentaCategoria {
        private String nombre;
        private String nombreLower;
        private double total;
        private double porcentaje;
        private double anguloInicio;
        private double anguloFin;
        
        public VentaCategoria(String nombre, double total) {
            this.nombre = nombre;
            this.nombreLower = nombre.toLowerCase()
                                     .replace("á", "a")
                                     .replace("é", "e")
                                     .replace("í", "i")
                                     .replace("ó", "o")
                                     .replace("ú", "u");
            this.total = total;
        }
        
        public String getNombre() { return nombre; }
        public String getNombreLower() { return nombreLower; }
        public double getTotal() { return total; }
        public double getPorcentaje() { return porcentaje; }
        public double getAnguloInicio() { return anguloInicio; }
        public double getAnguloFin() { return anguloFin; }
        
        public void setPorcentaje(double porcentaje) {
            this.porcentaje = porcentaje;
        }
        
        public void setAngulos(double inicio, double fin) {
            this.anguloInicio = inicio;
            this.anguloFin = fin;
        }
    }
    
    //obtain sales by month
    public List<VentaMes> obtenerVentasPorMes() {
        List<VentaMes> ventas = new ArrayList<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql =
        	    "SELECT " +
        	    "  MONTH(v.fecha) AS mes, " +
        	    "  CASE MONTH(v.fecha) " +
        	    "    WHEN 1 THEN 'Ene' " +
        	    "    WHEN 2 THEN 'Feb' " +
        	    "    WHEN 3 THEN 'Mar' " +
        	    "    WHEN 4 THEN 'Abr' " +
        	    "    WHEN 5 THEN 'May' " +
        	    "    WHEN 6 THEN 'Jun' " +
        	    "    WHEN 7 THEN 'Jul' " +
        	    "    WHEN 8 THEN 'Ago' " +
        	    "    WHEN 9 THEN 'Sep' " +
        	    "    WHEN 10 THEN 'Oct' " +
        	    "    WHEN 11 THEN 'Nov' " +
        	    "    WHEN 12 THEN 'Dic' " +
        	    "  END AS nombre_mes, " +
        	    "  SUM(dv.subtotal) AS total_ventas " +
        	    "FROM venta v " +
        	    "INNER JOIN detalle_venta dv ON dv.id_venta = v.id_venta " +
        	    "WHERE YEAR(v.fecha) = YEAR(CURDATE()) " +
        	    "GROUP BY MONTH(v.fecha) " +
        	    "ORDER BY MONTH(v.fecha)";

        
        try {
            cn = basedatos.Conectar();
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            double maxVenta = 0;
            List<VentaMes> ventasTemp = new ArrayList<>();
            
            while (rs.next()) {
                String mes = rs.getString("nombre_mes");
                double total = rs.getDouble("total_ventas");
                
                if (total > maxVenta) {
                    maxVenta = total;
                }
                
                ventasTemp.add(new VentaMes(mes, total, 0));
            }
            
            if (maxVenta > 0) {
                for (VentaMes venta : ventasTemp) {
                    double porcentaje = (venta.getTotal() / maxVenta) * 100;
                    venta.setPorcentaje(Math.round(porcentaje * 100.0) / 100.0);
                    ventas.add(venta);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al obtener ventas por mes: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return ventas;
    }
    
    //obtain sales by category
    public List<VentaCategoria> obtenerVentasPorCategoria() {
        List<VentaCategoria> categorias = new ArrayList<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT " +
                " p.categoria, " +
                " SUM(dv.subtotal) as total_categoria " +
                "FROM detalle_venta dv " +
                "INNER JOIN producto p ON dv.id_producto = p.id_producto " +
                "INNER JOIN venta v ON dv.id_venta = v.id_venta " +
                "WHERE YEAR(v.fecha) = YEAR(CURDATE()) " +
                "GROUP BY p.categoria " +
                "ORDER BY total_categoria DESC";

        
        try {
            cn = basedatos.Conectar();
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            double totalGeneral = 0;
            List<VentaCategoria> categoriasTemp = new ArrayList<>();
            
            while (rs.next()) {
                String nombre = rs.getString("categoria");
                double total = rs.getDouble("total_categoria");
                totalGeneral += total;
                
                categoriasTemp.add(new VentaCategoria(nombre, total));
            }
            
            if (totalGeneral > 0) {
                double anguloAcumulado = 0;
                for (VentaCategoria cat : categoriasTemp) {
                    double porcentaje = (cat.getTotal() / totalGeneral) * 100;
                    cat.setPorcentaje(Math.round(porcentaje * 10.0) / 10.0);
                    
                    double anguloInicio = anguloAcumulado;
                    double anguloSegmento = (porcentaje / 100.0) * 360.0;
                    double anguloFin = anguloInicio + anguloSegmento;
                    
                    cat.setAngulos(
                        Math.round(anguloInicio * 10.0) / 10.0,
                        Math.round(anguloFin * 10.0) / 10.0
                    );
                    
                    anguloAcumulado = anguloFin;
                    categorias.add(cat);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al obtener ventas por categoría: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return categorias;
    }
    
    //obtain color by category
    public static String obtenerColorCategoria(String categoria) {
        if (categoria == null) return "var(--text-3)";
        
        String cat = categoria.toLowerCase()
                             .replace("á", "a")
                             .replace("é", "e")
                             .replace("í", "i")
                             .replace("ó", "o")
                             .replace("ú", "u");
        
        switch (cat) {
            case "bebidas": return "var(--cyan)";
            case "comidas": return "var(--emerald)";
            case "golosinas": return "var(--amber)";
            case "panaderia": return "var(--violet)";
            case "snacks": return "var(--rose)";
            case "lacteos": return "#3498db";
            case "abarrotes": return "var(--text-3)";
            default: return "var(--text-3)";
        }
    }
  
    
    
}
