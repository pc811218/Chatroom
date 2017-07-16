package user.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import user.service.UserService;
import util.Encryption;

@Controller
public class UserController {
	
	@Resource(name="UserService")
	private UserService userService;
	
    private static final String accountRex = "^[A-Za-z][\\w\\.]{5,11}$"; //英文開頭、後面接英文/數字/_(6~12)
    private static final String passwordRex = "^[A-Za-z0-9@_]{6,12}$"; //英文/數字(6~12)
    private static final String nameRex = "^[A-Za-z\\u4e00-\\u9fa5]{2,10}$"; //英文/中文(2~10)
	
	// 處理登入動作
	@RequestMapping("/login.do")
	public ModelAndView handleLogin(HttpServletRequest req,
			HttpServletResponse resp) throws Exception {
		
		String name = req.getParameter("userName");
		String password = req.getParameter("password");
		
		// 檢核使用者登入帳密
		//去除空白
		name = name.trim();
		password = password.trim();
		
		//判斷是否為有輸入
		if(name.length()!=0&&password.length()!=0){
			//把輸入的密碼轉換為MD5
			String pswdMD5 = Encryption.encrypt("MD5", password);
			//用轉換後的密碼去資料庫比對
			Map<String, Object> resultMap = userService.checkAccount(name, pswdMD5);
			//帳密正確 resultMap有抓到東西
			if(resultMap!=null){
				req.getSession().setAttribute("Authorise", 1);
				req.getSession().setAttribute("uesrInfo", resultMap);
				return new ModelAndView("room_page","name",resultMap.get("name"));
			//帳密錯誤
			} else{
				return new ModelAndView("login","errMsg","不存在的帳號或密碼有誤!");
			}
			
		//沒有輸入任何值
		} else{
			return new ModelAndView("login","errMsg","帳號或密碼不可為空白");
			
		}
	}
	
	//處理註冊
    @RequestMapping("/regist.do")
    public ModelAndView handleRegist(HttpServletRequest req,
			HttpServletResponse res) throws Exception {
    		
    		req.setCharacterEncoding("utf-8");
    		
    		//用來存放錯誤的
    		List<String> errMsg = new ArrayList<String>(); 
    		
    		String account = req.getParameter("account");
    		String password = req.getParameter("password");
    		String name = req.getParameter("name");
    		
    		//去除空白
    		account = account.trim();
    		password = password.trim();
    		name = name.trim();
    		


    		
    		if(account.length()==0||!account.matches(accountRex))
    			errMsg.add("帳號不符合規定");
    		if(password.length()==0||!password.matches(passwordRex))
    			errMsg.add("密碼不符合規定");
    		if(name .length()==0||!name.matches(nameRex))
    			errMsg.add("姓名不符合規定");

    		//errMsg.add("test不符合規定");
    		//errMsg.add("test2不符合規定");
    		
    		
    		//####若有錯，返回給login，顯示錯誤####
    		if(!errMsg.isEmpty())
    			return new ModelAndView("login","error",errMsg);
    		
    		
    		//+++++資料無誤-開始新增++++++
    		int udp = userService.addAccount(account, password, name);
    		
    		
    		
    	return new ModelAndView("login","isRegistOK",udp);
    }
}
