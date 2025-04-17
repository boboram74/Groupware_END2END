package com.end2end.spring.schedule.serviceImpl;

import com.end2end.spring.alarm.AlarmService;
import com.end2end.spring.schedule.dao.BookDAO;
import com.end2end.spring.schedule.dao.ScheduleDAO;
import com.end2end.spring.schedule.dto.BookDTO;
import com.end2end.spring.schedule.dto.BookInsertDTO;
import com.end2end.spring.schedule.dto.BookTargetDTO;
import com.end2end.spring.schedule.dto.ScheduleDTO;
import com.end2end.spring.schedule.service.BookService;
import com.end2end.spring.util.EventDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class BookServiceImpl implements BookService {
    @Autowired private BookDAO bookDAO;
    @Autowired private ScheduleDAO scheduleDAO;
    @Autowired private AlarmService alarmService;

    @Override
    public List<BookTargetDTO> selectAllTarget() {
        return bookDAO.selectAllBookTarget();
    }

    @Override
    public List<EventDTO> selectByPeriod(LocalDate startDate, LocalDate endDate) {
        List<BookDTO> bookDTOList = bookDAO.selectAll();

        return bookDTOList.stream()
                .filter(bookDTO -> {
                    LocalDateTime bookStartDateTime = bookDTO.getStartDate().toLocalDateTime();
                    LocalDateTime bookEndDateTime = bookDTO.getEndDate().toLocalDateTime();
                    return (bookStartDateTime.isBefore(endDate.atStartOfDay())
                            && bookEndDateTime.isAfter(startDate.atStartOfDay())) ||
                            (bookStartDateTime.isBefore(startDate.atStartOfDay())
                            && bookEndDateTime.isAfter(endDate.atStartOfDay()));
                })
                .map(bookDTO -> EventDTO.convertFromBook(bookDTO, startDate, endDate))
                .collect(Collectors.toList());
    }

    @Override
    public List<BookDTO> selectAll() {
        return bookDAO.selectAll();
    }

    @Override
    public List<BookDTO> search() {
        // TODO: 검색 결과에 따른 예약을 출력
        return null;
    }

    @Override
    public BookDTO selectById(int id) {
        return bookDAO.selectById(id);
    }

    @Override
    public void insert(BookInsertDTO dto) {
        BookDTO bookDTO = BookDTO.builder()
                .employeeId(dto.getEmployeeId())
                .targetId(dto.getTargetId())
                .build();
        bookDAO.insert(bookDTO);

        BookDTO insertBookDTO = bookDAO.selectById(bookDTO.getId());

        ScheduleDTO scheduleDTO = ScheduleDTO.builder()
                .title("예약")
                .content(insertBookDTO.getTargetName())
                .calendarId(dto.getCalendarId())
                .startDate(Timestamp.valueOf(dto.getStartDate()))
                .endDate(Timestamp.valueOf(dto.getEndDate()))
                .bookId(bookDTO.getId())
                .build();
        scheduleDAO.insertWithBookId(scheduleDTO);
        alarmService.sendScheduleAlarm(scheduleDTO.getCalendarId());
    }

    @Override
    public void update(BookInsertDTO dto) {
        // TODO: 예약 수정
        BookDTO bookDTO = BookDTO.builder()
                .id(dto.getId())
                .employeeId(dto.getEmployeeId())
                .targetId(dto.getTargetId())
                .build();
        bookDAO.update(bookDTO);
        BookDTO updatedBookDTO = bookDAO.selectById(bookDTO.getId());

        ScheduleDTO scheduleDTO = scheduleDAO.selectById(dto.getId());
        ScheduleDTO updateScheduleDTO = ScheduleDTO.builder()
                .id(scheduleDTO.getId())
                .title(scheduleDTO.getTitle())
                .content(updatedBookDTO.getTargetName())
                .calendarId(dto.getCalendarId())
                .startDate(Timestamp.valueOf(dto.getStartDate()))
                .endDate(Timestamp.valueOf(dto.getEndDate()))
                .bookId(updatedBookDTO.getId())
                .build();
        scheduleDAO.update(updateScheduleDTO);
        alarmService.sendScheduleUpdateAlarm(scheduleDTO.getCalendarId());
    }

    @Override
    public void deleteById(int id) {
        // TODO: 해당 id의 모든 예약 삭제
        ScheduleDTO scheduleDTO = scheduleDAO.selectByBookId(id);
        scheduleDAO.deleteById(scheduleDTO.getId());
        alarmService.sendScheduleDeleteAlarm(scheduleDTO.getId());
        bookDAO.deleteById(id);
    }

    @Override
    public boolean isReserved(BookDTO dto) {
        return bookDAO.isReserved(dto) > 0;
    }
}
