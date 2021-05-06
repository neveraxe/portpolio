package com.klipsch.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klipsch.domain.OrderDetailListVO;
import com.klipsch.domain.OrderDetailVO;
import com.klipsch.domain.OrderVO;
import com.klipsch.dto.Criteria;
import com.klipsch.dto.OrderSaleDTO;
import com.klipsch.dto.PageDTO;

public interface OrderService {
	
	// 매퍼와 서비스는 메서드명이 다를 수 있다. 서비스가 여러개의 매퍼를 다룰수 있기 때문에
	public void order_buy(OrderVO vo, String mb_id_pk) throws Exception;
	
	public void orderDirect_buy(OrderVO vo, OrderDetailVO vo2) throws Exception;
	
	// 주문 리스트
	public List<OrderVO> orderInfo_list(Criteria cri) throws Exception;
		
	// 주문 상품개수(페이징 기능에 사용)
	public int getTotalCountOrder(Criteria cri) throws Exception;
	
	public List<OrderDetailListVO> order_detail_list(long odr_code_pk) throws Exception;
	
	public List<OrderSaleDTO> order_sale(String startDate, String endDate) throws Exception;
	
	public void orderDelete(Long odr_code_pk) throws Exception;
}
