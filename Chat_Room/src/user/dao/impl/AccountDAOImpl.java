package user.dao.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import user.dao.AccountDAO;
import util.ParseXml;

@Service("AccountDAO")
public class AccountDAOImpl implements AccountDAO {
	
	@Resource(name="jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	@Override
	public List<Map<String, Object>> getAccountByName(String account, String password) throws Exception {
		List<Map<String, Object>> results = 
			    (List<Map<String, Object>>) jdbcTemplate.queryForList(
			    		ParseXml.getSqlByName("Account.checkAccount"),account,password);
		return results;
	}

	@Override
	public int InsertOneData(String account, String password, String name) throws Exception {
		int upd = jdbcTemplate.update(ParseXml.getSqlByName("Account.addAccount"),
				account,password, name);
		return upd;
	}

}
