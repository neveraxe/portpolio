package com.klipsch.service;

import com.klipsch.domain.AdminVO;

public interface AdminService {

	// 회원 인증
	public AdminVO login_check(AdminVO vo) throws Exception;
	

}
