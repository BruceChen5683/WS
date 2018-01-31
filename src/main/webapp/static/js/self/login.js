$(function(){
	if($.cookie("status")==1){
        $("#username").val($.cookie("mobile"));
        $("#remember_user").prop("checked",true);
    }else{
        $("#username").val($.cookie(""));
        $("#remember_user").prop("checked",false);
    }
	//用户一进来，划过文本框时样式的变化
	function hoverFn(){
		$("#username").on("mouseover",function(){
			$(this).addClass("hover_status");
			$(this).next().attr("src","static/images/input2.png");
		}).on("mouseout",function(){
			$(this).removeClass("hover_status");
			$(this).next().attr("src","static/images/default2.png");
		})
		$("#password").on("mouseover",function(){
			$(this).addClass("hover_status");
			$(this).next().attr("src","static/images/input1.png");
		}).on("mouseout",function(){
			$(this).removeClass("hover_status");
			$(this).next().attr("src","static/images/default1.png");
		})
	}
	hoverFn();
	//聚焦时，文本框的样式变化(账号,密码)
	function focusFn(){
		$("#username").on("focus",function(){
			$(this).addClass("focus_status");
			$(this).next().attr("src","static/images/input2.png");
		})
		$("#password").on("focus",function(){
			$(this).addClass("focus_status");
			$(this).next().attr("src","static/images/input1.png");
		})
	}
	focusFn();
	//失焦时，文本框的格式判断，及样式变化
	function blurFn(){
		$("#username").on("blur",function(){
			$(this).removeClass("focus_status");
			$(this).next().attr("src","static/images/default2.png");
		})
		$("#password").on("blur",function(){
			$(this).removeClass("focus_status");
			$(this).next().attr("src","static/images/default1.png");
		})
	}
	blurFn();
	//判断账号信息，格式错误的文本框样式
	var flag=true;
	$("#username").on("blur",function(){
		var txt=$(this).val();
		//账号格式规定，11位手机号
		var reg=/^[1][358][0-9]{9}$/;
		if(txt.length==0){
			$(this).addClass("error_status");
			$(this).next().attr("src","static/images/err2.png");
			flag=false;
		}else if(!reg.test(txt)){
			$(this).addClass("error_status");
			$(this).next().attr("src","static/images/err2.png");
		    flag=false;
		}else{
			$(this).removeClass("error_status");
			$(this).next().attr("src","static/images/default2.png");
			flag=true;
		}
	})
	//判断密码
	var flag1=true;
	$("#password").on("blur",function(){
		var ptxt=$(this).val();
		//密码的正则匹配
		var reg=/^[\dA-Za-z]{6,16}$/;
		if(ptxt.length==0){
			$(this).addClass("error_status");
			$(this).next().attr("src","static/images/err1.png");
			flag1=false;
		}else if(ptxt.length<6 || ptxt.length>16){  //密码的长度判断6-16位
			$(this).addClass("error_status");
			$(this).next().attr("src","static/images/err1.png");
			flag1=false;
		}else if(!reg.test(ptxt)){
			$(this).addClass("error_status");
			$(this).next().attr("src","static/images/err1.png");
			flag1=false;
		}else{
			$(this).removeClass("error_status");
			$(this).next().attr("src","static/images/default1.png");
			flag1=true;
		}
	})
	//ajax渲染数据，取出账号和密码
	function loginFn(){
		var user_text=$.trim($("#username").val()),
		    pass_text=$("#password").val();
		$.ajax({
			url:json._url+"/"+json._nameSecuser+"/login/login",
			type:"get",
			dataType:"json",
			data:{
				mobile:user_text,
				password:pass_text
			},
			success:function(e){
				console.log(e);
				if(e.resultCode==200){ //请求成功
					//var userId=e.resultInfo.userID; //将用户的id提取出来存到session中
					$.cookie("mobile",user_text,{ expires: 7 }); //用cookie存储账号
					$.session.set('mobile',user_text); //用session存储账号，以及账号id
					$.session.set('userId',3);
					window.location.href="index.html";
				}else{
					alert("亲，您的用户账号和密码不一致,请重新登录");
					return false;
				}
			},
			error:function(e){
				console.log("页面请求失败！");
			}
		})
	}
	//点击登录时的验证
	$(".login_btn").on("click",function(){
		var user_text=$("#username").val(),
			pass_text=$("#password").val();
		if(user_text.length==0 || pass_text.length==0){
			$(".alert_text").show();
			return false;
		}
		if(flag && flag1){  //格式都成立
			loginFn();
		}
		//记住账号的功能实现
		if($("#remember_user").prop("checked")){
			$.cookie("status",1,{ expires: 7 });
		}else{
			$.cookie("status",0,{ expires: 7 });
		}
	})
})