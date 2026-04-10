package DataBase;

import java.sql.Connection;
import java.sql.DriverManager;

public class BaseDatos {
    Connection con=null;
    public Connection Conectar()
    {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url,usur,pwd,bd;
            bd="bd_tambo"; usur="root"; pwd="usbw";
            url="jdbc:mysql://localhost:3307/"+bd+"?useSSL=false&allowPublicKeyRetrieval=true";
            con=DriverManager.getConnection(url,usur,pwd);
            System.out.println("Conectado ok..");
        } catch (Exception e) {
            System.out.println("Error:"+e);
        }
        return con;
    }
    public static void Cerrar(Connection con)
    {
        if (con!=null)
            try {con.close();
                System.out.println("Cerrando bd");
            } catch (Exception e) {
                System.out.println("Error:"+e);
            }
    }
}