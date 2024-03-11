package com.sku.clubproject.service;

import com.sku.clubproject.model.ApplicationDTO;
import com.sku.clubproject.model.entity.Application;
import com.sku.clubproject.repository.ApplicationRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ApplicationService {

    @Autowired
    private ApplicationRepository applicationRepository;

    @Autowired
    private ModelMapper modelMapper;

    //새로운 지원서 db에 저장
    public void createApplication(ApplicationDTO applicationDTO){
        applicationRepository.save(modelMapper.map(applicationDTO, Application.class));
    }

    //clubId에 해당하는 지원서 리스트 반환. isProcess=0이면 미처리된 지원서, isProcess=1이면 이미 처리된 지원서
    public List<ApplicationDTO> showApplicationList(Long clubId, int isProcess){
        List<Application> applicationList = applicationRepository.findAllByClubIdAndIsProcess(clubId, isProcess);

        return applicationList.stream()
                .map(data -> modelMapper.map(data, ApplicationDTO.class))
                .toList();
    }

    //합격, 불합격 처리됨. isProcess=1로 변경
    public void changeIsProcess(Long applicationId){
        applicationRepository.changeIsProcess(applicationId);

    }


}
