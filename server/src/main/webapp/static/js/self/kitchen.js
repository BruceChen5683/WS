$(function(){
    //品牌、类别、型号的展开，折叠
    var leftStyleFn=function(){
        $(".brand_box h2").find("img").attr("src","static/images/2_03.png");
        $(".click_style").on("click",function(){
           if($(this).next().is(":hidden")){
                $(this).next().slideDown();
                $(this).find("img").attr("src","static/images/2_03.png");
           }else{
                $(this).next().slideUp();
                $(this).find("img").attr("src","static/images/1_03.png");
           }
        })
    }
    leftStyleFn();
    //窗口调节大小时，右边盒子外观部分高度的计算
    function HeightFn(){
       var _liW=$("._ulW").find("li").width();
           $("._ulW").find("li").css({"height":_liW*3/4+"px"});
           $("._ulW").find("li").css({"line-height":_liW*3/4+"px"});
           $("._ulW").css({"height":_liW*3/4+"px"});
    }
    $("window").on("resize",function(){
       HeightFn();
    })
    HeightFn();
    //外观、内部结构的展开，折叠
    var rightStyleFn=function(){
        $(".outview_box h2").find("img").attr("src","static/images/2_03.png");
        $(".right_click").on("click",function(){
           if($(this).next().is(":hidden")){
                $(this).next().slideDown();
                $(this).find("img").attr("src","static/images/2_03.png");
           }else{
                $(this).next().slideUp();
                $(this).find("img").attr("src","static/images/1_03.png");
           }
        })
    }
    rightStyleFn();
    //外观部分（高度）进度条的调整,插件调用
    function outview_H(){
      $('.single-sliderH').jRange({
        from:600,
        to:1200,
        step:1,
        format:'%s',
        showLabels:true,
        showScale:true
      })
    }
    outview_H();
    //外观部分（宽度）进度条的调整,插件调用
    function outview_W(){
      $('.single-sliderW').jRange({
        from:600,
        to:1200,
        step:1,
        format:'%s',
        showLabels:true,
        showScale:true
      })
    }
    outview_W();
    //外观部分（深度）进度条的调整，插件调用
    function outview_D(){
      $('.single-sliderD').jRange({
        from:600,
        to:1200,
        step:1,
        format:'%s',
        showLabels:true,
        showScale:true
      })
    }
    outview_D();
    //内部结构部分（宽度）进度条的调整，插件调用
    function intview_W(){
      $('.single-sliderW').jRange({
        from:600,
        to:1200,
        step:1,
        format:'%s',
        showLabels:true,
        showScale:true
      })
    }
    outview_W();
    //内部结构部分（高度）进度条的调整，插件调用
    function intview_H(){
      $('.single-sliderH').jRange({
        from:600,
        to:1200,
        step:1,
        format:'%s',
        showLabels:true,
        showScale:true
      })
    }
    outview_W();
})