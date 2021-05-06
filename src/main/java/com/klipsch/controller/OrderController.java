package com.klipsch.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.klipsch.domain.CartVOList;
import com.klipsch.domain.MemberVO;
import com.klipsch.domain.OrderDetailVO;
import com.klipsch.domain.OrderVO;
import com.klipsch.domain.ProductVO;
import com.klipsch.service.CartService;
import com.klipsch.service.OrderService;
import com.klipsch.service.UserProductService;
import com.klipsch.util.FileUploadUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/order/*")
public class OrderController {
	
	@Setter(onMethod_ = @Autowired)
	private CartService cartService;
	
	@Setter(onMethod_ = @Autowired)
	private OrderService orderService;
	
	@Setter(onMethod_ = @Autowired)
	private UserProductService userProductService;
	
	// 웹 프로젝트 영역 외부에 파일을 저장할 때 사용할 경로
	@Resource(name="uploadPath")
	private String uploadPath; // servlet-context.xml에 설정
	
//	@PostMapping("/order")
//	@GetMapping("/order") // @RequestParam
	
	// @RequestParam(required = false) : get요청에 의한 해당 쿼리스트링이 존재하지 않아도 처리하고자 할때 사용 (예외발생이 안됨)
	
	
	@RequestMapping(value = "/order", method = {RequestMethod.GET, RequestMethod.POST})
	public void order(HttpSession session, @ModelAttribute("type") String type, @RequestParam(required = false) Long pdt_num_pk, @RequestParam(required = false) Integer odr_amount, Model model) throws Exception {
		
		// type : 1-즉시구매(장바구니 사용안함), 2-장바구니 기반으로 주문하기  		
		
		// 사용자별 장바구니 내역
		String mb_id_pk = ((MemberVO) session.getAttribute("loginStatus")).getMb_id_pk();
		
		if(type.equals("1")) {
			// 즉시구매
			log.info("즉시구매" + type);
			
			// 구매상품에 대한 정보를 표시
			ProductVO vo = userProductService.getProductByNum((long) pdt_num_pk);
			
			// 즉시구매시 상품상세정보를 폼에 삽입하기 위한 Model작업
			model.addAttribute("pdt_num_pk", pdt_num_pk);
			model.addAttribute("odr_amount", odr_amount);
			model.addAttribute("odr_price", vo.getPdt_price());
			
			// 매개변수가 있는 생성자를 만들어서, 디폴트생성자 처리해 줄것
			CartVOList cartvo = new CartVOList(0, vo.getPdt_img(), vo.getPdt_name(), (int) odr_amount, vo.getPdt_price());
			
			List<CartVOList> cartvoList = new ArrayList<CartVOList>();
			cartvoList.add(cartvo);
			
			model.addAttribute("cartVOList", cartvoList);
			
		} else if(type.equals("2")) {
			log.info("장바구니 기반으로 구매" + type);
			// 구매상품을 장바구니에서 가져와서 표시
			model.addAttribute("cartVOList", cartService.list_cart(mb_id_pk));
			
			// 사용하지 않는 값이지만 에러발생이 되므로 형식만 유지를 했음 0값으로 OrderDetailVO vo2 파라미터
			model.addAttribute("pdt_num_pk", 0);
			model.addAttribute("odr_amount", 0);
			model.addAttribute("odr_price", 0);
		}
		
		// 주문 입력폼 구성작업
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		
		return FileUploadUtils.getFile(uploadPath, fileName);
	}
	
	
	// order.jsp에서 type파라미터 정보를 받아야야 즉시구매, 장바구니를 통한 구매를 분기작업을 할수가 있다.
	@PostMapping("/order_buy")
	public String order_buy(OrderVO vo, OrderDetailVO vo2, String type, HttpSession session) throws Exception {
		
		log.info("order_buy" + vo);
		
		String mb_id_pk = ((MemberVO) session.getAttribute("loginStatus")).getMb_id_pk();
		vo.setMb_id_pk(mb_id_pk);// 세션된 로그인 아이디를 vo에 집어 넣어주는 작업
		
		if(type.equals("1")) {
			
			log.info("order: " + vo);
			log.info("orderDetail: " + vo2);
			
			// 장바구니 테이블은 제외(즉시구매이므로 장바구니에 상품을 저장안함)
			// 주문, 주문상세테이블 작업 : pdt_num_pk, odr_amount, odr_price
			// 즉시구매한 상품구성 해줄 것
			orderService.orderDirect_buy(vo, vo2); // 즉시구매한 상품구성 해줄 것
			
		} else if(type.equals("2")) {
			// 주문, 주문상세, 장바구니 
			orderService.order_buy(vo, mb_id_pk);
		}
		
		
		return "redirect:/";
	}
	
	
	
	
	
}
