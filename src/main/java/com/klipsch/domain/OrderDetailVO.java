package com.klipsch.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderDetailVO {
	
	// odr_code_pk, pdt_num_pk, odr_amount, odr_price
	
	private long odr_code_pk; // 시퀀스
	private long pdt_num_pk; 
	private int odr_amount;
	private int odr_price;
	
}
