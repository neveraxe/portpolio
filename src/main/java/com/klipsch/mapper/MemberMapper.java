package com.klipsch.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klipsch.domain.BoardVO;
import com.klipsch.domain.MemberVO;
import com.klipsch.domain.UserInfoVO;
import com.klipsch.dto.Criteria;
import com.klipsch.dto.LoginDTO;

public interface MemberMapper {
	
	// 아이디 중복체크
	public int checkIdDuplicate(String mb_id_pk) throws Exception;
	
	// 회원가입
	public void join(MemberVO vo) throws Exception;
	
	// 로그인 인증
	public MemberVO login_ok(LoginDTO dto) throws Exception;
	
	// 회원수정 폼
	public MemberVO member_info(String mb_id_pk) throws Exception;
	
	// 회원 수정 저장
	public int modifyPOST(MemberVO vo) throws Exception;
	
	// 아이디 찾기 : 화면출력
	public String find_id(String mb_name) throws Exception;
	
	// 비밀번호 찾기 : 메일전송
	public MemberVO find_pwd(@Param("mb_id_pk") String mb_id_pk, @Param("mb_name") String mb_name) throws Exception;
	
	// 회원 삭제
	public void deleteUser(String mb_id_pk) throws Exception;
	
	// admin 회원목록
	public List<UserInfoVO> userinfo_list() throws Exception;
	
	public int getTotalCount(Criteria cri);
	
	// 책에 없는 부분 추가
	public List<BoardVO> getListWithSearchPaging(Criteria cri);
	
	// 난수발생한 비번 업데이트
	public void update_pw(LoginDTO dto) throws Exception;
	
}
