package com.end2end.spring.employee.serviceImpl;

import com.end2end.spring.board.dao.BoardDAO;
import com.end2end.spring.board.dto.BoardCategoryDTO;
import com.end2end.spring.board.dto.BoardCtUserDTO;
import com.end2end.spring.commute.dao.CommuteDAO;
import com.end2end.spring.employee.dao.EmployeeDAO;
import com.end2end.spring.employee.dto.*;
import com.end2end.spring.employee.service.EmployeeService;
import com.end2end.spring.mail.dao.MailDAO;
import com.end2end.spring.mail.dto.EmailAddressDTO;
import com.end2end.spring.mail.dto.EmailAddressUserDTO;
import com.end2end.spring.util.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeDAO employeeDAO;
    @Autowired
    private MailDAO mailDAO;
    @Autowired
    private BoardDAO boardDAO;
    @Autowired
    private CommuteDAO commuteDAO;

    @Override
    public EmployeeDTO selectById(String id) {
        // TODO: 해당 id의 사원 출력
        return null;
    }

    @Override
    public EmployeeDetailDTO selectDetailById(String employeeId) {
        // TODO: 해당 id의 사원 상세정보 조회
        return employeeDAO.selectDetailById(employeeId);
    }

    @Override
    public EmployeeDTO  login(LoginDTO dto) {
        String password = SecurityUtil.hashPassword(dto.getPassword());
        dto.setPassword(password);

        return employeeDAO.login(dto);
    }

    @Override
    public void logout() {
        // TODO: 로그아웃
    }

    @Transactional
    @Override
    public void insert(EmployeeDetailDTO dto, MultipartFile file) {
        // 1. 사원 기본 정보 저장
        String hashedPassword = SecurityUtil.hashPassword(dto.getPassword());
        dto.setPassword(hashedPassword);
        EmployeeDTO employeeDTO = EmployeeDTO.builder()
                .departmentId(dto.getDepartmentId())
                .jobId(dto.getJobId())
                .name(dto.getName())
                .email(dto.getEmail())
                .profileImg(dto.getProfileImg())
                .contact("010-1234-1234")
                .build();
        employeeDAO.insert(employeeDTO);
        String employeeId = employeeDTO.getId();

        // 2. 사원 상세 정보 저장
        dto.setId(employeeId);
        employeeDAO.insertDetail(dto);

        // 3. 이메일 주소 등록
        EmailAddressDTO emailAddressDTO = EmailAddressDTO.builder()
                .emailAddress(dto.getEmail())
                .name(dto.getName())
                .build();
        mailDAO.insert(emailAddressDTO);

        // 4. 본인 이메일 사용 등록
        EmailAddressUserDTO emailAddressUserDTO = EmailAddressUserDTO.builder()
                .employeeId(employeeId)
                .emailAddress(dto.getEmail())
                .build();
        mailDAO.insertEmailAddressUser(emailAddressUserDTO);

        // 5. 부서 이메일 등록
        DepartmentDTO departmentDTO = employeeDAO.selectDepartmentById(dto.getDepartmentId());
        // SELECT * FROM DEPARETMENT WHERE ID = 2;
        emailAddressUserDTO.setEmailAddress(departmentDTO.getEmail());
        // email_address_user 팀 이메일 사용 가능하게 사원 추가
        mailDAO.insertEmailAddressUser(emailAddressUserDTO);

        // 6. 전사 게시판 접근 권한 부여
        BoardCategoryDTO boardCategoryDTO = boardDAO.selectCategoryByName("전사 게시판");
        BoardCtUserDTO boardCtUserDTO = BoardCtUserDTO.builder()
                .employeeId(employeeId)
                .boardCtId(boardCategoryDTO.getId())
                .build();
        boardDAO.insertBoardCtUser(boardCtUserDTO);
    }

    @Override
    public boolean idVali(String loginId){
        return employeeDAO.idVali(loginId);
    }

    @Override
    public void update(EmployeeDetailDTO dto) {
        // TODO: 사원 수정
    }

    @Override
    public void deleteById(String id) {
        // TODO: 해당 id의 사원 삭제
    }

    @Override
    public List<EmployeeDTO> selectByDepartmentId(int departmentId) {
        return employeeDAO.selectByDepartmentId(departmentId);
    }

    @Override
    public List<DepartmentDTO> selectAllDepartment() {
        return employeeDAO.selectAllDepartment();
    }

    @Override
    public List<JobDTO> selectAllJob() {
        return employeeDAO.selectAllJob();
    }
}
