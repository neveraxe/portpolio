package com.klipsch.service;

import java.util.List;

import com.klipsch.domain.CategoryVO;
import com.klipsch.domain.ProductVO;
import com.klipsch.dto.Criteria;



public interface AdProductService {

	// 1차 카테고리
	public List<CategoryVO> getCategoryList() throws Exception;
	
	// 2차 카테고리
	public List<CategoryVO> getSubCategoryList(String cg_code_pk) throws Exception;
	
	// 상품 등록
	public void product_insert(ProductVO vo) throws Exception;
	
	// 상품 리스트
	public List<ProductVO> product_list(Criteria cri) throws Exception;
	
	// 상품 개수(페이징기능에 사용)
	public int getTotalCountProduct(Criteria cri) throws Exception;
	
	// 상품 수정폼
	public ProductVO product_modify(Long pdt_num_pk) throws Exception;
	
	// 상품 수정하기
	public void product_modifyOk(ProductVO vo) throws Exception;
	
	// 상품 삭제하기
	public void product_delete(Long pdt_num_pk) throws Exception;
	
}
