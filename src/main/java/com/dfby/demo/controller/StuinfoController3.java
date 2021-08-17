package com.dfby.demo.controller;

import com.dfby.demo.pojo.Stuinfo;
import com.dfby.demo.service.StuinfoService;
import com.dfby.demo.util.Response;
import com.dfby.demo.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

///RestFul风格

@RestController
public class StuinfoController3 {

    @Autowired
    private StuinfoService stuinfoService;

    @GetMapping("/stuinfo3")
    public Result list(){
        return Response.success(stuinfoService.selectAll());
    }

    @PostMapping("/stuinfo3")
    public Result add(Stuinfo stuinfo){
        if(stuinfoService.insert(stuinfo)>0){
            return Response.success();
        }else{
            return Response.error();
        }
    }

    @GetMapping("/stuinfo3/{stuno}")
    public Result toUpdate(@PathVariable("stuno") String stuno){

        return Response.success(stuinfoService.selectByPrimaryKey(stuno));
    }

    @PutMapping("/stuinfo3")
    public Result update(Stuinfo stuinfo){
        if(stuinfoService.updateByPrimaryKey(stuinfo)>0){
            return Response.success();
        }else{
            return Response.error();
        }
    }

    @DeleteMapping("/stuinfo3/{stuno}")
    public Result delete(@PathVariable("stuno") String stuno){
        if(stuinfoService.deleteByPrimaryKey(stuno)>0){
            return Response.success();
        }else{
            return Response.error();
        }
    }
}
