package com.end2end.spring.file.dao;

import com.end2end.spring.file.dto.FileColumnMapperDTO;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.dto.FileDetailDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class FileDAO {
    @Autowired
    private SqlSession mybatis;

    public List<FileDetailDTO> selectByParentsId(FileColumnMapperDTO dto) {
        return mybatis.selectList("file.selectByParentsId", dto);
    }

    public FileDTO selectById(int id) {
        return mybatis.selectOne("file.selectById", id);
    }

    public int insert(FileColumnMapperDTO dto) {
        return mybatis.insert("file.insert", dto);
    };

    public void detailInsert(FileDetailDTO dto) {
        mybatis.insert("file.detailInsert", dto);
    }

    public int deleteByPath(String path) {
        return mybatis.delete("file.deleteByPath", path);
    }

    public boolean deleteById(int id) {
        return mybatis.delete("file.deleteById", id) > 1;
    }
}
