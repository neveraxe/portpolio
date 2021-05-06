package com.klipsch.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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

import com.klipsch.domain.BoardVO;
import com.klipsch.domain.MemberVO;
import com.klipsch.domain.OrderDetailListVO;
import com.klipsch.dto.Criteria;
import com.klipsch.dto.EmailDTO;
import com.klipsch.dto.LoginDTO;
import com.klipsch.dto.PageDTO;
import com.klipsch.service.BoardService;
import com.klipsch.service.EmailService;
import com.klipsch.service.MemberService;
import com.klipsch.service.OrderService;
import com.klipsch.util.FileUploadUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {
	
	@Setter(onMethod_ = @Autowired)
	private MemberService service;
	
	@Setter(onMethod_ = @Autowired)
	private EmailService mailService;
	
	@Setter(onMethod_ = @Autowired)
	private OrderService orderService;
	
	@Setter(onMethod_ = @Autowired)
	private BoardService boardService;
	
	private boolean isAuthCheck;
	
	@Inject
	private BCryptPasswordEncoder cryPassEnc;
	
	// 웹 프로젝트 영역 외부에 파일을 저장할 때 사용할 경로
	@Resource(name="uploadPath")
	private String uploadPath; // servlet-context.xml에 설정
	
	
	// 로그인 주소
	@GetMapping("/login")
	public void login() {
		
		log.info("로그인");
	}
	
	// 로그인 인증
	@PostMapping(value = "/loginPost")
	public void login_ok(LoginDTO dto, RedirectAttributes rttr, HttpSession session, Model model) throws Exception {
		
		
		log.info("로그인 ok");
		MemberVO vo = service.login_ok(dto);
		
		if(vo == null) return;
		
		String result = "loginIDFail"; // "1" : 성공, "2" : 아이디 틀림, "3" : 비번 틀림
		
		if(vo != null) { // id 일치
			
			if(cryPassEnc.matches(dto.getMb_passwd(), vo.getMb_passwd())) { // pw 검사 완료
				// dto.getMb_passwd() : 사용자가 입력한 비밀번호
				// vo.getMb_passwd() : DB에서 가져온 비밀번호
				// if(vo.getMb_passwd().equals(dto.getMb_passwd())){ 원래 pw 검사
				// if(cryPassEnc.matches(dto.getMb_passwd(), vo.getMb_passwd()))
				
			
				//vo.setMb_passwd("");
				//session.setAttribute("loginStatus", vo); // 세션 정보로 인증상태를 저장시키는 구문
				
				// 인터셉터에서 참조할 모델작업
				model.addAttribute("memberVO", vo);
				
				result = "loginSuccess";
				log.info("로그인 success");
			} else {
				result = "loginPWFail";	
				return;
			}	
		}
		
		rttr.addFlashAttribute("status", result);
		
		//return "redirect:/";
	}
	
	// 로그아웃 기능(메인 페이지로 다시 돌아온다. "/")
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		
		log.info("logout");
		
		session.invalidate(); // 로그아웃 기능
		
		String result = "logout";
		rttr.addFlashAttribute("status", result);
		
		return "redirect:/";
	}
	
	
	// 회원가입 폼
	@GetMapping("/join")
	public void join() {
		
		log.info("회원가입");
	}
	
	// 회원가입
	@PostMapping("/join")
	public String join(MemberVO vo, RedirectAttributes rttr) throws Exception{
		
		// 인증확인 체크작업
		if(isAuthCheck == false) return "";
		
		// 회원가입시 비밀번호를 암호화 하는 구문
		vo.setMb_passwd(cryPassEnc.encode(vo.getMb_passwd()));		
		
		
		//String result = "";
		service.join(vo);
		
		//result = "insertSuccess"; // 회원가입 완료 팝업
		
		//rttr.addFlashAttribute("status", result);
		
		return "redirect:/"; // 루트 주소로 이동. HomeController 에 있음. home.jsp에서 "msg" 키사용
	}
	
	/* 아이디 중복체크(ajax요청)   /member/checkIdDuplicate  */
	@ResponseBody
	@RequestMapping(value = "/checkIdDuplicate", method=RequestMethod.POST)
	public ResponseEntity<String> checkIdDuplicate(@RequestParam("mb_id_pk") String mb_id_pk) throws Exception {
		
		
		ResponseEntity<String> entity = null;
		try {
			int count = service.checkIdDuplicate(mb_id_pk);
			// count 가 0이면 아이디 사용가능, 1이면 사용 불가능.

			if(count != 0) {
				// 아이디가 존재해서 사용이 불가능.
				entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
			} else {
				// 사용가능한 아이디
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST); // 요청이 문제가 있다.
		}
		
		return entity;
	}
	
	/* 
	 * 이메일 인증 코드 확인   // /member/checkAuthcode
	 * - 입력된 인증 코드와 세션에 저장해 두었던 인증 코드가 일치하는지 확인
	 */
	@ResponseBody
	@RequestMapping(value = "/checkAuthcode", method=RequestMethod.POST)
	public ResponseEntity<String> checkAuthcode(@RequestParam("code") String code, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		try {
			if(code.equals(session.getAttribute("authcode"))) {
				// 인증코드 일치
				entity= new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
				
				session.removeAttribute("authcode");
				
				isAuthCheck = true; // 최종 회원가입시 인증체크 상태 확인
			} else {
				// 인증코드 불일치
				entity= new ResponseEntity<String>("FAIL", HttpStatus.OK);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			entity= new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 회원수정 폼 : DB에서 회원정보를 가져와서 출력
	@GetMapping("/Modify")
	public void reg_edit(HttpSession session, Model model) throws Exception {
		
		// 로그인된 인증된 아이디값 가져오기
		String mb_id_pk = ((MemberVO) session.getAttribute("loginStatus")).getMb_id_pk();
		
		/*
		MemberVO vo = service.member_info(mb_id_pk);
		model.addAttribute("vo", vo);
		*/
		
		//model.addAttribute(service.member_info(mb_id_pk)); // jsp에 전달되는 데이터의 키는? memberVO
		model.addAttribute("vo", service.member_info(mb_id_pk));
	}	
	
	// 회원수정 저장
	@PostMapping("/Modify")
	public String modifyPOST(MemberVO vo, RedirectAttributes rttr, HttpSession session) throws Exception {
		
		log.info("회원수정 완료");
		vo.setMb_passwd(cryPassEnc.encode(vo.getMb_passwd()));
		// service.modifyPOST(vo);
		// result = "modifySuccess";
		
		String result = "";
		
		if(service.modifyPOST(vo) == true) {
			result = "modifySuccess";
		}else {
			result = "modifyFail";
		}
		// status(상태)를 통해 메세지를 주는 구문(rttr)		
		rttr.addFlashAttribute("status", result);
		
		return "redirect:/";
	}
	
	// 회원 삭제
	@GetMapping("/delete")
	public String deletePOST(HttpSession session, RedirectAttributes rttr) throws Exception {
		
		log.info("회원 삭제");
		
		// 로그인된 인증된 아이디값 가져오기
		String mb_id_pk = ((MemberVO) session.getAttribute("loginStatus")).getMb_id_pk(); 
		
		service.deleteUser(mb_id_pk); // 회원삭제
	 	
		session.invalidate(); // 로그아웃
		
		// status(상태)를 통해 메세지를 주는 구문(rttr)
		rttr.addFlashAttribute("status", "Delete_user_success");
		
		return "redirect:/";
	}
	
	// 아이디 찾기 폼
	@GetMapping("/find_id")
	public void find_id() {
		log.info("아이디 찾기");
				
	}
		
	// 아이디 찾기기능(ajax적용) : 화면 출력
	@ResponseBody
	@PostMapping("/find_id")
	public ResponseEntity<String> find_id(@RequestParam("mb_name") String mb_name) throws Exception {
		
		log.info("이름?" + mb_name);
		
		ResponseEntity<String> entity = null;
		
		String mb_id_pk = service.find_id(mb_name);
		
		if(mb_id_pk != null) {
			entity = new ResponseEntity<String>(mb_id_pk, HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}
		
		return entity;
	}
	
	// 비밀번호 찾기 폼(이메일로)
	@GetMapping("/find_pwd")
	public void find_pwd() {
		log.info("비밀번호 찾기");
				
	}
	
	
	
	// 비밀번호 찾기기능(ajax적용)
	@ResponseBody
	@PostMapping("/find_pwd")
	public ResponseEntity<String> find_pwd(@RequestParam("mb_id_pk") String mb_id_pk, @RequestParam("mb_name") String mb_name, EmailDTO dto, Model model) throws Exception{
		
		log.info("아이디?" + mb_id_pk);
		log.info("이름?" + mb_name);
		
		
		ResponseEntity<String> entity = null;
		
		MemberVO vo = service.find_pwd(mb_id_pk, mb_name);
		
		//model.addAttribute("authcodepw", authcodepw);

		//mb_passwd = authcodepw;
		
		
		
		if(vo != null) {
			
			// 메일 발송 작업
			dto.setReceiveMail(vo.getMb_email());
			dto.setSubject("요청하신 비밀번호 입니다.");
			dto.setMessage(mb_id_pk + " 님의 비밀번호입니다.");
			
			String authcodepw = "";
			for(int i=0; i<6; i++) {
				authcodepw += String.valueOf((int)(Math.random()*10));
			}	
			
			// 난수발생시킨 비번을 db에 저장하는 작업 추가
			// db에 저장시킨 변수를 아래에 넣을 것
			// db저장시킬때 암호화시켜서 저장
			
			//String mb_passwd = authcodepw;
			// 암호화는 못시킴
			
			mailService.sendMail(dto, authcodepw); //난수발생한 비밀번호 발송처리하는 구문			
			
			//service.update_pw(mb_id_pk, mb_passwd);			
			
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
			
		}else {
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}
		
		return entity;
	}
	
	
	/*
	@ResponseBody
	@GetMapping("/pw_search") // 비밀번호 찾아 바꾸기 // 화면에 SUCCESS 뜨는 처리
	public ResponseEntity<String> pw_search(String id, EmailDTO email_dto) throws Exception{
	*/
		// id 존재유무
		/*
		 
		id존재하고, 입력했던 email을 사용하여, 임시비번 전송. 암호화하여 비번저장.
		
		*/
	/*
		ResponseEntity<String> entity = null;
		
		LoginDTO dto = new LoginDTO();
		dto.setMb_id_pk(id);
		dto.setMb_passwd("");
		
		MemberVO vo = service.login_ok(dto);
		
		String imsi_pw = "";
		
		if(vo != null) {
			
			//String email = vo.getMb_email();
			
			for(int i=0;i<6;i++) {
				imsi_pw += (char)((Math.random() * 26) + 97);
			}
			
			// 비번 암호화작업
			String enc_pw = cryPassEnc.encode(imsi_pw); // 암호화 작업
			dto.setMb_passwd(enc_pw);
			
			// dto를 파라미터로 하여, 사용자 아이디에 해당하는 비번변경 작업 진행
			// update 회원테이블 set 비번컬럼명 = 암호화된 비번 where 조건식(아이디 일치)
			service.update_pw(dto);
			
			email_dto.setReceiveMail(vo.getMb_email());
			email_dto.setSubject("요청하신 임시비밀번호 입니다.");
			email_dto.setMessage(id + " 님의 비밀번호입니다.");
			
			mailService.sendMail(email_dto, imsi_pw); //난수발생한 비밀번호 발송처리하는 구문
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		}else {
			
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	*/
	
	@GetMapping("/pw_search") // 아이디 찾아 바꾸기 rttr 메세지로 처리
	public String pw_search(String id, EmailDTO email_dto, RedirectAttributes rttr) throws Exception{
	
		
		LoginDTO dto = new LoginDTO();
		dto.setMb_id_pk(id);
		dto.setMb_passwd("");
		
		MemberVO vo = service.login_ok(dto);
		
		String imsi_pw = "";
		
		if(vo != null) {
			
			//String email = vo.getMb_email();
			
			for(int i=0;i<6;i++) {
				imsi_pw += (char)((Math.random() * 26) + 97);
			}
			
			// 비번 암호화작업
			String enc_pw = cryPassEnc.encode(imsi_pw); // 암호화 작업
			dto.setMb_passwd(enc_pw);
			
			// dto를 파라미터로 하여, 사용자 아이디에 해당하는 비번변경 작업 진행
			// update 회원테이블 set 비번컬럼명 = 암호화된 비번 where 조건식(아이디 일치)
			service.update_pw(dto);
			
			email_dto.setReceiveMail(vo.getMb_email());
			email_dto.setSubject("요청하신 임시비밀번호 입니다.");
			email_dto.setMessage(id + " 님의 비밀번호입니다.");
			
			mailService.sendMail(email_dto, imsi_pw); //난수발생한 비밀번호 발송처리하는 구문
			
			String result = "passChange"; 
			rttr.addFlashAttribute("status", result);
			
			
		}
		return "redirect:/";	
	}

	@RequestMapping(value = "/MyPage/MyPageHome", method = {RequestMethod.GET, RequestMethod.POST})
	public void MyPageHome(HttpSession session, Model model) throws Exception {
		
		log.info("MyPageHome");

		String mb_id_pk = ((MemberVO) session.getAttribute("loginStatus")).getMb_id_pk();
		model.addAttribute("vo", service.member_info(mb_id_pk));
		
		
	}	
	
	@RequestMapping(value = "/MyPage/MyPageMenu1", method = {RequestMethod.GET, RequestMethod.POST})
	public void MyPageMenu1(HttpSession session, Model model, @ModelAttribute("cri") Criteria cri, BoardVO board) throws Exception {
		
		log.info("MyPageMenu1");
		
		String mb_id_pk = ((MemberVO) session.getAttribute("loginStatus")).getMb_id_pk();
		model.addAttribute("vo", service.member_info(mb_id_pk));
		
		log.info("주문리스트" + cri);
		
		model.addAttribute("order_list", orderService.orderInfo_list(cri));
		
		int total = orderService.getTotalCountOrder(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	
	}	
	
	@GetMapping("MyPage/order_detail_list")
	@ResponseBody
	public ResponseEntity<List<OrderDetailListVO>> order_detail_list(long odr_code_pk) throws Exception {
		
		ResponseEntity<List<OrderDetailListVO>> entity = null;
		
		try {
			entity = new ResponseEntity<List<OrderDetailListVO>>(orderService.order_detail_list(odr_code_pk), HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<OrderDetailListVO>>(HttpStatus.BAD_REQUEST);
		}
		
		
		return entity;
	}
	
	// 상품 이미지 뷰
		@ResponseBody
		@GetMapping("/displayFile")
		public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
			
			return FileUploadUtils.getFile(uploadPath, fileName);
			
		}
	
	@RequestMapping(value = "/MyPage/MyPageMenu2", method = {RequestMethod.GET, RequestMethod.POST})
	public void MyPageMenu2(HttpSession session, Model model, @ModelAttribute("cri") Criteria cri, BoardVO board) throws Exception {
		
		log.info("MyPageMenu2");

		String mb_id_pk = ((MemberVO) session.getAttribute("loginStatus")).getMb_id_pk();
		model.addAttribute("vo", service.member_info(mb_id_pk));

		log.info("called list..." + cri);
//		model.addAttribute("list", service.getList()); // 이건 의미가 없어짐
		
		
		// 1) 게시물 데이터
//		model.addAttribute("list", service.getListWithPaging(cri)); // 리스트 정보
		model.addAttribute("list", boardService.getListWithSearchPaging(cri));
		int total = boardService.getTotalCount(cri);
		
		log.info("total: " + total);
		// 2) 페이징 정보
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}	
	
	@RequestMapping(value = "/MyPage/MyPageMenu3", method = {RequestMethod.GET, RequestMethod.POST})
	public void MyPageMenu3() throws Exception {
		
		log.info("MyPageMenu3");

	}	
	
	@RequestMapping(value = "/MyPage/MyPageMenu4", method = {RequestMethod.GET, RequestMethod.POST})
	public void MyPageMenu4() throws Exception {
		
		log.info("MyPageMenu4");

	}	
	
	@RequestMapping(value = "/MyPage/MyPageMenu5", method = {RequestMethod.GET, RequestMethod.POST})
	public void MyPageMenu5() throws Exception {
		
		log.info("MyPageMenu5");

	}	
	
}
