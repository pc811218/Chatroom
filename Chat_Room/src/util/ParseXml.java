package util;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public class ParseXml {
	
	//傳入節點名稱KEY取得對應SQL指令
	public static String getSqlByName (String sqlName) throws Exception {
	     SAXReader reader = new SAXReader();
	     Document   document = reader.read(ParseXml.class.getResource("/Sql.xml"));
	     Element rootElm = document.getRootElement();
	     Element sqlElm = rootElm.element(sqlName);
	     String sqlStr = sqlElm.getText();
		return sqlStr;
	}
}
