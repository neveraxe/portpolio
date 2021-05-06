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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.klipsch.domain.BoardVO;
import com.klipsch.domain.MemberVO;
import com.klipsch.dto.Criteria;
import com.klipsch.dto.PageDTO;
import com.klipsch.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
public class BoardController {
	
	@Setter(onMethod_ = @Autowired)
	private BoardService boardService;
	
	
	// 리스트. 주소? /board/list
//		@GetMapping("/list")
		@RequestMapping(value = "/list", method= {RequestMethod.GET, RequestMethod.POST})
		public void list(BoardVO board, @ModelAttribute("cri") Criteria cri, Model model, HttpSession session) throws Exception{
			// Criteria는 자동으로 모델에 추가된다. @ModelAttribute를 사용하지 않아도 되지만 단축성을 위해 추가했다.
			// @ModelAttribute를 빼면 criteria로 사용되고 넣으면 cri라는 이름으로 사용된다.
			// 참조형 파라미터는 내부적으로 스프링에 의하여, 자동으로 기본생성자에 의하여 객체생성이 된다. Criteria cri
			log.info("called list..." + cri);
//			model.addAttribute("list", service.getList()); // 이건 의미가 없어짐
			
			String mb_id_pk = ((MemberVO) session.getAttribute("loginStatus")).getMb_id_pk();
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
		
		// 글쓰기 폼
		@GetMapping("/register")
		public void register() {
			
			log.info("called register...");
		
		}
		
		// 글 저장 -> 리스트
		@PostMapping("/register")
		public String register(BoardVO board, Model model, RedirectAttributes rttr, HttpSession session) throws Exception {
			
			log.info("called register..." + board);			
			String mb_id_pk = ((MemberVO) session.getAttribute("loginStatus")).getMb_id_pk();
			board.setMb_id_pk(mb_id_pk);
			; // 나중에 직접 제작할때 log가 정상적으로 들어오는지 보고 service를 주석을 풀고 사용
			model.addAttribute("id", mb_id_pk);
			
			boardService.insert(board);
			
			// 리다이렉트 주소로 이동하여, 진행되는 뷰(JSP)에서 참조하게 된다.(일회성)
			rttr.addFlashAttribute("result", board.getBrd_num_pk());
//			return "";
			return "redirect:/board/list";
		}
		
		
		@GetMapping({"/get","/modify"})
		public void get(@RequestParam("brd_num_pk") long brd_num_pk, @ModelAttribute("cri") Criteria cri, Model model) throws Exception {
			
			log.info("called get..." + brd_num_pk);
			model.addAttribute("list", boardService.read(brd_num_pk));		
			// 게시물에 해당하는 댓글데이터를 참조할수 있다.
		}
		
		

		// 수정하기 -> 리스트
		@PostMapping("/modify")
		public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr, HttpSession session) throws Exception { 
			// 원래 BoardVO만 있었는데 추후에 Criteria와 RedirectAttributes 추가함
			// 여기서는 @ModelAttribute가 필요없다. 뷰를 보여주지 않으니 필요하지 않다. 단순 주소이동이기 때문에
			log.info("called modify..." + board);
			String mb_id_pk = ((MemberVO) session.getAttribute("loginStatus")).getMb_id_pk();
			board.setMb_id_pk(mb_id_pk);
			boardService.update(board);
			
			// 1) rttr.addFlashAttribute("msg", 값) 
			// 설명> /board/list 주소에서 사용하는 View(JSP)에 데이터를 전달 
			// 내부적으로 세션으로 저장했다가 뷰에서 사용하고 즉시 소멸되는 정보.(일회성)
			
			rttr.addFlashAttribute("result", "modify"); // list.jsp에서 참조
			
			// 2) rttr.addAttribute("msg", 값)
			// 설명> /board/list 주소에 파라미터 형태로 전달.
			
			// /board/list 주소의 메서드에서 참조.
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keword", cri.getKeyword());
			
			
			return "redirect:/board/list"; // 주소이동
		}
		
		// 게시물 삭제 -> 리스트
		@PostMapping("/remove")
		public String remove(@RequestParam("brd_num_pk") long brd_num_pk, Criteria cri, RedirectAttributes rttr, HttpSession session) throws Exception {
			log.info("called remove..." + brd_num_pk);
			
			boardService.delete(brd_num_pk);
			
			rttr.addFlashAttribute("result", "remove");
			
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keword", cri.getKeyword());
			
			
			return "redirect:/board/list";
		}
}
