package com.dfby.demo.controller;

import com.dfby.demo.pojo.Stuinfo;
import com.dfby.demo.service.StuinfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.w3c.dom.stylesheets.LinkStyle;

import java.util.List;

///RestFul风格

@RestController
public class StuinfoController2 {

    @Autowired
    private StuinfoService stuinfoService;

    @GetMapping("/stuinfo")
    public List<Stuinfo> list(){
        return stuinfoService.selectAll();
    }

    @PostMapping("/stuinfo")
    public String add(Stuinfo stuinfo){
        if(stuinfoService.insert(stuinfo)>0){
            return "add success";
        }else{
            return "add error";
        }
    }

    @GetMapping("/stuinfo/{stuno}")
    public Stuinfo toUpdate(@PathVariable("stuno") String stuno){
        return stuinfoService.selectByPrimaryKey(stuno);
    }

    @PutMapping("/stuinfo")
    public String update(Stuinfo stuinfo){
        if(stuinfoService.updateByPrimaryKey(stuinfo)>0){
            return "edit success";
        }else{
            return "edit error";
        }
    }

    @DeleteMapping("/stuinfo/{stuno}")
    public String delete(@PathVariable("stuno") String stuno){
        if(stuinfoService.deleteByPrimaryKey(stuno)>0){
            return "delete success";
        }else{
            return "delete error";
        }
    }
}
