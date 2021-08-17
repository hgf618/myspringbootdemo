package com.dfby.demo.service;


import com.dfby.demo.pojo.Stuinfo;
import com.dfby.demo.util.Page;
import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

public interface StuinfoService {
    int deleteByPrimaryKey(String stuno);

    int insert(Stuinfo record);

    int insertSelective(Stuinfo record);

    Stuinfo selectByPrimaryKey(String stuno);

    int updateByPrimaryKeySelective(Stuinfo record);

    int updateByPrimaryKey(Stuinfo record);

    List<Stuinfo> selectAll();
    int selectCountByCon(Stuinfo record);

    List<Stuinfo>  selectPageListByCon(Stuinfo record, Page page);

    PageInfo<Stuinfo> selectPageInfo(Stuinfo record, Integer page, Integer limit);
}
