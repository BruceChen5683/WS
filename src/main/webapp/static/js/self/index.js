$(function(){
  var userId=$.session.get("userId"); //登录用户id
  var param_url="";//请求的url路径
  //任务列表的渲染
  param_url=json._url+"/"+json._nameCustommade+"/task/selectTask/"+userId;
  $.ajax({
     url:param_url,
     type:"post",
     dataType:"json",
     success:function(e){
        indexFn(e);
        //为进度条添加样式
        for(var i=0,len=$(".passenger_list").length;i<len;i++){
            var _obj=$(".passenger_list").eq(i);
            if(_obj.find(".progressBar").find("a").text()=="初测"){
              _obj.find(".progressBar").find(".round").eq(0).addClass('round_active');
              _obj.find(".progressBar>div").find("span").css({"width":"0%"}).addClass("progress_active");
            }else if(_obj.find(".progressBar").find("a").text()=="复测"){
              _obj.find(".progressBar").find(".round").eq(0).addClass('round_active');
              _obj.find(".progressBar").find(".round").eq(1).addClass('round_active');
              _obj.find(".progressBar>div").find("span").css({"width":"50%"}).addClass("progress_active");
            }else if(_obj.find(".progressBar").find("a").text()=="确认"){
              _obj.find(".progressBar").find(".round").eq(0).addClass('round_active');
              _obj.find(".progressBar").find(".round").eq(1).addClass('round_active');
              _obj.find(".progressBar").find(".round").eq(2).addClass('round_active');
              _obj.find(".progressBar>div").find("span").css({"width":"100%"}).addClass("progress_active");
            }
        }
     },
     error:function(){
       console.log("页面请求失败!");
     }
  })
  function indexFn(e){
    var html="",_a="",_aa="",_b="",isAlready="";
    for(var i in e.resultInfo){
      html+='<div class="passenger_list">';
          //判断客户等级                
          if(e.resultInfo[i].customerLevel==1){
            _a='<p><img src="static/images/vip.png" alt=""></p>';   
          }else if(e.resultInfo[i].customerLevel==2){
            _a='<p><img src="static/images/svip.png" alt=""></p>';
          }else if(e.resultInfo[i].customerLevel==3){
            _a='<p></p>';
          }
          //判断预警状态
          if(e.resultInfo[i].status==1){
            _b='<p>预警状态：正常<span><img src="static/images/22.png" alt=""></span></p>'
          }else if(e.resultInfo[i].status==2){
            _b='<p>预警状态：异常<span><img src="static/images/nof.png" alt=""></span></p>'
          }else if(e.resultInfo[i].status==3){
            _b='<p>预警状态：紧急<span><img src="static/images/danger.png" alt=""></span></p>'
          }
          //判断完成，未完成的状态
          if(e.resultInfo[i].progress<6){ //未完成
            isAlready='<img src="static/images/no.png" height="56" width="76" alt="" />'; 
          }else if(e.resultInfo[i].progress==6){  //完成
            isAlready='<img src="static/images/al.png" height="56" width="76" alt="" />'; 
          }
          //判断进度条的状态
          if(e.resultInfo[i].progress==1){
              _aa='<a href="#" style="left:0;">初测</a>';
          }else if(e.resultInfo[i].progress==2){
              _aa='<a href="#" style="left:50%">复测</a>'; 
          }else if(e.resultInfo[i].progress>=3){
              _aa='<a href="#" style="left:100%;">确认</a>';
          } 
          //渲染头像，等级
          html+='<div class="basic_area">'
                    +'<dl>'
                    +'<dt><span><img src="'+e.resultInfo[i].portrait+'"></span></dt>'
                       +'<dd>'
                          +'<p>'+e.resultInfo[i].username+'</p>'
                         +'<p>'+_a+'</p>'
                      +'</dd>'
                    +'</dl>'
                  +'</div>';
          //渲染信息
          html+='<div class="origin_area">'
                   + ' <div class="origin_list">'
                   +     ''+isAlready+''
                   +     ' <ul>'
                   +     '     <li class="taskId">任务编号：<span>'+e.resultInfo[i].taskID+'</span></li>'
                   +     '     <li>任务类型：<span>'+e.resultInfo[i].type+'</span></li>'
                   +     '     <li>订单地址：<span>'+e.resultInfo[i].addr+'</span></li>'
                   +     '     <li>合 同 号：<span>'+e.resultInfo[i].contract+'</span></li>'
                   +     ' </ul>'
                   +  '</div> '
                   + ' <div class="progress_box">'
                   +       ' <i>木作进度：</i>'
                   +       ' <div class="progressBar">'
                   +       '   <div>'
                   +       '     <span></span>'
                   +       '   </div>'
                   +       '   <span class="round"></span>'
                   +       '   <span class="round"></span>'
                  +        '   <span class="round"></span> '   
                  +        '   <p>'
                  +        '      '+_aa+''
                  +        '   </p> ' 
                  +        ' </div>'
                  +   ' </div>'
                  +   ' <div class="infor_box">'+_b+'</div>'
                 + '</div>';
        html+="</div>";
    }
    $("#passenger_content").html(html);
    //为进度条添加样式的变化
    $(".progressBar>p").find("a").addClass("light_color");
  }
  //为进度条添加样式
  function styleFn(){
    for(var i=0,len=$(".passenger_list").length;i<len;i++){
        var _obj=$(".passenger_list").eq(i);
        if(_obj.find(".progressBar").find("a").text()=="初测"){
          _obj.find(".progressBar").find(".round").eq(0).addClass('round_active');
          _obj.find(".progressBar>div").find("span").css({"width":"0%"}).addClass("progress_active");
        }else if(_obj.find(".progressBar").find("a").text()=="复测"){
          _obj.find(".progressBar").find(".round").eq(0).addClass('round_active');
          _obj.find(".progressBar").find(".round").eq(1).addClass('round_active');
          _obj.find(".progressBar>div").find("span").css({"width":"50%"}).addClass("progress_active");
        }else if(_obj.find(".progressBar").find("a").text()=="确认"){
          _obj.find(".progressBar").find(".round").eq(0).addClass('round_active');
          _obj.find(".progressBar").find(".round").eq(1).addClass('round_active');
          _obj.find(".progressBar").find(".round").eq(2).addClass('round_active');
          _obj.find(".progressBar>div").find("span").css({"width":"100%"}).addClass("progress_active");
        }
    }
  }
  //任务列表的搜索功能
  $("#search_btn").on("click",function(){
      var text=$("#input_txt").val();
      if($.trim(text)!=""){
        //ajax的url路径
        param_url=json._url+"/"+json._nameCustommade+"/task/like";
        $.ajax({
            url:param_url,
            dataType:"json",
            type:"post",
            data:{
              userId:userId,
              t:text
            },
            success:function(e){
               indexFn(e);
               styleFn();
            },
            error:function(){
               console.log("请求页面失败！");
            }
        })
      }else{
        return false;
      }
  })
  //订单状态筛选功能
  $(".isAlready").on("click",function(){
      $(this).addClass("click_status").siblings().removeClass();
      if($(this).text()=="未完成"){  //0 代表所有未完成的状态 
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/task/ifwancheng",
          dataType:"json",
          type:"post",
          data:{
            userId:userId,
            status:0
          },
          success:function(e){
            indexFn(e);
            styleFn();
          },
          error:function(){
            console.log("页面请求失败！");
          }
        })
        $(this).text("完成");
      }else{
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/task/ifwancheng",
          dataType:"json",
          type:"post",
          data:{
            userId:userId,
            status:6
          },
          success:function(e){
            indexFn(e);
            styleFn();
          },
          error:function(){
            console.log("页面请求失败！");
          }
        })
      }
  })
  //进度状态筛选功能
  $(".isTest").on("click",function(){
    $(this).addClass("click_status").siblings().removeClass();
    if($(this).text()=="初测"){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/task/ceshi",
        type:"post",
        dataType:"json",
        data:{
           userId:userId,
           ceStatus:1
        },
        success:function(e){
          indexFn(e);
          styleFn();
        },
        error:function(){
          console.log("请求页面失败！")
        }
      })
      $(this).text("复测");
    }else if($(this).text()=="复测"){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/task/ceshi",
        type:"post",
        dataType:"json",
        data:{
           userId:userId,
           ceStatus:2
        },
        success:function(e){
          indexFn(e);
          styleFn();
        },
        error:function(){
          console.log("请求页面失败！")
        }
      })
      $(this).text("确认");
    }else if($(this).text()=="确认"){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/task/ceshi",
        type:"post",
        dataType:"json",
        data:{
           userId:userId,
           ceStatus:3
        },
        success:function(e){
          indexFn(e);
          styleFn();
        },
        error:function(){
          console.log("请求页面失败！")
        }
      })
    }
  })
  //预警状态筛选功能
  $(".isNormal").on("click",function(){
      $(this).addClass("click_status").siblings().removeClass();
      if($(this).text()=="正常"){
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/task/ifzhengchang",
          type:"post",
          dataType:"json",
          data:{
             userId:userId,
             chStatus:1
          },
          success:function(e){
            indexFn(e);
            //为进度条添加样式
            styleFn();
          },
          error:function(){
            console.log("请求页面失败！")
          }
        })
        $(this).text("异常");
      }else if($(this).text()=="异常"){
          $.ajax({
            url:json._url+"/"+json._nameCustommade+"/task/ifzhengchang",
            type:"post",
            dataType:"json",
            data:{
              userId:userId,
              chStatus:2
            },
            success:function(e){
              indexFn(e);
              styleFn();
            },
            error:function(){
              console.log("请求页面失败！")
            }
          })
        $(this).text("紧急");
      }else if($(this).text()=="紧急"){
        $.ajax({
            url:json._url+"/"+json._nameCustommade+"/task/ifzhengchang",
            type:"post",
            dataType:"json",
            data:{
              userId:userId,
              chStatus:3
            },
            success:function(e){
              indexFn(e);
              styleFn();
            },
            error:function(){
              console.log("请求页面失败！")
            }
        })
      }
  })
  //点击每一个列表，进入订单列表页
  $("#passenger_content").on("click",".passenger_list",function(){
    var taskId=$(this).find(".taskId").children().text();
    $.session.set('taskId',taskId);  //任务编号的存储
    window.location.href="order.html"; 
  })
  //三种状态滑过功能的样式变化
  function status_Hover(){
    $(".isAlready").on("mouseover",function(){
      $(this).addClass("hover_status");
      $(this).css({"cursor":"pointer"});
    }).on("mouseout",function(){
        $(this).removeClass("hover_status");
    })
    $(".isTest").on("mouseover",function(){
      $(this).addClass("hover_status");
      $(this).css({"cursor":"pointer"});
    }).on("mouseout",function(){
        $(this).removeClass("hover_status");
    })
    $(".isNormal").on("mouseover",function(){
      $(this).addClass("hover_status");
      $(this).css({"cursor":"pointer"});
    }).on("mouseout",function(){
        $(this).removeClass("hover_status");
    })
  }
  status_Hover();
  //任务列表头像的控制
  function _HeightFn(){
    var dt_W=$(".basic_area>dl").find("dt").outerWidth();
    $(".basic_area>dl").find("dt").css("height",dt_W+'px')
  }
  _HeightFn();
  $(window).on("resize",function(){
     _HeightFn();
  })
})