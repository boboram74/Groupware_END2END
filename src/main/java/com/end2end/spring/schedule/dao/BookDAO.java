package com.end2end.spring.schedule.dao;

import com.end2end.spring.schedule.dto.BookDTO;
import com.end2end.spring.schedule.dto.BookTargetDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class BookDAO {
    @Autowired private SqlSession mybatis;

    public List<BookDTO> selectAll() {
        return mybatis.selectList("book.selectAll");
    }

    public List<BookDTO> selectByEmployeeId(String employeeId) {
        return mybatis.selectList("book.selectByEmployeeId", employeeId);
    }

    public BookDTO selectById(int id) {
        return mybatis.selectOne("book.selectById", id);
    }

    public List<BookTargetDTO> selectAllBookTarget() {
        return mybatis.selectList("book.selectAllBookTarget");
    }

    public void insert(BookDTO dto) {
        mybatis.insert("book.insert", dto);
    }

    public void update(BookDTO dto) {
        mybatis.update("book.update", dto);
    }

    public void deleteById(int id) {
        mybatis.delete("book.deleteById", id);
    }

    public int isReserved(BookDTO dto) {
        return mybatis.selectOne("book.isReserved", dto);
    }

    public BookDTO selectByDateAndTarget(LocalDate date, String targetType, int targetId) {
        Map<String, Object> params = new HashMap<>();
        params.put("date", date);
        params.put("targetId", targetId);
        params.put("targetType", targetType);

        return mybatis.selectOne("book.selectByDateAndTarget", params);
    }

    public BookDTO selectEntityById(int id) {
        return mybatis.selectOne("book.selectEntityById", id);
    }

    public BookTargetDTO selectByTarget(BookDTO bookDTO) {
        return mybatis.selectOne("book.selectByTarget", bookDTO);
    }
}
