package user;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.PreparedStatement;

public class hash {
	//해시 변환
	public static String hash_chg(String plaintext, String salt) {
		StringBuilder sb = new StringBuilder();
		String chgtext = plaintext + salt;			//평문 뒤에 salt를 추가하여 chgtext생성
		String coverted = new String();
		try {
			MessageDigest sha = MessageDigest.getInstance("SHA-512");	//해시 변환방식을  SHA-512으로 지정
			sha.update(chgtext.getBytes());								//chgtext를 바이트화 하여 변환
			byte[] digest = sha.digest();						//SHA-512방식으로 변환된 바이트 값을 바이트 배열 digest에 대입
			for (byte b : digest) {								//digest를 10진수의 문자열로 변경하여 sb에 저장
				sb.append(String.format("%02x", b));			
			}
			coverted = salt + sb.toString().toUpperCase();	//해시 변환문 앞에 salt를 추가하여 최종 변환문(coverted)생성
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		return coverted;		//최종 변환문 반환
	}
	
	//salt 생성
	public static String getSalt() {
		
		//1. Random, byte 객체 생성
		SecureRandom  r = new SecureRandom ();
		byte[] salt = new byte[20];
		
		//2. 난수 생성
		r.nextBytes(salt);
		
		//3. byte To String (10진수의 문자열로 변경)
		StringBuffer sb = new StringBuffer();
		for(byte b : salt) {
			sb.append(String.format("%02x", b));
		};
		
		return sb.toString().toUpperCase();
	}
	
}
