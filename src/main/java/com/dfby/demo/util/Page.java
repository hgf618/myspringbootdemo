package com.dfby.demo.util;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
public class Page {
    private int pageNo;
    private int pageSize;
    private int rowCount;
    private int pageCount;
    private List pageList;
    private boolean firstPage;
    private boolean lastPage;

    public Page(){
        this.pageNo=1;
        this.pageSize=5;
    }



    /**
     * 获取总页数
     * @return
     */
    public int getPageCount(){
        this.pageCount=rowCount/pageSize;
        if(rowCount%pageSize!=0){
            this.pageCount++;
        }
        return this.pageCount;
    }

    /**
     * 获取页码
     */
    public int getPageNo(){
        if(pageNo>getPageCount()){
            pageNo=pageCount;
        }
        if(pageNo<1){
            pageNo=1;
        }
        return pageNo;
    }

    public boolean isFirstPage(){
        return this.pageNo<=1?true:false;
    }

    public boolean isLastPage(){
        return this.pageNo>=this.pageCount?true:false;
    }

}
