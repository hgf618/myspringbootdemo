package com.dfby.demo.service.impl;

import com.dfby.demo.mapper.StuinfoMapper;
import com.dfby.demo.pojo.Stuinfo;
import com.dfby.demo.service.StuinfoService;
import com.dfby.demo.util.Page;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.github.pagehelper.PageInfo;
import com.github.pagehelper.PageHelper;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StuinfoServiceImpl implements StuinfoService {
    Logger logger = (Logger) LoggerFactory.getLogger(getClass());//日志
    @Autowired
    private StuinfoMapper stuinfoMapper;

    @Override
    public int deleteByPrimaryKey(String stuno) {
        return stuinfoMapper.deleteByPrimaryKey(stuno);
    }

    @Override
    public int insert(Stuinfo record) {
        return stuinfoMapper.insert(record);
    }

    @Override
    public int insertSelective(Stuinfo record) {
        return stuinfoMapper.insertSelective(record);
    }

    @Override
    public Stuinfo selectByPrimaryKey(String stuno) {
        return stuinfoMapper.selectByPrimaryKey(stuno);
    }

    @Override
    public int updateByPrimaryKeySelective(Stuinfo record) {
        return stuinfoMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Stuinfo record) {
        return stuinfoMapper.updateByPrimaryKey(record);
    }

    public List<Stuinfo> selectAll(){
        return stuinfoMapper.selectAll();
    }

    public int selectCountByCon(Stuinfo record){
        return stuinfoMapper.selectCountByCon(record);
    }

    public List<Stuinfo>  selectPageListByCon(Stuinfo record, Page page){
        Map<String,Object> paramsMap=new HashMap<>();
        paramsMap.put("stuinfo",record);
        paramsMap.put("pageStart",(page.getPageNo()-1)*page.getPageSize());
        paramsMap.put("pageSize",page.getPageSize());
        logger.info("分页相关参数："+paramsMap);
        return stuinfoMapper.selectPageListByCon(paramsMap);
    }

    public  PageInfo<Stuinfo> selectPageInfo(Stuinfo record,Integer page,Integer limit){
        PageHelper.startPage(page,limit);//设置页码和每页记录数
        return new PageInfo<Stuinfo>(stuinfoMapper.selectByCon(record));
    }

}
