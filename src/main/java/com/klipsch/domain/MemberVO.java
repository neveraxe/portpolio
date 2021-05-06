package com.klipsch.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	/*
	MB_ID_PK			VARCHAR2(15)			PRIMARY KEY, -- 회원아이디(기본키)
    MB_NAME             VARCHAR2(30)			NOT NULL, -- 회원이름
	MB_PASSWD           VARCHAR2(15)			NOT NULL, -- 회원비밀번호
    MB_EMAIL            VARCHAR2(50)			NOT NULL, -- 이메일주소
    MB_ZIPCODE         	CHAR(5) 				NOT NULL, -- 우편번호
    MB_ADDR             VARCHAR2(50)			NOT NULL, -- 기본주소
    MB_ADDR_D           VARCHAR2(50)			NOT NULL, -- 상세주소
    MB_PHONE            VARCHAR2(15)			NOT NULL, -- 전화번호
    MB_NICK             VARCHAR2(20)			NOT NULL UNIQUE, -- 닉네임(중복허용 안함)
    MB_ACCEPT_E      	CHAR(1)					NOT NULL, -- 메일 수신여부 Y,N
    MB_POINT            NUMBER DEFAULT 0        NOT NULL, -- 기본 적립금 0
    MB_DATE_SUB      	DATE DEFAULT SYSDATE    NOT NULL, -- 가입일
    MB_DATE_UPD        	DATE DEFAULT SYSDATE 	NOT NULL, -- 수정일
    MB_DATE_LAST   	    DATE DEFAULT SYSDATE    NOT NULL -- 최근 접속시간
    MB_AUTHCODE         CHAR(1)  DEFAULT 'N'    NOT NULL
    */
	
	private String mb_id_pk;
	private String mb_name;
	private String mb_passwd;
	private String mb_email;
	private String mb_zipcode;
	private String mb_addr;
	private String mb_addr_d;
	private String mb_phone;
	private String mb_nick;
	private String mb_accept_e;
	private int mb_point;
	private Date mb_date_sub;
	private Date mb_date_upd;
	private Date mb_date_last;
	//private String mb_authcode;
	
}
