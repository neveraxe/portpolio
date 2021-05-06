package com.klipsch.service;

import com.klipsch.dto.EmailDTO;

public interface EmailService {

	public void sendMail(EmailDTO dto, String message);
}
