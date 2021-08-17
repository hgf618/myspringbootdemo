<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/8/6 0006
  Time: 15:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form name="addForm" method="post" action="/add" >
        学号：<input type="text" name="stuno"><br>
        姓名：<input type="text" name="stuname"><br>
        性别：<input type="radio" name="stusex" value="男">男&nbsp;<input type="radio" name="stusex" value="女">女&nbsp;<br>
        年龄：<input type="text" name="stuage"><br>
        座位：<input type="text" name="stuseat"><br>
        身份证：<input type="text" name="stupid"><br>
        地址：<input type="text" name="stuaddress"><br>
        <input type="submit" value="添加"> <input type="submit" value="返回" onclick="history.back()"><br>


    </form>
</body>
</html>
