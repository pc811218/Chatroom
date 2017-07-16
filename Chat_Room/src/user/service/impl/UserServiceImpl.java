package user.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import user.dao.AccountDAO;
import user.service.UserService;
import util.Encryption;

@Service("UserService")
public class UserServiceImpl implements UserService {

	@Resource(name = "AccountDAO")
	private AccountDAO accountDAO;

	@Override
	public Map<String, Object> checkAccount(String name, String password) throws Exception {
		List<Map<String, Object>> list = null;
		Map<String, Object> map = null;
		try {
			list = accountDAO.getAccountByName(name, password);
		} catch (Exception e) { 
			//錯誤處理 ， 有問題直接回傳NULL的Map
			return map;
		}
		
		if (list!=null&&list.size()!=0) {
			map = list.get(0);
		}
		
		return map;
	}

	@Override
	public int addAccount(String account, String password, String name) throws Exception {
		int udp = 0;
		
		try {
			//進資料庫前把密碼轉換為MD5加密
			String pswdMD5 = Encryption.encrypt("MD5", password);
			udp = accountDAO.InsertOneData(account, pswdMD5, name);
		} catch (Exception e) {
			//錯誤處理 ， 有問題直接回傳0
			return 0;	
		}
		
		return udp;
	}

}
