package com.dfby.demo.mapper;

import com.dfby.demo.pojo.Stuinfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

//@Mapper
public interface StuinfoMapper {
    int deleteByPrimaryKey(String stuno);

    int insert(Stuinfo record);

    int insertSelective(Stuinfo record);

    Stuinfo selectByPrimaryKey(String stuno);

    int updateByPrimaryKeySelective(Stuinfo record);

    int updateByPrimaryKey(Stuinfo record);

    List<Stuinfo> selectAll();

    int selectCountByCon(Stuinfo record);

    List<Stuinfo>  selectPageListByCon(Map<String,Object> paramsMap);

     List<Stuinfo> selectByCon(Stuinfo record);
}