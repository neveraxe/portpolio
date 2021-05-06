package com.klipsch.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.klipsch.domain.AdminVO;
import com.klipsch.domain.BoardVO;
import com.klipsch.domain.MemberVO;
import com.klipsch.dto.AdminDTO;
import com.klipsch.dto.Criteria;
import com.klipsch.dto.PageDTO;
import com.klipsch.service.AdminService;
import com.klipsch.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
public class AdminController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminService adminService;
	
	@Setter(onMethod_ = @Autowired)
	private BoardService boardService;
	
	
	@GetMapping("") 
	public String admin_main() {
		
		return "/admin/admin_login"; // admin.jsp 불러옴
	}
	
	
	
	@PostMapping("/admin_check")
	public String amdin_ok(AdminVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
		
		
		log.info("admin_check: " + vo);
		
		AdminVO adVO = null;
		
		adVO = adminService.login_check(vo);
		
		if(adVO == null) {
			
			rttr.addFlashAttribute("msg", "Fail");
			return "redirect:/admin/";
		}
		
		// 세션인증작업
		session.setAttribute("adLoginStatus", adVO);
		
		return "redirect:/admin/admin_process";
	}
	
	@GetMapping("/admin_process")
	public String admin_process(HttpSession session) {
		
		log.info("admin_process");
		
		String url = "";
		
		if(session.getAttribute("adLoginStatus") == null) {
			url = "redirect:/admin/"; // 관리자로그인 주소
		}else {
			url = "/admin/admin_process"; // 관리자 메뉴 뷰(jsp)
		}
		
		return url; 
	
	}
	
	@PostMapping("/admin_logout")
	public String admin_logout(HttpSession session, RedirectAttributes rttr) {
		
		session.invalidate();
		
		rttr.addFlashAttribute("msg", "logout");
		return "redirect:/admin/";
	}
	
	
	/*
	// 로그인 인증
	@PostMapping(value = "/AdminloginPost")
	public String Adminlogin_ok(AdminDTO dto, RedirectAttributes rttr, HttpSession session) throws Exception {
			
			
			log.info("로그인 ok");
			AdminVO vo = adminService.login_ok(dto);
			
			String result = "loginIDFail"; // "1" : 성공, "2" : 아이디 틀림, "3" : 비번 틀림
			
			if(vo != null) {
				if(vo.getAdmin_pw().equals(dto.getAdmin_pw())) {
					//vo.setMb_passwd("");
					session.setAttribute("AdminloginStatus", vo); // 세션 정보로 인증상태를 저장시키는 구문
					result = "loginSuccess";
					log.info("로그인 success");
				} else {
					result = "loginPWFail";				
				}	
			}
			
			rttr.addFlashAttribute("Adminstatus", result);
			
			return "redirect:/admin/";
		}
		*/
		
		
		@GetMapping("/board/list")
		@RequestMapping(value = "/board/list", method= {RequestMethod.GET, RequestMethod.POST})
		public void list(BoardVO board, @ModelAttribute("cri") Criteria cri, Model model, HttpSession session) throws Exception{
			// Criteria는 자동으로 모델에 추가된다. @ModelAttribute를 사용하지 않아도 되지만 단축성을 위해 추가했다.
			// @ModelAttribute를 빼면 criteria로 사용되고 넣으면 cri라는 이름으로 사용된다.
			// 참조형 파라미터는 내부적으로 스프링에 의하여, 자동으로 기본생성자에 의하여 객체생성이 된다. Criteria cri
			log.info("called list..." + cri);
//			model.addAttribute("list", service.getList()); // 이건 의미가 없어짐
			
			String mb_id_pk = "neveraxe";
			board.setMb_id_pk(mb_id_pk);
			// 1) 게시물 데이터
//			model.addAttribute("list", service.getListWithPaging(cri)); // 리스트 정보
			model.addAttribute("list", boardService.getListWithSearchPaging(cri));
			model.addAttribute("id", board);
			int total = boardService.getTotalCount(cri);
			
			log.info("total: " + total);
			// 2) 페이징 정보
			model.addAttribute("pageMaker", new PageDTO(cri, total));
			
			// View(JSP)에 전달되는 데이터는 1)게시물 데이터 2)페이징정보 (Model로 전달)
			// View에서 사용가능한 model 1) cri 2) list 3) pageMaker
			
			
			
		}
}
