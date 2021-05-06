package com.klipsch.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klipsch.domain.ReviewVO;
import com.klipsch.dto.Criteria;

public interface ReviewMapper {
	
	public List<ReviewVO> getReviewListWithPaging(@Param("cri") Criteria cri, @Param("pdt_num_pk") Long pdt_num_pk) throws Exception;
	
	public int getCountByProduct_pdt_num(long pdt_num_pk) throws Exception;
	
	public void review_register(ReviewVO vo) throws Exception;
	
	public void review_modify(ReviewVO vo) throws Exception;
	
	public void review_delete(long rv_num_pk) throws Exception;
}
