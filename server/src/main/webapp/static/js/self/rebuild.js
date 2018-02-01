$(function(){
  //点击不同品类的门对应的型号列表的数据“修改(编辑)功能”
  $(".picture_model").on("click","dl",function(){
    $(".model_config").show();
    $(".model_list").hide();
    $(".edit_model").show();  //编辑按钮显示
    $(".confirm_btn").hide();  //确认提交按钮隐藏
    var dl_text=$(this).find("dd").text();
    $(".model_name").val(dl_text);
  })
  //点击套线列表的数据，进入型号配置界面，进行“修改(编辑)功能”
  $("#picture_line").on("click","dl",function(){
    $(".model_config").show();
    $(".line_area").hide();
    $(".edit_model").show();  //编辑按钮显示
    $(".confirm_btn").hide();  //确认提交按钮隐藏
    var dl_text=$(this).find("dd").text();
    $(".model_name").val(dl_text);
    })
  //点击花色配置列表的数据，进入型号配置界面，进行“修改(编辑)”功能
  $(".picture_design").on("click","dl",function(){
    $(".model_config").show();
    $(".design_list").hide();
    $(".edit_model").show();  //编辑按钮显示
    $(".confirm_btn").hide();  //确认提交按钮隐藏
    var dl_text=$(this).find("dd").text();
    $(".model_name").val(dl_text);
  })
  //五金配置列表的数据，进入型号配置界面，进行“修改(编辑)”功能
  $(".picture_glass").on("click","dl",function(){
    $(".model_config").show();
    $(".glass_list").hide();
    $(".edit_model").show();  //编辑按钮显示
    $(".confirm_btn").hide();  //确认提交按钮隐藏
    var dl_text=$(this).find("dd").text();
    $(".model_name").val(dl_text); 
  })
})