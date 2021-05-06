package com.klipsch.service;

import com.klipsch.domain.ReviewVO;
import com.klipsch.dto.Criteria;
import com.klipsch.dto.ReviewPageDTO;

public interface ReviewService {
	
	public ReviewPageDTO getReviewListWithPaging(Criteria cri, Long pdt_num_pk) throws Exception;
	
	public void review_register(ReviewVO vo) throws Exception;
	
	public void review_modify(ReviewVO vo) throws Exception;
	
	public void review_delete(long rv_num_pk) throws Exception;
}
