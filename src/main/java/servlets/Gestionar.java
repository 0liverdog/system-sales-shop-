package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

import Dao.Dao;
import Entidades.Cliente;
import Entidades.DetalleVenta;
import Entidades.Producto;
import Entidades.Proveedor;
import Entidades.Usuario;
import Entidades.Venta;


/**
 * Servlet implementation class Gestionar
 */
@WebServlet("/Gestionar")
public class Gestionar extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Gestionar() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Servlet Gestionar...");
		Dao dao = new Dao();
		String accion = request.getParameter("accion");
			
		if (accion != null && accion.equals("Producto")) {

		    int estado = 1;

		    if (request.getParameter("estado") != null) {
		        estado = Integer.parseInt(request.getParameter("estado"));
		    }

		    ArrayList<Producto> lista = dao.listarProductoPorEstado(estado);
		    request.setAttribute("lista", lista);
		    request.setAttribute("estadoActual", estado);

		    request.getRequestDispatcher("listadoProducto.jsp").forward(request, response);
		}

		if (accion != null && accion.equals("Cliente")) {
			int estado =1;
			if(request.getParameter("estado")!=null) {
				estado = Integer.parseInt(request.getParameter("estado"));
			}
		    ArrayList<Cliente> lista = dao.listarClientePorEstado(estado);
		    request.setAttribute("lista", lista);
		    request.getRequestDispatcher("listadoCliente.jsp").forward(request, response);
		}
		if (accion != null && accion.equals("Venta")) {
			int estado =1;
			if(request.getParameter("estado")!=null) {
				estado = Integer.parseInt(request.getParameter("estado"));
			}
		    ArrayList<Venta> lista = dao.listarVentaPorEstado(estado);
		    request.setAttribute("lista", lista);
		    request.getRequestDispatcher("listadoVentas.jsp").forward(request, response);
			double totalGeneral = dao.obtenerTotalGeneralVentas();
			request.setAttribute("totalGeneral", totalGeneral);
			request.getRequestDispatcher("listadoVentas.jsp").forward(request, response);
		}
		if (accion.equals("DetalleVenta")) {

		    int idVenta = Integer.parseInt(request.getParameter("idVenta"));

		    ArrayList<DetalleVenta> lista = dao.listarDetalleVenta(idVenta);

		    request.setAttribute("lista", lista);
		    request.setAttribute("idVenta", idVenta);

		    request.getRequestDispatcher("listadoDetalleVenta.jsp")
		           .forward(request, response);
		}
	
		if (accion != null && accion.equals("Proveedor")) {
 
			int estado =1;
			if(request.getParameter("estado")!=null) {
				estado = Integer.parseInt(request.getParameter("estado"));
			}
		    ArrayList<Proveedor> lista = dao.listarProveedorPorEstado(estado);
		    request.setAttribute("lista", lista);
		    request.getRequestDispatcher("listadoProveedor.jsp").forward(request, response);
		}
		if (accion.equals("InsertarProducto")) {

		    Producto p = new Producto();
		    p.setNombre(request.getParameter("nombre"));
		    p.setPrecio(Double.parseDouble(request.getParameter("precio")));
		    p.setCategoria(request.getParameter("categoria"));
		    p.setStock(Integer.parseInt(request.getParameter("stock")));

		    dao.insertarProducto(p);

		    response.sendRedirect("listadoProducto.jsp");
		}
		if (accion.equals("InsertarCliente")) {
		    Cliente c = new Cliente();
		    c.setNombre(request.getParameter("nombre"));
		    c.setDni(request.getParameter("dni"));
		    c.setTelefono(request.getParameter("telefono"));

		    dao.insertarCliente(c);
		    response.sendRedirect("listadoCliente.jsp");
		}
		if (accion.equals("InsertarProveedor")) {
		    Proveedor p = new Proveedor();
		    p.setNombre(request.getParameter("nombre"));
		    p.setRuc(request.getParameter("ruc"));
		    p.setTelefono(request.getParameter("telefono"));

		    dao.insertarProveedor(p);
		    response.sendRedirect("listadoProveedor.jsp");
		}
		if (accion.equals("InsertarUsuario")) {
		    Usuario u = new Usuario();
		    u.setUsername(request.getParameter("user"));
		    u.setPassword(request.getParameter("password"));
		    u.setRol(request.getParameter("rol"));

		    dao.insertarUsuario(u);
		    response.sendRedirect("login.jsp");
		}
		if ("ActualizarProducto".equals(accion)) {

		    Producto p = new Producto();
		    p.setId_producto((Integer.parseInt(request.getParameter("id"))));
		    p.setNombre(request.getParameter("nombre"));
		    p.setPrecio(Double.parseDouble(request.getParameter("precio")));
		    p.setStock(Integer.parseInt(request.getParameter("stock")));

		    dao.actualizarProducto(p);

		    response.sendRedirect("listadoProducto.jsp");
		}
		if ("ActualizarCliente".equals(accion)) { 
			Cliente c = new Cliente();
		    c.setId_cliente(Integer.parseInt(request.getParameter("id")));
		    c.setNombre(request.getParameter("nombre"));
		    c.setDni(request.getParameter("dni"));
		    c.setTelefono(request.getParameter("telefono"));

		    dao.actualizarCliente(c);
		    response.sendRedirect("listadoCliente.jsp");
		}
		if ("ActualizarProveedor".equals(accion)) {
		Proveedor p = new Proveedor();
	    p.setId_proveedor(Integer.parseInt(request.getParameter("id")));
	    p.setNombre(request.getParameter("nombre"));
	    p.setRuc(request.getParameter("ruc"));
	    p.setTelefono(request.getParameter("telefono"));

	    dao.actualizarProveedor(p);
	    response.sendRedirect("listadoProveedor.jsp");
		}
		if ("Usuario".equals(accion)) {
		    int estado = 1;
		    if (request.getParameter("estado") != null) {
		        estado = Integer.parseInt(request.getParameter("estado"));
		    }

		    ArrayList<Usuario> lista = dao.listarUsuarioPorEstado(estado);
		    request.setAttribute("lista", lista);
		    request.getRequestDispatcher("listadoUsuario.jsp").forward(request, response);
		}
		if ("BuscarUsuario".equals(accion)) {
		    String texto = request.getParameter("texto");
		    ArrayList<Usuario> lista = dao.buscarUsuario(texto);
		    request.setAttribute("lista", lista);
		    request.getRequestDispatcher("listadoUsuario.jsp").forward(request, response);
		}

		if ("BuscarProducto".equals(accion)) {
		    String nombre = request.getParameter("nombre");
		    ArrayList<Producto> lista = dao.buscarProductoPorNombre(nombre);
		    request.setAttribute("lista", lista);
		    request.getRequestDispatcher("listadoProducto.jsp").forward(request, response);
		}
		if ("BuscarCliente".equals(accion)) {
		    String dni = request.getParameter("dni");
		    ArrayList<Cliente> lista = dao.buscarCliente(dni);
		    request.setAttribute("lista", lista);
		    request.getRequestDispatcher("listadoCliente.jsp").forward(request, response);
		}
		if ("BuscarProveedor".equals(accion)) {
		    String ruc = request.getParameter("ruc");
		    ArrayList<Proveedor> lista = dao.buscarProveedor(ruc);
		    request.setAttribute("lista", lista);
		    request.getRequestDispatcher("listadoProveedor.jsp").forward(request, response);
		}
		if ("BuscarVenta".equals(accion)) {
		    int idVenta = Integer.parseInt(request.getParameter("idVenta"));
		    ArrayList<Venta> lista = dao.buscarVentaPorId(idVenta);
		    request.setAttribute("lista", lista);
		    request.getRequestDispatcher("listadoVentas.jsp").forward(request, response);
		}
		if ("ActualizarUsuario".equals(accion)) {
		    Usuario u = new Usuario();
		    u.setId_usuario(Integer.parseInt(request.getParameter("id")));
		    u.setUsername(request.getParameter("username"));
		    u.setRol(request.getParameter("rol"));

		    dao.actualizarUsuario(u);
		    response.sendRedirect("Gestionar?accion=Usuario&estado=1");
		}


	}
}