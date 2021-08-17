package com.dfby.demo.pojo;

import java.io.Serializable;

public class Stuinfo implements Serializable {
    private String stuno;

    private String stuname;

    private String stusex;

    private Integer stuage;

    private Integer stuseat;

    private String stupid;

    private String stuaddress;

    public String getStuno() {
        return stuno;
    }

    public void setStuno(String stuno) {
        this.stuno = stuno;
    }

    public String getStuname() {
        return stuname;
    }

    public void setStuname(String stuname) {
        this.stuname = stuname;
    }

    public String getStusex() {
        return stusex;
    }

    public void setStusex(String stusex) {
        this.stusex = stusex;
    }

    public Integer getStuage() {
        return stuage;
    }

    public void setStuage(Integer stuage) {
        this.stuage = stuage;
    }

    public Integer getStuseat() {
        return stuseat;
    }

    public void setStuseat(Integer stuseat) {
        this.stuseat = stuseat;
    }

    public String getStupid() {
        return stupid;
    }

    public void setStupid(String stupid) {
        this.stupid = stupid;
    }

    public String getStuaddress() {
        return stuaddress;
    }

    public void setStuaddress(String stuaddress) {
        this.stuaddress = stuaddress;
    }
}