<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/8/6 0006
  Time: 15:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html >
<head>
    <title>Title</title>
</head>
<body>
<h2>编辑</h2>
    <form name="addForm" method="post" action="/update">
        学号：<input type="text" name="stuno" value="${stuinfo.stuno}"><br>
        姓名：<input type="text" name="stuname" value="${stuinfo.stuname}"><br>
        性别：<input type="radio" name="stusex" value="男" ${stuinfo.stusex=="男"?"checked":""}>男&nbsp;
        <input type="radio" name="stusex" value="女" ${stuinfo.stusex=="女"?"checked":""}>女&nbsp;<br>
        年龄：<input type="text" name="stuage" value="${stuinfo.stuage}"><br>
        座位：<input type="text" name="stuseat" value="${stuinfo.stuseat}"><br>
        身份证：<input type="text" name="stupid" value="${stuinfo.stupid}"><br>
        地址：<input type="text" name="stuaddress"value="${stuinfo.stuaddress}"><br>
        <input type="submit" value="修改"> <input type="submit" value="返回" onclick="history.back()"><br>


    </form>
</body>
</html>
