package com.klipsch.mapper;

import java.util.List;

import com.klipsch.domain.BoardVO;
import com.klipsch.dto.Criteria;

public interface BoardMapper {
	
	public int getTotalCount(Criteria cri) throws Exception;
	
	// 책에 없는 부분 추가
	public List<BoardVO> getListWithSearchPaging(Criteria cri) throws Exception;
	
	// 게시물 등록
	public void insert(BoardVO board) throws Exception;
	
	public BoardVO read(long brd_num_pk) throws Exception;
	
	public int update(BoardVO board) throws Exception;
	
	public int delete(long brd_num_pk) throws Exception;
}
