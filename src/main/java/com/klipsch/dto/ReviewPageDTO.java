package com.klipsch.dto;

import java.util.List;

import com.klipsch.domain.ReviewVO;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ReviewPageDTO {
	
	private int reviewCnt; // 상품후기 개수
	private List<ReviewVO> list; // 상품후기 목록
	
}
