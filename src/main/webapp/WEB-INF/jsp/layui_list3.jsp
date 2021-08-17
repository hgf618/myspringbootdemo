<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/8/11 0011
  Time: 13:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<div class="demoTable">
    搜索学号：
    <div class="layui-inline">
        <input class="layui-input" name="searchstuno" id="searchstuno" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
<br>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
        <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
        <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
        <button class="layui-btn layui-btn-sm" lay-event="add">新增</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script src="/layui/jquery-3.5.1.min.js" charset="utf-8"></script>
<script src="/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述 JS 路径需要改成你本地的 -->

<script>
    layui.use(['table','form'], function(){
        var table = layui.table;
        var form = layui.form;
        table.render({
            elem: '#test'
            ,url:'${pageContext.request.contextPath}/stuinfo4_4'  //.../stuinfo4_3 也可以成功的
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户数据表'
            ,cols: [[
                {type:'checkbox', fixed: 'left'}
                ,{field:'stuno', width:80, title: '学号', sort: true}
                ,{field:'stuname', width:80, title: '姓名'}
                ,{field:'stusex', width:80, title: '性别', sort: true}
                ,{field:'stuage', width:80, title: '年龄'}
                ,{field:'stuseat', title: '座位', width: 80} //minWidth：局部定义当前单元格的最小宽度，layui 2.2.1 新增
                ,{field:'stupid', title: '身份证',width: 100, sort: true}
                ,{field:'stuaddress', title: '地址', sort: true}
                ,{fixed: 'right', title:'操作',width:178, align:'center', toolbar: '#barDemo'} //设置工具栏
            ]]
            ,id:'testReload'
            ,page:{
                limit: 5
                ,limits: [5, 10, 15,20]
            }
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": res.data.code, //解析接口状态
                    "msg": res.data.msg, //解析提示文本
                    "count": res.data.count, //解析数据长度
                    "data": res.data.data //解析数据列表
                };
            }
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选': '未全选');
                    break;

                //自定义头工具栏右侧图标 - 提示
                case 'LAYTABLE_TIPS':
                    layer.alert('这是工具栏右侧自定义的一个图标按钮');
                    break;
                case 'add':
                    //打开弹出框之前先清空表单
                    $("#addForm")[0].reset();
                    layer.open({
                        type: 1,//页面层
                        title:'新增学员信息',
                        area: ['400px', '500px'],
                        offset:'100px',
                        content: $("#addForm")
                    });
                    break;

            };
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //console.log(obj)
            if(obj.event=='detail'){
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
            reload: function(){
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
        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        //监听添加按钮提交
        form.on('submit(add)', function(data){
            $.ajax({
                url:'${pageContext.request.contextPath}/stuinfo4/',
                method:'POST',
                data:data.field,//提交表单数据
                success:function (result){
                    console.log(result);
                    if(result.code==200){
                        layer.closeAll(); //疯狂模式，关闭所有层
                        layer.msg('添加成功');
                        //执行重载
                        table.reload('testReload');
                    }else{
                        layer.closeAll(); //疯狂模式，关闭所有层
                        layer.msg('添加失败');
                        //执行重载
                        table.reload('testReload');
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
                        layer.closeAll(); //疯狂模式，关闭所有层
                        layer.msg('修改成功');
                        //执行重载
                        table.reload('testReload');

                    }else{
                        layer.closeAll(); //疯狂模式，关闭所有层
                        layer.msg('修改失败');
                        //执行重载
                        table.reload('testReload');
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
            <input type="text" name="stuname" lay-verify="required" lay-reqtext="姓名必填项，岂能为空？" placeholder="请输入姓名" autocomplete="off" class="layui-input">
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
            <input type="text" name="stuage"  placeholder="请输入年龄" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">座位</label>
        <div class="layui-input-inline">
            <input type="text" name="stuseat"   placeholder="请输入座位" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">身份证</label>
        <div class="layui-input-inline">
            <input type="text" name="stupid"  autocomplete="off" placeholder="请输入身份证" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">地址</label>
        <div class="layui-input-inline">
            <input type="text" name="stuaddress"  placeholder="请输入地址" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">&nbsp;</label>
        <div class="layui-input-inline">
            <button type="submit" class="layui-btn" lay-submit="" lay-filter="add">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>



<form class="layui-form" action="" style="display:none" id="editForm" lay-filter="editForm">

    <input type="hidden" name="stuno" id="stuno" lay-verify="stuno" autocomplete="off" placeholder="请输入学号" class="layui-input">

    <div class="layui-form-item">
        <label class="layui-form-label">姓名</label>
        <div class="layui-input-inline">
            <input type="text" name="stuname" id="stuname" lay-verify="required" lay-reqtext="姓名必填项，岂能为空？" autocomplete="off" class="layui-input">
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
            <input type="text" name="stuage" id="stuage"  class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">座位</label>
        <div class="layui-input-inline">
            <input type="text" name="stuseat" id="stuseat"    class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">身份证</label>
        <div class="layui-input-inline">
            <input type="text" name="stupid" id="stupid"  autocomplete="off"  class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">地址</label>
        <div class="layui-input-inline">
            <input type="text" name="stuaddress" id="stuaddress"  class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">&nbsp;</label>
        <div class="layui-input-inline">
            <button type="submit" class="layui-btn" lay-submit="" lay-filter="edit">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>

</body>
</html>
