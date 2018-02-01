$(function(){
    var taskId=$.session.get("taskId");  //获取任务编号
    var userId=$.session.get("userId");   //登录用户的id
    //一打开页面，订单列表的数据渲染
   /* $.ajax({
        url:json._url+"/"+json._nameCustommade+"/task/orderList",
        type:"post",
        dataType:"json",
        data:{
            userId:userId,
            taskId:taskId
        },
        beforeSend:function(){   //一打开，加载页面的动画
            var loadImg="";
            loadImg+='<div class="loadImg_box">'
                        +'<div class="loader-inner line-spin-fade-loader">'
                            +'<div></div>'
                            +'<div></div>'
                            +'<div></div>'
                            +'<div></div>'
                            +'<div></div>'
                            +'<div></div>'
                            +'<div></div>'
                            +'<div></div>'
                        +'</div>' 
                    '</div>'
            $(loadImg).prependTo($("body"));
        },
        success:function(e){
           $(".loadImg_box").remove();
            orderListFn(e);
        },
        error:function(){
            alert("请重示！");
        }
    })*/
    //刷新页面操作的功能
    function refreshFn(){
        $.ajax({
            url:json._url+"/"+json._nameCustommade+"/task/orderList",
            type:"post",
            dataType:"json",
            data:{
                userId:userId,
                taskId:taskId
            },
            beforeSend:function(){   //一打开，加载页面的动画
                var loadImg="";
                loadImg+='<div class="loadImg_box">'
                            +'<div class="loader-inner line-spin-fade-loader">'
                                +'<div></div>'
                                +'<div></div>'
                                +'<div></div>'
                                +'<div></div>'
                                +'<div></div>'
                                +'<div></div>'
                                +'<div></div>'
                                +'<div></div>'
                            +'</div>' 
                    '</div>'
                $(loadImg).prependTo($("body"));
            },
            success:function(e){
               $(".loadImg_box").remove(); 
               orderListFn(e);
            },
            error:function(){
               alert("请重示！");
            }
        })
    }
    //订单列表的数据
    function orderListFn(e){
        var str="", 
            html="",
            order_status="", //订单状态
            edit_btn="",  //编辑、查看按钮
            remove_btn="",  //删除,撤回,退单按钮
            progress="";  //当前任务进度
            //左上角的任务信息渲染
            str+='<dl>'
                       +'<dt>'
                            +'<span><img src="'+e.resultInfo.upData[0].portrait+'" alt=""></span>'
                       +' </dt>'
                       +'<dd>'
                           +'<p>任务编号：<span>'+e.resultInfo.upData[0].taskID+'</span></p>'
                           +'<p>任务类型：<span>'+e.resultInfo.upData[0].type+'</span></p>'
                           +'<p>合 同 号：<span>'+e.resultInfo.upData[0].contract+'</span></p>'
                           +'<p><span>合计金额：</span><span>'+e.resultInfo.upData[0].amounts+'元</span></p>'
                           +'<p><span>订单地址：</span><span>'+e.resultInfo.upData[0].addr+'</span></p>'
                       +'</dd>'
                +'</dl>'
            $(".basic_information").html(str);
            //当前任务进度的数据渲染
            progress+='<h2>当前任务进度</h2>'
                      +'<div class="progress_box">'
                            +'<div class="progressBar">'
                            +'    <div>'
                            +'      <span></span>'
                            +'    </div>'
                            +'    <span></span>'
                            +'    <span></span>'
                            +'    <span></span>'
                            +'    <span></span>'
                            +'    <span></span>'
                            +'    <span></span>'
                            +'    <p>'
                                +'   <a href="#">初测</a>'
                                +'   <a href="#">复测</a>'
                                +'   <a href="#">确认</a>'
                                +'   <a href="#">交款</a>'
                                +'   <a href="#">生产完成</a>'
                                +'   <a href="#">安装完成</a>'
                                +'</p>'
                            +'</div>'
                       +'</div>'
            $(".order-progress").html(progress);
            //判断当前任务的进度
            if(e.resultInfo.upData[0].progress==1){ //初测
                $(".progressBar>p").find("a").eq(0).addClass("hight_active");
                $(".progressBar>span").eq(0).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(1).html("<img src='static/images/stay.png' style='margin-top:-3px;'/>");
                $(".progressBar>div").find("span").css({"width":"20%"}).addClass("progress_active");
            }else if(e.resultInfo.upData[0].progress==2){  //复测
                $(".progressBar>p").find("a").eq(0).addClass("hight_active");
                $(".progressBar>p").find("a").eq(1).addClass("hight_active");
                $(".progressBar>span").eq(0).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(1).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(2).html("<img src='static/images/stay.png' style='margin-top:-3px;'/>");
                $(".progressBar>div").find("span").css({"width":"40%"}).addClass("progress_active");
            }else if(e.resultInfo.upData[0].progress==3){  //确认
                $(".progressBar>p").find("a").eq(0).addClass("hight_active");
                $(".progressBar>p").find("a").eq(1).addClass("hight_active");
                $(".progressBar>p").find("a").eq(2).addClass("hight_active");
                $(".progressBar>span").eq(0).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(1).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(2).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(3).html("<img src='static/images/stay.png' style='margin-top:-3px;'/>");
                $(".progressBar>div").find("span").css({"width":"60%"}).addClass("progress_active");
            }else if(e.resultInfo.upData[0].progress==4){  //交款
                $(".progressBar>p").find("a").eq(0).addClass("hight_active");
                $(".progressBar>p").find("a").eq(1).addClass("hight_active");
                $(".progressBar>p").find("a").eq(2).addClass("hight_active");
                $(".progressBar>p").find("a").eq(3).addClass("hight_active");
                $(".progressBar>span").eq(0).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(1).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(2).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(3).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(4).html("<img src='static/images/stay.png' style='margin-top:-3px;'/>");
                $(".progressBar>div").find("span").css({"width":"80%"}).addClass("progress_active");
            }else if(e.resultInfo.upData[0].progress==5){  //生产完成
                $(".progressBar>p").find("a").eq(0).addClass("hight_active");
                $(".progressBar>p").find("a").eq(1).addClass("hight_active");
                $(".progressBar>p").find("a").eq(2).addClass("hight_active");
                $(".progressBar>p").find("a").eq(3).addClass("hight_active");
                $(".progressBar>p").find("a").eq(4).addClass("hight_active");
                $(".progressBar>span").eq(0).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(1).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(2).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(3).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(4).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(5).html("<img src='static/images/stay.png' style='margin-top:-3px;'/>");
                $(".progressBar>div").find("span").css({"width":"100%"}).addClass("progress_active");
            }else if(e.resultInfo.upData[0].progress==6){  //安装完成
                $(".progressBar>p").find("a").eq(0).addClass("hight_active");
                $(".progressBar>p").find("a").eq(1).addClass("hight_active");
                $(".progressBar>p").find("a").eq(2).addClass("hight_active");
                $(".progressBar>p").find("a").eq(3).addClass("hight_active");
                $(".progressBar>p").find("a").eq(4).addClass("hight_active");
                $(".progressBar>p").find("a").eq(5).addClass("hight_active");
                $(".progressBar>span").eq(0).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(1).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(2).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(3).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(4).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(5).html("<img src='static/images/already.png' style='margin-top:0px;'/>");
                $(".progressBar>span").eq(6).html("<img src='static/images/stay.png' style='margin-top:-3px;'/>");
            }
            //木作订单列表的数据(表格部分)
            for(var i in e.resultInfo.downData){
                //判断订单状态，以及相应的按钮状态 
                if(e.resultInfo.downData[i].state==0){
                   order_status="<td>已退单</td>"; 
                   edit_btn="查看";
                   remove_btn="删除";
                }else if(e.resultInfo.downData[i].state==1){
                   order_status="<td>未提交</td>"; 
                   edit_btn="编辑";
                   remove_btn="删除";
                }else if(e.resultInfo.downData[i].state==2){
                   order_status="<td>待确认</td>"; 
                   edit_btn="查看";
                   remove_btn="撤回";
                }else if(e.resultInfo.downData[i].state==3){
                   order_status="<td>待交款</td>"; 
                   edit_btn="查看";
                   remove_btn="撤回";
                }else if(e.resultInfo.downData[i].state==4){
                   order_status="<td>客户退回</td>"; 
                   edit_btn="编辑";
                   remove_btn="删除";
                }else if(e.resultInfo.downData[i].state==5){
                   order_status="<td>客户已交款</td>";  
                   edit_btn="查看";
                   remove_btn="退单";
                }
                html+='<tr>'
                       +'<td>'+e.resultInfo.downData[i].orderID+'</td>'
                       +''+order_status+''
                       +'<td>'+e.resultInfo.downData[i].orderDate+'</td>'
                       +'<td>'+e.resultInfo.downData[i].payDate+'</td>'
                       +'<td>'
                           +'<div class="btn-group">'
                               +'<button class="ifshow_btn">'+edit_btn+'</button>'
                               +'<button class="change_btn">变更</button>'
                               +'<button class="ifremove_btn">'+remove_btn+'</button>'
                           +'</div>'
                       +'</td>'
                   +'</tr>'
            }
            $(".order_tableBox").html(html);
            //变更按钮的状态
            for(var i in e.resultInfo.downData){
              if(e.resultInfo.downData[i].state!=5){
                $(".order_tableBox").find("tr").eq(i).find(".btn-group").children("button").eq(1).addClass("disable_status");
                $(".order_tableBox").find("tr").eq(i).find(".btn-group").children("button").eq(1).attr("disabled",true);
              }else if(e.resultInfo.downData[i].state==5){
                $(".order_tableBox").find("tr").eq(i).find(".btn-group").children("button").eq(1).removeClass("disable_status");
              }
            }  
    }
    //遮罩层,弹窗的创建
    function markFn(){
        $.ajax({
            url:json._url+"/"+json._nameCustommade+"/task/houseDetail",
            type:"post",
            dataType:"json",
            data:{
                userId:userId,
                taskId:taskId
            },
            success:function(e){
                var str="",_a="",_houseType="";
                //判断客户等级                
                if(e.resultInfo[0].customerLevel==1){
                    _a='<p>客户等级：<span><img src="static/images/vip.png" style="width:34px;height:18px;" /></span></p>';   
                }else if(e.resultInfo[0].customerLevel==2){
                    _a='<p>客户等级：<span><img src="static/images/svip.png" alt="" /></span></p>';
                }else if(e.resultInfo[0].customerLevel==3){
                    _a='<p>客户等级：<span></span></p>';
                }
                //判断房屋类型
                if(e.resultInfo[0].houseType==1){
                    _houseType='<p>房屋类型：<span>老房</span></p>';
                }else if(e.resultInfo[0].houseType==2){
                    _houseType='<p>房屋类型：<span>新房</span></p>';
                }
                str+='<div class="mark"></div>'
                    +'<div class="dialog_box">'
                        +'<a href="#" class="close_btn"><img src="static/images/close.png"/></a>'
                        +'<h2>任务信息详情</h2>'
                        +'<div class="mask_detail">'
                            +'<h4>客户信息</h4>'
                            +'<div class="personal_information">'
                                +'<p>客户姓名：<span>'+e.resultInfo[0].username+'</span></p>'
                                +''+_a+''
                                +'<p>手机号：<span>'+e.resultInfo[0].mobile+'</span></p>'
                            +'</div>'
                            +'<h4>房屋信息</h4>'
                            +'<div class="house_information">'
                                +''+_houseType+''
                                +'<p>面积：<span>'+e.resultInfo[0].floorArea+'㎡</span></p>'
                                +'<p><span>'+e.resultInfo[0].room+'</span>室<span>'+e.resultInfo[0].hall+'</span>厅<span>'+e.resultInfo[0].toilet+'</span>卫<span>'+e.resultInfo[0].kitchen+'</span>厨</p>'
                            +'</div>'
                            +'<div class="detail_area">'
                                +'<p>详细地址：<span>'+e.resultInfo[0].addr+'</span></p>'
                            +'</div>'
                            +'<h4>任务信息</h4>'
                            +'<div class="mask_information">'
                                +'<p>任务类型：<span>'+e.resultInfo[0].type+'</span></p>'
                                +'<p>合同号：<span>'+e.resultInfo[0].contract+'</span></p>'
                            +'</div>'
                            +'<div class="mask_decoration">'
                                +'<span>任务描述：</span>'
                                +'<textarea name="" id="" cols="30" rows="10" disabled="disabled" style="background:#fff;">'+e.resultInfo[0].remarks+'</textarea>'
                            +'</div>'
                        +'</div>'
                    +'</div>'
                $(str).prependTo($("body"));
                //点击关闭按钮将其删掉
                $(".close_btn").on("click",function(){
                    $(".mark").hide();
                    $(".dialog_box").hide();
                })
            },
            error:function(){
                alert("请重示！");
            }
        })
    }
    //点击任务信息，调取弹窗，进入详情页面
    $("#passenger_information").on("click",function(){
       markFn();
    })
    //点击查看，编辑按钮，进入订单清单页面
    $(".order_tableBox").on("click",".ifshow_btn",function(){
        $(this).addClass("edit_status");
        $(this).parents("tr").nextAll("tr").find("td").find(".ifshow_btn").removeClass("edit_status");
        $(this).parents("tr").prevAll("tr").find("td").find(".ifshow_btn").removeClass("edit_status");
        if($(this).text()=="查看"){
           //获取当前行的订单编号
           var orderId=$(this).parents("tr").find("td").eq(0).text();
           $.session.set("orderId",orderId);
           window.location.href="detail.html";
        }else if($(this).text()=="编辑"){
           var orderId=$(this).parents("tr").find("td").eq(0).text()
           $.session.set("orderId",orderId);
           window.location.href="detail.html";
        } 
    })
    //点击删除，撤回，退单按钮时的操作
    $(".order_tableBox").on("click",".ifremove_btn",function(){
       $(this).addClass("remove_status");
       $(this).parents("tr").nextAll("tr").find("td").find(".ifremove_btn").removeClass("remove_status");
       $(this).parents("tr").prevAll("tr").find("td").find(".ifremove_btn").removeClass("remove_status");
       if($(this).text()=="删除"){
            //获取当前行的订单编号
            var orderId=$(this).parents("tr").find("td").eq(0).text(),
                dialog='';
            $.session.set("orderId",orderId);
            //调用删除弹框
            dialog+='<div class="remove_dialog">'
                        +'<h2>提示</h2>'
                        +'<p>您确定要删除此条订单吗？</p>'
                        +'<div class="btn_group">'
                            +'<button id="sure_btn">确定</button>'
                            +'<button id="cancel_btn">取消</button>'
                        +'</div>'
                    +'</div>'
            $(dialog).prependTo($("body"));
            $("#sure_btn").on("click",function(){
                $(this).addClass("sure_btn");
                $.ajax({
                    url:json._url+"/"+json._nameCustommade+"/task/deleteOrder",
                    dataType:"json",
                    type:"post",
                    data:{
                        orderId:orderId
                    },
                    success:function(e){
                        if(e.resultCode==200){  //删除成功
                            refreshFn();
                            var success_dialog="";
                            success_dialog+='<div class="success_dialog">'
                                                +'<h2>删除成功</h2>'
                                            '</div>'
                            $(".remove_dialog").remove();  //删除提示框消失
                            $(success_dialog).prependTo($("body"));//删除成功弹框出现
                            setInterval(function(){
                                $(".success_dialog").remove();
                            },1000)
                        }else if(e.resultCode==500){  //删除失败
                            $(".remove_dialog").remove();  //删除提示框消失
                            var fail_dialog="";
                            fail_dialog+='<div class="fail_dialog">'
                                                +'<h2>删除失败</h2>'
                                               /* +'<p>'+e.msg+'</p>'*/
                                            '</div>'
                            $(fail_dialog).prependTo($("body"));//删除成功弹框出现
                            setInterval(function(){
                                $(".fail_dialog").remove();
                            },1000)
                        }
                    },
                    error:function(){
                        alert("请重示！");
                    }
                })
            })
            $("#cancel_btn").on("click",function(){
                $(".ifremove_btn").removeClass("remove_status");
                $(".remove_dialog").remove();
            })
       }else if($(this).text()=="撤回"){
            //获取当前行的订单编号
            var orderId=$(this).parents("tr").find("td").eq(0).text();
            $.session.set("orderId",orderId);
            $.ajax({
                url:json._url+"/"+json._nameCustommade+"/task/rocallOrder",
                type:"post",
                dataType:"json",
                data:{
                    orderId:orderId
                },
                success:function(e){
                    if(e.resultCode==200){
                        refreshFn();
                    }
                },
                error:function(){
                   alert("请重示！");
                }
            })
       }else if($(this).text()=="退单"){
            //获取当前行的订单编号
            var orderId=$(this).parents("tr").find("td").eq(0).text();
            $.session.set("orderId",orderId); 
            $.ajax({
                url:json._url+"/"+json._nameCustommade+"/task/backOrder",
                type:"post",
                dataType:"json",
                data:{
                   orderId:orderId 
                },
                success:function(e){
                   if(e.resultCode==200){
                       refreshFn();
                   }
                },
                error:function(){
                    alert("请重示！");
                }
            })
       }
    })
    //点击变更按钮的操作，进入订单清单页面
    $(".order_tableBox").on("click",".change_btn",function(){
        window.location.href="detail.html";
    })
    //订单列表表格部分划过样式的变化
    $(".order_tableBox").on("mouseover","tr",function(){
        $(this).addClass("hover_bg");
    }).on("mouseout","tr",function(){
        $(this).removeClass("hover_bg");
    })
    //订单列表的订单状态排序功能操作
    $(".default_order").on("click",function(){  //升序
        $(this).attr("src","/static/images/down.png");
        $(this).css({"top":"25px"});
        $(this).addClass("down_order");
        $(this).removeClass("default_order");
        $.ajax({
            url:json._url+"/"+json._nameCustommade+"/task/rankOrder",
            dataType:"json",
            data:{
                userId:userId,
                taskId:taskId,
                flag:0
            },
            success:function(e){
                orderListFn(e);
            },
            error:function(){
                alert("请求超时！");
            }
        })
        $(".down_order").on("click",function(){  //降序
            if($(this).hasClass("down_order")){
                $(this).attr("src","/static/images/up.png");
                $(this).removeClass("down_order");
                $.ajax({
                    url:json._url+"/"+json._nameCustommade+"/task/rankOrder",
                    dataType:"json",
                    data:{
                        userId:userId,
                        taskId:taskId,
                        flag:1
                    },
                    success:function(e){
                        orderListFn(e);
                    },
                    error:function(){
                        alert("请求超时！");
                    }
                })
            }else{
                $(this).attr("src","/static/images/down.png");
                $(this).addClass("down_order");
                $.ajax({
                    url:json._url+"/"+json._nameCustommade+"/task/rankOrder",
                    dataType:"json",
                    data:{
                        userId:userId,
                        taskId:taskId,
                        flag:0 
                    },
                    success:function(e){
                        orderListFn(e);
                    },
                    error:function(){
                        alert("请求超时！");
                    }
                })
            }
        })
    })
    //任务列表头像的控制
    function _HeightFn(){
        var dt_W=$(".basic_information>dl").find("dt").outerWidth();
        $(".basic_information>dl").find("dt").css("height",dt_W+'px');
    }
    _HeightFn();
    $(window).on("resize",function(){
        _HeightFn();
        if($(window).width()>=1440){
            pieFn(-220,25);
        }else{
            pieFn(-400,-100);
        }
    })
    //统计区域饼状图的调用
    /*function pieFn(a,b){ 
        $.ajax({
            url:json._url+"/"+json._nameCustommade+"/task/orderPie",
            dataType:"json",
            type:"post",
            data:{
                taskId:taskId
            },
            success:function(e){
                //各种标识的数据
                var back=e.resultInfo.back, //已退单
                    noSubmit=e.resultInfo.noSubmit, //未提交
                    confirm=e.resultInfo.confirm,  //待确认
                    waitPay=e.resultInfo.waitPay, //待交款
                    rocall=e.resultInfo.rocall, //客户退回
                    payed=e.resultInfo.payed, //客户已交款
                    backPercent=back/100,
                    noSubmitPercent=noSubmit/100,
                    confirmPercent=confirm/100,
                    waitPayPercent=waitPay/100,
                    rocallPercent=rocall/100,
                    payedPercent=payed/100;
                $('#total_box').highcharts({
                    chart:{
                        type: 'pie',
                        height:175,
                        marginLeft:a
                    },
                    credits:{
                        enabled: false   //右下角不显示LOGO
                    },
                    title:{
                        text: '',
                    },
                    subtitle:{
                        text: '',
                    },
                    exporting:{//Highcharts 图表导出功能模块。
                        enabled: false
                    },
                    colors:['#117c86', '#38bded', '#f0ad4e', '#38af70',
                           '#f67768','red'],
                    legend:{
                      //layout: 'vertical',
                      floating:true,
                      backgroundColor:'#EEF3FA',
                      align:'right',
                      verticalAlign: 'top',
                      y:30,
                      x:b,
                      itemMarginBottom :3,//图例的上下间距
                      maxHeight:200,
                      width:250,
                      height:160,
                      symbolHeight: 14,//高度
                      symbolWidth:14,
                      symbolRadius:0,
                      symbolPadding:15,
                      navigation:{
                          activeColor:'#3E576F',
                          animation: true,
                          arrowSize: 1,
                          inactiveColor: '#CCC',
                          useHTML: true,
                          style:{
                              fontWeight: 'bold',
                              color: '#333',
                              fontSize: '12px'
                          }
                      }
                    },
                    plotOptions:{
                      pie:{
                          allowPointSelect: false,
                          cursor: 'pointer',
                          dataLabels: {
                              enabled: false
                          },
                          showInLegend: true,
                          symbolWidth: 24,
                          point:{
                              events:{
                                  legendItemClick: function (e) {
                                      return false; // 直接 return false 即可禁用图例点击事件
                                  }
                              }
                          }
                      }
                    },
                    series:[{
                        data:[
                            ['已退单'+'<br><span style="text-align:center;">'+back+'</span>',backPercent],
                            ['未提交'+'<br><span style="text-align:center;">'+noSubmit+'</span>',noSubmitPercent],
                            ['待确认'+'<br><span style="text-align:center;">'+confirm+'</span>',confirmPercent],
                            ['待交款'+'<br><span style="text-align:center;">'+waitPay+'</span>',waitPayPercent],
                            ['客户退回'+'<br><span style="text-align:center;">'+rocall+'</span>',rocallPercent],
                            ['客户已交款'+'<br><span style="text-align:center;">'+payed+'</span>',payedPercent]
                        ]
                    }]
                })
            },
            error:function(){
                alert("请求超时！");
            }
        })
    }*/
    //pieFn(-220,25);
    //点击新增时跳转空间选择页面
    $("#new_order").on("click",function(){
        window.location.href="newfunction.html";
    })
    //点击待办事项进入新增待办
    /*$(".information_btn").on("click",function(){
        window.location.href="list.html";
    })*/
})