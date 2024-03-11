package com.sku.clubproject.repository;

import com.sku.clubproject.model.ApplicationDTO;
import com.sku.clubproject.model.entity.Application;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ApplicationRepository extends JpaRepository<Application, Long> {

    public List<Application> findAllByClubIdAndIsProcess(Long clubId, int isProcess);

    @Modifying(clearAutomatically = true)
    @Query("UPDATE Application a set a.isProcess=1 WHERE a.id = :applicationId")
    void changeIsProcess(Long applicationId);
}
