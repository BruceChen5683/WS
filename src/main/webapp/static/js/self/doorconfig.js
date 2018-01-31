$(function(){
  var modelName="",   //型号
      brandName="", //品牌名称
      wireName="", //套线型号名称
      default_brandName=$(".dl_brand").find("dd").text(),//默认的品牌列表
      categoryName="", //不同品类的门
      seriesName="", //材质列表的系列
      _seriesName="", //关联配置中的系列
      colorName="", //关联配置中的花色
      wire=[], //关联配置中的套线
      lock=[], //锁具
      hinge=[], //合页
      stooper=[], //门吸
      sildeway=[], //滑轨
      glass=[],//玻璃
      standard_H=[], //标准值的高
      standard_W=[], //标准值的宽
      standard_D=[]; //标准值的厚
  var type=1;  //控制提交按钮的不同的方法
    $(".config_nav").on("click","h2",function(){
      if($(this).text()=="关联配置"){
        type=2;
      }else if($(this).text()=="供应配置"){
        type=3;
      }else if($(this).text()=="销售配置"){
        type=4;
      }
    })
  var typeNumber=0,   //不同品类的门的型号保存的状态
      stateNumber=0,  //套线、材质、五金的保存状态
      colorStatus=0, //花色配置提交按钮的状态
      hardWareStatues=0, //五金配置提交按钮的状态
      hardwareType="",  //五金名称
      flag=1,  //新增录入、修改保存的变量
      rebuildSelect_status=0,  //不同品类门的修改查询状态
      category_rebuild=0,  //不同品类门的型号的修改功能
      category_Name="", //原来品类对应的型号名称
      category_Img="", //原來品类对应的型号的图片
      stateNumber_rebuild=0,//套线、材质、五金的修改状态
      wire_Name="", //原来套线列表的名称
      wireImg="", //原来套线列表的图片
      series_Name="", //原来系列的名称
      series_Img="", //原来系列的图片
      hardware_rebuild=0, //锁具，合页，五金，滑轨，玻璃的修改状态
      hardware_Name="", //五金类型名称
      hardware_Img="", //五金类型图片
      color_Name="", //原来花色名称
      color_Img="", //原来花色图片
      doorNum="",
      widthMin="",
      widthMax="",
      model_Name="",
      modelMin="",
      widthMin="",
      widthMax="",
      fileImg_status=0;  //不同品类的门对应的型号图片状态
    //是否显示隐藏
    function isShow_div(){
      //三个配置的切换部分
      $(".config_nav").on("click","h2",function(){
          $(this).addClass('active').siblings().removeClass("active");
          var h2Index=$(this).index();
          $("#config_switch").find(".nav_area").eq(h2Index).show().siblings().hide();
      })
      //点击品牌进入产品列表
      $(".dl_brand").on("click",function(){
          brandName=$(this).find("dd").text();
          $(".product_list").show();
          $(".brand_list").hide();
      })
      //点击不同的产品列表进入不同的品类列表
      $(".picture_product").on("click","dl",function(){
          var dlIndex=$(this).index();
          $(".category_list").find(".list").eq(dlIndex).show().siblings().hide();
          $(".product_list").hide();
      })
      //点击不同品类的门进入品类配置列表
      $("#picture_category").on("click","dl",function(){
        if($(this).find("dd").text()=="平开门"){
          $("#last_number").hide();   
        }else if($(this).find("dd").text()=="对开门"){
          $("#last_number").hide(); 
        }else if($(this).find("dd").text()=="窗套/垭口"){
          $("#last_number").hide();
        }else if($(this).find("dd").text()=="子母门"){
          $("#last_number").find("dd").text("子母门小门扇配置");
          $(".acting_list").hide();
        }
        $(".category_allocation").show();
        $(".category_list").hide();
      })
      //点击不同材质中的系列列表，进入型号配置中进行修改功能
      $("#picture_materail").on("click","dl",function(){
        $(".design_list").show();
        $(".materail_area").hide();
        var dl_seriesName=$(this).find("dd").text();
        $(".model1_name").val(dl_seriesName);
      })
      //点击不同品类的门的尺寸进入尺寸配置页面
      $(".Size").on("click",function(){
        $(".Size_list").show();
        $(".category_allocation").hide();
      })
      //尺寸配置界面的高宽厚切换
      $(".nav_Size>ul").on("click","li",function(){
        $(this).addClass('active').siblings().removeClass("active");
        var liIndex=$(this).index();
        $(".Size_switch").find(".area_list").eq(liIndex).show().siblings().hide();
      })
      //点击不同品类的门的型号进入门的型号列表
      $(".Model").on("click",function(){
        $(".model_list").show();
        $(".category_allocation").hide();
      })
      //点击推拉门数量进入推拉门数量配置页面
      $("#last_number").on("click",function(){
        if($(this).find("dd").text()=="子母门小门扇配置"){
          $(".Composite_list").show();
          $(".acting_list").hide();
          $(".confirm_btn").attr("id","friendDoor_btn");  //确认提交按钮的设置，子母门
          selectLashDoorSize();
        }else{
          $(".acting_list").show();
          $(".Composite_list").hide(); 
          $(".confirm_btn").attr("id","SildingDoor_btn");  //确认提交按钮的设置，内置推拉门(外挂推拉门)
        }
        $(".category_allocation").hide();
      })
      //点击新增按钮时，进入型号配置列表
      $("#newly_btn").on("click",function(){
        $(".edit_model").hide();   //点击新增创建时，编辑按钮隐藏
        $(".model_config").show();
        $(".brand_list").hide();
        $(".model_list").hide();
        $(".line_area").hide();
        $(".design_list").hide();
        $(".glass_list").hide();
        $(".materail_area").hide();
        $(".hardware_area").hide();
        $(".model_name").val("");
      })
      //点击型号-配置进入关联的型号列表
      $(".modelConfig").on("click",function(){
        $(".relevancy_config").show();
        $(".config_list").hide();
      })
      //点击关联配置中不同的门切换不同型号
      $(".brand_door>ul").on("click","li",function(){
        $(this).addClass('active').siblings().removeClass('active');
      })
      //点击关联配置中的不同的门的型号进入系列配置列表
      $(".model").on("click","dl",function(){
        $(".series_list").show();
        $(".relevancy_config").hide();
      })
      //点击下一步按钮，再次进入关联配置的型号列表
      $(".confirm_btn").on("click",function(){
          $(".contract_area").show();
          $(".relevancy_config").show();
          $(".config_list").hide();
          $(".series_list").hide();
          $(".sell_area").hide();
          if($(this).val()=="确认提交"){ //进入基础配置的尺寸配置页面
             $(".relevancy_config").hide();
          }
      })
    }
    isShow_div();
    //基础配置：不同品类列表的尺寸配置录入(高宽厚)
    $("#picture_category").on("click","dl",function(){
      $(".aa").remove(); //将带有aa的input框删掉
      var modelText=$(this).find("dd").text(); //不同平类的门  
      categoryName=modelText; 
      selectModelByCategory(categoryName);
      selectSildingDoorNum(categoryName);
      if(modelText=="平开门"){
        modelName="PP01";
        rebuildSelect_status=1;
        category_rebuild=1;
        fileImg_status=1;
      }else if(modelText=="内置推拉门"){
        modelName="TN01";
        rebuildSelect_status=2;
        category_rebuild=2;
        fileImg_status=2;
      }else if(modelText=="外挂推拉门"){
        modelName="TW01";
        rebuildSelect_status=3;
        category_rebuild=3;
        fileImg_status=3;
      }else if(modelText=="对开门"){
        modelName="DP01";
        rebuildSelect_status=4;
        category_rebuild=4;
        fileImg_status=4;
      }else if(modelText=="子母门"){
        modelName="ZP01";
        rebuildSelect_status=5;
        category_rebuild=5;
        fileImg_status=5;
      }else if(modelText=="窗套/垭口"){
        modelName="窗套/垭口";
        rebuildSelect_status=6;
        category_rebuild=6;
        fileImg_status=6;
      }else if(modelText=="护角"){
        modelName="护角";
        rebuildSelect_status=7;
        category_rebuild=7;
        fileImg_status=7;
      }
    })
    //基础配置中：点击高宽厚不同尺寸配置的录入
    $("#addH_input").on("click",function(){  //高度新建input框
      if($("#StandardH_list").find("input[type=text]").length>=6){
        $(this).attr("disabled",true);
      }else{
        $(this).attr("disabled",false);
        var inputSelector='<b class="aa" style="font-weight:normal"><input type="text"/>&nbsp;&nbsp;mm</b>';
        $("#StandardH_list").append(inputSelector); 
      }
    }) 
    $("#addW_input").on("click",function(){  //宽度新建input框
      if($("#StandardW_list").find("input[type=text]").length>=6){
        $(this).attr("disabled",true);
      }else{
        $(this).attr("disabled",false);
        var inputSelector='<b class="aa" style="font-weight:normal"><input type="text"/>&nbsp;&nbsp;mm</b>';
        $("#StandardW_list").append(inputSelector); 
      }
    }) 
    $("#addD_input").on("click",function(){  //厚度新建input框
      if($("#StandardD_list").find("input[type=text]").length>=6){
        $(this).attr("disabled",true);
      }else{
        $(this).attr("disabled",false);
        var inputSelector='<b class="aa" style="font-weight:normal"><input type="text"/>&nbsp;&nbsp;mm</b>';
        $("#StandardD_list").append(inputSelector); 
      }
    })
    //点击尺寸配置的修改按钮操作
    $(".edit_btn").on("click",function(){
      if(rebuildSelect_status==1){ //平开门修改
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/selectProductSizeType",
          type:"post",
          data:{
            modelName:modelName
          },
          dataType:"json",
          success:function(e){
            if(e.resultCode==200){
              var html="",
                  standard_H="",
                  standard_W="",
                  standard_D="",
                  max_H="",
                  min_H="",
                  scale_H="",
                  max_W="",
                  min_W="",
                  scale_W="",
                  max_D="",
                  min_D="",
                  scale_D="";
              for(var i in e.resultInfo){
                if(e.resultInfo[i].dimension==1){//高度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_H+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    if(e.resultInfo[i].value==null){
                      max_H="";
                    }else{
                      max_H=e.resultInfo[i].value; //最大值
                    }
                  }
                  if(e.resultInfo[i].type==4){
                    if(e.resultInfo[i].value==null){
                      min_H="";
                    }else{
                      min_H=e.resultInfo[i].value; //最小值
                    }
                  } 
                  if(e.resultInfo[i].type==5){
                    if(e.resultInfo[i].value==null){
                      scale_H="";
                    }else{
                      scale_H=e.resultInfo[i].value; //步长
                    }
                  }
                }
                if(e.resultInfo[i].dimension==2){//宽度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_W+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    if(e.resultInfo[i].value==null){
                      max_W="";
                    }else{
                      max_W=e.resultInfo[i].value; //最大值
                    }
                  }
                  if(e.resultInfo[i].type==4){
                    if(e.resultInfo[i].value==null){
                      min_W="";
                    }else{
                      min_W=e.resultInfo[i].value; //最小值
                    }
                  } 
                  if(e.resultInfo[i].type==5){
                    if(e.resultInfo[i].value==null){
                      scale_W="";
                    }else{
                      scale_W=e.resultInfo[i].value; //步长
                    }
                  }
                }
                if(e.resultInfo[i].dimension==3){//厚度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_D+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    if(e.resultInfo[i].value==null){
                      max_D="";
                    }else{
                      max_D=e.resultInfo[i].value; //最大值
                    }
                  }
                  if(e.resultInfo[i].type==4){
                    if(e.resultInfo[i].value==null){
                      min_D="";
                    }else{
                      min_D=e.resultInfo[i].value; //最小值
                    }
                  } 
                  if(e.resultInfo[i].type==5){
                    if(e.resultInfo[i].value==null){
                      scale_D="";
                    }else{
                      scale_D=e.resultInfo[i].value; //步长
                    }
                  }
                }
              }
              $("#StandardH_list").html(standard_H); //高度标准值
              $(".max_H").val(max_H); //最大值
              $(".min_H").val(min_H); //最小值
              $(".step_H").val(scale_H); //步长
              $("#StandardW_list").html(standard_W); //宽度标准值
              $(".max_W").val(max_W); //最大值
              $(".min_W").val(min_W); //最小值
              $(".step_W").val(scale_W); //步长
              $("#StandardD_list").html(standard_D); //厚度标准值
              $(".max_D").val(max_D); //最大值
              $(".min_D").val(min_D); //最小值
              $(".step_D").val(scale_D); //步长
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时1！");
          }
        })
      }else if(rebuildSelect_status==2){ //内置推拉门修改 
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/selectProductSizeType",
          type:"post",
          data:{
            modelName:modelName
          },
          dataType:"json",
          success:function(e){
            if(e.resultCode==200){
              var html="",
                  standard_H="",
                  standard_W="",
                  standard_D="",
                  max_H="",
                  min_H="",
                  scale_H="",
                  max_W="",
                  min_W="",
                  scale_W="",
                  max_D="",
                  min_D="",
                  scale_D="";
              for(var i in e.resultInfo){
                if(e.resultInfo[i].dimension==1){//高度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_H+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_H=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_H=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_H=e.resultInfo[i].value; //步长
                  }
                }
                if(e.resultInfo[i].dimension==2){//宽度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_W+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_W=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_W=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_W=e.resultInfo[i].value; //步长
                  }
                }
                if(e.resultInfo[i].dimension==3){//厚度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_D+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_D=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_D=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_D=e.resultInfo[i].value; //步长
                  }
                }
              }
              $("#StandardH_list").html(standard_H); //高度标准值
              $(".max_H").val(max_H); //最大值
              $(".min_H").val(min_H); //最小值
              $(".step_H").val(scale_H); //步长
              $("#StandardW_list").html(standard_W); //宽度标准值
              $(".max_W").val(max_W); //最大值
              $(".min_W").val(min_W); //最小值
              $(".step_W").val(scale_W); //步长
              $("#StandardD_list").html(standard_D); //厚度标准值
              $(".max_D").val(max_D); //最大值
              $(".min_D").val(min_D); //最小值
              $(".step_D").val(scale_D); //步长
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时2！");
          }
        })
      }else if(rebuildSelect_status==3){ //外挂推拉门修改
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/selectProductSizeType",
          type:"post",
          data:{
            modelName:modelName
          },
          dataType:"json",
          success:function(e){
            if(e.resultCode==200){
              var html="",
                  standard_H="",
                  standard_W="",
                  standard_D="",
                  max_H="",
                  min_H="",
                  scale_H="",
                  max_W="",
                  min_W="",
                  scale_W="",
                  max_D="",
                  min_D="",
                  scale_D="";
              for(var i in e.resultInfo){
                if(e.resultInfo[i].dimension==1){//高度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_H+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_H=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_H=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_H=e.resultInfo[i].value; //步长
                  }
                }
                if(e.resultInfo[i].dimension==2){//宽度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_W+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_W=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_W=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_W=e.resultInfo[i].value; //步长
                  }
                }
                if(e.resultInfo[i].dimension==3){//厚度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_D+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_D=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_D=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_D=e.resultInfo[i].value; //步长
                  }
                }
              }
              $("#StandardH_list").html(standard_H); //高度标准值
              $(".max_H").val(max_H); //最大值
              $(".min_H").val(min_H); //最小值
              $(".step_H").val(scale_H); //步长
              $("#StandardW_list").html(standard_W); //宽度标准值
              $(".max_W").val(max_W); //最大值
              $(".min_W").val(min_W); //最小值
              $(".step_W").val(scale_W); //步长
              $("#StandardD_list").html(standard_D); //厚度标准值
              $(".max_D").val(max_D); //最大值
              $(".min_D").val(min_D); //最小值
              $(".step_D").val(scale_D); //步长
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时3！");
          }
        })
      }else if(rebuildSelect_status==4){ //对开门修改
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/selectProductSizeType",
          type:"post",
          data:{
            modelName:modelName
          },
          dataType:"json",
          success:function(e){
            if(e.resultCode==200){
              var html="",
                  standard_H="",
                  standard_W="",
                  standard_D="",
                  max_H="",
                  min_H="",
                  scale_H="",
                  max_W="",
                  min_W="",
                  scale_W="",
                  max_D="",
                  min_D="",
                  scale_D="";
              for(var i in e.resultInfo){
                if(e.resultInfo[i].dimension==1){//高度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_H+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_H=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_H=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_H=e.resultInfo[i].value; //步长
                  }
                }
                if(e.resultInfo[i].dimension==2){//宽度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_W+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_W=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_W=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_W=e.resultInfo[i].value; //步长
                  }
                }
                if(e.resultInfo[i].dimension==3){//厚度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_D+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_D=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_D=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_D=e.resultInfo[i].value; //步长
                  }
                }
              }
              $("#StandardH_list").html(standard_H); //高度标准值
              $(".max_H").val(max_H); //最大值
              $(".min_H").val(min_H); //最小值
              $(".step_H").val(scale_H); //步长
              $("#StandardW_list").html(standard_W); //宽度标准值
              $(".max_W").val(max_W); //最大值
              $(".min_W").val(min_W); //最小值
              $(".step_W").val(scale_W); //步长
              $("#StandardD_list").html(standard_D); //厚度标准值
              $(".max_D").val(max_D); //最大值
              $(".min_D").val(min_D); //最小值
              $(".step_D").val(scale_D); //步长
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时4！");
          }
        })
      }else if(rebuildSelect_status==5){ //子母门修改
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/selectProductSizeType",
          type:"post",
          data:{
            modelName:modelName
          },
          dataType:"json",
          success:function(e){
            if(e.resultCode==200){
              var html="",
                  standard_H="",
                  standard_W="",
                  standard_D="",
                  max_H="",
                  min_H="",
                  scale_H="",
                  max_W="",
                  min_W="",
                  scale_W="",
                  max_D="",
                  min_D="",
                  scale_D="";
              for(var i in e.resultInfo){
                if(e.resultInfo[i].dimension==1){//高度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_H+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_H=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_H=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_H=e.resultInfo[i].value; //步长
                  }
                }
                if(e.resultInfo[i].dimension==2){//宽度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_W+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_W=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_W=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_W=e.resultInfo[i].value; //步长
                  }
                }
                if(e.resultInfo[i].dimension==3){//厚度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_D+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_D=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_D=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_D=e.resultInfo[i].value; //步长
                  }
                }
              }
              $("#StandardH_list").html(standard_H); //高度标准值
              $(".max_H").val(max_H); //最大值
              $(".min_H").val(min_H); //最小值
              $(".step_H").val(scale_H); //步长
              $("#StandardW_list").html(standard_W); //宽度标准值
              $(".max_W").val(max_W); //最大值
              $(".min_W").val(min_W); //最小值
              $(".step_W").val(scale_W); //步长
              $("#StandardD_list").html(standard_D); //厚度标准值
              $(".max_D").val(max_D); //最大值
              $(".min_D").val(min_D); //最小值
              $(".step_D").val(scale_D); //步长
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时5！");
          }
        })
      }else if(rebuildSelect_status==6){ //窗套/垭口修改
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/selectProductSizeType",
          type:"post",
          data:{
            modelName:modelName
          },
          dataType:"json",
          success:function(e){
            if(e.resultCode==200){
              var html="",
                  standard_H="",
                  standard_W="",
                  standard_D="",
                  max_H="",
                  min_H="",
                  scale_H="",
                  max_W="",
                  min_W="",
                  scale_W="",
                  max_D="",
                  min_D="",
                  scale_D="";
              for(var i in e.resultInfo){
                if(e.resultInfo[i].dimension==1){//高度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_H+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_H=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_H=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_H=e.resultInfo[i].value; //步长
                  }
                }
                if(e.resultInfo[i].dimension==2){//宽度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_W+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_W=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_W=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_W=e.resultInfo[i].value; //步长
                  }
                }
                if(e.resultInfo[i].dimension==3){//厚度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_D+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_D=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_D=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_D=e.resultInfo[i].value; //步长
                  }
                }
              }
              $("#StandardH_list").html(standard_H); //高度标准值
              $(".max_H").val(max_H); //最大值
              $(".min_H").val(min_H); //最小值
              $(".step_H").val(scale_H); //步长
              $("#StandardW_list").html(standard_W); //宽度标准值
              $(".max_W").val(max_W); //最大值
              $(".min_W").val(min_W); //最小值
              $(".step_W").val(scale_W); //步长
              $("#StandardD_list").html(standard_D); //厚度标准值
              $(".max_D").val(max_D); //最大值
              $(".min_D").val(min_D); //最小值
              $(".step_D").val(scale_D); //步长
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时6！");
          }
        })
      }else if(rebuildSelect_status==7){ //护角修改
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/selectProductSizeType",
          type:"post",
          data:{
            modelName:modelName
          },
          dataType:"json",
          success:function(e){
            if(e.resultCode==200){
              var html="",
                  standard_H="",
                  standard_W="",
                  standard_D="",
                  max_H="",
                  min_H="",
                  scale_H="",
                  max_W="",
                  min_W="",
                  scale_W="",
                  max_D="",
                  min_D="",
                  scale_D="";
              for(var i in e.resultInfo){
                if(e.resultInfo[i].dimension==1){//高度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_H+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_H=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_H=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_H=e.resultInfo[i].value; //步长
                  }
                }
                if(e.resultInfo[i].dimension==2){//宽度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_W+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_W=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_W=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_W=e.resultInfo[i].value; //步长
                  }
                }
                if(e.resultInfo[i].dimension==3){//厚度
                  if(e.resultInfo[i].type==2){ //标准值
                    standard_D+='<b href="###" style="font-weight:normal"><input type="text" value='+e.resultInfo[i].value+'>&nbsp;&nbsp;mm</b>'
                  }
                  if(e.resultInfo[i].type==3){
                    max_D=e.resultInfo[i].value; //最大值
                  }
                  if(e.resultInfo[i].type==4){
                    min_D=e.resultInfo[i].value; //最小值
                  } 
                  if(e.resultInfo[i].type==5){
                    scale_D=e.resultInfo[i].value; //步长
                  }
                }
              }
              $("#StandardH_list").html(standard_H); //高度标准值
              $(".max_H").val(max_H); //最大值
              $(".min_H").val(min_H); //最小值
              $(".step_H").val(scale_H); //步长
              $("#StandardW_list").html(standard_W); //宽度标准值
              $(".max_W").val(max_W); //最大值
              $(".min_W").val(min_W); //最小值
              $(".step_W").val(scale_W); //步长
              $("#StandardD_list").html(standard_D); //厚度标准值
              $(".max_D").val(max_D); //最大值
              $(".min_D").val(min_D); //最小值
              $(".step_D").val(scale_D); //步长
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时7！");
          }
        })
      }
      flag=2;  //修改保存的状态
    })
    //新增录入尺寸的保存、修改保存的提交
    function Size_submit(){
      $(".confirm_btn").on("click",function(){
        var StandardH=$("#StandardH_list").find("input[type=text]"),
            StandardW=$("#StandardW_list").find("input[type=text]"),
            StandardD=$("#StandardD_list").find("input[type=text]");
        for(var i=0,len=StandardH.length;i<len;i++){  //高度标准值
          standard_H.push(StandardH.eq(i).val());
        }
        for(var i=0,len=StandardW.length;i<len;i++){ //宽度标准值
          standard_W.push(StandardW.eq(i).val());
        }
        for(var i=0,len=StandardD.length;i<len;i++){ //厚度标准值
          standard_D.push(StandardD.eq(i).val());
        }
        var max_H=$(".max_H").val(),
            min_H=$(".min_H").val(),
            scale_H=$(".step_H").val(),    
            first_H="",
            max_W=$(".max_W").val(),
            min_W=$(".min_W").val(),
            scale_W=$(".step_W").val(),
            first_W="",
            max_D=$(".max_D").val(),
            min_D=$(".min_D").val(),
            scale_D=$(".step_D").val(),
            first_D="";
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/saveProductSize",
          dataType:"json",
          type:"post",
          data:{
            modelName:modelName, //型号
            maxH:max_H,  //高度最大值
            minH:min_H,  //高度最小值
            scaleH:scale_H, //高度最小刻度
            standardH:standard_H.toString(),  //高度标准值
            firstH:first_H.toString(),  //高度初始值
            maxW:max_W,  //宽度最大值
            minW:min_W,  //宽度最小值
            scaleW:scale_W, //宽度最小刻度
            standardW:standard_W.toString(),  //宽度标准值
            firstW:first_W.toString(),  //宽度初始值
            maxD:max_D,  //厚度最大值
            minD:min_D,  //厚度最小值
            scaleD:scale_D, //厚度最小刻度
            standardD:standard_D.toString(),  //厚度标准值
            firstD:first_D.toString(),  //厚度初始值
            flag:flag   //新增
          },
          success:function(e){
            if(e.resultCode==200){
              //console.log(e);
              $(".height_area").find("input[type=text]").attr("disabled","disabled");
              $(".width_area").find("input[type=text]").attr("disabled","disabled");
              $(".deep_area").find("input[type=text]").attr("disabled","disabled");
              //清空原数组里面的数据
              standard_H=[];
              standard_W=[];
              standard_D=[];
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            //alert("请求超时w！");
          }
        })
      })
    }
    Size_submit();
    //基础配置：套线列表的新增功能配置录入
    //点击品牌进入产品列表
    $(".dl_brand").on("click",function(){
      brandName=$(this).find("dd").text(); //品牌名称
    })
    //套线型号名称的输入存值
    $(".model_name").on("blur",function(){
      wireName=$(this).val();
    })
    $("#picture_category").on("click","dl",function(){
      if($(this).find("dd").text()=="平开门"){
        typeNumber=1;
      }else if($(this).find("dd").text()=="内置推拉门"){
        typeNumber=2;
      }else if($(this).find("dd").text()=="外挂推拉门"){
        typeNumber=3;
      }else if($(this).find("dd").text()=="对开门"){
        typeNumber=4;
      }else if($(this).find("dd").text()=="子母门"){
        typeNumber=5;
      }else if($(this).find("dd").text()=="窗套/垭口"){
        typeNumber=6;
      }else if($(this).find("dd").text()=="护角"){
        typeNumber=7;
      }
    })
    //上传图片功能
    var uploader=new plupload.Uploader({ //实例化一个plupload上传对象
        browse_button:['browse','browsematerail'],
        url:json._url+"/"+json._nameCustommade+"/cusProduct/saveProductModel",
        flash_swf_url:'js/Moxie.swf',
        silverlight_xap_url:'js/Moxie.xap',
        filters:{
          max_file_size:"500kb",
          mime_types:[{title:"files",extensions:"jpg,png,gif"}]
        },
        multipart_params:{
          productType:1, //类别(木门)
          brandName:default_brandName, //品牌
          categoryName:categoryName, //品类名称
          modelName:wireName,  //型号名称
        },
    });
    uploader.init(); //初始化
    //绑定文件添加进队列事件
    uploader.bind('FilesAdded',function(uploader,files){
      if(uploader.files.length>1){  //plupload只限制上傳一個文件
        uploader.files.splice(0,1);
      }
      previewImage(files[0],function(imgsrc){
        $("#add").html('<img src="'+imgsrc+'"/>');
        $("#materialadd").html('<img src="'+imgsrc+'"/>');
      })
    });
    function previewImage(file,callback){//file为plupload事件监听函数参数中的file对象,callback为预览图片准备完成的回调函数
      if(!file || !/image\//.test(file.type)) return; //确保文件是图片
      if(file.type=='image/gif'){//gif使用FileReader进行预览,因为mOxie.Image只支持jpg和png
        var fr = new mOxie.FileReader();
        fr.onload = function(){
          callback(fr.result);
          fr.destroy();
          fr = null;
        }
        fr.readAsDataURL(file.getSource());
      }else{
        var preloader = new mOxie.Image();
        preloader.onload = function() {
          preloader.downsize( 300, 300 );//先压缩一下要预览的图片,宽300，高300
          var imgsrc = preloader.type=='image/jpeg' ? preloader.getAsDataURL('image/jpeg',80) : preloader.getAsDataURL(); //得到图片src,实质为一个base64编码的数据
          callback && callback(imgsrc); //callback传入的参数为预览图片的url
          preloader.destroy();
          preloader = null;
        };
        preloader.load( file.getSource() );
      }   
    }
    $(".confirm_btn").on("click",function(){
      if(typeNumber==1){
        if($(".model_name").val()==""){ //值为空
          $(this).attr("disabled","disabled");
        }else{
          $(this).removeAttr("disabled","disabled");
          uploader.setOption("multipart_params",{
            productType:1, //类别(木门)
            brandName:default_brandName, //品牌
            categoryName:categoryName, //品类名称
            modelName:wireName,  //型号名称
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("上传成功哦！")
            $(".model_list").show();
            $(".model_config").hide();//型号配置列表隐藏
            //型号列表的数据展示刷新
            selectModelByCategory(categoryName);
          });
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/cusProduct/saveProductModel",
            dataType:"json",
            data:{
              productType:1, //类别(木门)
              brandName:default_brandName, //品牌
              categoryName:categoryName, //品类名称
              modelName:wireName  //型号名称
            },
            type:"post",
            success:function(e){
              if(e.resultCode==200){
                $(".model_list").show();
                $(".model_config").hide();//型号配置列表隐藏
                //型号列表的数据展示刷新
                selectModelByCategory(categoryName);
              }else{
                alert("请求失败！");
              }
            },
            error:function(){
              alert("请求超时！");
            }
          })*/
        }
      }else if(typeNumber==2){
        if($(".model_name").val()==""){ //值为空
          $(this).attr("disabled","disabled");
        }else{
          $(this).removeAttr("disabled","disabled");
          uploader.setOption("multipart_params",{
            productType:1, //类别(木门)
            brandName:default_brandName, //品牌
            categoryName:categoryName, //品类名称
            modelName:wireName,  //型号名称
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("上传成功哦！")
            $(".model_list").show();
            $(".model_config").hide();//型号配置列表隐藏
            //型号列表的数据展示刷新
            selectModelByCategory(categoryName);
          });
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/cusProduct/saveProductModel",
            dataType:"json",
            data:{
              productType:1, //类别(木门)
              brandName:default_brandName, //品牌
              categoryName:categoryName, //品类名称
              modelName:wireName  //型号名称
            },
            type:"post",
            success:function(e){
              if(e.resultCode==200){
                $(".model_list").show();
                $(".model_config").hide();//型号配置列表隐藏
                //型号列表的数据展示刷新
                selectModelByCategory(categoryName);
              }else{
                alert("请求失败！");
              }
            },
            error:function(){
              alert("请求超时！");
            }
          })*/
        }
      }else if(typeNumber==3){
        if($(".model_name").val()==""){ //值为空
          $(this).attr("disabled","disabled");
        }else{
          $(this).removeAttr("disabled","disabled");
          uploader.setOption("multipart_params",{
            productType:1, //类别(木门)
            brandName:default_brandName, //品牌
            categoryName:categoryName, //品类名称
            modelName:wireName,  //型号名称
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("上传成功哦！")
            $(".model_list").show();
            $(".model_config").hide();//型号配置列表隐藏
            //型号列表的数据展示刷新
            selectModelByCategory(categoryName);
          });
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/cusProduct/saveProductModel",
            dataType:"json",
            data:{
              productType:1, //类别(木门)
              brandName:default_brandName, //品牌
              categoryName:categoryName, //品类名称
              modelName:wireName  //型号名称
            },
            type:"post",
            success:function(e){
              if(e.resultCode==200){
                $(".model_list").show();
                $(".model_config").hide();//型号配置列表隐藏
                //型号列表的数据展示刷新
                selectModelByCategory(categoryName);
              }else{
                alert("请求失败！");
              }
            },
            error:function(){
              alert("请求超时！");
            }
          })*/
        }
      }else if(typeNumber==4){
        if($(".model_name").val()==""){ //值为空
          $(this).attr("disabled","disabled");
        }else{
          $(this).removeAttr("disabled","disabled");
          uploader.setOption("multipart_params",{
            productType:1, //类别(木门)
            brandName:default_brandName, //品牌
            categoryName:categoryName, //品类名称
            modelName:wireName,  //型号名称
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("上传成功哦！")
            $(".model_list").show();
            $(".model_config").hide();//型号配置列表隐藏
            //型号列表的数据展示刷新
            selectModelByCategory(categoryName);
          });
         /* $.ajax({
            url:json._url+"/"+json._nameCustommade+"/cusProduct/saveProductModel",
            dataType:"json",
            data:{
              productType:1, //类别(木门)
              brandName:default_brandName, //品牌
              categoryName:categoryName, //品类名称
              modelName:wireName  //型号名称
            },
            type:"post",
            success:function(e){
              if(e.resultCode==200){
                $(".model_list").show();
                $(".model_config").hide();//型号配置列表隐藏
                //型号列表的数据展示刷新
                selectModelByCategory(categoryName);
              }else{
                alert("请求失败！");
              }
            },
            error:function(){
              alert("请求超时！");
            }
          })*/
        }
      }else if(typeNumber==5){
        if($(".model_name").val()==""){ //值为空
          $(this).attr("disabled","disabled");
        }else{
          $(this).removeAttr("disabled","disabled");
          uploader.setOption("multipart_params",{
            productType:1, //类别(木门)
            brandName:default_brandName, //品牌
            categoryName:categoryName, //品类名称
            modelName:wireName,  //型号名称
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("上传成功哦！")
            $(".model_list").show();
            $(".model_config").hide();//型号配置列表隐藏
            //型号列表的数据展示刷新
            selectModelByCategory(categoryName);
          });
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/cusProduct/saveProductModel",
            dataType:"json",
            data:{
              productType:1, //类别(木门)
              brandName:default_brandName, //品牌
              categoryName:categoryName, //品类名称
              modelName:wireName  //型号名称
            },
            type:"post",
            success:function(e){
              if(e.resultCode==200){
                $(".model_list").show();
                $(".model_config").hide();//型号配置列表隐藏
                //型号列表的数据展示刷新
                selectModelByCategory(categoryName);
              }else{
                alert("请求失败！");
              }
            },
            error:function(){
              alert("请求超时！");
            }
          })*/
        }
      }else if(typeNumber==6){
        if($(".model_name").val()==""){ //值为空
          $(this).attr("disabled","disabled");
        }else{
          $(this).removeAttr("disabled","disabled");
          uploader.setOption("multipart_params",{
            productType:1, //类别(木门)
            brandName:default_brandName, //品牌
            categoryName:categoryName, //品类名称
            modelName:wireName,  //型号名称
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("上传成功哦！")
            $(".model_list").show();
            $(".model_config").hide();//型号配置列表隐藏
            //型号列表的数据展示刷新
            selectModelByCategory(categoryName);
          });
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/cusProduct/saveProductModel",
            dataType:"json",
            data:{
              productType:1, //类别(木门)
              brandName:default_brandName, //品牌
              categoryName:categoryName, //品类名称
              modelName:wireName  //型号名称
            },
            type:"post",
            success:function(e){
              if(e.resultCode==200){
                $(".model_list").show();
                $(".model_config").hide();//型号配置列表隐藏
                //型号列表的数据展示刷新
                selectModelByCategory(categoryName);
              }else{
                alert("请求失败！");
              }
            },
            error:function(){
              alert("请求超时！");
            }
          })*/
        }
      }else if(typeNumber==7){
        if($(".model_name").val()==""){ //值为空
          $(this).attr("disabled","disabled");
        }else{
          $(this).removeAttr("disabled","disabled");
          uploader.setOption("multipart_params",{
            productType:1, //类别(木门)
            brandName:default_brandName, //品牌
            categoryName:categoryName, //品类名称
            modelName:wireName,  //型号名称
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("上传成功哦！")
            $(".model_list").show();
            $(".model_config").hide();//型号配置列表隐藏
            //型号列表的数据展示刷新
            selectModelByCategory(categoryName);
          });
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/cusProduct/saveProductModel",
            dataType:"json",
            data:{
              productType:1, //类别(木门)
              brandName:default_brandName, //品牌
              categoryName:categoryName, //品类名称
              modelName:wireName  //型号名称
            },
            type:"post",
            success:function(e){
              if(e.resultCode==200){
                $(".model_list").show();
                $(".model_config").hide();//型号配置列表隐藏
                //型号列表的数据展示刷新
                selectModelByCategory(categoryName);
              }else{
                alert("请求失败！");
              }
            },
            error:function(){
              alert("请求超时！");
            }
          })*/
        }
      }
    })
    //套线、材质、五金的数据保存渲染
    $(".picture_product").on("click","dl",function(){
      if($(this).find("dd").text()=="品类"){
        stateNumber=1;
        stateNumber_rebuild=1;
      }else if($(this).find("dd").text()=="套线"){
        stateNumber=2;
        stateNumber_rebuild=2;
      }else if($(this).find("dd").text()=="材质"){
        stateNumber=3;
        stateNumber_rebuild=3;
      }else if($(this).find("dd").text()=="五金"){
        stateNumber=4;
        stateNumber_rebuild=4;
      }
    })
    $(".confirm_btn").on("click",function(){
      if(stateNumber==1){
      }else if(stateNumber==2){  //套线保存
        if($(".model_name").val()==""){ //值为空
          $(this).attr("disabled","disabled");
        }else{
          $(this).removeAttr("disabled","disabled");
          uploader.setOption({
            "url":json._url+"/"+json._nameCustommade+"/door/saveDoorWire",
            "multipart_params":{
              productType:1, //类别(木门)
              brandName:brandName, //品牌
              wireName:wireName} //套线型号名称
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("上传成功哦！")
            $(".line_area>h2").find("span").text("套线列表");
            $(".line_area").show(); //套线列表显示
            $(".model_config").hide();//型号配置列表隐藏
            $(".materail_area").hide(); //材质列表显示
            $(".design_list").hide(); //花色配置列表显示
            $(".glass_list").hide();
            //套线列表的页面数据刷新渲染
            $.ajax({
              url:json._url+"/"+json._nameCustommade+"/door/selectDoorWire",
              dataType:"json",
              data:{
                productType:1, //类别(木门)
                brandName:default_brandName, //品牌
              },
              type:"post",
              success:function(data){
                refresh_fn(data);
              },
              error:function(){
                alert("请求超时8！");
              }
            })
          });
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/door/saveDoorWire",
            dataType:"json",
            data:{
              productType:1, //类别(木门)
              brandName:brandName, //品牌
              wireName:wireName //套线型号名称
            },
            type:"post",
            success:function(e){
              if(e.resultCode==200){
                $(".line_area>h2").find("span").text("套线列表");
                $(".line_area").show(); //套线列表显示
                $(".model_config").hide();//型号配置列表隐藏
                $(".materail_area").hide(); //材质列表显示
                $(".design_list").hide(); //花色配置列表显示
                $(".glass_list").hide();
                //套线列表的页面数据刷新渲染
                $.ajax({
                    url:json._url+"/"+json._nameCustommade+"/door/selectDoorWire",
                    dataType:"json",
                    data:{
                      productType:1, //类别(木门)
                      brandName:default_brandName, //品牌
                    },
                    type:"post",
                    success:function(data){
                      refresh_fn(data);
                    },
                    error:function(){
                      alert("请求超时！");
                    }
                })
              }else{
                alert("请求失败！");
              }
            },
            error:function(){
             alert("请求超时！");
            }
          })*/
        }
      }else if(stateNumber==3){  //材质系列的保存
        if($(".model_name").val()==""){ //值为空
          $(this).attr("disabled","disabled");
        }else{
          $(this).removeAttr("disabled","disabled");
          uploader.setOption({
            "url":json._url+"/"+json._nameCustommade+"/cusProduct/saveSeriesName",
            "multipart_params":{
              productType:1, //类别(木门)
              seriesName:wireName}  //系列名称
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("上传成功哦！")
            $(".materail_area>h2").find("span").text("材质列表");
            $(".materail_area").show(); //材质列表显示
            $(".line_area").hide(); //套线列表显示
            $(".design_list").hide(); //花色配置列表显示
            $(".glass_list").hide();
            $(".model_config").hide();
            //材质列表的系列页面数据刷新
            $.ajax({
              url:json._url+"/"+json._nameCustommade+"/cusProduct/selectSeriesName",
              dataType:"json",
              type:"post",
              data:{
                productType:1 //类别(木门)
              },
              success:function(data){
                refreshSeries(data);
              },
              error:function(){
                alert("请求超时8！");
              }
            })
          });
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/cusProduct/saveSeriesName",
            type:"post",
            dataType:"json",
            data:{
                productType:1, //类别(木门)
                seriesName:wireName  //系列名称
            },
            success:function(e){
                if(e.resultCode==200){
                  $(".materail_area>h2").find("span").text("材质列表");
                  $(".materail_area").show(); //材质列表显示
                  $(".line_area").hide(); //套线列表显示
                  $(".design_list").hide(); //花色配置列表显示
                  $(".glass_list").hide();
                  $(".model_config").hide();
                  //材质列表的系列页面数据刷新
                  $.ajax({
                      url:json._url+"/"+json._nameCustommade+"/cusProduct/selectSeriesName",
                      dataType:"json",
                      type:"post",
                      data:{
                        productType:1 //类别(木门)
                      },
                      success:function(data){
                        refreshSeries(data);
                      },
                      error:function(){
                       alert("请求超时！");
                      }
                  })
                }else{
                  alert("请求失败！");
                }
            },
            error:function(){
                alert("请求超时！");
            }
          })*/
        }
      }else if(stateNumber==4){ //五金的保存 
      }
    })
    //套线列表的页面数据渲染
    $.ajax({
      url:json._url+"/"+json._nameCustommade+"/door/selectDoorWire",
      dataType:"json",
      data:{
        productType:1, //类别(木门)
        brandName:default_brandName, //品牌
      },
      type:"post",
      success:function(e){
        refresh_fn(e);
      },
      error:function(){
        alert("请求超时9！");
      }
    })
    function refresh_fn(e){
      if(e.resultCode==200){
        var html="";
        for(var i in e.resultInfo){
          html+='<dl>'
                /*+'<span class="delete_line"><img src="static/images/lALOriVMtB8f_31_31.png"/></span>'*/
                +'<dt><img src="'+e.resultInfo[i].img+'" alt="" /></dt>'
                +'<dd>'+e.resultInfo[i].wirename+'</dd>'
             +'</dl>'
        }
        $("#picture_line").html(html);
        $(".confirm_btn").hide(); //套线列表的确认提交按钮隐藏
      }else{
        alert("请求失败！");
      }
    }
    //原来的套线名称，材质的系列名称，五金名称
    $("#picture_line").on("click","dl",function(){
      wire_Name=$(this).find("dd").text();  //原来套线名称
      wire_Img=$(this).find("dt").find("img").attr("src");
      $("#add").html('<img src="'+wire_Img+'"/>');
    })
    $("#picture_materail").on("click","dl",function(){
      series_Name=$(this).find("dd").text();  //原来系列名称
      series_Img=$(this).find("dt").find("img").attr("src");
      $("#materialadd").html('<img src="'+series_Img+'"/>');
    })
    $(".picture_glass").on("click","dl",function(){
      hardware_Name=$(this).find("dd").text();  //原来五金名称
      hardware_Img=$(this).find("dt").find("img").attr("src");
      $("#add").html('<img src="'+ hardware_Img+'"/>');
    })
    $(".picture_design").on("click","dl",function(){
      color_Name=$(this).find("dd").text();  //原来花色名称
      color_Img=$(this).find("dt").find("img").attr("src");
      $("#add").html('<img src="'+color_Img+'"/>');
    })
    //套线,花色，五金列表的修改功能
    $("#rebuild_model").on("click",function(){
      if(stateNumber_rebuild==1){ //品类修改
      }else if(stateNumber_rebuild==2){ //套线
        var wireNameLater=$(".model_name").val();
        /*$.ajax({
          url:json._url+"/"+json._nameCustommade+"/door/updateDoorWire",
          type:"post",
          data:{
            productType:1,//类别
            brandName:brandName, //品牌
            wireName:wire_Name, //套线型号
            wireNameLater:wireNameLater //套线型号
          },
          success:function(e){
            if(e.resultCode==200){
              $(".model_config").hide();
              $(".line_area").show();
              $.ajax({ //套线列表查询刷新
                url:json._url+"/"+json._nameCustommade+"/door/selectDoorWire",
                dataType:"json",
                data:{
                  productType:1, //类别(木门)
                  brandName:default_brandName, //品牌
                },
                type:"post",
                success:function(e){
                  refresh_fn(e);
                },
                error:function(){
                  alert("请求超时！");
                }
              })
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时！");
          }
        })*/
        uploader.setOption({
          "url":json._url+"/"+json._nameCustommade+"/door/updateDoorWire",
          "multipart_params":{
            productType:1,//类别
            brandName:brandName, //品牌
            wireName:wire_Name, //套线型号
            wireNameLater:wireNameLater} //修改后的套线型号
            //wireImg:wire_Img
        });
        uploader.start(); //开始上传
        uploader.bind("UploadComplete",function(uploader,files){
          alert("修改图片上传成功哦！");
          $(".model_config").hide();
          $(".line_area").show();
          $.ajax({ //套线列表查询刷新
            url:json._url+"/"+json._nameCustommade+"/door/selectDoorWire",
            dataType:"json",
            data:{
              productType:1, //类别(木门)
              brandName:default_brandName, //品牌
            },
            type:"post",
            success:function(e){
              refresh_fn(e);
            },
            error:function(){
              alert("请求超时10！");
            }
          })
        });
      }else if(stateNumber_rebuild==3){ //材质中的系列对应的花色修改
        var colorNameLater=$(".model_name").val();
        /*$.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/updateProductColor",
          type:"post",
          data:{
            productType:1, //类别
            brandName:brandName, //品牌
            seriesName:series_Name, //系列
            colorName:color_Name, //原来花色名称
            colorNameLater:colorNameLater//修改之后的花色
          },
          success:function(e){
            if(e.resultCode==200){
             console.log(e);
             $(".model_config").hide();
             $(".design_list").show();
             selectProductColor(seriesName);  //花色列表的数据重新刷新
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时！");
          }
        })*/
        uploader.setOption({
          "url":json._url+"/"+json._nameCustommade+"/cusProduct/updateProductColor",
          "multipart_params":{
            productType:1, //类别
            brandName:brandName, //品牌
            seriesName:series_Name, //系列
            colorName:color_Name, //原来花色名称
            colorNameLater:colorNameLater}//修改之后的花色
            //colorImg:hardware_Img
        });
        uploader.start(); //开始上传
        uploader.bind("UploadComplete",function(uploader,files){
          alert("修改图片上传成功哦！");
          $(".model_config").hide();
          $(".design_list").show();
          selectProductColor(seriesName);  //花色列表的数据重新刷新
        });
      }else if(stateNumber_rebuild==4){ //五金
        var hardwareNameLater=$(".model_name").val();
        if(hardware_rebuild==1){ //锁具
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/door/updateHardwareName",
            type:"post",
            data:{
              productType:1, //类别(木门)
              brandName:brandName, //品牌
              hardwareType:hardwareType, //五金类型名称
              hardwareName:hardware_Name, //五金型号
              hardwareNameLater:hardwareNameLater //修改之后的五金型号
            },
            success:function(e){
              if(e.resultCode==200){
                $(".model_config").hide();
                $(".glass_list").show();
                selectHardwareName(hardwareType); //五金列表的查询渲染
              }else{
                alert("请求失败！");
              }
            },
            error:function(){
              alert("请求超时！");
            }
          })*/
          uploader.setOption({
            "url":json._url+"/"+json._nameCustommade+"/door/updateHardwareName",
            "multipart_params":{
               productType:1, //类别(木门)
              brandName:brandName, //品牌
              hardwareType:hardwareType, //五金类型名称
              hardwareName:hardware_Name, //五金型号
              hardwareNameLater:hardwareNameLater} //修改之后的五金型号
              //hardwareImg:hardware_Img
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("修改图片上传成功哦！");
            $(".model_config").hide();
            $(".glass_list").show();
            selectHardwareName(hardwareType); //五金列表的查询渲染
          });
        }else if(hardware_rebuild==2){ //合页
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/door/updateHardwareName",
            type:"post",
            data:{
              productType:1, //类别(木门)
              brandName:brandName, //品牌
              hardwareType:hardwareType, //五金类型名称
              hardwareName:hardware_Name, //五金型号
              hardwareNameLater:hardwareNameLater //修改之后的五金型号
            },
            success:function(e){
              if(e.resultCode==200){
                $(".model_config").hide();
                $(".glass_list").show();
                selectHardwareName(hardwareType); //五金列表的查询渲染
              }else{
                alert("请求失败！");
              }
            },
            error:function(){
              alert("请求超时！");
            }
          })*/
          uploader.setOption({
            "url":json._url+"/"+json._nameCustommade+"/door/updateHardwareName",
            "multipart_params":{
               productType:1, //类别(木门)
              brandName:brandName, //品牌
              hardwareType:hardwareType, //五金类型名称
              hardwareName:hardware_Name, //五金型号
              hardwareNameLater:hardwareNameLater} //修改之后的五金型号
              //hardwareImg:hardware_Img
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("修改图片上传成功哦！");
            $(".model_config").hide();
            $(".glass_list").show();
            selectHardwareName(hardwareType); //五金列表的查询渲染
          });
        }else if(hardware_rebuild==3){ //门吸
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/door/updateHardwareName",
            type:"post",
            data:{
              productType:1, //类别(木门)
              brandName:brandName, //品牌
              hardwareType:hardwareType, //五金类型名称
              hardwareName:hardware_Name, //五金型号
              hardwareNameLater:hardwareNameLater //修改之后的五金型号
            },
            success:function(e){
              if(e.resultCode==200){
                $(".model_config").hide();
                $(".glass_list").show();
                selectHardwareName(hardwareType); //五金列表的查询渲染
              }else{
                alert("请求失败！");
              }
            },
            error:function(){
              alert("请求超时！");
            }
          })*/
          uploader.setOption({
            "url":json._url+"/"+json._nameCustommade+"/door/updateHardwareName",
            "multipart_params":{
               productType:1, //类别(木门)
              brandName:brandName, //品牌
              hardwareType:hardwareType, //五金类型名称
              hardwareName:hardware_Name, //五金型号
              hardwareNameLater:hardwareNameLater} //修改之后的五金型号
              //hardwareImg:hardware_Img
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("修改图片上传成功哦！");
            $(".model_config").hide();
            $(".glass_list").show();
            selectHardwareName(hardwareType); //五金列表的查询渲染
          });
        }else if(hardware_rebuild==4){ //玻璃
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/door/updateHardwareName",
            type:"post",
            data:{
              productType:1, //类别(木门)
              brandName:brandName, //品牌
              hardwareType:hardwareType, //五金类型名称
              hardwareName:hardware_Name, //五金型号
              hardwareNameLater:hardwareNameLater //修改之后的五金型号
            },
            success:function(e){
              if(e.resultCode==200){
                $(".model_config").hide();
                $(".glass_list").show();
                selectHardwareName(hardwareType); //五金列表的查询渲染
              }else{
                alert("请求失败！");
              }
            },
            error:function(){
              alert("请求超时！");
            }
          })*/
          uploader.setOption({
            "url":json._url+"/"+json._nameCustommade+"/door/updateHardwareName",
            "multipart_params":{
               productType:1, //类别(木门)
              brandName:brandName, //品牌
              hardwareType:hardwareType, //五金类型名称
              hardwareName:hardware_Name, //五金型号
              hardwareNameLater:hardwareNameLater} //修改之后的五金型号
              //hardwareImg:hardware_Img
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("修改图片上传成功哦！");
            $(".model_config").hide();
            $(".glass_list").show();
            selectHardwareName(hardwareType); //五金列表的查询渲染
          });
        }else if(hardware_rebuild==5){ //滑轨
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/door/updateHardwareName",
            type:"post",
            data:{
              productType:1, //类别(木门)
              brandName:brandName, //品牌
              hardwareType:hardwareType, //五金类型名称
              hardwareName:hardware_Name, //五金型号
              hardwareNameLater:hardwareNameLater //修改之后的五金型号
            },
            success:function(e){
              if(e.resultCode==200){
                $(".model_config").hide();
                $(".glass_list").show();
                selectHardwareName(hardwareType); //五金列表的查询渲染
              }else{
                alert("请求失败！");
              }
            },
            error:function(){
              alert("请求超时！");
            }
          })*/
          uploader.setOption({
            "url":json._url+"/"+json._nameCustommade+"/door/updateHardwareName",
            "multipart_params":{
               productType:1, //类别(木门)
              brandName:brandName, //品牌
              hardwareType:hardwareType, //五金类型名称
              hardwareName:hardware_Name, //五金型号
              hardwareNameLater:hardwareNameLater} //修改之后的五金型号
              //hardwareImg:hardware_Img
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("修改图片上传成功哦！");
            $(".model_config").hide();
            $(".glass_list").show();
            selectHardwareName(hardwareType); //五金列表的查询渲染
          });
        }
      }
    })
    //材质列表中的系列修改
    $("#materail_model").on("click",function(){
      var seriesNameLater=$(".model1_name").val();
      uploader.setOption({
        "url":json._url+"/"+json._nameCustommade+"/cusProduct/updateSeriesName",
        "multipart_params":{
          productType:1,//类别
          seriesName:series_Name, //系列型号
          seriesNameLater:seriesNameLater} //修改后的系列型号
          //seriesImg:series_Img
      });
      uploader.start(); //开始上传
      uploader.bind("UploadComplete",function(uploader,files){
        alert("修改图片上传成功哦！");
        $(".design_list").hide();
        $(".materail_area").show();
        $.ajax({  //修改后的系列列表的刷新
          url:json._url+"/"+json._nameCustommade+"/cusProduct/selectSeriesName",
          dataType:"json",
          type:"post",
          data:{
            productType:1 //类别(木门)
          },
          success:function(e){ 
            refreshSeries(e);
          },
          error:function(){
           alert("请求超时11！");
          }
        })
      });
      /*$.ajax({
        url:json._url+"/"+json._nameCustommade+"/cusProduct/updateSeriesName",
        type:"post",
        data:{
          productType:1,//类别
          seriesName:series_Name, //系列型号
          seriesNameLater:seriesNameLater
        },
        success:function(e){
          if(e.resultCode==200){
            $(".design_list").hide();
            $(".materail_area").show();
            $.ajax({  //修改后的系列列表的刷新
              url:json._url+"/"+json._nameCustommade+"/cusProduct/selectSeriesName",
              dataType:"json",
              type:"post",
              data:{
                productType:1 //类别(木门)
              },
              success:function(e){ 
                refreshSeries(e);
              },
              error:function(){
               alert("请求超时！");
              }
            })
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时！");
        }
      })*/
    })
    //品类列表的对应型号数据渲染
    function selectModelByCategory(categoryName){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/cusProduct/selectModelByCategory",
        type:"post",
        dataType:"json",
        data:{
          productType:1, //类别(木门)
          brandName:brandName, //品牌
          categoryName:categoryName, //品类名称
        },
        success:function(e){
          //console.log(e);
          refreshFn(e);
        },
        error:function(){
          alert("请求超时12！");
        }
      })
    }
    function refreshFn(e){
      var html="";
      for(var i in e.resultInfo){
        html+='<dl>'
              /* +'<span><img src="static/images/lALOriVMtB8f_31_31.png"/></span>'*/
               +'<dt><img src="'+e.resultInfo[i].img+'" alt="" /></dt>'
               +'<dd>'+e.resultInfo[i].modelname+'</dd>'
             +'</dl>'
      }
      $(".picture_model").html(html);
      //品类列表对应的型号中的确认提交按钮隐藏
      $(".confirm_btn").hide();
    }
    //品类列表对应原来的型号名称与图片
    $(".picture_model").on("click","dl",function(){
      category_Name=$(this).find("dd").text();
      category_Img=$(this).find("dt").find("img").attr("src");
      $("#add").html('<img src="'+category_Img+'"/>');
    })
    //品类列表对应型号数据的修改功能
    $("#rebuild_model").on("click",function(){
      if(category_rebuild==1){ //平开门型号的修改
        var modelNameLater=$(".model_name").val();//修改后的型号名称
        uploader.setOption({
          "url":json._url+"/"+json._nameCustommade+"/cusProduct/updateProductModel",
          "multipart_params":{
            productType:1, //类别
            brandName:brandName,//品牌
            categoryName:categoryName,//品类
            modelName:category_Name,//原来的型号名称
            modelNameLater:modelNameLater}//修改后的型号
            //modelImg:category_Img//原來的型号图片
        });
        uploader.start(); //开始上传
        uploader.bind("UploadComplete",function(uploader,files){
          alert("修改上传成功哦！");
          $(".model_config").hide();
          $(".model_list").show();
          selectModelByCategory(categoryName);  //刷新查询列表
        });
        /*$.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/updateProductModel",
          type:"post",
          data:{
            productType:1, //类别
            brandName:brandName,//品牌
            categoryName:categoryName,//品类
            modelName:category_Name,//原来的型号名称
            modelNameLater:modelNameLater,//修改后的型号
            modelImg:category_img//原來的型號圖片
          },
          success:function(e){
            if(e.resultCode==200){
              $(".model_config").hide();
              $(".model_list").show();
              selectModelByCategory(categoryName);  //刷新查询列表
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时！");
          }
        })*/
      }else if(category_rebuild==2){ //内置
        var modelNameLater=$(".model_name").val();//修改后的型号名称
        /*$.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/updateProductModel",
          type:"post",
          data:{
            productType:1, //类别
            brandName:brandName,//品牌
            categoryName:categoryName,//品类
            modelName:category_Name,//原来的型号名称
            modelNameLater:modelNameLater//修改后的型号
          },
          success:function(e){
            if(e.resultCode==200){
              console.log(e);
              $(".model_config").hide();
              $(".model_list").show();
              selectModelByCategory(categoryName);  //刷新查询列表
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时！");
          }
        })*/
        uploader.setOption({
          "url":json._url+"/"+json._nameCustommade+"/cusProduct/updateProductModel",
          "multipart_params":{
            productType:1, //类别
            brandName:brandName,//品牌
            categoryName:categoryName,//品类
            modelName:category_Name,//原来的型号名称
            modelNameLater:modelNameLater}//修改后的型号
            //modelImg:category_Img//原來的型号图片
        });
        uploader.start(); //开始上传
        uploader.bind("UploadComplete",function(uploader,files){
          alert("修改上传成功哦！");
          $(".model_config").hide();
          $(".model_list").show();
          selectModelByCategory(categoryName);  //刷新查询列表
        });
      }else if(category_rebuild==3){ //外挂
        var modelNameLater=$(".model_name").val();//修改后的型号名称
       /* $.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/updateProductModel",
          type:"post",
          data:{
            productType:1, //类别
            brandName:brandName,//品牌
            categoryName:categoryName,//品类
            modelName:category_Name,//原来的型号名称
            modelNameLater:modelNameLater//修改后的型号
          },
          success:function(e){
            if(e.resultCode==200){
              $(".model_config").hide();
              $(".model_list").show();
              selectModelByCategory(categoryName);  //刷新查询列表
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时！");
          }
        })*/
        uploader.setOption({
          "url":json._url+"/"+json._nameCustommade+"/cusProduct/updateProductModel",
          "multipart_params":{
            productType:1, //类别
            brandName:brandName,//品牌
            categoryName:categoryName,//品类
            modelName:category_Name,//原来的型号名称
            modelNameLater:modelNameLater}//修改后的型号
            //modelImg:category_Img//原來的型号图片
        });
        uploader.start(); //开始上传
        uploader.bind("UploadComplete",function(uploader,files){
          alert("修改上传成功哦！");
          $(".model_config").hide();
          $(".model_list").show();
          selectModelByCategory(categoryName);  //刷新查询列表
        });
      }else if(category_rebuild==4){ //对开门
        var modelNameLater=$(".model_name").val();//修改后的型号名称
        /*$.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/updateProductModel",
          type:"post",
          data:{
            productType:1, //类别
            brandName:brandName,//品牌
            categoryName:categoryName,//品类
            modelName:category_Name,//原来的型号名称
            modelNameLater:modelNameLater//修改后的型号
          },
          success:function(e){
            if(e.resultCode==200){
              $(".model_config").hide();
              $(".model_list").show();
              selectModelByCategory(categoryName);  //刷新查询列表
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时！");
          }
        })*/
        uploader.setOption({
          "url":json._url+"/"+json._nameCustommade+"/cusProduct/updateProductModel",
          "multipart_params":{
            productType:1, //类别
            brandName:brandName,//品牌
            categoryName:categoryName,//品类
            modelName:category_Name,//原来的型号名称
            modelNameLater:modelNameLater}//修改后的型号
            //modelImg:category_Img//原來的型号图片
        });
        uploader.start(); //开始上传
        uploader.bind("UploadComplete",function(uploader,files){
          alert("修改上传成功哦！");
          $(".model_config").hide();
          $(".model_list").show();
          selectModelByCategory(categoryName);  //刷新查询列表
        });
      }else if(category_rebuild==5){ //子母门
        var modelNameLater=$(".model_name").val();//修改后的型号名称
        /*$.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/updateProductModel",
          type:"post",
          data:{
            productType:1, //类别
            brandName:brandName,//品牌
            categoryName:categoryName,//品类
            modelName:category_Name,//原来的型号名称
            modelNameLater:modelNameLater//修改后的型号
          },
          success:function(e){
            if(e.resultCode==200){
              $(".model_config").hide();
              $(".model_list").show();
              selectModelByCategory(categoryName);  //刷新查询列表
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时！");
          }
        })*/
        uploader.setOption({
          "url":json._url+"/"+json._nameCustommade+"/cusProduct/updateProductModel",
          "multipart_params":{
            productType:1, //类别
            brandName:brandName,//品牌
            categoryName:categoryName,//品类
            modelName:category_Name,//原来的型号名称
            modelNameLater:modelNameLater}//修改后的型号
            //modelImg:category_Img//原來的型号图片
        });
        uploader.start(); //开始上传
        uploader.bind("UploadComplete",function(uploader,files){
          alert("修改上传成功哦！");
          $(".model_config").hide();
          $(".model_list").show();
          selectModelByCategory(categoryName);  //刷新查询列表
        });
      }else if(category_rebuild==6){ //窗套/垭口
        var modelNameLater=$(".model_name").val();//修改后的型号名称
        /*$.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/updateProductModel",
          type:"post",
          data:{
            productType:1, //类别
            brandName:brandName,//品牌
            categoryName:categoryName,//品类
            modelName:category_Name,//原来的型号名称
            modelNameLater:modelNameLater//修改后的型号
          },
          success:function(e){
            if(e.resultCode==200){
              $(".model_config").hide();
              $(".model_list").show();
              selectModelByCategory(categoryName);  //刷新查询列表
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时！");
          }
        })*/
        uploader.setOption({
          "url":json._url+"/"+json._nameCustommade+"/cusProduct/updateProductModel",
          "multipart_params":{
            productType:1, //类别
            brandName:brandName,//品牌
            categoryName:categoryName,//品类
            modelName:category_Name,//原来的型号名称
            modelNameLater:modelNameLater}//修改后的型号
            //modelImg:category_Img//原來的型号图片
        });
        uploader.start(); //开始上传
        uploader.bind("UploadComplete",function(uploader,files){
          alert("修改上传成功哦！");
          $(".model_config").hide();
          $(".model_list").show();
          selectModelByCategory(categoryName);  //刷新查询列表
        });
      }else if(category_rebuild==7){ //护角
        var modelNameLater=$(".model_name").val();//修改后的型号名称
        /*$.ajax({
          url:json._url+"/"+json._nameCustommade+"/cusProduct/updateProductModel",
          type:"post",
          data:{
            productType:1, //类别
            brandName:brandName,//品牌
            categoryName:categoryName,//品类
            modelName:category_Name,//原来的型号名称
            modelNameLater:modelNameLater//修改后的型号
          },
          success:function(e){
            if(e.resultCode==200){
              $(".model_config").hide();
              $(".model_list").show();
              selectModelByCategory(categoryName);  //刷新查询列表
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时！");
          }
        })*/
        uploader.setOption({
          "url":json._url+"/"+json._nameCustommade+"/cusProduct/updateProductModel",
          "multipart_params":{
            productType:1, //类别
            brandName:brandName,//品牌
            categoryName:categoryName,//品类
            modelName:category_Name,//原来的型号名称
            modelNameLater:modelNameLater}//修改后的型号
            //modelImg:category_Img//原來的型号图片
        });
        uploader.start(); //开始上传
        uploader.bind("UploadComplete",function(uploader,files){
          alert("修改上传成功哦！");
          $(".model_config").hide();
          $(".model_list").show();
          selectModelByCategory(categoryName);  //刷新查询列表
        });
      }
    })
    //材质列表“系列”的数据渲染展示
    $.ajax({
      url:json._url+"/"+json._nameCustommade+"/cusProduct/selectSeriesName",
      dataType:"json",
      type:"post",
      data:{
        productType:1 //类别(木门)
      },
      success:function(e){
        refreshSeries(e);
      },
      error:function(){
       alert("请求超时43545！");
      }
    })
    function refreshSeries(e){
      if(e.resultCode==200){
        var html="";
        for(var i in e.resultInfo){
          html+='<dl>'
              /* +'<span><img src="static/images/lALOriVMtB8f_31_31.png"/></span>'*/
               +'<dt><img src="'+e.resultInfo[i].img+'" alt="" /></dt>'
               +'<dd>'+e.resultInfo[i].seriesname+'</dd>'
            +'</dl>'
        }
        $(".picture_materail").html(html);
        $(".confirm_btn").hide();//系列名称列表的确认提交按钮隐藏
      }else{
        alert("请求失败！");
      }
    }
    //材质列表的系列对应的“花色”数据渲染
    $(".picture_materail").on("click","dl",function(){
      colorStatus=1;
      seriesName=$(this).find("dd").text();
      selectProductColor(seriesName);
    })
    //花色配置录入的提交保存
    $(".confirm_btn").on("click",function(){
      if(colorStatus==1){
        if($(".model_name").val()==""){ //值为空
          $(this).attr("disabled","disabled");
        }else{
          $(this).removeAttr("disabled","disabled");
          uploader.setOption({
            "url":json._url+"/"+json._nameCustommade+"/cusProduct/saveProductColor",
            "multipart_params":{
              productType:1, //类别(木门)
              brandName:brandName,  //品牌
              seriesName:seriesName,  //系列名称
              colorName:wireName}   //花色
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("上传成功哦！")
            $(".design_list").show(); //花色配置列表显示
            $(".line_area").hide(); //套线列表隐藏
            $(".materail_area").hide();
            //花色配置列表的页面数据刷新
            selectProductColor(seriesName);
          });
          /*$.ajax({
              url:json._url+"/"+json._nameCustommade+"/cusProduct/saveProductColor",
              type:"post",
              dataType:"json",
              data:{
                productType:1, //类别(木门)
                brandName:brandName,  //品牌
                seriesName:seriesName,  //系列名称
                colorName:wireName   //花色
              },
              success:function(e){
                  if(e.resultCode==200){
                    $(".design_list").show(); //花色配置列表显示
                    $(".line_area").hide(); //套线列表显示
                    $(".materail_area").hide();
                    //花色配置列表的页面数据刷新
                    selectProductColor(seriesName);
                  }else{
                    alert("请求失败！");
                  }
              },
              error:function(){
                  alert("请求超时！");
              }
          })*/
        }
      }
    })
    //花色配置列表的数据渲染展示
    function selectProductColor(seriesName){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/cusProduct/selectProductColor",
        dataType:"json",
        type:"post",
        data:{
          brandName:brandName, //品牌
          seriesName:seriesName, //系列
          productType:1 //类别(木门)
        },
        success:function(e){
          refreshProductColor(e);
        },
        error:function(){
         alert("请求超时13！");
        }
      })
    }
    function refreshProductColor(e){
      if(e.resultCode==200){
        var html="";
        for(var i in e.resultInfo){
          html+='<dl>'
                /* +'<span><img src="static/images/lALOriVMtB8f_31_31.png"/></span>'*/
                 +'<dt><img src="'+e.resultInfo[i].img+'" alt="" /></dt>'
                 +'<dd>'+e.resultInfo[i].colorname+'</dd>'
              +'</dl>'
        }
        $(".picture_design").html(html);
        //花色配置列表的确认提交按钮隐藏
        $(".confirm_btn").hide();
      }else{
        alert("请求失败！");
      }
    }
    //五金列表的系列对应的“五金”型号数据渲染
    $(".picture_hardware").on("click","dl",function(){
      hardwareType=$(this).find("dd").text();
      $(".glass_list").show();
      $(".hardware_area").hide();
      if(hardwareType=="锁具"){
        $(".handware_title").text("锁具配置列表");
        hardWareStatues=1;
        hardware_rebuild=1;
      }else if(hardwareType=="合页"){
        $(".handware_title").text("合页配置列表");
        hardWareStatues=2;
        hardware_rebuild=2;
      }else if(hardwareType=="门吸"){
        $(".handware_title").text("门吸配置列表"); 
        hardWareStatues=3;
        hardware_rebuild=3;
      }else if(hardwareType=="玻璃"){
        $(".handware_title").text("玻璃配置列表"); 
        hardWareStatues=4;
        hardware_rebuild=4;
      }else if(hardwareType=="滑轨"){
        $(".handware_title").text("滑轨配置列表");
        hardWareStatues=5;
        hardware_rebuild=5;
      }
      selectHardwareName(hardwareType);
    })
    //保存五金系列的配置录入
    $(".confirm_btn").on("click",function(){
      if(hardWareStatues==1){ //锁具
        if($(".model_name").val()==""){ //值为空
          $(this).attr("disabled","disabled");
        }else{
          $(this).removeAttr("disabled","disabled");
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/door/saveHardwareName",
            type:"post",
            dataType:"json",
            data:{
                brandName:brandName,  //品牌
                hardwareType:hardwareType,  //五金类型名称
                hardwareName:wireName   //五金型号
            },
            success:function(e){
                if(e.resultCode==200){
                  $(".design_list").hide(); //花色配置列表
                  $(".line_area").hide(); //套线列表隐藏
                  $(".materail_area").hide();
                  $(".hardware_area").hide();
                  $(".category_list").hide();
                  $(".model_config").hide();
                  $(".glass_list").show();
                  //五金配置列表的页面数据刷新
                  selectHardwareName(hardwareType);
                  $("#glass_list_btn").on("click",function(){
                    $(".glass_list").hide();
                    $(".hardware_area").show();
                  })
                }else{
                  alert("请求失败！");
                }
            },
            error:function(){
                alert("请求超时！");
            }
          })*/
          uploader.setOption({
            "url":json._url+"/"+json._nameCustommade+"/door/saveHardwareName",
            "multipart_params":{
              brandName:brandName,  //品牌
              hardwareType:hardwareType,  //五金类型名称
              hardwareName:wireName}   //五金型号
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("上传成功哦！");
            $(".design_list").hide(); //花色配置列表
            $(".line_area").hide(); //套线列表隐藏
            $(".materail_area").hide();
            $(".hardware_area").hide();
            $(".category_list").hide();
            $(".model_config").hide();
            $(".glass_list").show();
            //五金配置列表的页面数据刷新
            selectHardwareName(hardwareType);
            $("#glass_list_btn").on("click",function(){
              $(".glass_list").hide();
              $(".hardware_area").show();
            })
          });
        }
      }else if(hardWareStatues==2){ //合页
        if($(".model_name").val()==""){ //值为空
          $(this).attr("disabled","disabled");
        }else{
          $(this).removeAttr("disabled","disabled");
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/door/saveHardwareName",
            type:"post",
            dataType:"json",
            data:{
                brandName:brandName,  //品牌
                hardwareType:hardwareType,  //五金类型名称
                hardwareName:wireName   //五金型号
            },
            success:function(e){
                if(e.resultCode==200){
                  $(".design_list").hide(); //花色配置列表隐藏
                  $(".line_area").hide(); //套线列表显示
                  $(".materail_area").hide();
                  $(".hardware_area").hide();
                  $(".category_list").hide();
                  $(".model_config").hide();
                  $(".glass_list").show();
                  //五金配置列表的页面数据刷新
                  selectHardwareName(hardwareType);
                  $("#glass_list_btn").on("click",function(){
                    $(".glass_list").hide();
                    $(".hardware_area").show();
                  })
                }else{
                  alert("请求失败！");
                }
            },
            error:function(){
                alert("请求超时！");
            }
          })*/
          uploader.setOption({
            "url":json._url+"/"+json._nameCustommade+"/door/saveHardwareName",
            "multipart_params":{
              brandName:brandName,  //品牌
              hardwareType:hardwareType,  //五金类型名称
              hardwareName:wireName}   //五金型号
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("上传成功哦！")
            $(".design_list").hide(); //花色配置列表
            $(".line_area").hide(); //套线列表隐藏
            $(".materail_area").hide();
            $(".hardware_area").hide();
            $(".category_list").hide();
            $(".model_config").hide();
            $(".glass_list").show();
            //五金配置列表的页面数据刷新
            selectHardwareName(hardwareType);
            $("#glass_list_btn").on("click",function(){
              $(".glass_list").hide();
              $(".hardware_area").show();
            })
          });
        }
      }else if(hardWareStatues==3){ //门吸
        if($(".model_name").val()==""){ //值为空
          $(this).attr("disabled","disabled");
        }else{
          $(this).removeAttr("disabled","disabled");
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/door/saveHardwareName",
            type:"post",
            dataType:"json",
            data:{
                brandName:brandName,  //品牌
                hardwareType:hardwareType,  //五金类型名称
                hardwareName:wireName   //五金型号
            },
            success:function(e){
                if(e.resultCode==200){
                  $(".design_list").hide(); //花色配置列表隐藏
                  $(".line_area").hide(); //套线列表显示
                  $(".materail_area").hide();
                  $(".hardware_area").hide();
                  $(".category_list").hide();
                  $(".model_config").hide();
                  $(".glass_list").show();
                  //五金配置列表的页面数据刷新
                  selectHardwareName(hardwareType);
                  $("#glass_list_btn").on("click",function(){
                    $(".glass_list").hide();
                    $(".hardware_area").show();
                  })
                }else{
                  alert("请求失败！");
                }
            },
            error:function(){
                alert("请求超时！");
            }
          })*/
          uploader.setOption({
            "url":json._url+"/"+json._nameCustommade+"/door/saveHardwareName",
            "multipart_params":{
              brandName:brandName,  //品牌
              hardwareType:hardwareType,  //五金类型名称
              hardwareName:wireName}   //五金型号
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("上传成功哦！")
            $(".design_list").hide(); //花色配置列表
            $(".line_area").hide(); //套线列表隐藏
            $(".materail_area").hide();
            $(".hardware_area").hide();
            $(".category_list").hide();
            $(".model_config").hide();
            $(".glass_list").show();
            //五金配置列表的页面数据刷新
            selectHardwareName(hardwareType);
            $("#glass_list_btn").on("click",function(){
              $(".glass_list").hide();
              $(".hardware_area").show();
            })
          });
        }
      }else if(hardWareStatues==4){ //玻璃
        if($(".model_name").val()==""){ //值为空
          $(this).attr("disabled","disabled");
        }else{
          $(this).removeAttr("disabled","disabled");
          /*$.ajax({
            url:json._url+"/"+json._nameCustommade+"/door/saveHardwareName",
            type:"post",
            dataType:"json",
            data:{
                brandName:brandName,  //品牌
                hardwareType:hardwareType,  //五金类型名称
                hardwareName:wireName   //五金型号
            },
            success:function(e){
                if(e.resultCode==200){
                  $(".design_list").hide(); //花色配置列表隐藏
                  $(".line_area").hide(); //套线列表显示
                  $(".materail_area").hide();
                  $(".hardware_area").hide();
                  $(".category_list").hide();
                  $(".model_config").hide();
                  $(".glass_list").show();
                  //五金配置列表的页面数据刷新
                  selectHardwareName(hardwareType);
                  $("#glass_list_btn").on("click",function(){
                    $(".glass_list").hide();
                    $(".hardware_area").show();
                  })
                }else{
                  alert("请求失败！");
                }
            },
            error:function(){
                alert("请求超时！");
            }
          })*/
          uploader.setOption({
            "url":json._url+"/"+json._nameCustommade+"/door/saveHardwareName",
            "multipart_params":{
              brandName:brandName,  //品牌
              hardwareType:hardwareType,  //五金类型名称
              hardwareName:wireName}   //五金型号
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("上传成功哦！")
            $(".design_list").hide(); //花色配置列表
            $(".line_area").hide(); //套线列表隐藏
            $(".materail_area").hide();
            $(".hardware_area").hide();
            $(".category_list").hide();
            $(".model_config").hide();
            $(".glass_list").show();
            //五金配置列表的页面数据刷新
            selectHardwareName(hardwareType);
            $("#glass_list_btn").on("click",function(){
              $(".glass_list").hide();
              $(".hardware_area").show();
            })
          });
        }
      }else if(hardWareStatues==5){ //滑轨
        if($(".model_name").val()==""){ //值为空
          $(this).attr("disabled","disabled");
        }else{
          $(this).removeAttr("disabled","disabled");
         /* $.ajax({
            url:json._url+"/"+json._nameCustommade+"/door/saveHardwareName",
            type:"post",
            dataType:"json",
            data:{
                brandName:brandName,  //品牌
                hardwareType:hardwareType,  //五金类型名称
                hardwareName:wireName   //五金型号
            },
            success:function(e){
                if(e.resultCode==200){
                  $(".design_list").hide(); //花色配置列表隐藏
                  $(".line_area").hide(); //套线列表显示
                  $(".materail_area").hide();
                  $(".hardware_area").hide();
                  $(".category_list").hide();
                  $(".model_config").hide();
                  $(".glass_list").show();
                  //五金配置列表的页面数据刷新
                  selectHardwareName(hardwareType);
                  $("#glass_list_btn").on("click",function(){
                    $(".glass_list").hide();
                    $(".hardware_area").show();
                  })
                }else{
                  alert("请求失败！");
                }
            },
            error:function(){
              alert("请求超时！");
            }
          })*/
          uploader.setOption({
            "url":json._url+"/"+json._nameCustommade+"/door/saveHardwareName",
            "multipart_params":{
              brandName:brandName,  //品牌
              hardwareType:hardwareType,  //五金类型名称
              hardwareName:wireName}   //五金型号
          });
          uploader.start(); //开始上传
          uploader.bind("UploadComplete",function(uploader,files){
            alert("上传成功哦！")
            $(".design_list").hide(); //花色配置列表
            $(".line_area").hide(); //套线列表隐藏
            $(".materail_area").hide();
            $(".hardware_area").hide();
            $(".category_list").hide();
            $(".model_config").hide();
            $(".glass_list").show();
            //五金配置列表的页面数据刷新
            selectHardwareName(hardwareType);
            $("#glass_list_btn").on("click",function(){
              $(".glass_list").hide();
              $(".hardware_area").show();
            })
          });
        }
      }
    })
    //五金配置列表对应的型号列表添加的数据渲染
    function selectHardwareName(hardwareType){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/door/selectHardwareName",
        dataType:"json",
        type:"post",
        data:{
          brandName:brandName, //品牌
          hardwareType:hardwareType  //五金类型名称
        },
        success:function(e){
          refresh_Hardware(e);
        },
        error:function(){
         alert("请求超时14！");
        }
      })
    }
    function refresh_Hardware(e){
      if(e.resultCode==200){
        var html="";
        for(var i in e.resultInfo){
          html+='<dl>'
                /* +'<span><img src="static/images/lALOriVMtB8f_31_31.png"/></span>'*/
                 +'<dt><img src="'+e.resultInfo[i].img+'" alt="" /></dt>'
                 +'<dd>'+e.resultInfo[i].hardwarename+'</dd>'
              +'</dl>'
        }
        $(".picture_glass").html(html);
        $(".confirm_btn").hide();  //五金列表的确认提交按钮隐藏
      }else{
          alert("请求失败！");
      }
    }
    //内置推拉门、外挂推拉门的门扇数量的保存录入数据
    function saveSildingDoorNum(arr){
      $("#SildingDoor_btn").on("click",function(){
        $("#acting_newbtn").attr("disabled","disabled");
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/door/saveSildingDoorNum",
          type:"post",
          data:{
            brandName:brandName, //品牌
            categoryName:categoryName, //品类（内置还是外挂）
            doorNum:arr[0], //数量
            widthMin:arr[1],//门洞下限
            widthMax:arr[2] //门洞上限
          },
          dataType:"json",
          success:function(e){
            if(e.resultCode==200){
              //console.log(e);
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时15！");
          }
        })
      })
    }
    //内置推拉门、外挂推拉门的门扇数量的查询数据渲染
    function selectSildingDoorNum(categoryName){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/door/selectSildingDoorNum",
        type:"post",
        dataType:"json",
        data:{
          categoryName:categoryName
        },
        success:function(e){
          if(e.resultCode==200){
            var html="";
            for(var i in e.resultInfo){
              html+='<ul>'
                      +'<li>'+e.resultInfo[i].categoryname+'</li>'
                      +'<li><input type="text" class="acting_num" value='+e.resultInfo[i].doornum+'></li>'
                      +'<li><input type="text" class="actingW_min" value='+e.resultInfo[i].widthmin+'>&nbsp;mm</li>'
                      +'<li><input type="text" class="actingW_max" value='+e.resultInfo[i].widthmax+'>&nbsp;mm</li>'
                    +'</ul>'
            }
            $(".acting_showlist").append(html);
            //一打开页面获取原始数量，门洞下限，门洞上限
            doorNum=$(".acting_num").val(),
            widthMin=$(".actingW_min").val(),
            widthMax=$(".actingW_max").val();
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时16！");
        }
      })
    }
    //点击新建功能，对门扇数量的功能操作，保存录入配置
    $("#acting_newbtn").on("click",function(){
      $(".model_area").attr("disabled","disabled"); //编辑按钮不能点击
      if($(".acting_showlist").find("ul").length>0){  //不为空
        $(this).attr("disabled",false);
        var html='<ul>'
                  +'<li>'+categoryName+'</li>'
                  +'<li><input type="text" class="acting_num"/></li>'
                  +'<li><input type="text" class="actingW_min"/>&nbsp;mm</li>'
                  +'<li><input type="text" class="actingW_max" />&nbsp;mm</li>'
                +'</ul>'
        $(".acting_showlist").append(html);
        var arr=[];
        $(".acting_showlist>ul>li").on("change","input[type=text]",function(){ //新添加的文本框
          var acting_input=$(this).val();     
          arr.push(acting_input);
        })
        saveSildingDoorNum(arr);  //新建的保存记录
      }else{  //为空
        $(this).attr("disabled",false);
        var html='<ul>'
                  +'<li>'+categoryName+'</li>'
                  +'<li><input type="text" class="acting_num"/></li>'
                  +'<li><input type="text" class="actingW_min"/>&nbsp;mm</li>'
                  +'<li><input type="text" class="actingW_max" />&nbsp;mm</li>'
                +'</ul>'
        $(".acting_showlist").append(html);
        var arr=[];
        $(".acting_showlist>ul>li").on("change","input[type=text]",function(){ //新添加的文本框
         var acting_input=$(this).val();    
         arr.push(acting_input);   
        })
        saveSildingDoorNum(arr);
      }
    })
    //内置推拉门，外挂推拉门的编辑修改功能
    $("#double_rebuild").on("click",function(){
      var doorNumLater=$(".acting_num").val(),
          widthMinLater=$(".actingW_min").val(),
          widthMaxLater=$(".actingW_max").val();
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/door/updateSildingDoorNum",
        type:"post",
        data:{
          brandName:brandName,//品牌
          categoryName:categoryName, //品类（内置还是外挂）
          doorNum:doorNum, //数量
          widthMin:widthMin,//门洞下限
          widthMax:widthMax,//门洞上限
          doorNumLater:doorNumLater,//修改之后的数量
          widthMinLater:widthMinLater,//修改之后的门洞下限
          widthMaxLater:widthMaxLater//修改之后的门洞上限
        },
        success:function(e){
          if(e.resultCode==200){
            console.log(e);
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时17！");
        }
      })
    })
    //基础配置：保存子母门小门扇尺寸配置录入操作
    function saveLashDoorSize(arr){
      $("#friendDoor_btn").on("click",function(){
        $(".model_area").attr("disabled","disabled");
        $("#Composite_newbtn").attr("disabled","disabled");
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/door/saveLashDoorSize",
          type:"post",
          data:{
            brandName:brandName,//品牌
            modelName:arr[0], //型号 
            widthMax:arr[1],//上限
            modelMin:arr[2], //型号下限
            widthMin:arr[3] //下限
          },
          dataType:"json",
          success:function(e){
            if(e.resultCode==200){
              console.log(e);
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时18！");
          }
        })
      })
    }
    //子母门小门扇尺寸配置数据查询展示操作
    function selectLashDoorSize(){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/door/selectLashDoorSize",
        type:"post",
        dataType:"json",
        success:function(e){
          if(e.resultCode==200){
            var html="";
            for(var i in e.resultInfo){
              html+='<ul>'
                      +'<li><input type="text" value='+e.resultInfo[i].modelname+' class="model"></li>'
                      +'<li><input type="text" value='+e.resultInfo[i].widthmax+' class="model_max">&nbsp;mm</li>'
                      +'<li><input type="text" value='+e.resultInfo[i].modelmin+' class="model_min">&nbsp;mm</li>'
                      +'<li><input type="text" value='+e.resultInfo[i].widthmin+' class="minModel">&nbsp;mm</li>'
                    +'</ul>'
            }
            $(".Composite_showlist").html(html);
            model_Name=$(".model").val();
            widthMax=$(".model_max").val();
            modelMin=$(".model_min").val();
            widthMin=$(".minModel").val();
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时19！");
        }
      })
    }
    //点击新建功能，对子母门小门扇数量的功能操作，保存录入配置
    $("#Composite_newbtn").on("click",function(){
      $(".model_area").attr("disabled","disabled"); //编辑按钮不能点击
      if($(".Composite_showlist").find("ul").length>0){  //不为空
        $(this).attr("disabled",false);
        var html='<ul>'
                    +'<li><input type="text"></li>'
                    +'<li><input type="text">&nbsp;mm</li>'
                    +'<li><input type="text">&nbsp;mm</li>'
                    +'<li><input type="text">&nbsp;mm</li>'
                  +'</ul>'
        $(".Composite_showlist").append(html);
        var arr=[];
        $(".Composite_showlist>ul>li").on("change","input[type=text]",function(){ //新添加的文本框
          var Composite_input=$(this).val();     
          arr.push(Composite_input);
        })
        saveLashDoorSize(arr);  //新建的保存记录
      }else{  //为空
        $(this).attr("disabled",false);
        var html='<ul>'
                  +'<li><input type="text"></li>'
                  +'<li><input type="text"></li>'
                  +'<li><input type="text">&nbsp;mm</li>'
                  +'<li><input type="text">&nbsp;mm</li>'
                +'</ul>'
        $(".Composite_showlist").append(html);
        var arr=[];
        $(".Composite_showlist>ul>li").on("change","input[type=text]",function(){ //新添加的文本框
         var Composite_input=$(this).val();    
         arr.push(Composite_input);   
        })
        saveLashDoorSize(arr);
      }
    })
    //子母门小门扇尺寸配置的编辑修改功能操作
    $("#Composite_rebuild").on("click",function(){
      var modelMinLater=$(".model_min").val(),
          widthMinLater=$(".minModel").val(),
          widthMaxLater=$(".model_max").val();
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/door/updateLashDoorSize",
        type:"post",
        data:{
          brandName:brandName,//品牌
          modelName:model_Name, //型号
          modelMin:modelMin, //型号下限
          widthMin:widthMin,//下限
          widthMax:widthMax,//上限
          modelMinLater:modelMinLater,//修改后型号下限
          widthMinLater:widthMinLater,//修改后下限
          widthMaxLater:widthMaxLater//修改后上限
        },
        success:function(e){
          if(e.resultCode==200){
            console.log(e);
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时20！");
        }
      })
    })
    //关联配置中依据品类(不同的门)查询不同的型号
    var default_Category=$(".brand_door>ul>li").eq(0).text(), //默认的品类
        brandName_text=$(".dl_brand").find("dd").text(); //品牌
    //默认显示第一个品类对应的型号
    $.ajax({
      url:json._url+"/"+json._nameCustommade+"/cusProduct/selectModelByCategory",
      dataType:"json",
      type:"post",
      data:{
        productType:1, //类别
        brandName:brandName_text, //品牌
        categoryName:default_Category  //品类
      },
      success:function(e){
         _defaultCategory(e);
      },
      error:function(){
        alert("请求超时21！");
      }
    })
    function _defaultCategory(e){
      if(e.resultCode==200){
        var html='';
        for(var i in e.resultInfo){
          html+='<dl>'
                 +'<dt><img src="static/images/aa.png" alt="" /></dt>'
                 +'<dd>'
                   +'<span>'+e.resultInfo[i].modelname+'</span>' 
                   +'<input type="checkbox" />'
                 +'</dd>'
              +'</dl>'
        }
        $(".vertical_model").html(html);
      }else{
        alert("请求失败！");
      }
    } 
    $(".brand_door>ul>li").on("click",function(){
      var liText=$(this).text();
      selectModelByCategory_Relevancy(liText);
    })
    //点击加载的依据品类查询型号
    function selectModelByCategory_Relevancy(liText){
      var brandName=$(".dl_brand").find("dd").text(); //品牌
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/cusProduct/selectModelByCategory",
        dataType:"json",
        type:"post",
        data:{
          productType:1, //类别
          brandName:brandName, //品牌
          categoryName:liText  //品类
        },
        success:function(e){
          if(e.resultCode==200){
            var html='';
            for(var i in e.resultInfo){
              html+='<dl>'
                       +'<dt><img src="static/images/aa.png" alt="" /></dt>'
                       +'<dd>'
                         +'<span>'+e.resultInfo[i].modelname+'</span>' 
                         +'<input type="checkbox" />'
                       +'</dd>'
                    +'</dl>'
            }
            $(".vertical_model").html(html);
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时22！");
        }
      })
    }
    //关联配置中产品型号的搜索功能操作
    $("#search_model").on("click",function(){
      var input_model=$("#input_model").val();
      $.ajax({
         url:json._url+"/"+json._nameCustommade+"/cusProduct/likeProductModel",
         type:"post",
         dataType:"json",
         data:{
            productType:1, //类别
            modelName:input_model //产品型号
         },
         success:function(e){
            if(e.resultCode==200){
              _defaultCategory(e);
            }else{
              alert("请求失败！");
            }
         },
         error:function(){
            alert("请求超时23！");
         }
      })
    })
    //点击系列查询对应的花色列表数据渲染
    $(".vertical_model").on("click","dl",function(){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/cusProduct/selectSeriesName",
        type:"post",
        async:false,
        data:{
          productType:1  //类别
        },
        success:function(e){
          if(e.resultCode==200){
            var html="";
            for(var i in e.resultInfo){
              html+='<div class="contract_list">'
                       +'<div class="series_title">'
                         +'<h2>'+e.resultInfo[i].seriesname+'</h2>'
                         +'<input type="checkbox" />'
                         +'<img src="static/images/55.png" alt="" class="sliderImg1" flag-data="1"/>'
                         +'<div class="clear"></div>'
                       +'</div>'
                    +'</div>'
            }
            $(".series_list").append(html);
            //关联配置中系列列表的展开折叠
            $(".sliderImg1").attr("flag-data","0");
            $(".sliderImg1").on("click",function(){
              var state=$(this).attr("flag-data"); //0
              if($(this).parent().next().is(":hidden")){
                $(this).parent().next().slideDown();
                $(this).attr("src","static/images/55.png");
              }else{
                $(this).parent().next().slideUp();
                $(this).attr("src","static/images/56.png");
              }
              if(state==0){  //状态为0，就触发ajax
                var seriesName=$(this).parent().find("h2").text(); //系列名称
                contarct_selectProductColor(seriesName,this); //依据系列查询花色
                $(this).attr("flag-data","1");
              }else if(state==1){  //为1，就不触发
                return;
              }
            })
            //关联配置中系列的选择
            $(".series_title").on("click","input[type=checkbox]",function(){
              if($(this).is(":checked")){
                _seriesName=$(this).parent().find("h2").text();
              }else{
                _seriesName="";
              }
            })
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时24！");
        }
      })
    })
    //关联配置中依据系列查询花色的数据渲染
    function contarct_selectProductColor(seriesName,that){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/cusProduct/selectProductColor",
        dataType:"json",
        async:false,
        data:{
          brandName:brandName_text, //品牌
          seriesName:seriesName, //系列名称
          productType:1   //类别
        },
        type:"post",
        success:function(e){
          if(e.resultCode==200){
            var str='<div class="series_area">'
                      +'<p>花色<input type="checkbox" /></p>'
                      +'<div class="flowser_picture">'
            for(var i in e.resultInfo){
              str+='<dl>'
                     +'<dt><img src="static/images/aa.png" alt="" /></dt>'
                     +'<dd>'
                       +'<span>'+e.resultInfo[i].colorname+'</span>'
                       +'<input type="checkbox" />'
                     +'</dd>'
                   +'</dl>'
            }
            str+='<div/><div class="clear"></div></div>';
            $(that).parents(".contract_list").append(str);
            //点击花色进入套线，五金列表
            $(".flowser_picture").on("click","dl",function(){
              //当点击关联配置中的系列列表的花色进入五金套线列表时，确认提交按钮出现
              $(".confirm_btn").show();
              $(".confirm_btn").val("确认提交");
              $(".confirm_btn").css({"margin-left":"8%"});
              $("#templte_config").show(); //模板出现
              $(".contract_linehandware").show();
              $(".series_list").hide();
              $("#flowser_title").text($(this).find("dd").text()); //花色的名称
              colorName=$(this).find("dd").find("span").text(); //关联配置中保存花色的名称
              contract_selectDoorWire(); //查询套线
              contract_selectProductionHardware(modelName); //查询五金
            })
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时25！");
        }
      })
    }
    //关联配置中依据花色查询对应的套线的数据渲染
    //点击花色进入套线，五金列表
    //点击型号列表，进入系列花色五金配置列表
    $(".vertical_model").on("click","dl",function(){
      modelName=$(this).find("dd").find("span").text(); //型号
      if(modelName.indexOf("B")<0 && modelName.indexOf("b")<0){  //不含B返回-1  不显示玻璃盒子
        $(".BoLi_picture").hide();
      }else{ //含的话返回下标，显示玻璃盒子
        $(".BoLi_picture").show();
      }
    })
    function contract_selectDoorWire(){   //套线接口
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/door/selectDoorWire",
        type:"post",
        dataType:"json",
        data:{
          brandName:brandName_text, //品牌
          productType:1 //类别
        },
        success:function(e){
          if(e.resultCode==200){
            var arr="";
            for(var i in e.resultInfo){
              arr+='<dl>'
                      +'<dt><img src="static/images/aa.png" alt="" /></dt>'
                      +'<dd>'
                      +'  <span>'+e.resultInfo[i].wirename+'</span>'
                      +'  <input type="checkbox" />'
                      +'</dd>'
                    +'</dl>'
            }
            $(".line_picture").html(arr);
            //关联配置中依据花色查询套线的选择
            $(".line_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
              if($(this).is(":checked")){  //选中状态
                var wireName=$(this).prev("span").text(); //套线
                wire.push(wireName);
              }
            })
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时26！");
        }
      })
    }
    function contract_selectProductionHardware(modelName){ //五金接口
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/door/selectProductionHardware",
        type:"post",
        dataType:"json",
        async:false,
        data:{
          productType:1, //产品类别
          brandName:brandName_text, //品牌
          modelName:modelName//型号名称
        },
        success:function(e){
          if(e.resultCode==200){
            var arr="",
                html="",
                str="",
                door_data="",
                glass_data="";
            for(var i in e.resultInfo.lockData){  //锁具
              arr+='<dl>'
                    +'<dt><img src="static/images/aa.png" alt="" /></dt>'
                    +'<dd>'
                    +'  <span>'+e.resultInfo.lockData[i].hardwarename+'</span>'
                    +'  <input type="checkbox" />'
                    +'</dd>'
                  +'</dl>'
            }
            for(var i in e.resultInfo.slidewayData){ //滑轨
              html+='<dl>'
                    +'<dt><img src="static/images/aa.png" alt="" /></dt>'
                    +'<dd>'
                    +'  <span>'+e.resultInfo.slidewayData[i].hardwarename+'</span>'
                    +'  <input type="checkbox" />'
                    +'</dd>'
                  +'</dl>'
            }
            for(var i in e.resultInfo.hingeData){ //合页
              str+='<dl>'
                    +'<dt><img src="static/images/aa.png" alt="" /></dt>'
                    +'<dd>'
                    +'  <span>'+e.resultInfo.hingeData[i].hardwarename+'</span>'
                    +'  <input type="checkbox" />'
                    +'</dd>'
                  +'</dl>'
            }
            for(var i in e.resultInfo.stopperData){ //门吸
              door_data+='<dl>'
                    +'<dt><img src="static/images/aa.png" alt="" /></dt>'
                    +'<dd>'
                    +'  <span>'+e.resultInfo.stopperData[i].hardwarename+'</span>'
                    +'  <input type="checkbox" />'
                    +'</dd>'
                  +'</dl>'
            }
            for(var i in e.resultInfo.glassData){ //玻璃
              glass_data+='<dl>'
                    +'<dt><img src="static/images/aa.png" alt="" /></dt>'
                    +'<dd>'
                    +'  <span>'+e.resultInfo.glassData[i].hardwarename+'</span>'
                    +'  <input type="checkbox" />'
                    +'</dd>'
                  +'</dl>'
            }
            $("#handware_picture").html(arr);
            $(".glass_picture").html(html);
            $(".HeYe_picture").append(str);
            $(".hinge_picture").append(door_data);
            $(".BoLi_picture").html(glass_data);
            //关联配置中五金里面锁具的选择
            $("#handware_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
              if($(this).is(":checked")){
                var lockName=$(this).prev("span").text();
                lock.push(lockName);
              }
            })
            //关联配置中五金里面合页的选择
            $(".HeYe_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
              if($(this).is(":checked")){
                var hingeName=$(this).prev("span").text();
                hinge.push(hingeName);
              }
            })
            //关联配置中五金里面门吸的选择
            $(".hinge_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
              if($(this).is(":checked")){
                var stooperName=$(this).prev("span").text();
                stooper.push(stooperName);
              }
            })
            //关联配置中五金里面滑轨的选择
            $(".glass_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
              if($(this).is(":checked")){
                var sildewayName=$(this).prev("span").text();
                sildeway.push(sildewayName);
              }
            })
            //关联配置中五金里面玻璃的选择
            $(".BoLi_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
              if($(this).is(":checked")){
                var glassName=$(this).prev("span").text();
                glass.push(glassName);
              }
            })
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时27！");
        }
      })
    }
    //关联配置中保存花色配置生产的接口数据
    $(".brand_door>ul").on("click","li",function(){
      categoryName=$(this).text(); //关联配置中的品类
    })
    function saveProductionModelRelation(){
      $(".confirm_btn").on("click",function(){
        if(type==2){
          if($(this).val()=="确认提交"){
            $.ajax({
              url:json._url+"/"+json._nameCustommade+"/door/saveProductionModelRelation",
              type:"post",
              dataType:"json",
              data:{
                categoryName:categoryName, //品类
                modelName:modelName, //型号
                seriesName:_seriesName, //系列
                colorName:colorName, //花色
                wire:wire.toString(), //套线（数组）
                lock:lock.toString(),//锁具（数组）
                hinge:hinge.toString(),//合页（数组）
                stooper:stooper.toString(), //门吸（数组）
                sildeway:sildeway.toString(), //滑轨（数组）
                glass:glass.toString() //玻璃（数组）
              },
              success:function(e){
                if(e.resultCode==200){
                  console.log(e);
                }else{
                  alert("请求失败！");
                }
              },
              error:function(){
                alert("请求超时28！");
              }
            })
          }
        }
      })
    }
    saveProductionModelRelation();
})
