package com.klipsch.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {
	// rv_num_pk, mb_id_pk, pdt_num_pk, rv_content, rv_score, rv_date_reg
	
	private long rv_num_pk;
	private String mb_id_pk;
	private long pdt_num_pk;
	private String rv_content;
	private int rv_score;
	private Date rv_date_reg;
}
