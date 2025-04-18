package com.end2end.spring.board.dao;

import com.end2end.spring.board.dto.NoticeDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class NoticeDAO {
    @Autowired private SqlSession mybatis;

    public List<NoticeDTO> selectAll() {
        return mybatis.selectList("notice.selectAll");
    }

    public List<NoticeDTO> selectAllFromTo(int start, int end) {
        Map<String, Object> map = new HashMap<>();
        map.put("start", start);
        map.put("end", end);

        return mybatis.selectList("notice.selectAllFromTo", map);
    }

    public List<NoticeDTO> selectByCategoryId(int categoryId) {
        return mybatis.selectList("notice.selectByCategoryId", categoryId);
    }

    public List<NoticeDTO> selectByCategoryIdFromTo(int categoryId, int start, int end) {
        Map<String, Object> map = new HashMap<>();
        map.put("categoryId", categoryId);
        map.put("start", start);
        map.put("end", end);

        return mybatis.selectList("notice.selectByCategoryIdFromTo", map);
    }

    public NoticeDTO selectById(int id) {
        return mybatis.selectOne("notice.selectById", id);
    }

    public void insert(NoticeDTO dto) {
        mybatis.insert("notice.insert", dto);
    }

    public void update(NoticeDTO dto) {
        mybatis.update("notice.update", dto);
    }

    public void deleteById(int id) {
        mybatis.delete("notice.deleteById", id);
    }
}
