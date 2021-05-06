package com.klipsch.domain;

import lombok.Data;

@Data
public class OrderDetailListVO {
	
	// od.odr_code_pk, od.pdt_num_pk, od.odr_amount, od.odr_price, p.pdt_name, p.pdt_img
	
	private long odr_code_pk; // 시퀀스
	private long pdt_num_pk; 
	private int odr_amount;
	private int odr_price;
	
	private String pdt_name;
	private String pdt_img;
	
}
