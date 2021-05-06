package com.klipsch.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klipsch.domain.OrderDetailListVO;
import com.klipsch.domain.OrderDetailVO;
import com.klipsch.domain.OrderVO;
import com.klipsch.dto.Criteria;
import com.klipsch.dto.OrderSaleDTO;
import com.klipsch.dto.PageDTO;

public interface OrderMapper {
	
	// 주문 정보
	public void order_add(OrderVO vo) throws Exception;
	
	// 주문상세정보(주문내역)
	public void orderDetail_add(@Param("odr_code_pk") long odr_code_pk, @Param("mb_id_pk") String mb_id_pk) throws Exception;
	
	public void orderDirect_add(OrderDetailVO vo) throws Exception;
	
	// 주문 리스트
	public List<OrderVO> orderInfo_list(Criteria cri) throws Exception;
		
	// 주문 상품개수(페이징 기능에 사용)
	public int getTotalCountOrder(Criteria cri) throws Exception;
	
	public List<OrderDetailListVO> order_detail_list(long odr_code_pk) throws Exception;
	
	public List<OrderSaleDTO> order_sale(@Param("startDate") String startDate, @Param("endDate") String endDate) throws Exception;
	
	// 주문 삭제
	public void orderDelete(Long odr_code_pk) throws Exception;

}
