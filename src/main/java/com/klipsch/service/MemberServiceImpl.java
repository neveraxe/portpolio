package com.klipsch.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klipsch.domain.BoardVO;
import com.klipsch.domain.MemberVO;
import com.klipsch.domain.UserInfoVO;
import com.klipsch.dto.Criteria;
import com.klipsch.dto.LoginDTO;
import com.klipsch.mapper.MemberMapper;

import lombok.Setter;

@Service // bean name : memberServiceImpl
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Override
	public int checkIdDuplicate(String mb_id_pk) throws Exception {
		// TODO Auto-generated method stub
		return mapper.checkIdDuplicate(mb_id_pk);
	}

	@Override
	public void join(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.join(vo);
	}

	@Override
	public MemberVO login_ok(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
				
		return mapper.login_ok(dto);
	}

	@Override
	public MemberVO member_info(String mb_id_pk) throws Exception {
		// TODO Auto-generated method stub
		return mapper.member_info(mb_id_pk);
	}

	@Override
	public boolean modifyPOST(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mapper.modifyPOST(vo) == 1;
	}

	@Override
	public String find_id(String mb_name) throws Exception {
		// TODO Auto-generated method stub
		return mapper.find_id(mb_name);
	}

	@Override
	public MemberVO find_pwd(String mb_id_pk, String mb_name) throws Exception {
		// TODO Auto-generated method stub
		return mapper.find_pwd(mb_id_pk, mb_name);
	}

	@Override
	public void deleteUser(String mb_id_pk) throws Exception {
		// TODO Auto-generated method stub
		mapper.deleteUser(mb_id_pk);
	}

	@Override
	public List<UserInfoVO> userinfo_list() throws Exception {
		// TODO Auto-generated method stub
		return mapper.userinfo_list();
	}

	@Override
	public int getTotalCount(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardVO> getListWithSearchPaging(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getListWithSearchPaging(cri);
	}

	@Override
	public void update_pw(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		mapper.update_pw(dto);
	}


	
	

	

	
	
	

	

	

	
}
