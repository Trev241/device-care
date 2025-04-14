import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class EnvInitListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext ctx = sce.getServletContext();

        // Read environment variables
        String dbUrl = System.getenv("DB_URL");
        String dbUser = System.getenv("DB_USER");
        String dbPass = System.getenv("DB_PASSWORD");

        // Optional fallbacks (for local dev/testing)
        if (dbUrl == null) dbUrl = "jdbc:mysql://localhost:3306/device_insurance";
        if (dbUser == null) dbUser = "root";
        if (dbPass == null) dbPass = "root";

        // Set as application-scope attributes
        ctx.setAttribute("dbDriver", "com.mysql.cj.jdbc.Driver");
        ctx.setAttribute("dbUrl", dbUrl);
        ctx.setAttribute("dbUser", dbUser);
        ctx.setAttribute("dbPass", dbPass);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Optional cleanup
    }
}
