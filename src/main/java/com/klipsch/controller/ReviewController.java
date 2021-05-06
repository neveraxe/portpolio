package com.klipsch.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.klipsch.domain.MemberVO;
import com.klipsch.domain.ReviewVO;
import com.klipsch.dto.Criteria;
import com.klipsch.dto.ReviewPageDTO;
import com.klipsch.service.ReviewService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/review/*")
public class ReviewController {
	
	@Setter(onMethod_ = @Autowired)
	private ReviewService reviewService; // @AllArgsConstructor : 모든 필드에 생성자메서드가 생성이 되고 생성자는 어노테이션을 생략하고 자동으로 주입받을 수 있다.
	
	// 상품후기 목록(페이징기능 포함)
	@GetMapping(value = "/pages/{pdt_num_pk}/{page}",
			produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReviewPageDTO> getReviewListPage(@PathVariable("pdt_num_pk") long pdt_num_pk, @PathVariable("page") int page) {
		
		ResponseEntity<ReviewPageDTO> entity = null;
		
		Criteria cri = new Criteria(page, 5); // 상품후기를 1페이지에 5개씩
		
		log.info("상품번호: " + pdt_num_pk);
		log.info("cri :" + cri);
		
		// 상품후기 개수(페이징)
		// 상품후기 목록
		
		try {
			entity = new ResponseEntity<ReviewPageDTO>(reviewService.getReviewListWithPaging(cri, pdt_num_pk), HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			entity = new ResponseEntity<ReviewPageDTO>(HttpStatus.BAD_REQUEST);
		}
		
		
		return entity;
	}
	
	// 상품후기 작성
	@PostMapping(value = "/review_register")
	@ResponseBody // ajax는 리스폰스바디 어노테이션 !!
	public ResponseEntity<String> review_register(ReviewVO vo, HttpSession session) throws Exception{ // @RequestBody json형태의 데이터를 object으로 변환시켜주는 구문
		
		String mb_id_pk =  ((MemberVO) session.getAttribute("loginStatus")).getMb_id_pk();
		vo.setMb_id_pk(mb_id_pk);
		
		log.info("review_register: " + vo);
		
		ResponseEntity<String> entity = null;
		
		try {
			reviewService.review_register(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 상품후기 수정하기
	@PostMapping(value = "/review_modify")
	@ResponseBody // ajax는 리스폰스바디 어노테이션 !!
	public ResponseEntity<String> review_modify(ReviewVO vo) throws Exception{ 
		
		log.info("review_modify: " + vo);
		
		ResponseEntity<String> entity = null;
		
		try {
			reviewService.review_modify(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 상품후기 삭제하기
	@PostMapping(value = "/review_delete")
	@ResponseBody // ajax는 리스폰스바디 어노테이션 !!
	public ResponseEntity<String> review_delete(long rv_num_pk) throws Exception{ 
		
		log.info("review_modify: " + rv_num_pk);
		
		ResponseEntity<String> entity = null;
		
		try {
			reviewService.review_delete(rv_num_pk);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
