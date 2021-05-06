package com.klipsch.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	
	// brd_num_pk, mb_id_pk, brd_title, brd_content, brd_date_reg
	
	private long brd_num_pk;
	private String mb_id_pk;
	private String brd_title;
	private String brd_content;
	private Date brd_date_reg;
	
}
