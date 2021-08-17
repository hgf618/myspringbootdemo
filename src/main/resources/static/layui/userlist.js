layui.use(['table','layer','form'],function(){ //,'laypage'
    //var data=document.getElementById("dz").value;
    var data="";
    var table =layui.table;
    var layer=layui.layer;
    var form = layui.form;
    form.render();

    table.render({
        elem:'#test',
        url:data+'/user',
        method:'GET',
        dataType: "json",
        cols:[[
            {field:'stuno',title:'学生编号',width:100,height:80},
            {field:'stuname',title:'学生姓名',width:100,height:80},
            {field:'stusex',title:'学生性别',width:100,height:80},
            {field:'stuage',title:'学生年龄',width:100,height:80},
            {field:'stuseat',title:'学生座位',width:100,height:80},
            {field:'stupid',title:'学生身份证',width:100,height:80},
            {field:'stuaddress',title:'学生地址',width:100,height:80},
            {fixed: 'right', title:'操作', toolbar: '#lineBtns', width:150}
        ]],
        parseData:function(res){ //res 即为原始返回的数据
            console.log(typeof res.data);
            return {
                "code":res.code, //此处默认值是0，默认必须是0才能正常渲染数据，除非respnose:{statusCode: 200}即接口返回200才显示数据
                "msg": res.msg, //解析提示文本
                "count": res.data.total, //解析数据长度
                "data": res.data.rows//解析数据列表
            };
        },
        response: {
            statusName: 'code',//数据状态的字段名称
            statusCode: 200,
            msgName: 'msg', //状态信息的字段名称
            dataName: 'data', //数据详情的字段名称
            countName: 'count' //数据条数的字段名称，用于 table
        },
        page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: [  'prev', 'page', 'next', 'skip','count','limit'] //自定义分页布局
                //,curr: 1 //设定初始在第 1 页
                //  ,groups: 2 //只显示 2 个连续页码
                // ,first: false //不显示首页
                // ,last: false //不显示尾页
                ,limit:5
                ,limits:[2,5,10,15,20,30]
            },
       // page:'true',
       // limit:5,
       // limits:[2,5,10,15,20,30],
        done: function(res, curr, count){
            //如果是异步请求数据方式，res即为你接口返回的信息。
            //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
            console.log(res);
            //得到当前页码
            console.log(curr);
            //得到数据总量
            console.log(count);
        },
        id: 'testReload'
    });
    //上方菜单操作栏(查询、以及  增加  按钮  )
    var $ = layui.$, active = {
        //查询
        reload: function () {
            var name = $('#stu_name');//书籍名称 根据 id来取值
            console.log(name.val());
            // 执行重载
            table.reload('testReload', {
                page: {
                    curr: 1
                    // 重新从第 1 页开始
                },
                where: {
                    key: 'stuname',
                    stuname: name.val(),
                },
                dataType:'json',
            });
        }, add: function () { //添加
            layer.open({//弹出框
                type: 1,
                title: '添加学生',
                maxmin: true,
                shadeClose: true, //点击遮罩关闭层
                area: ['80%', '80%'],
                content: $('#box1'),
                btn: ['确定', '取消'],
                yes: function (index, layero) {//确定执行函数
                    console.log(layero);
                    $.ajax({
                        url:data+"/user",
                        method: "POST",
                        data:$("#user").serialize(),//序列化表单把表单数据传递到后台
                        dataType: "json",
                        success:function (data){
                            console.log(data);
                            if(data.code==200){
                                //弹出提示层
                                layer.alert('添加成功', {icon: 1, title: '提示'}, function (i) {
                                    layer.close(i);
                                    layer.close(index);//关闭弹出层
                                    $("#user")[0].reset()//重置form
                                    $("#box1").hide();
                                })
                                //重载表格
                                table.reload('testReload', {
                                    page: {
                                        curr: 1// 重新从第 1 页开始
                                    }
                                })
                            }else{
                                layer.msg('添加失败')
                            }

                        },
                        error:function(){
                            //提示添加失败
                            layer.msg('请求失败')
                        }
                    })
                }, cancel: function (index, layero) {//取消
                    console.log("点击了右上角关闭按钮");
                    //当点击取消按钮
                    $("#user")[0].reset();//重置form  根据id
                    layer.close(index);
                    $("#box1").hide();
                },btn2:function(index){
                    console.log("点击了取消按钮");
                    //当点击取消按钮
                    $("#user")[0].reset();//重置form  根据id
                    layer.close(index);
                    $("#box1").hide();
                }
            });
        }
    }
    $('.layui-form .layui-btn').on('click', function () {
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });

    /*表格 行内操作(编辑  以及  删除 按钮操作)  */
    table.on('tool(test)', function(obj){
        var data = obj.data; //获得当前行数据
        //var urlex=document.getElementById("dz").value;
        var urlex="";
        var tr=obj.tr//活动当前行tr 的  DOM对象
        console.log(data);
        var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
        if(layEvent === 'del'){ //删除
            layer.confirm('确定删除吗？',{title:'删除'}, function(index){
                //向服务端发送删除指令og
                $.ajax({
                    url:urlex+'/user/'+data.stuno,
                    dataType: "json",
                    method:"DELETE",
                    //data:{stuno: data.stuno},//当前行的stuno字段值
                    success:function (data){
                        if(data.code==200){
                            layer.close(index);//关闭弹窗
                            table.reload('testReload', {//重载表格
                                page: {
                                    curr: 1
                                    // 重新从第 1 页开始
                                }
                            })
                            layer.msg("删除成功");
                        }else{
                            layer.msg("删除失败");
                        }
                        layer.close(index);
                    },
                    error:function (){
                        layer.msg("请求失败");
                    }

                })

            });
        } else if(layEvent === 'edit'){ //编辑
            layer.open({
                type: 1 //Page层类型
                ,skin: 'layui-layer-molv'
                ,area: ['380px', '270px']
                ,title: ['编辑学生信息','font-size:18px']
                ,btn: ['确定', '取消']
                ,shadeClose: true
                ,shade: 0 //遮罩透明度
                ,maxmin: true //允许全屏最小化
                ,content:$('#box1')  //弹窗id
                ,success:function(layero,index){
                    $('#stuno').val(data.stuno);
                    $('#stuname').val(data.stuname);
                    //$('#stusex').val(data.stusex);
                    $('[name=stusex]').each(function(i,item){
                        // console.log($(item).val()+"~~~~"+data.stusex);
                        if($(item).val()==data.stusex){
                            $(item).prop('checked',true);
                            form.render('radio');//刷新单选按钮
                        }
                    });
                    $('#stuage').val(data.stuage);
                    $('#stuseat').val(data.stuseat);
                    $('#stupid').val(data.stupid);
                    $('#stuaddress').val(data.stuaddress);
                },yes:function(index,layero){
                    $.ajax({
                        url:urlex+'/user/'+data.stuno,
                        dataType: "json",
                        method:"POST",
                        data:$("#user").serialize()+"&_method=PUT",//&_method=put  设置请求方式为put
                        success:function (data){
                            console.log(data+"===");
                            if(data.code==200){
                                layer.alert('编辑成功',{icon:1,title:'提示'},function(i){
                                    layer.close(i);
                                    layer.close(index);//关闭弹出层
                                    $("#user")[0].reset()//重置form
                                })
                                table.reload('testReload',{//重载表格
                                    page:{
                                        curr:1
                                    }
                                })
                            }else{
                                layer.msg("编辑失败");
                            }
                            $("#box1").hide();
                        },
                        error:function (){
                            layer.msg("请求失败");
                        }
                    })
                }, cancel: function (index, layero) {//取消
                    console.log("点击了右上角关闭按钮");
                    //当点击取消按钮
                    $("#user")[0].reset();//重置form  根据id
                    layer.close(index);
                    $("#box1").hide();
                },btn2:function(index){
                    console.log("点击了取消按钮");
                    //当点击取消按钮
                    $("#user")[0].reset();//重置form  根据id
                    layer.close(index);
                    $("#box1").hide();
                }
            });
        }
    });

})