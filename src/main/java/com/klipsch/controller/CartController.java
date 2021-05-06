package com.klipsch.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.klipsch.domain.CartVO;
import com.klipsch.domain.MemberVO;
import com.klipsch.dto.CartDTO;
import com.klipsch.service.CartService;
import com.klipsch.util.FileUploadUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/cart/*") // 공통주소로 사용 또는 jsp 폴더명 경로로 사용
public class CartController {
	
	@Setter(onMethod_ = @Autowired)
	private CartService cartService;
	
	
	// 웹 프로젝트 영역 외부에 파일을 저장할 때 사용할 경로
	@Resource(name="uploadPath")
	private String uploadPath; // servlet-context.xml에 설정
	
	@ResponseBody
	@PostMapping("/add")
	public ResponseEntity<String> cart_add(Long pdt_num_pk, int pdt_amount, HttpSession session, HttpServletResponse response) throws Exception{
		
		// log.info("cart_add: " + pdt_num_pk);
		// log.info("cart_add: " + pdt_amount);
		

		ResponseEntity<String> entity = null;
		
		if(session.getAttribute("loginStatus") == null) {
			entity = new ResponseEntity<String>("LoginRequired", HttpStatus.OK);
			
			return entity;
			//response.sendRedirect("/member/login");
		}
		
		// loginStatus(세션 작업)
		
		MemberVO vo = (MemberVO) session.getAttribute("loginStatus");
		
		CartVO cart = new CartVO(0, pdt_num_pk, vo.getMb_id_pk(), pdt_amount); 
		
		log.info("card_add: " + cart);
		
		try {
			cartService.add_cart(cart);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@GetMapping("/cart_list")
	public void cart_list(HttpSession session, Model model) throws Exception{
		
		log.info("cart_list");
		
		String mb_id_pk = ((MemberVO) session.getAttribute("loginStatus")).getMb_id_pk();
		model.addAttribute("cartVOList", cartService.list_cart(mb_id_pk));  	
	}
	
	@ResponseBody
	@RequestMapping(value = "/displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		
		return FileUploadUtils.getFile(uploadPath, fileName);
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public ResponseEntity<String> cart_delete(long cart_code_pk) throws Exception {
		
		ResponseEntity<String> entity = null;
		
		// 개별작업 처리
		cartService.cart_delete(cart_code_pk);
		try {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@ResponseBody
	@PostMapping("/cart/modify")
	public ResponseEntity<String> cart_update(long cart_code_pk, int cart_amount) throws Exception {
		
		ResponseEntity<String> entity = null;
				
		try {
			cartService.cart_update(cart_code_pk, cart_amount);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	@ResponseBody
	@PostMapping("/deleteAll")
	public ResponseEntity<String> cart_deleteAll(HttpSession session) throws Exception {
		
		ResponseEntity<String> entity = null;
		
		// 개별작업 처리
		String mb_id_pk = ((MemberVO) session.getAttribute("loginStatus")).getMb_id_pk();
		
		try {
			cartService.cartAll_delete(mb_id_pk);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@PostMapping("/cart_check_delete")
	@ResponseBody
	public ResponseEntity<String> cart_check_delete(@RequestParam("checkArr[]") List<Integer> checkArr) throws Exception{
		
		log.info("cart_check_delete: " + checkArr);
		
		ResponseEntity<String> entity = null;
	
		try {
			cartService.cart_check_delete(checkArr);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception ex) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	
	// 선택상품만 주문(선택안한거 장바구니 삭제)
	@PostMapping("/cart_check_order")
	@ResponseBody
	public ResponseEntity<String> cart_check_order(@RequestParam("checkArr[]") List<Integer> checkArr) throws Exception{
		
		log.info("cart_check_order: " + checkArr);
		
		ResponseEntity<String> entity = null;
	
		try {
			cartService.cart_not_check_delete(checkArr);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception ex) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	

	
	@GetMapping("/chart_sample")
	public void chart_sample(Model model) {
		
		List<CartDTO> items = new ArrayList<CartDTO>();
		
		Random random = new Random();
		
		for(int i=1; i<=5; i++) {
			CartDTO cart = new CartDTO();
			int price = random.nextInt(10000 - 1000 + 1) + 1000;
			cart.setAmount(price);
			cart.setPdt_name("전자제품" + i);
			
			items.add(cart);
		}
		/*
		 pie chart sample data
		 
		 [
          ['상품명', '가격'],
          ['전자제품1', 15000],
          ['전자제품2', 25000],
          ['전자제품3', 18000],
          ['전자제품4', 16500],
          ['전자제품5', 25000]
        ] 
		 		  
		 */
		
		
		int num = 0;
		String str = "[";
		str += "['상품명', '가격'],";
		for(CartDTO dto : items) {
			str += "['";
			str += dto.getPdt_name();
			str += "',";
			str += dto.getAmount();
			str += "]";
			
			num++;
			if(num<items.size()) str += ",";
		}
		
		str += "]";
		
		log.info(str);
		
		model.addAttribute("chartData", str);
	}
	
	
}
