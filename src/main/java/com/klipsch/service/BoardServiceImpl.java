package com.klipsch.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klipsch.domain.BoardVO;
import com.klipsch.dto.Criteria;
import com.klipsch.mapper.BoardMapper;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	
	@Override
	public int getTotalCount(Criteria cri) throws Exception{
		// TODO Auto-generated method stub
		return boardMapper.getTotalCount(cri);
	}

	@Override
	public List<BoardVO> getListWithSearchPaging(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.getListWithSearchPaging(cri);
	}

	@Override
	public void insert(BoardVO board) throws Exception{
		// TODO Auto-generated method stub
		boardMapper.insert(board);
	}

	@Override
	public BoardVO read(long brd_num_pk) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.read(brd_num_pk);
	}

	@Override
	public int update(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.update(board);
	}

	@Override
	public int delete(long brd_num_pk) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.delete(brd_num_pk);
	}

}
