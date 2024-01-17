package user;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.PreparedStatement;

public class hash {
	//�ؽ� ��ȯ
	public static String hash_chg(String plaintext, String salt) {
		StringBuilder sb = new StringBuilder();
		String chgtext = plaintext + salt;			//�� �ڿ� salt�� �߰��Ͽ� chgtext����
		String coverted = new String();
		try {
			MessageDigest sha = MessageDigest.getInstance("SHA-512");	//�ؽ� ��ȯ�����  SHA-512���� ����
			sha.update(chgtext.getBytes());								//chgtext�� ����Ʈȭ �Ͽ� ��ȯ
			byte[] digest = sha.digest();						//SHA-512������� ��ȯ�� ����Ʈ ���� ����Ʈ �迭 digest�� ����
			for (byte b : digest) {								//digest�� 10������ ���ڿ��� �����Ͽ� sb�� ����
				sb.append(String.format("%02x", b));			
			}
			coverted = salt + sb.toString().toUpperCase();	//�ؽ� ��ȯ�� �տ� salt�� �߰��Ͽ� ���� ��ȯ��(coverted)����
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		return coverted;		//���� ��ȯ�� ��ȯ
	}
	
	//salt ����
	public static String getSalt() {
		
		//1. Random, byte ��ü ����
		SecureRandom  r = new SecureRandom ();
		byte[] salt = new byte[20];
		
		//2. ���� ����
		r.nextBytes(salt);
		
		//3. byte To String (10������ ���ڿ��� ����)
		StringBuffer sb = new StringBuffer();
		for(byte b : salt) {
			sb.append(String.format("%02x", b));
		};
		
		return sb.toString().toUpperCase();
	}
	
}
