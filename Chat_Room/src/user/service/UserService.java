package user.service;

import java.util.Map;

public interface UserService {
	public Map<String, Object> checkAccount(String name, String password) throws Exception;
	public int addAccount(String account, String password,String name) throws Exception;

}
