package com.klipsch.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klipsch.domain.CartVO;
import com.klipsch.domain.CartVOList;
import com.klipsch.dto.CartDTO;

public interface CartMapper {
	
	public void add_cart(CartVO vo) throws Exception;
	
	public List<CartVOList> list_cart(String mb_id_pk) throws Exception;
	
	public void cart_delete(long cart_code_pk) throws Exception;
	
	public void cart_update(@Param("cart_code_pk") long cart_code_pk, @Param("cart_amount") int cart_amount) throws Exception;
	
	public void cartAll_delete(String mb_id_pk) throws Exception;
	
	public void cart_check_delete(List<Integer> checkArr) throws Exception;
	
	public List<CartDTO> cart_money() throws Exception;
	
	public void cart_not_check_delete(List<Integer> checkArr) throws Exception;
	
	
}
