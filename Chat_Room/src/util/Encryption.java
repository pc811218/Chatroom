package util;

import java.math.BigInteger;
import java.security.MessageDigest;

public class Encryption {
	
	
	public static String encrypt(String type,String msg) {
		
		String uppText = new String();
		try {
			MessageDigest md = MessageDigest.getInstance(type);
			byte[] messageDigest = md.digest(msg.getBytes());
			BigInteger number = new BigInteger(1, messageDigest);
			String hashtext = number.toString(16);
			uppText = hashtext.toUpperCase();
		} catch (Exception e) {
			throw new RuntimeException("encrypt failed");
		}
		return uppText;
	}
	
}
