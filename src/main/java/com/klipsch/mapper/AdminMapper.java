package com.klipsch.mapper;

import com.klipsch.domain.AdminVO;

public interface AdminMapper {

	public void login_update(String admin_id) throws Exception;
	
	// 로그인 인증
	public AdminVO login_check(AdminVO vo) throws Exception;
	

}
