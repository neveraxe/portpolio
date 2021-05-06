package com.klipsch.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

// 스프링 기반에서 본작업 들어가기 전에 jdbc oracle driver를 이용한 연동테스트

@Log4j
public class JDBCTests {
	static {
		try {
			// DriverManager객체가 생성이되어 로딩된다.
			Class.forName("oracle.jdbc.OracleDriver");
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		String uid = "klipsch";
		String pwd = "klipsch";
		
		try(Connection con = DriverManager.getConnection(url, uid, pwd)){
			log.info(con);
		}catch(Exception ex) {
			fail(ex.getMessage());
		}
	}
}
