package com.sku.clubproject.service;

import com.sku.clubproject.model.BoardDTO;
import com.sku.clubproject.model.entity.Board;
import com.sku.clubproject.repository.BoardRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BoardService {
    @Autowired
    private BoardRepository boardRepository;

    @Autowired
    private ModelMapper modelMapper;

    //동아리 부원 모집하는 게시글(isJoin=1) 또는 활동 내역 게시글(isJoin=0) list return
    public List<BoardDTO> selectAllBoardByJoin(int isJoin){
        List<Board> board = boardRepository.findAllByIsJoin(isJoin);
        List<BoardDTO> resultBoard = board.stream()
                .map(data -> modelMapper.map(data, BoardDTO.class))
                .toList();

        return resultBoard;
    }

    //게시글 id 주면 boardDTO 리턴
    public BoardDTO selectOneBoard(Long boardId){
        Optional<Board> board = boardRepository.findById(boardId);

        if(board.isPresent()){
            return modelMapper.map(board.get(), BoardDTO.class);
        }
        return null;
    }


    //하나의 동아리가 쓴 게시글. isJoin=0이면 활동 내역, isJoin=1이면 모집글
    public List<BoardDTO> selectAllClubBoard(Long clubId, int isJoin){
        List<Board> board = boardRepository.findAllByClubIdAndIsJoin(clubId, isJoin);

        return board.stream()
                .map(data -> modelMapper.map(data, BoardDTO.class))
                .toList();
    }
    
    //새 게시물 등록
    public void createBoard(BoardDTO boardDTO){
        boardRepository.save(modelMapper.map(boardDTO, Board.class));
    }

    public void deleteBoard(Long boardId){
        boardRepository.deleteById(boardId);
    }

}
