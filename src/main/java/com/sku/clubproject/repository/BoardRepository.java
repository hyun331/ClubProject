package com.sku.clubproject.repository;

import com.sku.clubproject.model.entity.Board;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BoardRepository extends JpaRepository<Board, Long> {

    //모든 동아리 모집글 return
    public List<Board> findAllByIsJoin(int isJoin);

    public List<Board> findAllByClubIdAndIsJoin(Long clubId, int isJoin);
}
