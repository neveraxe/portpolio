package com.klipsch.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductVO {
	/*
	CREATE TABLE PRODUCT_TBL(
		    PDT_NUM_PK			NUMBER					PRIMARY KEY, -- 상품번호(기본키)
		    CG_CODE				VARCHAR2(20)			NOT NULL, -- 카테고리 코드
		    PDT_NAME			VARCHAR2(50)			NOT NULL, -- 상품명
		    PDT_PRICE			NUMBER					NOT NULL, -- 상품가격
		    PDT_DISCOUNT		NUMBER					NOT NULL, -- 상품 할인율
		    PDT_COMPANY			VARCHAR2(30)			NOT NULL, -- 상품 개발사
		    PDT_DETAIL			CLOB					NOT NULL, -- 상품 상세소개
		    PDT_IMG				VARCHAR2(50)		    NOT NULL, -- 상품 대표이미지
		    PDT_AMOUNT			NUMBER					NOT NULL, -- 상품의 남은수량
		    PDT_BUY				CHAR(1)					NOT NULL, -- 구매가능여부 Y,N
		    PDT_DATE_SUB		DATE DEFAULT SYSDATE	NOT NULL, -- 상품 등록날짜
		    PDT_DATE_UPD		DATE DEFAULT SYSDATE	NOT NULL -- 상품정보 수정날짜
		);
	*/
	private long	pdt_num_pk;
	private String 	cg_code_pk;  // 2차카테고리 코드
	private String 	cg_code_pri; //  1차카테고리 코드(추후 추가)
	private String 	pdt_name;
	private int		pdt_price;
	private int 	pdt_discount;
	private String	pdt_company;
	private String	pdt_detail;
	private String	pdt_img;
	private int		pdt_amount;
	private String 	pdt_buy;
	private Date	pdt_date_sub;
	private Date	pdt_date_upd;
	
	// 업로드 파일
	private MultipartFile file1;  // insert.jsp <input type="file" id="file1" name="file1" class="form-control" />
	
	
}
