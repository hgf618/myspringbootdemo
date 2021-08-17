package com.dfby.demo.util;

/**
 * 返回码的枚举
 */
public enum ResultsCode {

    SUCCESS(200, "成功"),
    FAIL(-1, "失败"),
    ERROR(500, "服务器异常"),
    UNAUTHORIZED(401, "未认证（签名错误）"),
    NOT_FOUND(404, "接口不存在");

    public int code;
    public String message;

    ResultsCode(int code, String message) {
        this.code = code;
        this.message = message;
    }
}