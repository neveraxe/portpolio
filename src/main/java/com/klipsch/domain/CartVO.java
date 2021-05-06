package com.klipsch.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@AllArgsConstructor // private 변수에 대한 생성자 메서드가 만들어짐
public class CartVO {
	
	// cart_code, pdt_num_pk, mb_id_pk, cart_amount
	
	private int cart_code_pk;
	private long pdt_num_pk;
	private String mb_id_pk;
	private int cart_amount;
	
}
