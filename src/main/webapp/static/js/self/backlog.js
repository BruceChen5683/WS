$(function(){
    var _url="http://192.168.1.217:8080/shichuang";  //url接口路径
    var taskId=$.session.get("taskId");  //获取任务编号
    //获取后台的数据，渲染待办事项的列表
    $.ajax({
        url:""+_url+"/task/selectBacklog?taskId="+taskId+"",
        dataType:"json",
        type:"post",
        success:function(e){
            var html="",stay_type="";
            for(var i in e.data){
                //判断待办事项类型
                if(e.data[i].backlogType=1){
                    stay_type="<td>预约初测</td>";
                }else if(e.data[i].backlogType=2){
                    stay_type="<td>预约初测</td>";
                }
                html+='<div class="backlog_row">'
                    +'<h2></h2>'
                    +'<table>'
                        +'<thead>'
                            +'<tr>'
                                +'<th>待办类型</th>'
                                +'<th>相关人员</th>'
                                +'<th>计划日期</th>'
                                +'<th>待办当前状态</th>'
                                +'<th>操作</th>'
                            +'</tr>'
                        +'</thead>'
                        +'<tbody>'
                            +'<tr>'
                                +'<td>'+stay_type+'</td>'
                                +'<td>客户</td>'
                                +'<td>2016-09-10 19:21</td>'
                                +'<td><span class="already_status">已完成</span></td>'
                                +'<td><button>详情</button></td>'
                            +'</tr>'
                        +'</tbody>'
                    +'</table>'
                +'</div>'
            }
            //$(".backlog_list").html(html);
        },
        error:function(){
            alert("请求超时！");
        }
    })
})