package com.dfby.demo.controller;

import com.dfby.demo.Springboot02Application;
import com.dfby.demo.pojo.Stuinfo;
import com.dfby.demo.service.StuinfoService;
import com.dfby.demo.util.Page;
import com.dfby.demo.util.Response;
import com.dfby.demo.util.Result;
import com.github.pagehelper.PageInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

///RestFul风格

@RestController
public class StuinfoController4 {
    Logger logger = (Logger) LoggerFactory.getLogger(getClass());//日志

    @Autowired
    private StuinfoService stuinfoService;

    //无分页
    @GetMapping("/stuinfo4")
    public Map list(String stuno)
    {
        List<Stuinfo> stuinfoList=new ArrayList<>();
        if(stuno!=null){
            stuinfoList.add(stuinfoService.selectByPrimaryKey(stuno));
        }else{
            stuinfoList=stuinfoService.selectAll();
        }
        Map<String,Object> map=new HashMap<>();
        map.put("code",0);
        map.put("msg","query success");
        map.put("count",stuinfoList.size());
        map.put("data",stuinfoList);
        System.out.println(map+"~~~");
        return map;
    }

    //分页
    @GetMapping("/stuinfo4_2")
    public Map list2(Stuinfo stuinfo,Integer page,Integer limit)
    {
        Page myPage=new Page();
        myPage.setPageNo(page);
        myPage.setPageSize(limit);
        myPage.setRowCount(stuinfoService.selectCountByCon(stuinfo));
        List<Stuinfo> stuinfoList=stuinfoService.selectPageListByCon(stuinfo,myPage);

        Map<String,Object> map=new HashMap<>();
        map.put("code",0);
        map.put("msg","query success");
        map.put("count",myPage.getRowCount());
        map.put("data",stuinfoList);
        System.out.println(map+"~~~");
        return map;
    }


    //分页切结果集格式自定义
    @GetMapping("/stuinfo4_3")
    public Result list3(Stuinfo stuinfo,Integer page,Integer limit)
    {
        Page myPage=new Page();
        if(page!=null) {
            myPage.setPageNo(page);
        }
        if(limit!=null) {
            myPage.setPageSize(limit);
        }
        myPage.setRowCount(stuinfoService.selectCountByCon(stuinfo));
        List<Stuinfo> stuinfoList=stuinfoService.selectPageListByCon(stuinfo,myPage);

        Map<String,Object> map=new HashMap<>();
        map.put("code",0);
        map.put("msg","query success");
        map.put("count",myPage.getRowCount());
        map.put("data",stuinfoList);
        System.out.println(map+"~~~");

        //调用 sl4j 的 info() 方法，而非调用 logback 的方法
        logger.trace("trace 日志消息");
        logger.debug("debug 日志消息");
        logger.info("我的控制器~~"+map);
        logger.warn("warn 日志信息");
        logger.error("error 日志信息");
        return  Response.success(map);
    }

    //分页且结果集格式自定义（使用分页插件实现分页）
    @GetMapping("/stuinfo4_4")
    public Result list4(Stuinfo stuinfo,Integer page,Integer limit)
    {
        PageInfo<Stuinfo> pageInfo=stuinfoService.selectPageInfo(stuinfo,page,limit);
        Map<String,Object> map=new HashMap<>();
        map.put("code",0);
        map.put("msg","query success");
        map.put("count",pageInfo.getTotal());
        map.put("data",pageInfo.getList());
        logger.info("我的控制器~~"+map);
        return  Response.success(map);
    }

//    @GetMapping("/stuinfo4")
//    public Result list()
//    {
//        return Response.success(stuinfoService.selectAll());
//        
//    }

    @PostMapping("/stuinfo4")
    public Result add(Stuinfo stuinfo){
        if(stuinfoService.insert(stuinfo)>0){
            return Response.success();
        }else{
            return Response.error();
        }
    }

    @GetMapping("/stuinfo4/{stuno}")
    public Result toUpdate(@PathVariable("stuno") String stuno){

        return Response.success(stuinfoService.selectByPrimaryKey(stuno));
    }

    @PutMapping("/stuinfo4")
    public Result update(Stuinfo stuinfo){
        if(stuinfoService.updateByPrimaryKey(stuinfo)>0){
            return Response.success();
        }else{
            return Response.error();
        }
    }

    @DeleteMapping("/stuinfo4/{stuno}")
    public Result delete(@PathVariable("stuno") String stuno){
        if(stuinfoService.deleteByPrimaryKey(stuno)>0){
            return Response.success();
        }else{
            return Response.error();
        }
    }
}
