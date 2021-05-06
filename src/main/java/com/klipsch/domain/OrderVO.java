package com.klipsch.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderVO {
	
	// odr_code_pk, mb_id_pk, odr_name, odr_zipcode, odr_addr, odr_addr_d, odr_phone, odr_total_price, odr_date
	
	private long odr_code_pk; // 시퀀스
	private String mb_id_pk; // 세션정보참조
	private String odr_name;
	private String odr_zipcode;
	private String odr_addr;
	private String odr_addr_d;
	private String odr_phone;
	private int odr_total_price; // 이부분만 값을 처리해주면 됨(hidden)으로 값 가져옴
	private Date odr_date; // DB(default-sysdate)
	
	
	
}
