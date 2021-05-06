package com.klipsch.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@ToString
@Setter
@Getter
public class Criteria { // DTO클래스 : 테이블에 매핑과는 상관없이 데이터를 전달 목적으로 사용하는 클래스
	
	// 이 공식DTO 게시판 코딩은 한순간에 만들어진게 아니고 수많은 프로그래머가 만들어낸것
	// 우리는 이 공식을 암기해 버리는 것 (그게 스프링 코딩)
	// 이 코딩 구조를 외우면 실무에서 사용할 수 있으나 실무에서 안쓸수도 있다.
	
	private int pageNum; // 페이지번호를 저장하는 클래스 1 2 3 4 5
	private int amount; //페이지마다 출력될(보여줄) 게시물 개수(예> 10개)
	
	// 항상 변수를 사용하는 용도를 정확히 기억해야 한다.
	// 검색종류
	// 검색방법?
	// 1)단일항목검색 제목(T), 내용(C), 작성자(W)
	// 2)다중항목검색 제목(T), 내용(C), 작성자(W), 제목+내용(TC), 제목+작성자(TW), 제목+내용+작성자(TCW)
	private String type; // 혼합 검색어 정보로 들어갈때 mapper 파일에서 편하게 가져다 쓰기 위해 스트링 배열로 읽어온다. 
	private String keyword; // 검색어
	
	
	public Criteria() {
		this(1, 3);
	}

	public Criteria(int pageNum, int amount) {
		// TODO Auto-generated constructor stub
		this.pageNum = pageNum;
		this.amount = amount;
		
	}
	
	/*
	public String getType() {
		return type;
	}
	*/
	
	public String[]getTypeArr() {
		
//		System.out.println("검색: " + type);
		
//		return type == null? new String[] {} :type.split("");
		
//		System.out.println("검색: " + str.length);
		return type == null? new String[] {} :type.split("");
	}
	
	
	/*
	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}
	*/
	
}
