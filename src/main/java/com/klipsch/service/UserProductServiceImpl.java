package com.klipsch.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klipsch.domain.CategoryVO;
import com.klipsch.domain.ProductVO;
import com.klipsch.dto.Criteria;
import com.klipsch.mapper.UserProductMapper;

import lombok.Setter;

@Service
public class UserProductServiceImpl implements UserProductService {

	@Setter(onMethod_ = @Autowired)
	private UserProductMapper userProductMapper;
	
	
	@Override
	public List<CategoryVO> getCategoryList() throws Exception {
		// TODO Auto-generated method stub
		return userProductMapper.getCategoryList();
	}

	@Override
	public List<CategoryVO> getSubCategoryList(String cg_code_pk) throws Exception {
		// TODO Auto-generated method stub
		return userProductMapper.getSubCategoryList(cg_code_pk);
	}

	@Override
	public List<ProductVO> getProductListBysubCate(Criteria cri, String cg_code_pk) throws Exception {
		// TODO Auto-generated method stub
		return userProductMapper.getProductListBysubCate(cri, cg_code_pk);
	}

	@Override
	public int getTotalCountProductBySubCate(String cg_code_pk) throws Exception {
		// TODO Auto-generated method stub
		return userProductMapper.getTotalCountProductBySubCate(cg_code_pk);
	}

	@Override
	public ProductVO getProductByNum(Long pdt_num_pk) throws Exception {
		// TODO Auto-generated method stub
		return userProductMapper.getProductByNum(pdt_num_pk);
	}

	

	

}
