package com.klipsch.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.klipsch.domain.CartVOList;
import com.klipsch.domain.OrderDetailListVO;
import com.klipsch.domain.OrderDetailVO;
import com.klipsch.domain.OrderVO;
import com.klipsch.dto.Criteria;
import com.klipsch.dto.OrderSaleDTO;
import com.klipsch.dto.PageDTO;
import com.klipsch.mapper.CartMapper;
import com.klipsch.mapper.OrderMapper;

import lombok.Setter;

@Service
public class OrderServiceImpl implements OrderService {

	@Setter(onMethod_ = @Autowired)
	private OrderMapper orderMapper;
	
	@Setter(onMethod_ = @Autowired)
	private CartMapper cartMapper;
	
	@Transactional // 트랜잭션 처리
	@Override
	public void order_buy(OrderVO vo, String mb_id_pk) throws Exception {
		// TODO Auto-generated method stub
		
		orderMapper.order_add(vo);
		orderMapper.orderDetail_add(vo.getOdr_code_pk(), mb_id_pk);
		cartMapper.cartAll_delete(mb_id_pk);
	}

	@Override
	public void orderDirect_buy(OrderVO vo, OrderDetailVO vo2) throws Exception {
		// TODO Auto-generated method stub
		orderMapper.order_add(vo);
		vo2.setOdr_code_pk(vo.getOdr_code_pk());
		orderMapper.orderDirect_add(vo2);
	}

	@Override
	public List<OrderVO> orderInfo_list(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.orderInfo_list(cri);
	}

	@Override
	public int getTotalCountOrder(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.getTotalCountOrder(cri);
	}

	@Override
	public List<OrderDetailListVO> order_detail_list(long odr_code_pk) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.order_detail_list(odr_code_pk);
	}

	@Override
	public List<OrderSaleDTO> order_sale(String startDate, String endDate) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.order_sale(startDate, endDate);
	}

	@Override
	public void orderDelete(Long odr_code_pk) throws Exception {
		// TODO Auto-generated method stub
		orderMapper.orderDelete(odr_code_pk);
	}


	

	

	
	

	

	

}
