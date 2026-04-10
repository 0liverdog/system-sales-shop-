package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import Dao.Dao;

@WebServlet("/CambiarEstado")
public class CambiarEstado extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CambiarEstado() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 Dao dao = new Dao();

	        String tabla = request.getParameter("tabla");
	        String campoId = request.getParameter("campo");
	        int id = Integer.parseInt(request.getParameter("id"));
	        int estado = Integer.parseInt(request.getParameter("estado"));

	        dao.cambiarEstado(tabla, campoId, id, estado);

	        switch (tabla) {
            case "producto":
                response.sendRedirect("Gestionar?accion=Producto&estado=1");
                break;
            case "cliente":
                response.sendRedirect("Gestionar?accion=Cliente&estado=1");
                break;
            case "proveedor":
                response.sendRedirect("Gestionar?accion=Proveedor&estado=1");
                break;
            case "usuario":
                response.sendRedirect("Gestionar?accion=Usuario&estado=1");
                break;
            case "venta":
                response.sendRedirect("Gestionar?accion=Venta&estado=1");
                break;
            default:
                response.sendRedirect("index.jsp");
        }
	}

}
