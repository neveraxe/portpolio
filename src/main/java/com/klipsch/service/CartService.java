package com.klipsch.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.json.simple.JSONObject;

import com.klipsch.domain.CartVO;
import com.klipsch.domain.CartVOList;
import com.klipsch.dto.CartDTO;

public interface CartService {
	
	public void add_cart(CartVO vo) throws Exception;
	
	public List<CartVOList> list_cart(String mb_id_pk) throws Exception;
	
	public void cart_delete(long cart_code_pk) throws Exception;
	
	public void cart_update(long cart_code_pk, int cart_amount) throws Exception;

	public void cartAll_delete(String mb_id_pk) throws Exception;
	
	public void cart_check_delete(List<Integer> checkArr) throws Exception;
	
	public void cart_not_check_delete(List<Integer> checkArr) throws Exception;
	
	public List<CartDTO> cart_money() throws Exception;
	
	public JSONObject getChartData();
}
