package config;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class AppInitializer implements ServletContextListener {
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext ctx = sce.getServletContext();
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("[SERVER] oralce connect library load success");

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("[SERVER] ojdbc library load failed");
			System.exit(0);
		}
	}

}
