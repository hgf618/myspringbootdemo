package com.dfby.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class GoController {

    @RequestMapping("/go/{page}")
    public String go(@PathVariable("page") String page){
        return page;
    }

    @RequestMapping("/hello")
    @ResponseBody
    public String hello(){
        return "HelloWorld!!!";
    }
}
