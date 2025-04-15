package com.end2end.spring.schedule.controller;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.schedule.dto.BookDTO;
import com.end2end.spring.schedule.dto.CalendarDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@RequestMapping("/schedule")
@Controller
public class ScheduleController {


    @RequestMapping("/calender/list")
    public String toCalendar(HttpSession session, Model model) {
        // TODO: 해당 사원의 달력 페이지로 이동
        EmployeeDTO employeeDTO = (EmployeeDTO) session.getAttribute("employee");
        return "schedule/calender";
    }

    @RequestMapping("/calender/list/search")
    public String toCalenderSearch(Model model) {
        // TODO: 해당 검색 기록 결과를 calender.jsp에 출력
        return "schedule/calender";
    }

    @RequestMapping("/book")
    public String toBook() {
        // TODO: 예약 페이지로 이동
        return "schedule/book";
    }

    @RequestMapping("/book/search")
    public String toBookSearch(Model model) {
        // TODO: 해당 검색 기록 결과의 예약을 book.jsp에 출력
        return "schedule/book";
    }

    @RequestMapping("/calender/{id}")
    public void selectCalender(@PathVariable int id) {
        // TODO: 해당 id의 일정을 출력
    }

    @RequestMapping("/calender/insert")
    public void insert(CalendarDTO dto) {
        // TODO: 일정을 추가
    }

    @RequestMapping("/calender/update")
    public void update(CalendarDTO dto) {
        // TODO: 일정을 수정
    }

    @RequestMapping("/calender/delete/{id}")
    public void deleteCalenderById(@PathVariable int id) {
        // TODO: 해당 id에 해당하는 일정을 삭제
    }

    @RequestMapping("/book/{id}")
    public void selectBook(@PathVariable int id) {
        // TODO: 해당 id의 예약을 확인
    }

    @RequestMapping("/book/insert")
    public void insert(BookDTO dto) {
        // TODO: 예약을 추가
    }

    @RequestMapping("/book/update")
    public void update(BookDTO dto) {
        // TODO: 예약을 수정
    }

    @RequestMapping("/book/delete/{id}")
    public void deleteBookById(@PathVariable int id) {
        // TODO: 해당 id의 예약을 삭제
    }
}
