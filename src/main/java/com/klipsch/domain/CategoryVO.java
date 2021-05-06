package com.klipsch.domain;

import lombok.Data;

@Data
public class CategoryVO {
	
	/*
	CREATE TABLE CATEGORY_TBL (
		    CG_CODE_PK       	VARCHAR2(20)        	PRIMARY KEY, -- 현재 카테고리(기본키) (2차)
		    CG_CODE_PRI       	VARCHAR2(20),                        -- 상위 카테고리  (1차)                
		    CG_NAME           	VARCHAR2(50)         	NOT NULL     -- 카테고리명
		);
	*/
	
	private String cg_code_pk;
	private String cg_code_pri;
	private String cg_name;
	
	
}
