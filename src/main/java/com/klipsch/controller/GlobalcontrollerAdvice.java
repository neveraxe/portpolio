package com.klipsch.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.klipsch.service.UserProductService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@ControllerAdvice(basePackages = {"com.klipsch.controller"})
@Log4j
public class GlobalcontrollerAdvice {
	
	@Setter(onMethod_ = @Autowired)
	private UserProductService userProductService;
	
	// 여기 모델로 추가된 것은 basePackage에서 선언한 모든 패키지에 적용된다.(1차 카테고리 적용)
	@ModelAttribute
	public void CategoryList(Model model) throws Exception {
		
		log.info("톰캣서비스 시작....");
		
		model.addAttribute("mainCateList", userProductService.getCategoryList());
	}
}
