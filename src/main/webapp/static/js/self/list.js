$(function(){
    var _url="http://192.168.1.217:8080/shichuang";  //url接口路径
    var taskId=$.session.get("taskId");  //获取任务编号
    var userId=$.session.get("userId");   //登录用户的id
    //窗口调节大小时，事项类型部分高度的计算
    function HeightFn(){
       var _liW=$("._ulW").find("li").width();
           $("._ulW").find("li").css({"height":_liW*10/20+"px"});
           $("._ulW").find("li").css({"line-height":_liW*10/20+"px"});
    }
    $("window").on("resize",function(){
       HeightFn();
    })
    HeightFn();
    //事项类型的选择
    //事项类型划过的状态
    $("._ulW").on("mouseover","li",function(){
        $(this).addClass("hover_sta").siblings().removeClass("hover_sta");
    })
    //事项类型点击的状态
    var type="",people=[];
    $("._ulW").on("click","li",function(){
        $(this).addClass("click_sta").siblings().removeClass("click_sta");
        if($(this).text()=="预约初测"){
            type=1;
        }else if($(this).text()=="预约复测"){
            type=2;
        }else if($(this).text()=="预约确认"){
            type=3;
        }
    })
    //待通知人员的点击状态
    var arr=["#cdcdcd","#d9534f","#38bded"];  //文字样式的变化
    $(".role_list").on("click","img",function(){
        var imgName=$(this).attr("src").split("."),  //["",""]
            _imgUrl=imgName[0].indexOf("-on"),  //有返回下标，没有返回-1
            idx=$(this).parents("dl").index();
        if(_imgUrl<0){  //没有就添加高亮
            var hightImg=imgName[0]+"-on."+imgName[1];
            $(this).attr("src",hightImg);
            $(this).parents("dl").find("dd").css({"color":arr[idx+1]});
        }else{
            var hightImg=imgName[0].replace("-on","")+"."+imgName[1];
            $(this).attr("src",hightImg);
            $(this).parents("dl").find("dd").css({"color":arr[0]});
        }
        var peopleAll=$(this).parents("dl").find("dd").text();
        people.push(peopleAll);
    })
    //获取时间
    var mydate=new Date(),
        Year=mydate.getFullYear(),  //年
        Month=mydate.getMonth()+1, //月
        Day="", //日
        hour="",//小时
        minute="",//分钟
        timer="";
    $(".rili_clock>tbody>tr").on("click","td",function(){  //点击日历时调取时间弹窗
        $(this).addClass("click_status").siblings().removeClass("click_status");
        $(this).parent("tr").next().children().removeClass("click_status");
        $(this).parent("tr").prev().children().removeClass("click_status");
        Day=$(this).text(); //日
        //日补零
        if(Day<10){
            Day=""+0+""+Day;
        }else{
            Day=Day;
        }
        //时间选择器的弹框调取
        var str="";
        str+='<div class="T_mark"></div>'
              +'<div class="T_dialog">'
                 +'<div class="T_time">'
                    +'<h2>时间选择器</h2>'
                    +'<div class="time_select">'
                        +'<div>'
                            +'<span>小时</span>'
                            +'<div class="hour_inter">'
                                +'<img src="static/images/tar_03.png"/>'
                                +'<select class="hour_select">'
                                    +'<option value="">1</option>'
                                    +'<option value="">2</option>'
                                    +'<option value="">3</option>'
                                    +'<option value="">4</option>'
                                    +'<option value="">5</option>'
                                    +'<option value="">6</option>'
                                    +'<option value="">7</option>'
                                    +'<option value="">8</option>'
                                    +'<option value="">9</option>'
                                    +'<option value="">10</option>'
                                    +'<option value="">11</option>'
                                    +'<option value="">12</option>'
                                    +'<option value="">13</option>'
                                    +'<option value="">14</option>'
                                    +'<option value="">15</option>'
                                    +'<option value="">16</option>'
                                    +'<option value="">17</option>'
                                    +'<option value="">18</option>'
                                    +'<option value="">19</option>'
                                    +'<option value="">20</option>'
                                    +'<option value="">21</option>'
                                    +'<option value="">22</option>'
                                    +'<option value="">23</option>'
                                    +'<option value="">24</option>'
                                +'</select>'
                            +'</div>'
                            +'<span>分钟</span>'
                            +'<div class="minimute_inter">'
                                +'<img src="static/images/tar_03.png"/>'
                                +'<select class="minute_select">'
                                    +'<option value="">00</option>'
                                    +'<option value="">10</option>'
                                    +'<option value="">20</option>'
                                    +'<option value="">30</option>'
                                    +'<option value="">40</option>'
                                    +'<option value="">50</option>'
                                +'</select>'
                            +'</div>'
                        +'</div>'
                    +'</div>'
                    +'<div class="btn-group">'
                        +'<button id="sure">确定</button>'
                        +'<button id="cancel">取消</button>'
                    +'</div>'
                 +'</div>'
              +'</div>'
        $(str).prependTo($('body'));
        //小时的选择
        $(".hour_select").on("change",function(){
            hour=$(this).find("option:selected").text();
        })
        //分钟的选择
        $(".minute_select").on("change",function(){
            minute=$(this).find("option:selected").text();
        })
        //点击取消时，关闭遮罩层
        $("#cancel").on("click",function(){
            $(".T_mark").remove();
            $(".T_dialog").remove();
        })
        //点击确定按钮时，将时间显示在文本框中
        $("#sure").on("click",function(){
            $(this).addClass("hight_style");
            timer=Year+"-"+Month+"-"+Day+" "+hour+":"+minute;
            $("#time_input").val(timer);
            setInterval(function(){
                $(".T_mark").remove();
                $(".T_dialog").remove();
            },1000);
        })
    })
    $(".rili_clock>tbody>tr").on("mouseover","td",function(){  //划过日历的状态
       $(this).addClass("hover_status").siblings().removeClass("hover_status");
       $(this).parent("tr").next().children().removeClass("hover_status");
       $(this).parent("tr").prev().children().removeClass("hover_status");
    })
    //点击确认提交时，将选择的信息传给后台做处理
    $("#submit_btn").on("click",function(){
        $.ajax({
            url:""+_url+"/task/addBacklog?backlogType="+type+"&backlogPeople="+people+"&time="+timer+"&userid="+userId+"&taskId="+taskId+"",
            dataType:"json",
            type:"post",
            success:function(e){
                window.location.href="backlog.html";
            },
            error:function(){
                alert("请求超时！");
            }
        })
    })
})