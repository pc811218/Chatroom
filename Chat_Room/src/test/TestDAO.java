package test;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import user.dao.AccountDAO;


/**
 * Servlet implementation class TestDAO
 */
@WebServlet("/TestDAO")
public class TestDAO extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public TestDAO() {
        super();
        
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
//		request.setCharacterEncoding("UTF-8");
//		response.setCharacterEncoding("UTF-8");
		WebApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(this.getServletContext());
//		AccountDao  dao = (AccountDaoImpl)context.getBean("accountDao");
		AccountDAO dao = (AccountDAO) context.getBean("AccountDAO");

		
		try {
			
			
			List<Map<String, Object>> list = dao.getAccountByName("pc811218", "pc27856395");
			out.println(list);
			
//			Map<String, Object> map = svc.checkAccount("abc123", "123456");
//			out.println(map);
//			Date.valueOf("2017-02-02");
//			int u = dao.InsertOneData("fgh555", "123123", "gary", Date.valueOf("2017-02-02"), "0911222111");
//			out.print(u);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
