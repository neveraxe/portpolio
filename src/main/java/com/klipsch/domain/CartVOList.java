package com.klipsch.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class CartVOList {
	
	private long cart_code_pk;
	private String pdt_img;
	private String pdt_name;
	private int cart_amount;
	private long pdt_price;
}
