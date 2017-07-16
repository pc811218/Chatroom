package user.dao;

import java.util.List;
import java.util.Map;

public interface AccountDAO {
	public List<Map<String, Object>> getAccountByName(String account, String passord) throws Exception;
	public int InsertOneData(String account, String password,String name) throws Exception;
}
