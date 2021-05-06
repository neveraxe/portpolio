package com.klipsch.service;

import java.util.List;

import com.klipsch.domain.BoardVO;
import com.klipsch.dto.Criteria;

public interface BoardService {

	public int getTotalCount(Criteria cri) throws Exception;
	
	public List<BoardVO> getListWithSearchPaging(Criteria cri) throws Exception;
	
	public void insert(BoardVO board) throws Exception;
	
	public BoardVO read(long brd_num_pk) throws Exception;
	
	public int update(BoardVO board) throws Exception;
	
	public int delete(long brd_num_pk) throws Exception;
}
