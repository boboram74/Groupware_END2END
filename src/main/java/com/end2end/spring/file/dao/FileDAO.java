package com.end2end.spring.file.dao;

import com.end2end.spring.file.dto.FileColumnMapperDTO;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.dto.FileDetailDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class FileDAO {
    @Autowired
    private SqlSession mybatis;

    public List<FileDetailDTO> selectByParentsId(FileColumnMapperDTO dto) {
        return mybatis.selectList("file.selectByParentsId", dto);
    }

    public Optional<FileDetailDTO> selectById(int id) {
        return mybatis.selectOne("file.selectById", id);
    }

    public int insert(FileColumnMapperDTO dto) {
        return mybatis.insert("file.insert", dto);
    };

    public void detailInsert(FileDetailDTO dto) {
        mybatis.insert("file.detailInsert", dto);
    }

    public void deleteDetailByPath(String path) {
        mybatis.delete("file.deleteDetailByPath", path);
    }

    public boolean deleteDetailById(int id) {
        return mybatis.delete("file.deleteDetailById", id) > 1;
    }

    public void deleteById(FileColumnMapperDTO dto) {
        mybatis.delete("file.deleteById", dto);
    }
}
