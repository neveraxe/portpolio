package com.klipsch.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klipsch.domain.CategoryVO;
import com.klipsch.domain.ProductVO;
import com.klipsch.dto.Criteria;

public interface UserProductService {
	
	// 1차 카테고리
	public List<CategoryVO> getCategoryList() throws Exception;
		
	// 2차 카테고리
	public List<CategoryVO> getSubCategoryList(String cg_code_pk) throws Exception;
	
	// 2차카테고리에 해당하는 상품목록(@Param은 매퍼인터페이스에서만 사용 Service 인터페이스에서는 사용안함)
	public List<ProductVO> getProductListBysubCate(Criteria cri, String cg_code_pk) throws Exception;
		
	public int getTotalCountProductBySubCate(String cg_code_pk) throws Exception;
	
	public ProductVO getProductByNum(Long pdt_num_pk) throws Exception;
}
