$(function(){
    var taskId=$.session.get("taskId"),  //获取任务编号
        userId=$.session.get("userId");   //登录用户的id
    //新增木作产品页面
    $.ajax({
        url:json._url+"/"+json._nameCustommade+"/task/selectRoomDetail",
        dataType:"json",
        type:"post",
        data:{
            taskId:1
        },
        success:function(e){
            console.log(e);
            //空间选择的渲染
            var html="<ul>";
            for(var i in e.resultInfo.data){
                html+='<li data-color="0">'+e.resultInfo.data[i].roomDetailName+'</li>'
            }
            html+='</ul>'
            $(".space_choice").html(html);
            //为空间选择添加默认的样式
            var liNumber=$(".space_choice>ul").find("li").size(),
                arr=["#93e6f8","#61a2df","#337ab7","#a06f9a","#ee8576"];
            for(var i=0;i<liNumber;i++){
                var j=i%5;
                $(".space_choice>ul").find("li").eq(i).css({"color":''+arr[j]+'',"border-color":''+arr[j]+''});
            }
            //类别选择的权限判断以及样式的添加
            var str=e.resultInfo.typeNum,
                kind_choice="";  //类别选择
            $(".grade_choice").on("click","img",function(){
                var index=($(this).parents("dl").index()+1).toString(); //1-5
                if(str.indexOf(index)<0){ //没有返回-1 
                    var dialog="";
                    //调用提示弹框
                    dialog+='<div class="alert_dialog">'
                                +'<h2>提示</h2>'
                                +'<p>对不起！您当前的身份权限 暂时无法对该模块进行操作！</p>'
                            +'</div>'
                    $(dialog).prependTo($("body"));
                    setInterval(function(){
                        $(".alert_dialog").remove();
                    },2000);
                }else{
                    var imgUrl=$(this).attr("src").split(".");
                    var check=imgUrl[0].indexOf("-on");
                    if(check<0){//没有就添加样式
                        var imgSrc=imgUrl[0]+"-on."+imgUrl[1];
                        $(this).parents("dl").find("dd").addClass("higth_color");
                    }else{ 
                        var imgSrc=imgUrl[0].replace("-on","")+"."+imgUrl[1];
                        $(this).parents("dl").find("dd").removeClass("higth_color");
                    }
                    $(this).attr("src",imgSrc);
                    kind_choice=$(this).parents("dl").find("dd").text();  //类别选择
                    $.session.set("kind_choice",kind_choice);  //存储session中
                }
            })
            //空间页面的操作
            //为空间选择添加点击的样式
            var space_choice="";//空间选择
            $(".space_choice>ul").find("li").on("click",function(){
                var idxC=$(this).index()%5;
                var _data=$(this).data("color");
                space_choice=$(this).text();
                $.session.set("space_choice",space_choice);
                for(var i=0,len=$(".space_choice>ul").find("li").length;i<len;i++){
                    var j=i%5;
                    $(".space_choice>ul").find("li").eq(i).css({ "color":arr[j]});
                }
                if(_data==0){
                    $(this).css({"background":arr[idxC],"color":"#fff" }).siblings().css({"background":"#fff"});
                    $(this).data("color",1).siblings().data("color",0);
                }else if(_data==1){
                    $(this).css({
                        "background":"#fff",
                        "color":arr[idxC]
                    })
                    $(this).data("color",0);
                }
            })
        },
        error:function(){
            alert("请求超时！");
        }
    })
    //点击确认提交时，跳转到明细页面
    $("#confirm_btn").on("click",function(){
        //分别判断类别选择进入的不同页面
        var kind_choice=$.session.get("kind_choice");
        if(kind_choice=="木门"){
            window.location.href="door.html";
        }else if(kind_choice=="定制家具"){
            window.location.href="innitcontaic.html";
        }else if(kind_choice=="橱柜"){
            window.location.href="cupboard.html";
        }
    })
})