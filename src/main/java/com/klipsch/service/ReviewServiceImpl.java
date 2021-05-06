package com.klipsch.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klipsch.domain.ReviewVO;
import com.klipsch.dto.Criteria;
import com.klipsch.dto.ReviewPageDTO;
import com.klipsch.mapper.ReviewMapper;

import lombok.Setter;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Setter(onMethod_ = @Autowired)
	private ReviewMapper reviewMapper;

	@Override
	public ReviewPageDTO getReviewListWithPaging(Criteria cri, Long pdt_num_pk) throws Exception {
		// TODO Auto-generated method stub
		return new ReviewPageDTO(reviewMapper.getCountByProduct_pdt_num(pdt_num_pk), reviewMapper.getReviewListWithPaging(cri, pdt_num_pk));
	}

	@Override
	public void review_register(ReviewVO vo) throws Exception {
		// TODO Auto-generated method stub
		reviewMapper.review_register(vo);
	}

	@Override
	public void review_modify(ReviewVO vo) throws Exception {
		// TODO Auto-generated method stub
		reviewMapper.review_modify(vo);
	}

	@Override
	public void review_delete(long rv_num_pk) throws Exception {
		// TODO Auto-generated method stub
		reviewMapper.review_delete(rv_num_pk);
	}


	

}
