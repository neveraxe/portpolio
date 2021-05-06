package com.klipsch.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.klipsch.dto.CartDTO;
import com.klipsch.service.CartService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController // @ResponseBody 기본제공해줌
@Log4j
@AllArgsConstructor
@RequestMapping("/admin/chart/*")
public class ChartController {
	
	private CartService cartService;
	/*
	@ResponseBody
	@GetMapping("/chart_example")
	public ResponseEntity<String[][]> getChartData() {
		
		ResponseEntity<String[][]> entity = null;
		
		String[][] chartData = null;
		
		try {
			
			// 장바구니 더미 데이터 준비해서 실행
			//List<CartDTO> items = cartService.cart_money();
			
			// 데이터가 준비가 안되어, 코드로 샘풀데이터 작업
			List<CartDTO> items = new ArrayList<CartDTO>();
			
			Random random = new Random();
			
			for(int i=0; i<5; i++) {
				CartDTO cart = new CartDTO();
				int price = random.nextInt(10000 - 1000 + 1) + 1000;
				cart.setAmount(price);
				cart.setPdt_name("전자제품" + i);
				
				items.add(cart);
			}
			
			JSONArray row = new JSONArray();
			
			// 제목 작업
			JSONObject name = new JSONObject();
			name.put("상품명", "가격");
			row.add(name);
			
			// 데이터 작업
			for(CartDTO dto : items) {
				JSONObject cell = new JSONObject();
				cell.put(dto.getPdt_name(), dto.getAmount());
				
				row.add(cell);
			}
			
			for(int i=0;i<row.size();i++) {
				
			}
			
			
			
			entity = new ResponseEntity<String[][]>(chartData, HttpStatus.OK);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			entity = new ResponseEntity<String[][]>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	*/
	
	// 차트에 사용할 데이터를 2차원 배열형태로 작업하여, String변수에 저장
	//@ResponseBody
	@GetMapping("/chart_example")
	public ResponseEntity<String> getChartData2() {
		
		ResponseEntity<String> entity = null;
		
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
		
		
		
		String str = "[";
		str += "['상품명', '가격']";
		for(CartDTO dto : items) {
			str += "['";
			str += dto.getPdt_name();
			str += "',";
			str += dto.getAmount();
			str += "]";
		}
		
		str += "]";
		
		log.info(str);
		
		
		entity = new ResponseEntity<String>(str, HttpStatus.OK);
		
		
		return entity;
		
	}
	
	@GetMapping("/chartData")
	public ResponseEntity<JSONObject> getChartData() throws Exception{
		
		ResponseEntity<JSONObject> entity = null;
		
		try{
			 entity = new ResponseEntity<JSONObject>(cartService.getChartData(), HttpStatus.OK);
		}catch (Exception e) {
			System.out.println(" 에러            -- ");
			entity =new ResponseEntity<JSONObject>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	@GetMapping("/chart")
	public ModelAndView chart() {
		
		/*
		ModelAndView mv = new ModelAndView();
		mv.setViewName("jsp파일명"); // 뷰
		mv.addObject("memberVO", "db에서 불러온 데이터"); // 모델작업
		
		return mv;
		*/
		return new ModelAndView("/admin/chart/chart");
	}
	
	
	
}
