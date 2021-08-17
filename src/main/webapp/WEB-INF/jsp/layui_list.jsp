<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/8/9 0009
  Time: 14:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/layui/css/layui.css"  media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->

</head>
<body>


<div style="margin-bottom: 5px;">

    <!-- 示例-970 -->
    <ins class="adsbygoogle" style="display:inline-block;width:970px;height:90px" data-ad-client="ca-pub-6111334333458862" data-ad-slot="3820120620"></ins>

</div>
<div class="demoTable">
    搜索学号：
    <div class="layui-inline">
        <input class="layui-input" name="searchstuno" id="searchstuno" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
<br>

<div class="layui-btn-group demoTable">
    <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
    <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
    <button class="layui-btn" data-type="isAll">验证是否全选</button>
    <button class="layui-btn layui-btn-sm" data-type="addBtn">新增</button>
</div>

<table class="layui-table" id="test" lay-filter="demo"> </table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>


<script src="/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述 JS 路径需要改成你本地的 -->
<script>
    layui.use(['table','form'], function(){
        var table = layui.table;
        var form = layui.form;

        table.render({
            elem: '#test'
            ,url:'${pageContext.request.contextPath}/stuinfo4'
            ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            ,cols: [[
                {type:'checkbox'}
                ,{field:'stuno', width:80, title: '学号', sort: true}
                ,{field:'stuname', width:80, title: '姓名'}
                ,{field:'stusex', width:80, title: '性别', sort: true}
                ,{field:'stuage', width:80, title: '年龄'}
                ,{field:'stuseat', title: '座位', width: 80} //minWidth：局部定义当前单元格的最小宽度，layui 2.2.1 新增
                ,{field:'stupid', title: '身份证',width: 100, sort: true}
                ,{field:'stuaddress', title: '地址', sort: true}
                ,{fixed: 'right', width:178, align:'center', toolbar: '#barDemo'} //设置工具栏
            ]]
            ,id:'testReload'
        });


        //监听表格复选框选择
        table.on('checkbox(demo)', function(obj){
            console.log(obj)
        });
        //监听工具条
        table.on('tool(demo)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                layer.msg('ID：'+ data.stuno + ' 的查看操作');
            } else if(obj.event === 'del'){
                layer.confirm('您真的要删除当前行吗？', function(index){
                    $.ajax({
                        url:'${pageContext.request.contextPath}/stuinfo4/'+data.stuno,
                        method:'DELETE',
                        success:function (result){
                            console.log(result);
                            if(result.code==200){
                                layer.msg('删除成功');
                            }else{
                                layer.msg('删除失败');
                            }
                            obj.del();//当前行删除
                            layer.close(index);
                        },
                        error:function(){
                            console.log('请求失败');
                        }
                    })

                });
            } else if(obj.event === 'edit'){
               // layer.alert('编辑行：<br>'+ JSON.stringify(data));
                $("#editForm")[0].reset();
                $("#stuno").val(data.stuno);
                $("#stuname").val(data.stuname);
                if(data.stusex=='男'){
                    $("#stusex_male").attr("checked","true");
                }else{
                    $("#stusex_female").attr("checked","true");
                }
                $("#stuage").val(data.stuage);
                $("#stuseat").val(data.stuseat);
                $("#stupid").val(data.stupid);
                $("#stuaddress").val(data.stuaddress);
                layer.open({
                    type: 1,//页面层
                    title:'编辑学员信息',
                    area: ['400px', '500px'],
                    offset:'100px',
                    content: $("#editForm")
                });

            }
        });

        var $ = layui.$, active = {
            getCheckData: function(){ //获取选中数据
                var checkStatus = table.checkStatus('test')
                    ,data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            }
            ,getCheckLength: function(){ //获取选中数目
                var checkStatus = table.checkStatus('test')
                    ,data = checkStatus.data;
                layer.msg('选中了：'+ data.length + ' 个');
            }
            ,isAll: function(){ //验证是否全选
                var checkStatus = table.checkStatus('test');
                layer.msg(checkStatus.isAll ? '全选': '未全选')
            }
            ,addBtn: function(){
               // layer.msg('aaaaa');
                //打开弹出框之前先清空表单
                $("#addForm")[0].reset();
                layer.open({
                    type: 1,//页面层
                    title:'新增学员信息',
                    area: ['400px', '500px'],
                    offset:'100px',
                    content: $("#addForm")
                });
            }
            ,reload:function (){
                var stunoValue = $('#searchstuno').val();
                console.log(stunoValue+"===");
                //执行重载
                table.reload('testReload', {
                    where: {
                        // key: {
                        //     stuno: stunoValue
                        // }
                        key: 'stuno',
                        stuno:stunoValue,
                    }
                });
            }
        };

        //监听添加按钮提交
        form.on('submit(add)', function(data){
            $.ajax({
                url:'${pageContext.request.contextPath}/stuinfo4/',
                method:'POST',
                data:data.field,//提交表单数据
                success:function (result){
                    console.log(result);
                    if(result.code==200){
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        parent.layer.close(index);
                        layer.msg({title:'添加成功',time:2000});
                        parent.location.reload();//
                    }else{
                        layer.msg('添加失败');
                    }
                    layer.close();
                },
                error:function(){
                    console.log('请求失败');
                }
            })
            // layer.alert(JSON.stringify(data.field), {
            //     title: '最终的提交信息'
            // })
            return false;
        });

        //监听修改按钮提交
        form.on('submit(edit)', function(data){
            $.ajax({
                url:'${pageContext.request.contextPath}/stuinfo4/',
                method:'PUT',
                data:data.field,//提交表单数据
                success:function (result){
                    console.log(result);
                    if(result.code==200){
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        parent.layer.close(index);
                        layer.msg('修改成功');
                        parent.location.reload();

                    }else{
                        layer.msg('修改失败');
                    }

                },
                error:function(){
                    console.log('请求失败');
                }
            })
            // layer.alert(JSON.stringify(data.field), {
            //     title: '最终的提交信息'
            // })
            return false;
        });



        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });
</script>



<form class="layui-form" action="" style="display:none" id="addForm" lay-filter="stuForm">
    <div class="layui-form-item">
        <label class="layui-form-label">学号</label>
        <div class="layui-input-inline">
            <input type="text" name="stuno" lay-verify="stuno" autocomplete="off" placeholder="请输入学号" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">姓名</label>
        <div class="layui-input-inline">
            <input type="text" name="stuname" lay-verify="required" lay-reqtext="姓名必填项，岂能为空？" placeholder="请输入" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
            <div class="layui-input-inline">
                <input type="radio" name="stusex" value="男" title="男" checked="">
                <input type="radio" name="stusex" value="女" title="女">
            </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">年龄</label>
        <div class="layui-input-inline">
            <input type="text" name="stuage"  placeholder="请输入学号" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">座位</label>
        <div class="layui-input-inline">
            <input type="text" name="stuseat"   placeholder="请输入学号" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">身份证</label>
        <div class="layui-input-inline">
            <input type="text" name="stupid"  autocomplete="off" placeholder="请输入学号" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
    <label class="layui-form-label">地址</label>
    <div class="layui-input-inline">
        <input type="text" name="stuaddress"  placeholder="请输入学号" class="layui-input">
    </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-inline">
            <button type="submit" class="layui-btn" lay-submit="" lay-filter="add">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>



<form class="layui-form" action="" style="display:none" id="editForm" lay-filter="editForm">
<%--    <div class="layui-form-item">--%>
<%--        <label class="layui-form-label">学号</label>--%>
<%--        <div class="layui-input-inline">--%>
<%--            <input type="text" name="stuno" id="stuno" lay-verify="stuno" autocomplete="off" placeholder="请输入学号" class="layui-input">--%>
<%--        </div>--%>
<%--    </div>--%>
    <input type="hidden" name="stuno" id="stuno" lay-verify="stuno" autocomplete="off" placeholder="请输入学号" class="layui-input">

    <div class="layui-form-item">
        <label class="layui-form-label">姓名</label>
        <div class="layui-input-inline">
            <input type="text" name="stuname" id="stuname" lay-verify="required" lay-reqtext="姓名必填项，岂能为空？" placeholder="请输入" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-inline">
            <input type="radio" name="stusex" id="stusex_male" value="男" title="男" checked="">
            <input type="radio" name="stusex" id="stusex_female" value="女" title="女">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">年龄</label>
        <div class="layui-input-inline">
            <input type="text" name="stuage" id="stuage"  placeholder="请输入学号" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">座位</label>
        <div class="layui-input-inline">
            <input type="text" name="stuseat" id="stuseat"   placeholder="请输入学号" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">身份证</label>
        <div class="layui-input-inline">
            <input type="text" name="stupid" id="stupid"  autocomplete="off" placeholder="请输入学号" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">地址</label>
        <div class="layui-input-inline">
            <input type="text" name="stuaddress" id="stuaddress"  placeholder="请输入学号" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-inline">
            <button type="submit" class="layui-btn" lay-submit="" lay-filter="edit">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>


</body>
</html>