$(function(){
    var taskId=$.session.get("taskId"),   //获取任务编号
        orderId=$.session.get("orderId"), //当前订单编号
        userId=$.session.get("userId");   //登录用户的id
    //清单(订单详情列表)的数据渲染
    $.ajax({
        url:json._url+"/"+json._nameCustommade+"/task/orderDetail",
        dataType:"json",
        type:"post",
        data:{
           /* userId:userId,
            taskId:taskId,*/
            orderId:orderId
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
            detailListFn(e);
        },
        error:function(){
            console.log("请求页面失败！");
        }
    })
    //刷新页面操作的功能
    function refreshFn(){
        $.ajax({
            url:json._url+"/"+json._nameCustommade+"/task/orderDetail",
            type:"post",
            dataType:"json",
            data:{
                /*userId:userId,
                taskId:taskId,*/
                orderId:orderId
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
               detailListFn(e);
            },
            error:function(){
               alert("请重示！");
            }
        })
    }
    //清单列表的数据渲染
    function detailListFn(e){
        console.log(e);
        var html="",
            str="", 
            detail_status="";//订单状态
        //左上角的房屋信息数据渲染
       /* html+='<dl>'
                   +'<dt>'
                        +'<span><img src="'+e.resultInfo.upData[0].portrait+'" alt=""></span>'
                   +' </dt>'
                   +' <dd>'
                   +'     <p>任务编号：<span>'+e.resultInfo.upData[0].taskID+'</span></p>'
                   +'     <p>任务类型：<span>'+e.resultInfo.upData[0].type+'</span></p>'
                   +'     <p>合 同 号：<span>'+e.resultInfo.upData[0].contract+'</span></p>'
                   +'     <p>当前订单：<span>'+e.resultInfo.upData[0].orderID+'</span></p>'
                   +'     <p><span>订单地址：</span><span>'+e.resultInfo.upData[0].addr+'</span></p>'
                  +'  </dd>'
                +'</dl>'
        $(".basic_information").html(html);*/
        //订单详情列表数据渲染
        for(var i in e.resultInfo.downData){
            //判断订单详情的按钮状态，以及相应的按钮状态 
           /* if(e.resultInfo.downData[i].state==0){
               edit_btn="查看";
               remove_btn="删除";
            }else if(e.resultInfo.downData[i].state==1){
               edit_btn="编辑";
               remove_btn="删除";
            }else if(e.resultInfo.downData[i].state==2){
               edit_btn="查看";
               remove_btn="删除";
            }else if(e.resultInfo.downData[i].state==3){
               edit_btn="查看";
               remove_btn="删除";
            }else if(e.resultInfo.downData[i].state==4){ 
               edit_btn="编辑";
               remove_btn="删除";
            }else if(e.resultInfo.downData[i].state==5){
               edit_btn="查看";
               remove_btn="删除";
            }*/
            str+='<tr>'
                    +'<td>'+e.resultInfo.downData[i].productID+'</td>'
                    +'<td>'+e.resultInfo.downData[i].roomDetailName+'</td>'
                    +'<td>'+e.resultInfo.downData[i].productType+'</td>'
                    +'<td>'+e.resultInfo.downData[i].brandName+'</td>'
                    +'<td>'+e.resultInfo.downData[i].categoryName+'</td>'
                    +'<td>'+e.resultInfo.downData[i].modelName+'</td>'
                   /* +'<td>'
                        +'<div class="btn-group">'
                        +'    <button class="ifshow_btn">'+edit_btn+'</button>'
                        +'    <button class="change_btn">变更</button>'
                        +'    <button class="ifremove_btn">'+remove_btn+'</button>'
                        +'</div>'
                    +'</td>'*/
                    +'<td>'
                        +'<div class="btn-group">'
                        +'    <button class="ifshow_btn">查看</button>'
                        +'    <button class="change_btn">变更</button>'
                        +'    <button class="ifremove_btn">删除</button>'
                        +'</div>'
                    +'</td>'
                +'</tr>'
        }
        $(".detail_tableBox").html(str);
        //变更按钮的状态
        for(var i in e.resultInfo.downData){
          if(e.resultInfo.downData[i].state!=5){
            $(".detail_tableBox").find("tr").eq(i).find(".btn-group").children("button").eq(1).addClass("disable_status");
            $(".detail_tableBox").find("tr").eq(i).find(".btn-group").children("button").eq(1).attr("disabled",true);
          }else if(e.resultInfo.downData[i].state==5){
            $(".detail_tableBox").find("tr").eq(i).find(".btn-group").children("button").eq(1).removeClass("disable_status");
          }
        } 
        //删除按钮的状态操作
        for(var i in e.resultInfo.downData){
            if(e.resultInfo.downData[i].state==0 ||e.resultInfo.downData[i].state==2 || e.resultInfo.downData[i].state==3 || e.resultInfo.downData[i].state==5){
                $(".detail_tableBox").find("tr").eq(i).find(".btn-group").children("button").eq(2).addClass("removedisabled_status");
                $(".detail_tableBox").find("tr").eq(i).find(".btn-group").children("button").eq(2).attr("disabled",true);
            }else if(e.resultInfo.downData[i].state==1 || e.resultInfo.downData[i].state==4){
                $(".detail_tableBox").find("tr").eq(i).find(".btn-group").children("button").eq(2).removeClass("removedisabled_status");
            }
        } 
    }
    //遮罩层的创建
    function markFn(){
        $.ajax({
            url:json._url+"/"+json._nameCustommade+"/task/orderInfo",
            type:"post",
            data:{
                orderId:orderId
            },
            success:function(e){
                var str="", 
                    detail_status="";
                //订单状态的判断
                if(e.resultInfo[0].state==0){
                    detail_status="已退单";
                }else if(e.resultInfo[0].state==1){
                    detail_status="未提交";
                }else if(e.resultInfo[0].state==2){
                    detail_status="待确认";
                }else if(e.resultInfo[0].state==3){
                    detail_status="已确认";
                }else if(e.resultInfo[0].state==4){
                    detail_status="客户退回";
                }else if(e.resultInfo[0].state==5){
                    detail_status="客户已交款";
                }
                str+='<div class="mark"></div>'
                    +'<div class="dialog_box">'
                        +'<a href="#" class="close_btn"><img src="static/images/close.png"/></a>'
                        +'<h2>订单信息详情</h2>'
                        +'<div class="pay_list">'
                            +'<ul>'
                                +'<li>订单编号：<span>'+e.resultInfo[0].orderID+'</span></li>'
                                +'<li>订单状态：<span>'+detail_status+'</span></li>'
                                +'<li>创建日期：<span>'+e.resultInfo[0].ordergenerationdate+'</span></li>'
                                +'<li>交款日期：<span>'+e.resultInfo[0].paydate+'</span></li>'
                                +'<li>计划交付日期：<span>'+e.resultInfo[0].orderdate+'</span></li>'
                            +'</ul>'
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
                console.log("页面请求失败！");
            }
        })
    }
    //点击任务信息，调取弹窗，进入详情页面
    $("#passenger_information").on("click",function(){
        markFn();
    })
    //点击查看，编辑按钮，进入产品明细页面
    $(".detail_tableBox").on("click",".ifshow_btn",function(){
        $(this).addClass("edit_status");
        $(this).parents("tr").nextAll("tr").find("td").find(".ifshow_btn").removeClass("edit_status");
        $(this).parents("tr").prevAll("tr").find("td").find(".ifshow_btn").removeClass("edit_status");
        if($(this).text()=="查看"){
           //获取当前行的清单编号
           var detailId=$(this).parents("tr").find("td").eq(0).text();
           $.session.set("detailId",detailId);
           //window.location.href="innitcontaic.html";
           window.location.href="door.html"
        }else if($(this).text()=="编辑"){
           var detailId=$(this).parents("tr").find("td").eq(0).text();
           $.session.set("detailId",detailId);
           //window.location.href="innitcontaic.html";
           window.location.href="door.html"
        } 
    })
    //点击删除按钮时的操作
    $(".detail_tableBox").on("click",".ifremove_btn",function(){
        $(this).addClass("remove_status");
        $(this).parents("tr").nextAll("tr").find("td").find(".ifremove_btn").removeClass("remove_status");
        $(this).parents("tr").prevAll("tr").find("td").find(".ifremove_btn").removeClass("remove_status");
        if($(this).text()=="删除"){
            //获取当前行的清单编号
            var detailId=$(this).parents("tr").find("td").eq(0).text(),
                dialog='';
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
                    url:json._url+"/"+json._nameCustommade+"/task/deleteOrderDetail",
                    dataType:"json",
                    type:"post",
                    data:{
                        productId:detailId  
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
                                               /* +'<p>'+e.resultMsg+'</p>'*/
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
                $(".remove_dialog").remove();
                $(".ifremove_btn").removeClass("remove_status");
            })
        }
    })
    //点击变更按钮的操作，进入订单清单页面
    $(".detail_tableBox").on("click",".change_btn",function(){
        window.location.href="innitcontaic.html";
    })
    //订单列表表格部分划过样式的变化
    $(".detail_tableBox").on("mouseover","tr",function(){
        $(this).addClass("hover_bg");
    }).on("mouseout","tr",function(){
        $(this).removeClass("hover_bg");
    })
    //统计区域饼状图的调用
    function d_pieFn(a,b){
        $.ajax({
            url:json._url+"/"+json._nameCustommade+"/task/orderDetailPie",
            dataType:"json",
            type:"post",
            data:{
                orderId:orderId
            },
            success:function(e){
                var json=e.resultInfo, 
                    str="", 
                    responsestr="";
                //构造data格式[[x1,y1],[x2,y2]...],特别注意的是这里构造完的是字符串  
                for(var i=0; i<json.length; i++){  
                    responsestr='['+'\"'+json[i].productType+'<br/>'+json[i].num+'\",'+json[i].num;
                    if(i<json.length-1){  
                        responsestr=responsestr+'],'; 
                    }else{  
                        responsestr=responsestr+']';  
                    } 
                    str=str+responsestr;  
                }  
                responsestr="["+str+"]"; 
                //将字符串转换成json数组格式，直接序列化。然后将此序列化的值赋给series中的data  
                var x=JSON.parse(responsestr);  
                $('#total_box').highcharts({
                    chart:{
                        type: 'pie',
                        height:180,
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
                             '#f67768','#ccc','red','yellow'],
                    legend:{
                        //layout: 'vertical',
                        floating:true,
                        backgroundColor:'#EEF3FA',
                        align:'right',
                        verticalAlign: 'top',
                        y:5,
                        x:b,
                        itemMarginBottom :5,//图例的上下间距
                        maxHeight:200,
                        width:400,
                        height:150,
                        symbolHeight: 12,//高度
                        symbolWidth:12,
                        symbolRadius:0,
                        itemDistance:10,
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
                        data:x //赋值
                    }]
                })
            },
            error:function(){
                alert("请求超时！");
            }
        })
    }
    //d_pieFn(-420,-50);
    //改变窗口大小的时候，饼状图的具体位置
    $(window).on("resize",function(){
        _HeightFn();
        if($(window).width()>=1440){
            d_pieFn(-420,-50);
        }else{
            d_pieFn(-300,100);
        }
    })
    //点击清单列表的新增，跳转到空间页面
    $("#new_btn").on("click",function(){
        window.location.href="newfunction.html";
    })
    //点击清单列表的撤回
    $("#remote_btn").on("click",function(){
        $("#confirm_btn").css({"background":"#ccc","color":"#fff"});
        $("#confirm_btn").attr("disabled",true);
        $.ajax({
            url:json._url+"/"+json._nameCustommade+"/task/rocallOrder",
            dataType:"json",
            data:{
                orderId:orderId
            },
            success:function(e){
                if(e.resultCode=200){
                    refreshFn();
                }
            },
            error:function(){
                alert("请求超时！");
            }
        })
    })
    //点击提交的时候，将这条订单推送给客户，工长
    $("#confirm_btn").on("click",function(){
        $("#remote_btn").css({"background":"#ccc","color":"#fff"});
        $("#remote_btn").attr("disabled",true);
    })
})