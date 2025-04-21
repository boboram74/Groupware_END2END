package com.end2end.spring.employee.serviceImpl;

import com.end2end.spring.board.dao.BoardDAO;
import com.end2end.spring.board.dto.BoardCategoryDTO;
import com.end2end.spring.board.dto.BoardCtUserDTO;
import com.end2end.spring.employee.dao.EmployeeDAO;
import com.end2end.spring.employee.dto.*;
import com.end2end.spring.employee.service.EmployeeService;
import com.end2end.spring.mail.dao.MailDAO;
import com.end2end.spring.mail.dto.EmailAddressDTO;
import com.end2end.spring.mail.dto.EmailAddressUserDTO;
import com.end2end.spring.util.SecurityUtil;
import com.end2end.spring.util.Statics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeDAO employeeDAO;
    @Autowired
    private MailDAO mailDAO;
    @Autowired
    private BoardDAO boardDAO;

    @Override
    public EmployeeDTO selectById(String id) {
        return employeeDAO.mypageUpdate(id);
    }

    @Override
    public List<EmployeeDTO> selectAll() {
        return employeeDAO.selectAll();
    }

    @Override
    public EmployeeDetailDTO selectDetailById(String employeeId) {return employeeDAO.selectDetailById(employeeId);}

    @Override
    public EmployeeDTO login(LoginDTO dto) {
        String password = SecurityUtil.hashPassword(dto.getPassword());
        dto.setPassword(password);
        return employeeDAO.login(dto);
    }

    @Transactional
    @Override
    public void insert(EmployeeDetailDTO dto, MultipartFile file) {
        // 1. 사원 기본 정보 저장
        String hashedPassword = SecurityUtil.hashPassword(dto.getPassword());
        dto.setPassword(hashedPassword);
        dto.setEmail(dto.getLoginId() + "@end2end.site");

        EmployeeDTO employeeDTO = EmployeeDTO.builder()
                .departmentId(dto.getDepartmentId())
                .jobId(dto.getJobId())
                .name(dto.getName())
                .email(dto.getEmail())
                .profileImg(dto.getProfileImg())
                .contact(dto.getContact())
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
        DepartmentDTO departmentDTO = mailDAO.selectDepartmentById(dto.getDepartmentId());
        emailAddressUserDTO.setEmailAddress(departmentDTO.getEmail());
        // email_address_user 팀 이메일 사용 가능하게 사원 추가
        mailDAO.insertEmailAddressUser(emailAddressUserDTO);
    }

    @Override
    public void roleUpdate(String id) {
        EmployeeDTO employee = employeeDAO.selectJobById(id);
        int jobId = employee.getJobId();
        String newRole;
        switch (jobId) {
            case 1:
                newRole = "ADMIN";
                break;
            case 2:
            case 3:
                newRole = "TEAM_LEADER";
                break;
            default:
                newRole = "USER";
                break;
        }
        employeeDAO.roleUpdate(id,newRole);
    }

    @Override
    public boolean idVali(String loginId){
        return employeeDAO.idVali(loginId);
    }

    @Transactional
    @Override
    public void update(EmployeeDetailDTO dto, MultipartFile file) {
        EmployeeDTO employeeDTO = EmployeeDTO.builder()
                .id(dto.getId())
                .departmentId(dto.getDepartmentId())
                .jobId(dto.getJobId())
                .name(dto.getName())
                .contact(dto.getContact())
                .profileImg(dto.getProfileImg())
                .build();
        employeeDAO.update(employeeDTO);
        employeeDAO.updateDetail(dto);
    }

    @Override
    public void deleteById(String id) {employeeDAO.deleteById(id);}

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

    @Override
    public List<EmployeeDTO> selectContactList() {
        return employeeDAO.selectContactList();
    }

    @Override
    public boolean isNoAuthExist() {
        return employeeDAO.countNoAuth() > 0;
    }

    @Override
    public List<EmployeeDTO> selectByThisMonthBirthday() {return employeeDAO.selectByThisMonthBirthday();}

    @Override
    public boolean pwVali(String currentPw) {return employeeDAO.pwVali(currentPw);}

    @Override
    public void changePw(String newPw,String id) {employeeDAO.changePw(newPw,id);}

    @Override
    public void isResigned(String id) {employeeDAO.isResigned(id);}

    @Override
    public List<Map<String, Object>> employeeAll() {
        return employeeDAO.employeeAll();
    }

    @Override
    public Map<String, List<Integer>> getMonthlyLineData() {
        List<Map<String, Object>> rawList = employeeDAO.getMonthlyStats();

        Map<String, List<Integer>> result = new HashMap<>();
        result.put("join", new ArrayList<>(Collections.nCopies(12, 0)));
        result.put("resign", new ArrayList<>(Collections.nCopies(12, 0)));

        for (Map<String, Object> row : rawList) {
            String type = (String) row.get("TYPE");
            int month = Integer.parseInt((String) row.get("MONTH"));
            int count = ((Number) row.get("COUNT")).intValue();

            result.get(type).set(month - 1, count);
        }
        return result;
    }

    @Override
    public String findByLoginId(String id) {
        return employeeDAO.findByLoginId(id);
    }

    @Override
    public List<Map<String, Object>> getVacationStats() {
        return employeeDAO.getVacationStats();
    }

    @Override
    public List<Map<String, Object>> getAttendanceStats() {
        return employeeDAO.getAttendanceStats();
    }

    @Override
    public List<EmployeeDTO> selectAll(int page) {
        int start = (page - 1) * Statics.recordCountPerPage;
        int end = Math.min(page * Statics.recordCountPerPage, employeeDAO.selectAll().size());
        return employeeDAO.selectFromTo(start, end);
    }

    @Override
    public List<EmployeeDTO> searchContactList(String searchOption, String keyword) {
        return employeeDAO.searchContactList(searchOption, keyword);
    }

    @Override
    public List<EmployeeDTO> searchContactList(String searchOption, String keyword, int page) {
        int start = (page - 1) * Statics.recordCountPerPage;
        int end = Math.min(page * Statics.recordCountPerPage, employeeDAO.searchContactList(searchOption, keyword).size());

        return employeeDAO.searchContactListFromTo(searchOption, keyword, start, end);
    }

    @Override
    public List<EmployeeDTO> searchEmployeeList(String searchOption, String keyword) {
        return employeeDAO.searchEmployeeList(searchOption, keyword);
    }

    @Override
    public List<DepartmentDTO> selectByDepartmentList() {
        return employeeDAO.selectByDepartmentList();
    }

    @Transactional
    @Override
    public void saveAll(List<DepartmentDTO> dtos) {
        for (DepartmentDTO dto : dtos) {
            String name  = dto.getName();
            String email = dto.getEmail();
            Integer id   = dto.getId();
            if (name == null || name.isEmpty()) { continue; }
            if (id == null || id == 0) {
                employeeDAO.insertDepartment(name, email);
            } else {
                int exists = employeeDAO.existsById(id);
                if (exists == 0) {
                    employeeDAO.insertDepartment(name, email);
                } else {
                    employeeDAO.updateDepartment(id, name, email);
                }
            }
        }
    }

    @Override
    public void deleteByDepartmentId(int id) {
        employeeDAO.deleteByDepartmentId(id);
    }

    @Override
    public List<RoleListDTO> loadSettingList() {
        return employeeDAO.loadSettingList();
    }

    @Override
    public void updateRole(String employeeId, String role) {
        employeeDAO.updateRole(employeeId,role);
    }
}