package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import Dao.Dao;
import Entidades.Usuario;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	    String user = request.getParameter("username");
	    String pass = request.getParameter("password");

	    Dao dao = new Dao();
	    Usuario u = dao.login(user, pass);

	    if (u != null) {
	        request.getSession().setAttribute("usuario", u);
	        response.sendRedirect("index.jsp");
	    } else {
	        request.setAttribute("error", "Credenciales incorrectas");
	        request.getRequestDispatcher("login.jsp").forward(request, response);
	    }
	}

}
