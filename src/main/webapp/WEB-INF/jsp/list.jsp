<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/8/6 0006
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<a href="/go/add">添加</a>
    <table border="1">
        <tr>
            <th>学号</th>
            <th>姓名</th>
            <th>性别</th>
            <th>年龄</th>
            <th>座位</th>
            <th>身份证</th>
            <th>地址</th>
            <th>操作</th>
        </tr>
        <c:forEach var="stuinfo" items="${stuinfoList}">
            <tr>
                <td>${stuinfo.stuno}</td>
                <td>${stuinfo.stuname}</td>
                <td>${stuinfo.stusex}</td>
                <td>${stuinfo.stuage}</td>
                <td>${stuinfo.stuseat}</td>
                <td>${stuinfo.stupid}</td>
                <td>${stuinfo.stuaddress}</td>
                <td>
                    <a href="/toUpdate?stuno=${stuinfo.stuno}">编辑</a>&nbsp;
                    <a href="/delete?stuno=${stuinfo.stuno}">删除</a>&nbsp;
                </td>
            </tr>
        </c:forEach>
    </table>

    <c:if test="${msg!=null}">
        <span style="color:red">${msg}</span>
    </c:if>

</body>
</html>
