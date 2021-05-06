package com.klipsch.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UserInfoVO {
	
	private String user_id_pk;
	private String user_name;
	private String user_passwd;
	private String user_email;
	private String user_zipcode;
	private String user_addr;
	private String user_addr_d;
	private String user_phone;
	private String user_nick;
	private String user_accept_e;
	private int user_point;
	private Date user_date_sub;
	private Date user_date_upd;
	private Date user_date_last;
	private String user_authcode;
	
}
