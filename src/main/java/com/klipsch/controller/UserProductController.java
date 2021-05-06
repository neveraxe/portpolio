package com.klipsch.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.klipsch.domain.CategoryVO;
import com.klipsch.domain.ProductVO;
import com.klipsch.dto.Criteria;
import com.klipsch.service.UserProductService;
import com.klipsch.util.FileUploadUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/product/*")
public class UserProductController {
	
	// URL Mapping주소
	// 메서드 : 카테고리정보를 불러와서 Model로 추가한 후 jsp사용
	
	@Setter(onMethod_ = @Autowired)
	private UserProductService userProductService;
	
	// 웹 프로젝트 영역 외부에 파일을 저장할 때 사용할 경로
	@Resource(name="uploadPath")
	private String uploadPath; // servlet-context.xml에 설정
	
	
	@ResponseBody
	@GetMapping("/subCategoryList/{cg_code_pk}")
	public ResponseEntity<List<CategoryVO>> subCategoryList(@PathVariable("cg_code_pk") String cg_code_pk) throws Exception {
		
		log.info("subCategoryList: " + cg_code_pk);
		
		ResponseEntity<List<CategoryVO>> entity = null;
		
		try {
			entity = new ResponseEntity<List<CategoryVO>>(userProductService.getSubCategoryList(cg_code_pk), HttpStatus.OK);
		}catch(Exception e) {
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST); // 잘못된 요청
		}
		
		return entity;
	}
	
	// 2차 카테고리에 의한 상품목록 정보
	@GetMapping("/product_list")
	public String productListBysubCate(@ModelAttribute("cri") Criteria cri, String cg_code_pk, Model model) throws Exception {
		
		log.info("productListBysubCate: " + cg_code_pk);
		
		log.info("productListBysubCate: " + cri);
		
		cri.setAmount(9); // 상품 출력 개수설정
		
		log.info(userProductService.getProductListBysubCate(cri, cg_code_pk).size());
		
		model.addAttribute("productVOList", userProductService.getProductListBysubCate(cri, cg_code_pk));
		
		return "/product/product_list";
	}
	
	// 상품 이미지 뷰
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		
		return FileUploadUtils.getFile(uploadPath, fileName);
		
	}
	
	// 상품상세설명(상품 조회)
	// jsp가 필요하면 model이 필요하다.
	@GetMapping("/product_read")
	public void product_read(@RequestParam("pdt_num_pk") Long pdt_num_pk, Model model) throws Exception {
		
		log.info("product_read: " + pdt_num_pk);
		
		ProductVO vo = userProductService.getProductByNum(pdt_num_pk);
		
		// 기본 이미지를 설정하는 작업(세터로 s_가 빠진 이름으로 변경되서 넣은 값을 vo로)
		vo.setPdt_img(FileUploadUtils.thumbToOriginName(vo.getPdt_img()));		
		
		model.addAttribute("productVO", vo);
		
	}
	
	
}
