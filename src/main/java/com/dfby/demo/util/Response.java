package com.dfby.demo.util;

/**
 * 响应结果方法
 */
public class Response {
    /****
     * 成功响应Msg中的信息
     **/
    private final static String SUCCESS = "success";

    /****
     * 失败响应Msg中的信息
     **/
    private final static String FAILED = "failed";

    public static <T> Result<T> success() {
        return new Result<T>().setCode(ResultsCode.SUCCESS).setMsg(SUCCESS);
    }

    public static <T> Result<T> success(T data) {
        return new Result<T>().setCode(ResultsCode.SUCCESS).setMsg(SUCCESS).setData(data);
    }

    public static <T> Result<T> error(ResultsCode resultsCode) {
        return new Result<T>().setCode(resultsCode.code).setMsg(resultsCode.message);
    }

    public static <T> Result<T> error(String message) {
        return new Result<T>().setMsg(message).setCode(ResultsCode.FAIL);
    }


    public static <T> Result<T> error(String message, ResultsCode resultsCode) {
        return new Result<T>().setMsg(message).setCode(resultsCode.code);
    }

    public static <T> Result<T> error() {
        return new Result<T>().setCode(ResultsCode.FAIL).setMsg(FAILED);
    }


}