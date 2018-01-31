$(function(){
    var province="", //省
        city="", //市
        Supply_categoryName="", //品类名称
        Supply_modelName="", //型号名称
        Supply_seriesName="", //系列名称
        Supply_colorName="",  //花色名称
        Supply_wire=[], //供应配置中的套线
        Supply_lock=[], //锁具
        Supply_hinge=[], //合页
        Supply_stooper=[], //门吸
        Supply_sildeway=[], //滑轨
        Supply_glass=[], //玻璃
        sell_province="", //销售配置的省
        sell_city="", //销售配置的市
        sell_colorName="", //销售配置的花色名称
        sell_seriesName="", //销售配置的系列名称
        sell_wire=[], //销售配置中的套线
        sell_lock=[], //锁具
        sell_hinge=[], //合页
        sell_stooper=[], //门吸
        sell_sildeway=[], //滑轨
        sell_glass=[]; //玻璃
    var type=1;  //控制提交按钮不同的方法
    $(".config_nav").on("click","h2",function(){
      if($(this).text()=="关联配置"){
        type=2;
      }else if($(this).text()=="供应配置"){
        type=3;
      }else if($(this).text()=="销售配置"){
        type=4;
      }
    })
    $(".brand_door>ul").on("click","li",function(){
      Supply_categoryName=$(this).text(); //品类
    })
    //供应、销售配置中查询省份的接口数据
    $(".config_nav").on("click","h2",function(){
      if($(this).text()=="供应配置"){
        $.ajax({
          url:json._url+"/"+json._nameSecuser+"/authen/getProvinceCityCounty",
          dataType:"json",
          data:{
            code:0   //固定值
          },
          type:"post",
          success:function(e){
            if(e.resultCode==200){
              var html='';
              for(var i in e.resultInfo){
                html+='<li>'+e.resultInfo[i].name+'</li>'
              }
              $(".Provicesupply_list").html(html);
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时！");
          }
        })
      }else if($(this).text()=="销售配置"){
        $.ajax({
          url:json._url+"/"+json._nameCustommade+"/door/selectSaleProvince",
          dataType:"json",
          type:"post",
          success:function(e){
            if(e.resultCode==200){
              var html='';
              for(var i in e.resultInfo){
                html+='<li>'+e.resultInfo[i].province+'</li>'
              }
              $(".Provicesell_list").html(html);
            }else{
              alert("请求失败！");
            }
          },
          error:function(){
            alert("请求超时！");
          }
        })
      }
    })
    //供应配置中查询省份对应的城市接口
    //点击供应配置的省份查询对应的城市
    $(".Provicesupply_list").on("click","li",function(){
      $(this).addClass('active').siblings().removeClass('active');
      province=$(this).text();
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/cusProduct/selectCitySupply",
        type:"post",
        data:{
          province:province   //省份
        },
        success:function(e){
          if(e.resultCode==200){
            if(province=="北京市" || province=="天津市" || province=="上海市" || province=="重庆市"){
              var html='';
              html+='<li>'+e.resultInfo.name+'</li>';
            }else{
              var html='';
              for(var i in e.resultInfo){
                html+='<li>'+e.resultInfo[i].name+'</li>';
              }
            }
            $(".Citysupply_list").html(html);
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时！");
        }
      })
    })
    //销售配置中查询省份对应的城市接口
    //点击销售配置的省份查询对应的城市
    $(".Provicesell_list").on("click","li",function(){
      $(this).addClass('active').siblings().removeClass('active');
      sell_province=$(this).text();
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/door/selectSaleCity",
        type:"post",
        data:{
          province:sell_province   //省份
        },
        success:function(e){
          if(e.resultCode==200){
            var html='';
            for(var i in e.resultInfo){
                html+='<li>'+e.resultInfo[i].city+'</li>';
            }
            $(".Citysell_list").html(html);
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时100！");
        }
      })
    })
    //供应配置中根据省、市，进行型号，系列，花色，套线，五金的配置录入
    $(".Citysupply_list").on("click","li",function(){
      city=$(this).text(); //市
      $(this).addClass('active').siblings().removeClass('active');
      $(".supplyrelevancy_config").show(); //型号列表显示
      $(".supply_list").hide();
    })
    //点击型号列表进入系列-花色列表
    $(".vertical_model").on("click","dl",function(){
       Supply_modelName=$(this).find("dd").find("span").text();
       if(Supply_modelName.indexOf("B")<0 && Supply_modelName.indexOf("b")<0){  //不含B返回-1  不显示玻璃盒子
        $(".supply_BoLi_picture").hide();
       }else{ //含的话返回下标，显示玻璃盒子
        $(".supply_BoLi_picture").show();
       }
       $(".supplyseries_list").show();
       $(".supplyrelevancy_config").hide();
       supply_selectSeriesSupply(Supply_modelName);
    })
    //供应配置中依据型号查询系列
    function supply_selectSeriesSupply(Supply_modelName){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/door/selectSeriesSupply",
        data:{
          modelName:Supply_modelName   //型号名称
        },
        async:false,
        dataType:"json",
        type:"post",
        success:function(e){
          if(e.resultCode==200){
            var html="";
            for(var i in e.resultInfo){
              html+='<div class="contract_list">'
                       +'<div class="series_title">'
                         +'<h2>'+e.resultInfo[i].seriesname+'</h2>'
                         +'<input type="checkbox" />'
                         +'<img src="static/images/55.png" alt="" class="sliderImg2" flag-data="1"/>'
                         +'<div class="clear"></div>'
                       +'</div>'
                    +'</div>'
            }
            $(".supplyseries_list").append(html);
            //供应配置中系列列表的展开折叠
            $(".sliderImg2").attr("flag-data","0");
            $(".sliderImg2").on("click",function(){
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
                supply_selectSupplyColor(seriesName,this); //依据系列查询花色
                $(this).attr("flag-data","1");
              }else if(state==1){  //为1，就不触发
                return;
              }
            })
            //供应配置中系列的选择
            $(".series_title").on("click","input[type=checkbox]",function(){
              if($(this).is(":checked")){
                Supply_seriesName=$(this).parent().find("h2").text();
              }else{
                Supply_seriesName="";
              }
            })
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时111！");
        }
      })
    }
    //供应配置中依据系列查询花色的数据渲染
    function supply_selectSupplyColor(seriesName,that){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/door/selectSupplyColor",
        dataType:"json",
        async:false,
        data:{
           modelName:Supply_modelName, //型号名称
           seriesName:seriesName  //系列名称
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
              //当点击供应配置中的系列列表的花色进入五金套线列表时，确认提交按钮出现
              $(".confirm_btn").show();
              $(".confirm_btn").val("确认提交");
              $(".confirm_btn").css({"margin-left":"8%"});
              $("#templte_config").show(); //模板出现
              $(".supplycontract_linehandware").show();
              $(".supplyseries_list").hide();
              $("#supplyflowser_title").text($(this).find("dd").find("span").text()); //花色的名称
              Supply_colorName=$(this).find("dd").find("span").text(); //供应配置中保存花色的名称
              supply_selectSupplyWire(Supply_colorName);  //套线
              supply_selectSupplyHardware(Supply_colorName); //五金
            })
          }else{
            alert("请求失败！");
          }
        },
        error:function(){
          alert("请求超时222！");
        }
      })
    }
    //供应配置中依据花色查询套线的数据渲染
    function supply_selectSupplyWire(Supply_colorName){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/door/selectSupplyWire",
        type:"post",
        dataType:"json",
        async:false,
        data:{
          modelName:Supply_modelName,//型号名称
          colorName:Supply_colorName //花色名称
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
                $(".supply_line_picture").html(arr);
                //供应配置中依据花色查询套线的选择
                $(".supply_line_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
                  if($(this).is(":checked")){  //选中状态
                    var wireName=$(this).prev("span").text(); //套线
                    Supply_wire.push(wireName);
                  }
                })
            }else{
              alert("请求失败！");
            }
        },
        error:function(){
          alert("请求超时333！");
        }
      })
    }
    //供应配置中依据花色查询五金的数据渲染
    function supply_selectSupplyHardware(Supply_colorName){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/door/selectSupplyHardware",
        type:"post",
        dataType:"json",
        async:false,
        data:{
           modelName:Supply_modelName,//型号名称
           colorName:Supply_colorName //花色名称
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
                $("#supply_handware_picture").html(arr);
                $("#supply_glass_picture").html(html);
                $("#supply_HeYe_picture").append(str);
                $("#supply_hinge_picture").append(door_data);
                $("#supply_BoLi_picture").html(glass_data);
                //供应配置中五金里面锁具的选择
                $("#supply_handware_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
                  if($(this).is(":checked")){
                    var lockName=$(this).prev("span").text();
                    Supply_lock.push(lockName);
                  }
                })
                //供应配置中五金里面合页的选择
                $("#supply_HeYe_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
                  if($(this).is(":checked")){
                    var hingeName=$(this).prev("span").text();
                    Supply_hinge.push(hingeName);
                  }
                })
                //供应配置中五金里面门吸的选择
                $("#supply_hinge_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
                  if($(this).is(":checked")){
                    var stooperName=$(this).prev("span").text();
                    Supply_stooper.push(stooperName);
                  }
                })
                //供应配置中五金里面滑轨的选择
                $("#supply_glass_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
                  if($(this).is(":checked")){
                    var sildewayName=$(this).prev("span").text();
                    Supply_sildeway.push(sildewayName);
                  }
                })
                //供应配置中五金里面玻璃的选择
                $("#supply_BoLi_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
                  if($(this).is(":checked")){
                    var glassName=$(this).prev("span").text();
                    Supply_glass.push(glassName);
                   }
                })
            }else{
                alert("请求失败！");
            }
        },
        error:function(){
          alert("请求超时777！");
        }
      })
    } 
    //供应配置中保存花色的配置录入
    function supply_saveSupplyModelRelation(){
      $(".confirm_btn").on("click",function(){
        if(type==3){
          if($(this).val()=="确认提交"){
            $.ajax({
                url:json._url+"/"+json._nameCustommade+"/door/saveSupplyModelRelation",
                type:"post",
                dataType:"json",
                data:{
                  province:province, //省
                  city:city, //城市
                  categoryName:Supply_categoryName, //品类
                  modelName:Supply_modelName, //型号
                  seriesName:Supply_seriesName, //系列
                  colorName:Supply_colorName, //花色
                  wire:Supply_wire.toString(), //套线（数组）
                  lock:Supply_lock.toString(),//锁具（数组）
                  hinge:Supply_hinge.toString(), //合页（数组）
                  stooper:Supply_stooper.toString(), //门吸（数组）
                  sildeway:Supply_sildeway.toString(), //滑轨（数组）
                  glass:Supply_glass.toString() //玻璃（数组）
                },
                success:function(e){
                  if(e.resultCode==200){
                    console.log(e);
                  }else{
                    alert("请求失败！");
                  }
                },
                error:function(){
                  alert("请求超时888！");
                }
            })
          }
        }
      })
    }
    supply_saveSupplyModelRelation();
    //销售配置中根据省、市，进行型号，系列，花色，套线，五金的配置录入
    $(".Citysell_list").on("click","li",function(){
      sell_city=$(this).text(); //销售的城市
      $(this).addClass('active').siblings().removeClass('active');
      $(".sellrelevancy_config").show(); //销售型号列表显示
      $(".sell_list").hide();
    })
    //点击型号列表进入系列-花色列表
    $(".vertical_model").on("click","dl",function(){
      Supply_modelName=$(this).find("dd").find("span").text();
      if(Supply_modelName.indexOf("B")<0 && Supply_modelName.indexOf("b")<0){  //不含B返回-1  不显示玻璃盒子
       $(".sell_BoLi_picture").hide();
      }else{ //含的话返回下标，显示玻璃盒子
       $(".sell_BoLi_picture").show();
      }
      $(".sellseries_list").show();
      $(".sellrelevancy_config").hide();
      sell_selectSeriesSale(Supply_modelName);
    })
    //销售配置中依据型号查询系列
    function sell_selectSeriesSale(Supply_modelName){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/door/selectSeriesSale",
        data:{
          modelName:Supply_modelName   //型号名称
        },
        async:false,
        dataType:"json",
        type:"post",
        success:function(e){
            if(e.resultCode==200){
                var html="";
                for(var i in e.resultInfo){
                  html+='<div class="contract_list">'
                           +'<div class="series_title">'
                             +'<h2>'+e.resultInfo[i].seriesname+'</h2>'
                             +'<input type="checkbox" />'
                             +'<img src="static/images/55.png" alt="" class="sliderImg3" flag-data="1"/>'
                             +'<div class="clear"></div>'
                           +'</div>'
                        +'</div>'
                }
                $(".sellseries_list").append(html);
                //销售配置中系列列表的展开折叠
                $(".sliderImg3").attr("flag-data","0");
                $(".sliderImg3").on("click",function(){
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
                    sell_selectSaleColor(seriesName,this); //依据系列查询花色
                    $(this).attr("flag-data","1");
                  }else if(state==1){  //为1，就不触发
                    return;
                  }
                })
                //销售配置中系列的选择
                $(".series_title").on("click","input[type=checkbox]",function(){
                  if($(this).is(":checked")){
                    sell_seriesName=$(this).parent().find("h2").text();
                  }else{
                    sell_seriesName="";
                  }
                })
            }else{
                alert("请求失败！");
            }
        },
        error:function(){
          alert("请求超时000！");
        }
      })
    }
    //销售配置中依据系列查询花色的数据渲染
    function sell_selectSaleColor(seriesName,that){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/door/selectSaleColor",
        dataType:"json",
        async:false,
        data:{
           modelName:Supply_modelName, //型号名称
           seriesName:seriesName,  //系列名称
           province:sell_province,//省
           city:sell_city//城市
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
                  //当点击供应配置中的系列列表的花色进入五金套线列表时，确认提交按钮出现
                  $("#confirm_btn").show();
                  $("#confirm_btn").val("确认提交");
                  $("#confirm_btn").css({"margin-left":"8%"});
                  $("#templte_config").show(); //模板出现
                  $(".sellcontract_linehandware").show();
                  $(".sellseries_list").hide();
                  $("#sellflowser_title").text($(this).find("dd").find("span").text()); //花色的名称
                  sell_colorName=$(this).find("dd").find("span").text(); //销售配置中保存花色的名称
                  sell_selectSaleWire(sell_colorName);  //套线
                  sell_selectSaleHardware(sell_colorName); //五金
                })
            }else{
                alert("请求失败！");
            }
        },
        error:function(){
          alert("请求超时78！");
        }
      })
    }
    //销售配置中依据花色查询套线的数据渲染
    function sell_selectSaleWire(sell_colorName){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/door/selectSaleWire",
        type:"post",
        dataType:"json",
        async:false,
        data:{
            modelName:Supply_modelName,//型号名称
            colorName:sell_colorName, //花色名称
            province:sell_province,//省
            city:sell_city//城市
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
                $(".sell_line_picture").html(arr);
                //销售配置中依据花色查询套线的选择
               /* $(".supply_line_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
                  if($(this).is(":checked")){  //选中状态
                    var wireName=$(this).prev("span").text(); //套线
                    Supply_wire.push(wireName);
                  }
                })*/
            }else{
              alert("请求失败！");
            }
        },
        error:function(){
          alert("请求超时000000！");
        }
      })
    }
    //销售配置中依据花色查询五金的数据渲染
    function sell_selectSaleHardware(sell_colorName){
      $.ajax({
        url:json._url+"/"+json._nameCustommade+"/door/selectSaleHardware",
        type:"post",
        dataType:"json",
        async:false,
        data:{
          modelName:Supply_modelName,//型号名称
          colorName:sell_colorName, //花色名称
          province:sell_province,//省
          city:sell_city//城市
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
              $("#sell_handware_picture").html(arr);
              $("#sell_glass_picture").html(html);
              $("#sell_HeYe_picture").append(str);
              $("#sell_hinge_picture").append(door_data);
              $("#sell_BoLi_picture").html(glass_data);
              //销售配置中五金里面锁具的选择
              $("#sell_handware_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
                if($(this).is(":checked")){
                  var lockName=$(this).prev("span").text();
                  sell_lock.push(lockName);
                }
              })
              //销售配置中五金里面合页的选择
              $("#sell_HeYe_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
                if($(this).is(":checked")){
                  var hingeName=$(this).prev("span").text();
                  sell_hinge.push(hingeName);
                }
              })
              //销售配置中五金里面门吸的选择
              $("#sell_hinge_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
                if($(this).is(":checked")){
                  var stooperName=$(this).prev("span").text();
                  sell_stooper.push(stooperName);
                }
              })
              //销售配置中五金里面滑轨的选择
              $("#sell_glass_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
                if($(this).is(":checked")){
                  var sildewayName=$(this).prev("span").text();
                  sell_sildeway.push(sildewayName);
                }
              })
              //销售配置中五金里面玻璃的选择
              $("#sell_BoLi_picture>dl>dd").find("input[type=checkbox]").on("click",function(){
                if($(this).is(":checked")){
                  var glassName=$(this).prev("span").text();
                  sell_glass.push(glassName);
                 }
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
    //销售配置中保存花色的配置录入
    function sell_saveSaleModelRelation(){
      $(".confirm_btn").on("click",function(){
        if(type==4){
          if($(this).val()=="确认提交"){
            $.ajax({
              url:json._url+"/"+json._nameCustommade+"/door/saveSaleModelRelation",
              type:"post",
              dataType:"json",
              data:{
                province:sell_province, //省
                city:sell_city, //城市
                categoryName:Supply_categoryName, //品类
                modelName:Supply_modelName, //型号
                seriesName:sell_seriesName, //系列
                colorName:sell_colorName, //花色
                wire:sell_wire.toString(), //套线（数组）
                lock:sell_lock.toString(),//锁具（数组）
                hinge:sell_hinge.toString(), //合页（数组）
                stooper:sell_stooper.toString(), //门吸（数组）
                sildeway:sell_sildeway.toString(), //滑轨（数组）
                glass:sell_glass.toString() //玻璃（数组）
              },
              success:function(e){
                if(e.resultCode==200){
                  console.log(e);
                }else{
                  alert("请求失败！");
                }
              },
              error:function(){
                alert("请求超时！");
              }
            })
          }
        }
      })
    }
    sell_saveSaleModelRelation();
})