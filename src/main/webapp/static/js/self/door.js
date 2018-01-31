
$(function(){
  var kind_choice=$.session.get("kind_choice"), //类别选择
      roomDetailName=$.session.get("space_choice"),  //空间选择
      productType="", //类别状态
      title=$.session.get("space_choice"),//录入木门界面的标题设置 
      modelName=""; //木门品类的型号 (死值)
  var Door_H="", //木门的高
      str_H="", //高度的标准值
      max_H="", //最大值的高
      min_H="", //最小值的高
      step_H="", //最小刻度的高
      Door_W="", //木门的宽
      str_W="", //宽度的标准值
      max_W="", //最大值的宽
      min_W="", //最小值的宽
      step_W="", //最小刻度的宽
      Door_D="", //木门的厚
      str_D="", //厚度的标准值
      max_D="", //最大值的厚
      min_D="", //最小值的厚
      step_D=""; //最小刻度的厚
  $("#space_title").html(title);
  var category_name="", //品类名称
      brand_name="", //品牌名称
      series_name="", //系列名称
      color_name="", //花色名称
      model_name="", //型号名称
      openForm="", //木门配置的开启方向
      door_H="",  //提交木门的高
      door_W="", //提交木门的宽
      door_D="", //提交木门的厚
      wire_name="",  //套线名称
      wireLine="",  //门套线里外
      wireLineIn="", //门套线里
      wireLineOut="", //门套线外
      glass_name="",  //玻璃
      lock_name="", //锁具
      hinge_name="", //合页
      stopper_name="", //门吸
      sildeway_name="",  //滑轨
      remarks="", //标注
      config_hardware="",  //双扇门五金
      door_size="",  //扇宽尺寸调整
      door_num="", //门扇数量(内置，外挂)
      scheme=$.session.get("orderId"), //方案（订单编号）
      model="",  //型号名称
      doorb_widthMin="",  //子母门大门的最小值
      doorb_widthMax="", //子母门大门的最大值
      doorl_widthMin="", //子母门小门的最小值
      doorl_widthMax="", //子母门小门的最大值
      diffentb_Min="",  //大门的最小值
      diffentb_Max="", //大门的最大值
      singlebig_from="", //子母门中大门可调节的范围
      singlebig_to="", //子母门中大门可调节的范围
      doorBig_width="", //子母门中大门的宽度
      doorLittle_width="", //子母门中小门的宽度
      doorLittleModel="", //子母门中小门造型的宽
      flag=0,   //第三方变量
      flag_btn=true, //确认提交按钮
      sonMon=0,  //子母门玻璃型号变量
      flag_doorNum=false,   //内置、外挂门扇数量控制
      flag_double=false;  //子母门的扇宽尺寸调整变量
    //子母门的宽扇尺寸调整的功能操作
    $("#Widefan_input").on("click",function(){
      if($(this).prop("checked")){
        $("#Widefan_list").show();
      }else{
        $("#Widefan_list").hide();
      }
    })
    function selectDoorleafAdjustFn(){  //子母门的宽扇尺寸调整
      if(flag_double==true){
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/door/selectDoorleafAdjust",
          type:"post",
          data:{
            modelName:model_name //型号名称
          },
          dataType:"json",
          success:function(e){
            if(e.resultCode==200){
              for(var i in e.resultInfo){
                if(e.resultInfo[i].type==1){ //大门
                  doorb_widthMin=e.resultInfo[i].widthMin;  //大门最小值 600
                  doorb_widthMax=e.resultInfo[i].widthMax;  //大门最大值 900
                }
                if(e.resultInfo[i].type==2){ //小门
                  doorl_widthMin=e.resultInfo[i].widthMin; //小门最小值  300
                  doorl_widthMax=e.resultInfo[i].widthMax; //小门最大值  600
                  doorLittleModel=e.resultInfo[i].modelMin;  //小门的造型尺寸
                }
              }
              diffentb_Min=door_W-doorl_widthMax;  //总宽-小门的最大值=大门的最小值   700
              diffentb_Max=door_W-doorl_widthMin;  //总宽-小门的最小值=大门的最大值   1000
              if(diffentb_Min>=doorb_widthMin){
                singlebig_from=diffentb_Min;  //700
              }else{
                singlebig_from=doorb_widthMin;
              }
              if(diffentb_Max<=doorb_widthMax){
                singlebig_to=doorb_widthMax;
              }else{
                singlebig_to=diffentb_Max;
              } 
              $('.single-sliderdoorW').jRange({  //子母门的大门的尺寸调整(700-1000)
                from:singlebig_from,
                to:singlebig_to,
                step:5,
                format:'%s',
                showLabels:true,
                showScale:true,
                onstatechange:function(){
                  doorBig_width=$('.single-sliderdoorW')[0].value; //大门的宽度调整
                  doorLittle_width=door_W-doorBig_width; //小门的宽度
                 /* if(doorLittle_width>=doorLittleModel){  //能做造型
                  }else{
                    alert("小门扇不能够做造型哦！");
                  }*/
                }
              }) 
            }else{
              alert("请求页面数据失败11！");
            }
            var val=singlebig_from+','+singlebig_to;
            $('.single-sliderdoorW').jRange('updateRange',val); //更改滑块的范围
          },
          error:function(){
            alert("error3");
          }
        })
      }else{
        return;
      }
    }
    //根据类别选择判断明细页面对应的数据
    if(kind_choice=="木门"){
      productType=1;
    }else if(kind_choice=="橱柜"){
      productType=2;
    }else if(kind_choice=="卫浴柜"){
      productType=3;
    }else if(kind_choice=="整体家装"){
      productType=4;
    }else if(kind_choice=="定制家具"){
      productType=5;
    }
    //根据不同品类的木门，判断给后台传入的参数
    $("#categroy_list").on("click","dl",function(){
      if($(this).find("dd").text()=="平开门"){
        sonMon=0;
        modelName="PP01";
        selectProductSize(modelName);
        flag=1;
        flag_doorNum=false;
        flag_double=false;
      }else if($(this).find("dd").text()=="对开门"){
        sonMon=0;
        modelName="DP01";
        selectProductSize(modelName);
        flag=2;
        flag_doorNum=false;
        flag_double=false;
      }else if($(this).find("dd").text()=="内置推拉门"){
        sonMon=0;
        modelName="TN01";
        selectProductSize(modelName);
        flag=3;
        flag_doorNum=true;
        flag_double=false;
      }else if($(this).find("dd").text()=="外挂推拉门"){
        sonMon=0;
        modelName="TW01";
        selectProductSize(modelName);
        flag=4;
        flag_doorNum=true;
        flag_double=false;
      }else if($(this).find("dd").text()=="子母门"){
        sonMon=1;
        modelName="ZP01";
        selectProductSize(modelName);
        flag=5;
        flag_doorNum=false;
        flag_double=true;
      }else if($(this).find("dd").text()=="窗套/垭口"){
        sonMon=0;
        modelName="窗套/垭口";
        selectProductSize(modelName);
        flag=6;
        flag_doorNum=false;
        flag_double=false;
      }else if($(this).find("dd").text()=="护角"){
        sonMon=0;
        modelName="护角";
        selectProductSize(modelName);
        flag=7;
        flag_doorNum=false;
        flag_double=false;
      }
    })
    //品牌的接口渲染
    function leftBrandFn(){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/cusProduct/selectBrandName",
        type:"post",
        dataType:"json",
        async:false,
        data:{productType:productType},
        success:function(e){
          if(e.resultCode==200){
            var html="<ul>"
            for(var i in e.resultInfo){
               html+='<li><a href="#">'+e.resultInfo[i].brandName+'</a></li>'
            }
            html+="</ul>";
            $("#brand_list").html(html);
            //点击品牌添加样式
            $("#brand_list>ul").on("click","li",function(){
              if($(this).hasClass('active')){
                $(this).removeClass('active');
              }else{
                $(this).addClass('active');
              }
              var liText=$(this).text();
              $(".brand_title").text(liText);
            })
            brand_name=$("#brand_list>ul>li").eq(0).find("a").text();
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时！");
        }
      })
    }
    leftBrandFn();
    //默认的品类接口渲染
    $.ajax({
      url:json._url+"/"+json._nameCustommade+"/cusProduct/selectProductCategory",
      type:"post",
      dataType:"json",
      data:{productType:productType},
      success:function(e){
        if(e.resultCode==200){
            modelName="PP01";//默认平开门的型号
            selectProductSize(modelName);
            changeHtmlFn();
        }else{
          alert("请求失败！");
        }
      },
      error:function(){
        alert("请求超时！");
      }
    })
    //品类的接口渲染
    function leftCategoryFn(){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/cusProduct/selectProductCategory",
        type:"post",
        dataType:"json",
        data:{productType:productType},
        success:function(e){
          if(e.resultCode==200){
              var html="";
              for(var i in e.resultInfo){
                html+='<dl>'
                        +'<dt><img src="static/images/floor_03.png" alt=""></dt>'
                        +'<dd>'+e.resultInfo[i].categoryName+'</dd>'
                      +'</dl>'
              }
              $("#categroy_list").html(html);
              $("#categroy_list").on("click","dl",function(){ 
                //点击品类时，清空所有的值
                series_name=""; //系列名称
                color_name=""; //花色名称
                model_name=""; //型号名称
                openForm=""; //木门配置的开启方向
                door_H="";  //提交木门的高
                door_W=""; //提交木门的宽
                door_D=""; //提交木门的厚
                wire_name="";  //套线名称
                wireLine="";  //门套线里外
                wireLineIn=""; //门套线里
                wireLineOut=""; //门套线外
                glass_name="";  //玻璃
                lock_name=""; //锁具
                hinge_name=""; //合页
                stopper_name=""; //门吸
                sildeway_name="";  //滑轨
                remarks=""; //标注
                config_hardware="";  //双扇门五金
                door_size="";  //扇宽尺寸调整
                door_num=""; //门扇数量(内置，外挂)
                $(this).addClass('dl_active').siblings('').removeClass("dl_active");
              })
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时！");
        }
      })
    }
    leftCategoryFn();
    //默认的型号接口渲染
    $.ajax({
      url:json._url+"/"+json._nameCustommade+"/cusProduct/selectModelName",
      type:"post",
      dataType:"json",
      data:{productType:productType},
      success:function(e){
        if(e.resultCode==200){
          var html=e.resultInfo[0].modelName;
          $("#model_txt").text(html);
        }else{
          alert("请求失败！");
        }
      },
      error:function(){
        alert("请求超时！");
      }
    })
    //型号的接口渲染
    function leftModelFn(){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/cusProduct/selectModelName",
        type:"post",
        dataType:"json",
        data:{productType:productType},
        success:function(e){
          leftModelRefresh(e);
        },
        error:function(){
          alert("请求超时！");
        }
      })
    }
    leftModelFn();
    //型号列表的刷新
    function leftModelRefresh(e){
      if(e.resultCode==200){
        var html="";
        for(var i in e.resultInfo){
          html+='<dl>'
                +'<dt><img src="'+e.resultInfo[i].img+'" alt=""></dt>'
                +'<dd>'+e.resultInfo[i].modelName+'</dd>'
              +'</dl>'
        }
        $("#model_list").html(html);
        //点击不同的型号添加样式
        $("#model_list").on("click","dl",function(){
          $(this).addClass('dl_active').siblings().removeClass("dl_active");
          model_name=$(this).find("dd").text();
          $(".model_title").text(model_name);
          $("#model_txt").text(model_name);
        })
      }else{
        alert("请求失败！");
      }
    }
    //型号列表的搜索功能
    $("#search_btn").on("click",function(){
      var inputModel=$.trim($("#input_txt").val());
      if(inputModel!=""){
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/likeProductModel",
          type:"post",
          data:{
            productType:productType,
            modelName:inputModel
          },
          dataType:"json",
          success:function(e){
            leftModelRefresh(e);
          },
          error:function(){
            alert("请求超时！");
          }
        })
      }else{
        return false;
      }
    })
    //依据品类去查询型号的数据渲染
    $("#categroy_list").on("click","dl",function(){
      category_name=$(this).find("dd").text();
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/cusProduct/selectModelByCategory",
        type:"post",
        dataType:"json",
        data:{
          productType:1, //类别(木门)
          brandName:brand_name, //品牌名称
          categoryName:category_name, //品类名称
        },
        success:function(e){
         if(e.resultCode==200){
          var html="";
          for(var i in e.resultInfo){
            html+='<dl>'
                 +'<dt><img src="'+e.resultInfo[i].img+'" alt="" /></dt>'
                 +'<dd>'+e.resultInfo[i].modelName+'</dd>'
               +'</dl>'
          } 
          $("#model_list").html(html);
          //点击型号列表，加载材质、配置不同的内容
          $("#model_list").on("click","dl",function(){
            //点击型号列表清空所有的值
            series_name=""; //系列名称
            color_name=""; //花色名称
            openForm=""; //木门配置的开启方向
            door_H="";  //提交木门的高
            door_W=""; //提交木门的宽
            door_D=""; //提交木门的厚
            wire_name="";  //套线名称
            wireLine="";  //门套线里外
            wireLineIn=""; //门套线里
            wireLineOut=""; //门套线外
            glass_name="";  //玻璃
            lock_name=""; //锁具
            hinge_name=""; //合页
            stopper_name=""; //门吸
            sildeway_name="";  //滑轨
            remarks=""; //标注
            config_hardware="";  //双扇门五金
            door_size="";  //扇宽尺寸调整
            door_num=""; //门扇数量(内置，外挂)
            flag_btn=true;
            model=$(this).find("dd").text();
            isshow_glass(model);  //是否加载玻璃选项
            selectSeriesNameFn(model);   //型号与系列的关联
          })
         }else{
          alert("请求页面数据失败！");
         }
        },
        error:function(){
          alert("请求超时12！");
        }
      })
    })
    //不同品类的门的尺寸设置的初始值渲染
    function selectProductSize(modelName){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/cusProduct/selectProductSize",
        type:"post",
        dataType:"json",
        data:{modelName:modelName},
        success:function(e){
          if(e.resultCode==200){
            str_H=""; //高度的标准值
            str_W=""; //宽度的标准值
            str_D=""; //厚度的标准值
            for(var i in e.resultInfo){
              //判断维度
              if(e.resultInfo[i].dimension==1){ //高度
                if(e.resultInfo[i].type==1){
                  Door_H=e.resultInfo[i].value; //初始值
                }
                if(e.resultInfo[i].type==2){ //标准值
                  str_H+='<li>'+e.resultInfo[i].value+'</li>';
                }
                if(e.resultInfo[i].type==3){
                  max_H=e.resultInfo[i].value; //最大值
                }
                if(e.resultInfo[i].type==4){
                  min_H=e.resultInfo[i].value; //最小值
                } 
                if(e.resultInfo[i].type==5){
                  step_H=e.resultInfo[i].value; //最小刻度
                }
              }
              if(e.resultInfo[i].dimension==2){ //宽度
                if(e.resultInfo[i].type==1){
                  Door_W=e.resultInfo[i].value;
                }
                if(e.resultInfo[i].type==2){
                  str_W+='<li>'+e.resultInfo[i].value+'</li>';
                }
                if(e.resultInfo[i].type==3){
                  max_W=e.resultInfo[i].value;
                }
                if(e.resultInfo[i].type==4){
                  min_W=e.resultInfo[i].value;
                } 
                if(e.resultInfo[i].type==5){
                  step_W=e.resultInfo[i].value;
                }
              }
              if(e.resultInfo[i].dimension==3){ //厚度
                if(e.resultInfo[i].type==1){
                  Door_D=e.resultInfo[i].value;
                }
                if(e.resultInfo[i].type==2){
                  str_D+='<li>'+e.resultInfo[i].value+'</li>';
                }
                if(e.resultInfo[i].type==3){
                  max_D=e.resultInfo[i].value;
                }
                if(e.resultInfo[i].type==4){
                  min_D=e.resultInfo[i].value;
                } 
                if(e.resultInfo[i].type==5){
                  step_D=e.resultInfo[i].value;
                }
              }
            }
            $(".outview_H").html(str_H);
            $(".outview_W").html(str_W);
            $(".outview_D").html(str_D);
            //高度调整
            $('.single-sliderH').jRange({
              from:min_H,
              to:max_H,
              step:step_H,
              format:'%s',
              showLabels:true,
              showScale:true,
              onstatechange:function(){
                var slider_textH=$('.single-sliderH')[0].value; //变化的高度
                door_H=slider_textH; //木门的高
                for(var i=0,len=$("#outview_H_1 li").length;i<len;i++){ //关联
                  var eleVal=$("#outview_H_1 li").eq(i).html();
                  if(door_H==eleVal){
                    $("#outview_H_1 li").eq(i).addClass('active').siblings().removeClass('active');
                  }else{
                    $("#outview_H_1 li").eq(i).removeClass('active');
                  }
                }
              }
            }) 
            //点击高度的标准值来提交数据
            $(".outview_H").on("click","li",function(){
              $(this).addClass('active').siblings().removeClass("active");
              var LiTextH=$(this).text();
              door_H=LiTextH; 
              $('.single-sliderH').jRange('setValue',LiTextH);//更改滑块的位置
            })
            //宽度调整
            $('.single-sliderW').jRange({
              from:min_W,
              to:max_W,
              step:step_W,
              format:'%s',
              showLabels:true,
              showScale:true,
              onstatechange:function(){
                var slider_textW=$('.single-sliderW')[0].value; //变化的宽度
                door_W=slider_textW; //木门的宽
                actingdoorFn();  //内置、外挂推拉门门扇数量的操作
                selectDoorleafAdjustFn(); //子母门扇宽尺寸调整
                for(var i=0,len=$("#outview_W_1 li").length;i<len;i++){ //关联
                  var eleVal=$("#outview_W_1 li").eq(i).html();
                  if(door_W==eleVal){
                    $("#outview_W_1 li").eq(i).addClass('active').siblings().removeClass('active');
                  }else{
                    $("#outview_W_1 li").eq(i).removeClass('active');
                  }
                }
              }
            })
            //点击宽度的标准值来提交数据
            $(".outview_W").on("click","li",function(){
              $(this).addClass('active').siblings().removeClass("active");
              var LiTextW=$(this).text();
              door_W=LiTextW;
              $('.single-sliderW').jRange('setValue',LiTextW);//更改滑块的位置
            })
            //厚度调整
            $('.single-sliderD').jRange({
              from:min_D,
              to:max_D,
              step:step_D,
              format:'%s',
              showLabels:true,
              showScale:true,
              onstatechange:function(){
                var slider_textD=$('.single-sliderD')[0].value; //变化的厚度
                door_D=slider_textD; //木门的厚
                for(var i=0,len=$("#outview_D_1 li").length;i<len;i++){ //关联
                  var eleVal=$("#outview_D_1 li").eq(i).html();
                  if(door_D==eleVal){
                    $("#outview_D_1 li").eq(i).addClass('active').siblings().removeClass('active');
                  }else{
                    $("#outview_D_1 li").eq(i).removeClass('active');
                  }
                }
              }
            })
            //点击厚度的标准值来提交数据
            $(".outview_D").on("click","li",function(){
              $(this).addClass('active').siblings().removeClass("active");
              var LiTextD=$(this).text();
              door_D=LiTextD; 
              $('.single-sliderD').jRange('setValue',LiTextD);
            })
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时！");
        }
      })
    }
    function isshow_glass(model){
      if(sonMon==1){
        $(".glass_show").show();
        $(".glass_title").show();
        $("#glass_underline").show();
      }else{
        if(model.indexOf("B")<0 && model.indexOf("b")<0){ //不含B、b返回-1，不显示五金中的玻璃选项
          $(".glass_show").hide();
          $(".glass_title").hide();
          $("#glass_underline").hide();
        }else{
          $(".glass_show").show();
          $(".glass_title").show();
          $("#glass_underline").show();
        }
      }
    }
    //依据型号关联系列列表
    function selectSeriesNameFn(model){
      $("#flowser_show").html("");
      $(".block_list").html("");
      $(".shundoor_list").html("");
      $("#xian_show").html("");
      $(".page_list").html("");
      $("#glass_show").html("");  
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/cusProduct/selectSaleSeries",
        dataType:"json",
        type:"post",
        data:{
          productType:1, //类别(木门)
          modelName:model  //型号名称
        },
        success:function(e){
          if(e.resultCode==200){
            var html="";
            for(var i in e.resultInfo){ //系列
              html+='<dl>'
                   +'<dt><img src="'+e.resultInfo[i].img+'" alt="" /></dt>'
                   +'<dd>'+e.resultInfo[i].seriesName+'</dd>'
                +'</dl>'
            }
            $("#flowser_material").html(html);
            $("#colorUnderline").hide();
          }else{
            alert("请求页面数据失败！");
          }
        },
        error:function(){
          alert("error");
        }
      })
    }
    $("#flowser_material").on("click","dl",function(){ //点击系列渲染花色
      if($(this).hasClass('active')){
        $(this).removeClass('active');
        $("#flowser_show").html("");
        $(".block_list").html("");
        $(".shundoor_list").html("");
        $("#xian_show").html("");
        $(".page_list").html("");
        $("#glass_show").html("");
        $("#colorUnderline").hide();
      }else{
        $(this).addClass('active').siblings('').removeClass('active');
        series_name=$(this).find("dd").text();
        selectProductColorFn(series_name,model);  //渲染花色列表
        $("#colorUnderline").show();
      }
    })
    //依据系列去查询花色的数据渲染
    function selectProductColorFn(series_name,model){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/cusProduct/selectSaleColor",
        dataType:"json",
        type:"post",
        data:{
          seriesName:series_name, //系列名称
          productType:1, //类别(木门)
          modelName:model   //型号名称
        },
        success:function(e){
          if(e.resultCode==200){
            var html="";
            for(var i in e.resultInfo){
              html+='<dl>'
                     +'<dt><img src="'+e.resultInfo[i].colorImg+'" alt="" /></dt>'
                     +'<dd>'+e.resultInfo[i].colorName+'</dd>'
                  +'</dl>'
            }
            $("#flowser_show").html(html);
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时13！");
        }
      })
    }
    $("#flowser_show").on("click","dl",function(){ //点击花色渲染五金、套线
      if($(this).hasClass('active')){
        $(this).removeClass('active');
        $(".block_list").html("");
        $(".shundoor_list").html("");
        $("#xian_show").html("");
        $(".page_list").html("");
        $("#glass_show").html("");
      }else{
        $(this).addClass('active').siblings('').removeClass('active');
        color_name=$(this).find("dd").text();
        selectDoorWireFn(color_name,model); //依据花色查询套线、五金
      }
    })
    //依据花色查询套线、五金的数据渲染
    function selectDoorWireFn(color_name,model){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/cusProduct/selectHardwareWireByModel",
        dataType:"json",
        data:{
          productType:1, //类别(木门)
          modelName:model, //型号名称
          colorName:color_name //花色名称
        },
        type:"post",
        success:function(e){
          if(e.resultCode==200){
            var lockhtml="",
                shundoorhtml="",
                xianhtml="",
                pagehtml="",
                huaguihtml="",
                doublehtml="",
                glasshtml="";
            for(var i in e.resultInfo){
              for(var j in e.resultInfo[i]){
                if(e.resultInfo[i][j].hardwareType=="锁具"){
                  lockhtml+='<dl>'
                    +'<dt><img src="'+e.resultInfo[i][j].img+'" alt="" /></dt>'
                    +'<dd>'+e.resultInfo[i][j].hardwareName+'</dd>'
                  +'</dl>'
                } 
                if(e.resultInfo[i][j].hardwareType=="门吸"){
                  shundoorhtml+='<dl>'
                    +'<dt><img src="'+e.resultInfo[i][j].img+'" alt="" /></dt>'
                    +'<dd>'+e.resultInfo[i][j].hardwareName+'</dd>'
                  +'</dl>'
                }
                if(e.resultInfo[i][j].hardwareType=="门套线"){
                   xianhtml+='<dl>'
                    +'<dt><img src="'+e.resultInfo[i][j].img+'" alt="" /></dt>'
                    +'<dd>'+e.resultInfo[i][j].hardwareName+'</dd>'
                  +'</dl>'
                }
                if(e.resultInfo[i][j].hardwareType=="合页"){
                  pagehtml+='<dl>'
                    +'<dt><img src="'+e.resultInfo[i][j].img+'" alt="" /></dt>'
                    +'<dd>'+e.resultInfo[i][j].hardwareName+'</dd>'
                  +'</dl>'
                }
                if(e.resultInfo[i][j].hardwareType=="玻璃"){
                  glasshtml+='<dl>'
                    +'<dt><img src="'+e.resultInfo[i][j].img+'" alt="" /></dt>'
                    +'<dd>'+e.resultInfo[i][j].hardwareName+'</dd>'
                  +'</dl>'
                }
                if(e.resultInfo[i][j].hardwareType=="滑轨"){
                  huaguihtml+='<dl>'
                    +'<dt><img src="'+e.resultInfo[i][j].img+'" alt="" /></dt>'
                    +'<dd>'+e.resultInfo[i][j].hardwareName+'</dd>'
                  +'</dl>'
                }
                if(e.resultInfo[i][j].hardwareType=="双扇门五金"){
                  doublehtml+='<dl>'
                    +'<dt><img src="'+e.resultInfo[i][j].img+'" alt="" /></dt>'
                    +'<dd>'+e.resultInfo[i][j].hardwareName+'</dd>'
                  +'</dl>'
                }
              }
            }
            $(".block_list").html(lockhtml);
            $(".shundoor_list").html(shundoorhtml);
            $("#xian_show").html(xianhtml);
            $(".page_list").html(pagehtml);
            $("#glass_show").html(glasshtml);
            $(".huagui_list").html(huaguihtml);
            $("#Hardware_list").html(doublehtml);
            $("#lettergate_list").html(doublehtml);
            $(".block_list").on("click","dl",function(){ //锁具
              if($(this).hasClass('active')){
                $(this).removeClass('active');
              }else{
                $(this).addClass('active').siblings('').removeClass("active");
              }
              lock_name=$(this).find("dd").text();
            })  
            $(".shundoor_list").on("click","dl",function(){ //门吸
              if($(this).hasClass('active')){
                $(this).removeClass('active');
              }else{
                $(this).addClass('active').siblings('').removeClass("active");
              }
              stopper_name=$(this).find("dd").text();
            })  
            $("#xian_show").on("click","dl",function(){ //套线
              if($(this).hasClass('active')){
                $(this).removeClass('active');
              }else{
                $(this).addClass('active').siblings('').removeClass("active");
              }
              wire_name=$(this).find("dd").text();
            })  
            $(".page_list").on("click","dl",function(){ //合页
              if($(this).hasClass('active')){
                $(this).removeClass('active');
              }else{
                $(this).addClass('active').siblings('').removeClass("active");
              }
              hinge_name=$(this).find("dd").text();
            })
            $("#glass_show").on("click","dl",function(){ //玻璃
              if($(this).hasClass('active')){
                $(this).removeClass('active');
              }else{
                $(this).addClass('active').siblings('').removeClass("active");
              }
              glass_name=$(this).find("dd").text();
            })
            $(".huagui_list").on("click","dl",function(){ //滑轨
              if($(this).hasClass('active')){
                $(this).removeClass('active');
              }else{
                $(this).addClass('active').siblings('').removeClass("active");
              }
              huagui_name=$(this).find("dd").text();
            })
            $("#Hardware_list").on("click","dl",function(){ //对开门双扇门五金
              if($(this).hasClass('active')){
                $(this).removeClass('active');
              }else{
                $(this).addClass('active').siblings('').removeClass("active");
              }
              config_hardware=$(this).find("dd").text();
            }) 
            $("#lettergate_list").on("click","dl",function(){ //子母门双扇门五金
              if($(this).hasClass('active')){
                $(this).removeClass('active');
              }else{
                $(this).addClass('active').siblings('').removeClass("active");
              }
              config_hardware=$(this).find("dd").text();
            })     
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时9！");
        }
      })
    }
    //木门配置的开启方向
    $(".start_decoration>ul").on("click","li",function(){
      $(this).addClass('active').siblings('').removeClass('active');
      openForm=$(this).attr("data-txt");
    })
    //内置推拉门、外挂推拉门的门扇数量的功能操作
    //点击宽度的标准值来提交数据
    $(".outview_W").on("click","li",function(){
      var LiTextW=$(this).text();
      door_W=LiTextW; 
      actingdoorFn();  //内置、外挂推拉门门扇数量的操作
      selectDoorleafAdjustFn(); //子母门扇宽尺寸调整
    })
    function actingdoorFn(){
      if(flag_doorNum==true){
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/door/selectSildingDoorNum",
          type:"post",
          dataType:"json",
          data:{
            brandName:brand_name,//品牌
            categoryName:category_name,//品类（内置还是外挂）
            width:door_W//宽度
          },
          success:function(e){
            if(e.resultCode==200){
              var html="";
              for(var i in e.resultInfo){
                html+='<li>'+e.resultInfo[i]+'</li>';
              }
              $(".doorNum_ul").html(html);
              //默认第一个显示高亮
              $(".doorNum_ul").find("li").eq(0).addClass('active');
            }else{
              alert("请求页面数据失败！");
            }
          },
          error:function(){
            alert("error2");
          }
        })
      }else{
        return;
      }
    }
    $(".doorNum>ul").on("click","li",function(){  //点击门扇数量添加高亮
      $(this).addClass('active').siblings('').removeClass("active");
      door_num=$(this).text();
    })
    //确认提交保存木门订单详情的功能操作
    $("#confirm_btn").on("click",function(){
      if(flag_btn){
        if(flag==1){ //平开门
        }else if(flag==2){
        }else if(flag==3){
        }else if(flag==4){
        }else if(flag==5){
        }else if(flag==6){
        }else if(flag==7){
        }
        wireLine=$("#otherDoor").val();
        wireLineIn=$("#initDoor").val();
        wireLineOut=$("#outDoor").val();
        console.log(productType,brand_name,category_name,model_name,series_name,color_name,door_H,door_W,door_D,openForm,wire_name,wireLine,wireLineIn,wireLineOut,glass_name,lock_name,hinge_name,stopper_name,scheme,sildeway_name,remarks,config_hardware,doorBig_width,doorLittle_width,door_num);
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/door/saveDoor",
          type:"post",
          dataType:"json",
          data:{
            productType:1, //木门(类别)
            brandName:brand_name,   //品牌
            scheme:scheme,   //订单编号
            roomDetailName:roomDetailName, //空间选择
            categoryName:category_name, //品类
            modelName:model_name, //型号
            seriesName:series_name,//系列
            colorName:color_name, //花色
            height:door_H,  //高
            width:door_W, //宽
            deep:door_D, //厚
            openForm:openForm,   //开启方向
            wireName:wire_name, //套线
            wireLengthIn:wireLineIn, //门套线里
            wireLengthOut:wireLineOut, //门套线外
            wireLength:wireLine, //门套线里外
            glassName:glass_name, //玻璃
            lockName:lock_name, //锁具
            hingeName:hinge_name, //合页
            stopperName:stopper_name, //门吸
            sildewayName:sildeway_name, //滑轨
            configHardware:config_hardware,  //双扇门五金
            doorNum:door_num,  //门扇数量
            doorLargeSize:doorBig_width, //子母门大门的宽度
            doorSmallSize:doorLittle_width, //子母门小门的宽度
            remarks:remarks  //标注
          },
          success:function(e){
            if(e.resultCode==200){
              console.log(e);
              $(".success_dialog").show();
              setTimeout(function(){
                $(".success_dialog").remove();
                window.location.href="detail.html";
              },2000)
            }else{
              alert("请求页面数据失败！");
            }
          },
          error:function(){
            alert("error1");
          }
        })
        flag_btn=false;
      }else{
        return;
      }
    })
})