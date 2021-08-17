package com.dfby.demo.controller;

import com.dfby.demo.pojo.Stuinfo;
import com.dfby.demo.service.StuinfoService;
import com.dfby.demo.util.RedisUtil;
import com.sun.corba.se.impl.presentation.rmi.StubInvocationHandlerImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.w3c.dom.stylesheets.LinkStyle;

import java.util.List;

/**
 * 演示使用Thymeleaf
 */
@Controller
public class StuinfoController5 {
    Logger logger = (Logger) LoggerFactory.getLogger(getClass());//日志

    @Autowired
    private StuinfoService stuinfoService;

    @Autowired
    private RedisUtil redisUtil;

    @RequestMapping("/stuinfo5_list")
    public String list(Model model){
        model.addAttribute("stuinfoList",stuinfoService.selectAll());
        return "list";
    }

    @RequestMapping("/stuinfo5_add")
    public String add(Stuinfo stuinfo,Model model){
        if(stuinfoService.insert(stuinfo)>0){
            model.addAttribute("msg","添加成功");
        }else{
            model.addAttribute("msg","添加失败");
        }
        return list(model);
    }

    @RequestMapping("/stuinfo5_toUpdate")
    public String toUpdate(String stuno,Model model){
        model.addAttribute("stuinfo",stuinfoService.selectByPrimaryKey(stuno));
        return "edit";
    }

    @RequestMapping("/stuinfo5_update")
    public String update(Stuinfo stuinfo,Model model){
        if(stuinfoService.updateByPrimaryKey(stuinfo)>0){
            model.addAttribute("msg","修改成功");
        }else{
            model.addAttribute("msg","修改失败");
        }
        return list(model);
    }

    @RequestMapping("/stuinfo5_delete")
    public String delete(String stuno,Model model){
        if(stuinfoService.deleteByPrimaryKey(stuno)>0){
            model.addAttribute("msg","删除成功");
        }else{
            model.addAttribute("msg","删除失败");
        }
        return list(model);
    }
}
