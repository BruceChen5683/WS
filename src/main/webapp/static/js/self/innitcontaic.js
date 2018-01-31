$(function() {
	var product = {
		"scheme" : "", // 方案，原来的订单id
		"productType" : 5, // 定制家具
		"roomDetailName" : "", // 空间选择
		"brandName" : "", // 品牌
		"categoryName" : "", // 品类
		"modelName" : "", // 型号名称
		"pHeight" : "", // 产品的高
		"pWidth" : "", // 产品的宽
		"pDeep" : "", // 产品的深
		"bHeigth" : "", // 地柜的高度
		"tHeight" : "", // 顶柜的高度
		"inner" : []
	}

	var kind_choice = "", // 类别选择
	space_choice = "", // 空间选择
	productType = 1, // 类别状态
	ProductMatrix = "", // 存取后台表中所有的数据
	initial_W1 = "", // 产品型号的宽(像素为单位)
	initial_H1 = "", // 顶柜+地柜(Hb)的高 (Hp)
	initial_D1 = "", // 深
	initial_floorH1 = "", // 地柜的高(Hb)
	initial_topH1 = "", // 顶柜的高
	img_Z0 = "", // 图片起始点的纵坐标
	img_X0 = "", // 图片起始点的横坐标(x)
	scale = "", // 像素比例
	x = 10, // 宽度不变,x=10
	z = 10, // 高度不变,z=10
	imgW = "", // 实际产品的像素宽
	imgH = "", // 实际产品的像素高
	imgz = "", // 实际产品左下角起始点的Z坐标
	canvas = document.getElementById("myCanvas"), scheme = "", // 方案（订单编号）
	cxt = canvas.getContext("2d");
	$("#space_title").html(space_choice);
	var str_H = "", str_W = "", str_D = "", floor_H = "", max_H = "", min_H = "", step_H = "", max_W = "", min_W = "", step_W = "", max_D = "", min_D = "", step_D = "", floormax_H = "", floormin_H = "", floorstep_H = "", initial_H = "", // 初始值的高(地柜(Hb)+顶柜)Hp
	initial_W = "", // 初始值的宽
	initial_D = "", // 初始值的深
	initial_topH = "", // 顶柜的高度
	initial_floorH = "", // 地柜(Hb)高度的初始值
	backPanelD = "", // 背板的厚度
	rightPanelD = "", // 右侧板的厚度
	leftPanelD = "", // 左侧板的厚度
	doorPanelD = "", // 门板的厚度
	tPopanelD = "", // 顶板的厚度
	middlePanel1D = "", // 中立板1的厚度
	bottomPanelD = "", // 底板厚度
	middlePanel2D = "", // 中立板2的厚度
	baseboardD = "", // 踢脚厚度
	backBaseboardH = ""; // 踢脚高度
	var brand_Name = "", // 品牌名称
	categroy_Name = "", // 品类名称
	model_Name = "", // 型号名称
	model_id = "", // 型号id
	areaName = "", // 区域名称
	unitCabinetName = "", // 单元柜名称
	functionId = "", // 功能区的id
	functionName = "", // 功能区的名称
	unitCabinetId = "", // 单元柜id
	floorHeight = 1800, // 地柜的高度(死值)
	seriesData = [], // 材质列表的数据
	flag = false, // 保存的第三方变量
	furniture = [], // 保存的数据数组
	object = {

	// 内部结构
	}, objInnit = {}, // 内部结构的存储对象
	objFunction = {}, // 内部结构功能区的存储对象
	objConfig = {}; // 内部结构功能区配置的存储对象
	// 根据类别选择判断明细页面对应的数据
	if (kind_choice == "木门") {
		product["productType"] = 1;
	} else if (kind_choice == "橱柜") {
		product["productType"] = 2;
	} else if (kind_choice == "卫浴柜") {
		product["productType"] = 3;
	} else if (kind_choice == "整体家装") {
		product["productType"] = 4;
	} else if (kind_choice == "定制家具") {
		product["productType"] = 5;
	}
	// 品牌的接口渲染
	getBrands(product["productType"], function(res) {
		if (res.resultCode == 200) {
			var html = ""
			for ( var i in res.resultInfo) {
				html += '<li>' + res.resultInfo[i].name + '</li>';
			}
			$("#brandList").html(html);
			// 点击品牌添加样式
			$("#brandList").find("li").on("click", function() {
				$(this).addClass("active").siblings().removeClass("active");
				$("#brand_style").text($(this).text());
				product["brandName"] = $(this).text();
				getModels();
			})
		} else {
			alert("请求页面数据失败！");
		}
	});
	getProductCategorys(product["productType"], function(res) {
		if (res.resultCode == 200) {
			var html = ""
			for ( var i in res.resultInfo) {
				html += '<dl><dt><img src="' + res.resultInfo[i].img
						+ '" alt=""></dt><dd>' + res.resultInfo[i].name
						+ '</dd></dl>';
			}
			$("#categroy_list").html(html);
			// 点击品类添加样式
			$("#categroy_list").on(
					"click",
					"dl",
					function() {
						$(this).addClass("dl_active").siblings().removeClass(
								"dl_active");
						var categroyName = $(this).find("dd").text();
						$("#categroy_style").text(categroyName);
						product["categoryName"] = categroyName;
						getModels();
					})
		} else {
			alert("请求页面数据失败！");
		}
	})
	function getModels() {
		getProductModels(product, function(res) {
			if (res.resultCode == 200) {
				var html = "";
				for ( var i in res.resultInfo) {
					html += '<dl data-id="' + res.resultInfo[i].id + '">'
							+ '<dt><img src="' + res.resultInfo[i].img
							+ '" alt=""></dt>' + '<dd>'
							+ res.resultInfo[i].modelName + '</dd>' + '</dl>'
				}
				$(".model_list").html(html);
				// 点击型号添加样式
				$(".model_list").find("dl").on(
						"click",
						function() {
							flag = true;
							$(this).addClass("dl_active").siblings()
									.removeClass("dl_active");
							var product_Txt = $(this).find("dd").text();
							$(".title_area").find("span").children().text(
									product_Txt);
							model_id = $(this).attr("data-id");
							selectProductSize(product_Txt);
							selectAreaUnitByModelIdFn(model_id); // 根据型号查询区域和单元柜的数据渲染
							materialFn(model_id); // 依据型号去关联材质列表
							saveUnitCabinetFn(product_Txt); // 保存数据接口
							// selectProductDepth(product_Txt);
							// selectProductMatrix(product_Txt);
						})
			} else {
				alert("请求失败！");
			}
		})
	}

	function selectModelNameRefresh(e) {
		if (e.resultCode == 200) {
			var html = "";
			for ( var i in e.resultInfo) {
				html += '<dl data-id="' + e.resultInfo[i].modelId + '">'
						+ '<dt><img src="' + e.resultInfo[i].img
						+ '" alt=""></dt>' + '<dd>' + e.resultInfo[i].modelName
						+ '</dd>' + '</dl>'
			}
			$(".model_list").html(html);
			// 点击型号添加样式
			$(".model_list").find("dl").on(
					"click",
					function() {
						flag = true;
						$(this).addClass("dl_active").siblings().removeClass(
								"dl_active");
						var product_Txt = $(this).find("dd").text();
						$(".title_area").find("span").children().text(
								product_Txt);
						model_id = $(this).attr("data-id"); // 型号id
						str_H = "";
						str_W = "";
						str_D = "";
						floor_H = "";
						max_H = "";
						min_H = "";
						step_H = "";
						max_W = "";
						min_W = "";
						step_W = "";
						max_D = "";
						min_D = "";
						step_D = "";
						selectProductSize(product_Txt); // 依据型号查询外观尺寸数据
						selectAreaUnitByModelIdFn(model_id); // 依据型号查询区域和单元柜的数据渲染
						materialFn(model_id); // 依据型号去关联材质列表
						saveUnitCabinetFn(product_Txt); // 保存数据
						// selectProductDepth(product_Txt);
						// selectProductMatrix(product_Txt);
					})
		} else {
			alert("请求页面数据失败！");
		}
	}
	// 型号列表的搜索功能
	$("#search_btn").on(
			"click",
			function() {
				var model_txt = $.trim($("#input_txt").val());
				if ($.trim($("#input_txt").val()) == "") { // 为空
					return false;
				} else {
					$.ajax({
						url : json._url + "/" + json._nameCustommade
								+ "/cusProduct/likeProductModel",
						dataType : "json",
						data : {
							productType : productType, // 产品类别
							modelName : model_txt
						// 产品型号
						},
						type : "post",
						success : function(e) {
							if (e.resultCode == 200) {
								selectModelNameRefresh(e);
							} else {
								alert("请求页面数据失败！");
							}
						},
						error : function() {
							alert("error6");
						}
					})
				}
			})
	// 依据型号查询产品外观尺寸的初始值数据渲染
	function selectProductSize(model_Name) {
		$
				.ajax({
					url : json._url + "/" + json._nameCustommade
							+ "/cusProduct/selectProductSize",
					type : "post",
					dataType : "json",
					data : {
						modelName : model_Name
					},
					success : function(e) {
						if (e.resultCode == 200) {
							str_H = "";
							str_W = "";
							str_D = "";
							floor_H = "";
							for ( var i in e.resultInfo) {
								if (e.resultInfo[i].dimension == 1) { // 高度
									if (e.resultInfo[i].type == 1) {
										initial_H = e.resultInfo[i].value; // 初始值
									}
									if (e.resultInfo[i].type == 2) { // 标准值
										str_H += '<li class="LiHeight">'
												+ e.resultInfo[i].value
												+ '</li>';
									}
									if (e.resultInfo[i].type == 3) {
										max_H = e.resultInfo[i].value; // 最大值
									}
									if (e.resultInfo[i].type == 4) {
										min_H = e.resultInfo[i].value; // 最小值
									}
									if (e.resultInfo[i].type == 5) {
										step_H = e.resultInfo[i].value; // 步长
									}
								}
								if (e.resultInfo[i].dimension == 2) { // 宽度
									if (e.resultInfo[i].type == 1) {
										initial_W = e.resultInfo[i].value;
									}
									if (e.resultInfo[i].type == 2) {
										str_W += '<li class="LiWidth">'
												+ e.resultInfo[i].value
												+ '</li>';
									}
									if (e.resultInfo[i].type == 3) {
										max_W = e.resultInfo[i].value;
									}
									if (e.resultInfo[i].type == 4) {
										min_W = e.resultInfo[i].value;
									}
									if (e.resultInfo[i].type == 5) {
										step_W = e.resultInfo[i].value;
									}
								}
								if (e.resultInfo[i].dimension == 3) { // 深度
									if (e.resultInfo[i].type == 1) {
										initial_D = e.resultInfo[i].value;
									}
									if (e.resultInfo[i].type == 2) {
										str_D += '<li>' + e.resultInfo[i].value
												+ '</li>';
									}
									if (e.resultInfo[i].type == 3) {
										max_D = e.resultInfo[i].value;
									}
									if (e.resultInfo[i].type == 4) {
										min_D = e.resultInfo[i].value;
									}
									if (e.resultInfo[i].type == 5) {
										step_D = e.resultInfo[i].value;
									}
								}
								if (e.resultInfo[i].dimension == 4) { // 地柜高度
									if (e.resultInfo[i].type == 1) {
										initial_floorH = e.resultInfo[i].value;
										initial_topH = initial_H
												- initial_floorH // 顶柜高度
									}
									if (e.resultInfo[i].type == 2) {
										floor_H += '<li>'
												+ e.resultInfo[i].value
												+ '</li>';
									}
									if (e.resultInfo[i].type == 3) {
										floormax_H = e.resultInfo[i].value;
									}
									if (e.resultInfo[i].type == 4) {
										floormin_H = e.resultInfo[i].value;
									}
									if (e.resultInfo[i].type == 5) {
										floorstep_H = e.resultInfo[i].value;
									}
								}
							}
							$(".outview_H").html(str_H);
							$(".outview_W").html(str_W);
							$(".outview_D").html(str_D);
							$(".floor_H").html(floor_H);
							// 高度调整
							$('.single-sliderH')
									.jRange(
											{
												from : min_H,// 最小值
												to : max_H, // 最大值
												step : step_H, // 刻度值
												format : '%s',
												showLabels : true,
												showScale : true,
												onstatechange : function() {
													var slider_textH = $('.single-sliderH')[0].value; // 变化的高度
													initial_H = slider_textH; // 定制家具的高
													for ( var i = 0, len = $("#outview_H_1 li").length; i < len; i++) { // 关联
														var eleVal = $(
																"#outview_H_1 li")
																.eq(i).html();
														if (initial_H == eleVal) {
															$("#outview_H_1 li")
																	.eq(i)
																	.addClass(
																			'active')
																	.siblings()
																	.removeClass(
																			'active');
														} else {
															$("#outview_H_1 li")
																	.eq(i)
																	.removeClass(
																			'active');
														}
													}
													// initial_floorH=slider_textH-initial_topH;
													// //地柜的高
													// scaleFn();
													// cxt.clearRect(0,0,imgW,imgH);
													// Matrix(ProductMatrix);
												}
											})
							// 点击高度的标准值渲染图片
							$("#outview_H_1").on(
									"click",
									"li",
									function() {
										$(this).addClass('active').siblings()
												.removeClass("active");
										var LiTextH = $(this).text();
										initial_H = LiTextH; // 产品的高
										$('.single-sliderH').jRange('setValue',
												LiTextH);// 更改滑块的位置
										// initial_floorH=LiTextH-initial_topH;
										// //地柜的高
										// scaleFn();
										// cxt.clearRect(0,0,imgW,imgH);
										// Matrix(ProductMatrix);
									})
							// 宽度调整
							$('.single-sliderW')
									.jRange(
											{
												from : min_W,
												to : max_W,
												step : step_W,
												format : '%s',
												showLabels : true,
												showScale : true,
												onstatechange : function() {
													var slider_textW = $('.single-sliderW')[0].value;
													initial_W = slider_textW; // 产品的宽
													for ( var i = 0, len = $("#outview_W_1 li").length; i < len; i++) { // 关联
														var eleVal = $(
																"#outview_W_1 li")
																.eq(i).html();
														if (initial_W == eleVal) {
															$("#outview_W_1 li")
																	.eq(i)
																	.addClass(
																			'active')
																	.siblings()
																	.removeClass(
																			'active');
														} else {
															$("#outview_W_1 li")
																	.eq(i)
																	.removeClass(
																			'active');
														}
													}
													// scaleFn();
													// cxt.clearRect(0,0,imgW,imgH);
													// Matrix(ProductMatrix);
												}
											})
							// 点击宽度的标准值渲染图片
							$("#outview_W_1").on(
									"click",
									"li",
									function() {
										$(this).addClass('active').siblings()
												.removeClass("active");
										var LiTextW = $(this).text();
										initial_W = LiTextW;
										$('.single-sliderW').jRange('setValue',
												LiTextW);// 更改滑块的位置
										// /scaleFn();
										// cxt.clearRect(0,0,imgW,imgH);
										// Matrix(ProductMatrix);
									})
							// 深度调整
							$('.single-sliderD')
									.jRange(
											{
												from : min_D,
												to : max_D,
												step : step_D,
												format : '%s',
												showLabels : true,
												showScale : true,
												onstatechange : function() {
													var slider_textD = $('.single-sliderD')[0].value;
													initial_D = slider_textD; // 产品的深度
													for ( var i = 0, len = $("#outview_D_1 li").length; i < len; i++) { // 关联
														var eleVal = $(
																"#outview_D_1 li")
																.eq(i).html();
														if (initial_D == eleVal) {
															$("#outview_D_1 li")
																	.eq(i)
																	.addClass(
																			'active')
																	.siblings()
																	.removeClass(
																			'active');
														} else {
															$("#outview_D_1 li")
																	.eq(i)
																	.removeClass(
																			'active');
														}
													}
													// scaleFn();
													// cxt.clearRect(0,0,imgW,imgH);
													// Matrix(ProductMatrix);
												}
											})
							// 点击深度的标准值渲染图片
							$("#outview_D_1").on(
									"click",
									"li",
									function() {
										$(this).addClass('active').siblings()
												.removeClass("active");
										var LiTextD = $(this).text();
										initial_D = LiTextD;
										$('.single-sliderD').jRange('setValue',
												LiTextD);// 更改滑块的位置
										// scaleFn();
										// cxt.clearRect(0,0,imgW,imgH);
										// Matrix(ProductMatrix);
									})
							// 地柜高度调整
							$('.floor-sliderH')
									.jRange(
											{
												from : floormin_H,
												to : floormax_H,
												step : floorstep_H,
												format : '%s',
												showLabels : true,
												showScale : true,
												onstatechange : function() {
													var floor_textH = $('.floor-sliderH')[0].value;
													initial_floorH = floor_textH;
													for ( var i = 0, len = $("#floor_H_1 li").length; i < len; i++) { // 关联
														var eleVal = $(
																"#floor_H_1 li")
																.eq(i).html();
														if (initial_floorH == eleVal) {
															$("#floor_H_1 li")
																	.eq(i)
																	.addClass(
																			'active')
																	.siblings()
																	.removeClass(
																			'active');
														} else {
															$("#floor_H_1 li")
																	.eq(i)
																	.removeClass(
																			'active');
														}
													}
												}
											})
							// scaleFn();
							// 点击地柜高度的标准值渲染图片
							$("#floor_H_1").on(
									"click",
									"li",
									function() {
										$(this).addClass('active').siblings()
												.removeClass("active");
										var floor_H = $(this).text();
										initial_floorH = floor_H;
										$('.floor-sliderH').jRange('setValue',
												floor_H);// 更改滑块的位置
										// scaleFn();
										// cxt.clearRect(0,0,imgW,imgH);
										// Matrix(ProductMatrix);
									})
						} else {
							alert("请求页面数据失败！");
						}
					},
					error : function() {
						alert("error7");
					}
				})
	}
	// 点击型号添加样式
	$(".model_list").find("dl").on("click", function() {
		$(this).addClass("dl_active").siblings().removeClass("dl_active");
		var product_Txt = $(this).find("dd").text();
		$(".title_area").find("span").children().text(product_Txt);
		model_id = $(this).attr("data-id"); // 型号id
		str_H = "";
		str_W = "";
		str_D = "";
		floor_H = "";
		max_H = "";
		min_H = "";
		step_H = "";
		max_W = "";
		min_W = "";
		step_W = "";
		max_D = "";
		min_D = "";
		step_D = "";
		selectProductSize(product_Txt); // 依据型号查询外观尺寸数据
		selectAreaUnitByModelIdFn(model_id); // 依据型号查询区域和单元柜的数据渲染
		// selectProductDepth(product_Txt);
		// selectProductMatrix(product_Txt);
	})
	// 内部结构:根据型号查询区域和单元柜的数据渲染
	function selectAreaUnitByModelIdFn(model_id) {
		$
				.ajax({
					url : json._url + "/" + json._nameCustommade
							+ "/furniture/selectAreaUnitByModelId",
					dataType : "json",
					type : "post",
					data : {
						modelId : model_id
					// 型号id
					},
					success : function(data) {
						if (data.resultCode == 200) {
							var html = "", str = "";
							for ( var i in data.resultInfo) {
								html += '<li>' + data.resultInfo[i].areaName
										+ '</li>';
								str += '<div class="constructed_list">'
								for ( var j in data.resultInfo[i].unitList) {
									str += '<dl data-id="'
											+ data.resultInfo[i].unitList[j].id
											+ '">'
											+ '<dt><img src="'
											+ data.resultInfo[i].unitList[j].img
											+ '" alt="" /></dt>'
											+ '<dd>'
											+ data.resultInfo[i].unitList[j].unitCabinetName
											+ '</dd>' + '</dl>'
								}
								str += '</div>';
							}
							$("#domain_list").html(html);
							$("#construct_img").html(str);
							// 点击区域切换不同的单元柜
							$("#domain_list").find("li").eq(0).addClass(
									'active');
							$("#construct_img").find(".constructed_list").eq(0)
									.show();// 默认显示第一个li对应的盒子
							$("#domain_list").on(
									"click",
									"li",
									function() {
										var liIndex = $(this).index();
										$(this).addClass('active').siblings('')
												.removeClass('active');
										$("#construct_img").find(
												".constructed_list")
												.eq(liIndex).show()
												.siblings('').hide();
										areaName = $(this).html(); // 区域名称
									})
							// 点击单元柜去查询各个功能区的数据
							$("#construct_img .constructed_list")
									.on(
											"click",
											"dl",
											function() {
												$(".number_area").show();
												$(this).addClass('active')
														.siblings('')
														.removeClass('active');
												unitCabinetId = $(this).attr(
														"data-id");
												selectFunctionByUnitFn(unitCabinetId);
												unitCabinetName = $(this).find(
														"dd").html(); // 单元柜名称
												objInnit = { // 内部结构的对象
													"areaName" : areaName,
													"unitCabinetName" : unitCabinetName,
													"funList" : []
												// 功能区的数组
												};
												// 避免重复添加
												var kk = 0;
												for ( var k in object.inner) {
													if (areaName == object.inner[k].areaName
															&& unitCabinetName == object.inner[k].unitCabinetName) {
														kk++;
													} else {
														kk = kk;
													}
												}
												if (kk > 0) {
													return;
												} else {
													object.inner.push(objInnit);
												}
											})
						} else {
							alert("请求页面数据失败！")
						}
					},
					error : function() {
						alert("error10");
					}
				})
	}
	// 根据单元柜去查询各个功能区的数据
	function selectFunctionByUnitFn(unitCabinetId) {
		$.ajax({
			url : json._url + "/" + json._nameCustommade
					+ "/furniture/selectFunctionByUnit",
			data : {
				unitCabinetId : unitCabinetId
			// 单元柜id
			},
			dataType : "json",
			type : "post",
			success : function(data) {
				if (data.resultCode == 200) {
					rendInitConstruct(data); // 渲染内部结构区域的数据结构
				} else {
					alert("请求页面数据失败！");
				}
			},
			error : function() {
				alert("error11");
			}
		})
	}
	// 渲染内部结构区域的数据结构
	function rendInitConstruct(data) {
		var html = "", str = "", arr = "", obj = [];
		for ( var i in data.resultInfo) {
			var drawMax = data.resultInfo[i]["drawerMax"], // 抽屉数量最大值
			drawMin = data.resultInfo[i]["drawerMin"], // 抽屉数量最小值
			laminateMax = data.resultInfo[i]["laminateMax"], // 层板数量最大值
			laminateMin = data.resultInfo[i]["laminateMin"], // 层板数量最小值
			heightStandard = "";// 高度标准值
			var defaultValue = data.resultInfo[i].heightMin;
			if (Number(data.resultInfo[i].heightMin) == 300) {
				defaultValue = 500;
			}
			var prototype = {
				"id" : 'sliderH' + i, // input框id
				"min" : data.resultInfo[i].heightMin, // 最小值
				"max" : data.resultInfo[i].heightMax, // 最大值
				// "step":data.resultInfo[i].step, //最小刻度
				"step" : 5,
				"default" : defaultValue + "",
				"StandardH_id" : 'StandardH' + i, // 标准值id
				"oldHeight" : data.resultInfo[i].heightMin, // 原来的旧值的高度
				"curHeight" : data.resultInfo[i].heightMin
			// 当前调整的高度(最小值)
			}
			obj.push(prototype);
			if (drawMax && drawMin) {
				var drawNumber = "<ul>"; // 抽屉数量
				// 抽屉的数量判断、遍历循环
				for ( var j = drawMin; j <= drawMax; j++) {
					drawNumber += '<li>' + j + '</li>';
				}
				drawNumber += "</ul>";
				html += '<div class="chouti_area" data-areaId=' + i + '>'
						+ '<span>' + data.resultInfo[i].functionDistrictName
						+ '抽屉数量</span>' + drawNumber + '</div>'
			}
			if (laminateMax && laminateMin) {
				var drawNumber = "<ul>"; // 层板数量
				// 层板的数量判断、遍历循环
				for ( var j = laminateMin; j <= laminateMax; j++) {
					drawNumber += '<li>' + j + '</li>';
				}
				drawNumber += "</ul>";
				html += '<div class="clear"></div>'
						+ '<div class="cengban_area" data-areaId=' + i + '>'
						+ '<span>' + data.resultInfo[i].functionDistrictName
						+ '层板数量</span>' + drawNumber + '</div>'
			}
			for ( var n in data.resultInfo[i].heightStandard) { // 标准值的循环
				heightStandard += '<li>' + data.resultInfo[i].heightStandard[n]
						+ '</li>'
			}
			// 功能区高度的渲染
			functionId = data.resultInfo[i].id; // 功能区的id
			functionName = data.resultInfo[i].functionDistrictName; // 功能区的名称
			objFunction = { // 内部结构功能区的对象
				"functionId" : functionId,// 功能区的id
				"functionName" : functionName, // 功能区的名称
				"config" : []
			// 功能区的配置
			}
			objInnit.funList.push(objFunction);
			str += '<h4>' + data.resultInfo[i].functionDistrictName
					+ '高度：</h4>' + '<div class="Hight_area">' + '<div>'
					+ '<span>高：</span>' + '<ul id="StandardH' + i + '">'
					+ heightStandard + '</ul>' + '</div>'
					+ '<input type="hidden" id="sliderH' + i + '" value="'
					+ defaultValue + '"/> ' + '</div>'
			objConfig = { // 功能区配置的对象
				"name" : "", // 功能区的名称
				"value" : "" // 功能区高度调节的值
			}
			objFunction.config.push(objConfig);
			console.log(objFunction);
			// 功能区配置的渲染
			if (data.resultInfo[i].functionDistrictName == "叠放区") {
				$("#fixed_area").show();
				$("#fixed_list").on(
						"click",
						"li",
						function() {
							$(this).addClass('active').siblings('')
									.removeClass("active");
						})
			} else {
				$("#fixed_area").hide();
			}
			arr += '<h4 data-areaId=' + i + '>'
					+ data.resultInfo[i].functionDistrictName + '配置：</h4>'
			for ( var q in data.resultInfo[i].config) {
				arr += '<div class="role">'
						+ '<img src="static/images/1_03.png" alt="" />'
						+ '<span>' + data.resultInfo[i].config[q].configname
						+ '：</span>' + '<select name="" id="">'
				for ( var x in data.resultInfo[i].config[q].chooseModel) {
					arr += '<option value="">'
							+ data.resultInfo[i].config[q].chooseModel[x].choosableValue
							+ '</option>'
				}
				arr += '</select>'
				arr += '</div>'
			}
		}
		$("#number_total").html(html);
		$("#size_area").html(str);
		$("#money_area").html(arr);
		repeatSliderFn(obj);
		// 点击抽屉数量、层板数量
		$(".chouti_area>ul")
				.on(
						"click",
						"li",
						function() {
							var numHtml = $(this).html();
							$(this).addClass('hight_active').siblings('')
									.removeClass("hight_active");
							var areaId = $(this).parents(".chouti_area").attr(
									"data-areaId");
							for ( var i = 0, len = $("#money_area").find("h4").length; i < len; i++) {
								if ($("#money_area").find("h4").eq(i).attr(
										"data-areaId") == areaId) {
									$(".addrole" + i).remove();
									var appendHtml = "";
									var newHtml = '<div class="role addrole'
											+ i
											+ '">'
											+ $("#money_area").find("h4").eq(i)
													.next().html()
											+ '</div><div class="role addrole'
											+ i
											+ '">'
											+ $("#money_area").find("h4").eq(i)
													.next().next().html()
											+ '</div>';
									for ( var jj = 0; jj < numHtml; jj++) {
										appendHtml += newHtml;
									}
									$("#money_area").find("h4").eq(i).after(
											appendHtml);
								}
							}
						})
		$(".cengban_area>ul")
				.on(
						"click",
						"li",
						function() {
							$(this).addClass('hight_active').siblings('')
									.removeClass("hight_active");
							var numHtml = $(this).html();
							$(this).addClass('hight_active').siblings('')
									.removeClass("hight_active");
							var areaId = $(this).parents(".cengban_area").attr(
									"data-areaId");
							for ( var i = 0, len = $("#money_area").find("h4").length; i < len; i++) {
								if ($("#money_area").find("h4").eq(i).attr(
										"data-areaId") == areaId) {
									$(".addrole" + i).remove();
									var appendHtml = "";
									var newHtml = '<div class="role addrole'
											+ i
											+ '">'
											+ $("#money_area").find("h4").eq(i)
													.next().html()
											+ '</div><div class="role addrole'
											+ i
											+ '">'
											+ $("#money_area").find("h4").eq(i)
													.next().next().html()
											+ '</div>';
									for ( var jj = 0; jj < numHtml; jj++) {
										appendHtml += newHtml;
									}
									$("#money_area").find("h4").eq(i).after(
											appendHtml);
								}
							}
						})
	}
	// 渲染内部结构滑块的数据
	function repeatSliderFn(obj) {
		for ( var m in obj) {
			(function(m) { // 闭包的使用
				$("#" + obj[m].id)
						.jRange(
								{
									from : obj[m].min,// 最小值
									to : obj[m].max, // 最大值
									step : obj[m].step, // 刻度值
									// value:obj[m]["default"],
									format : '%s',
									showLabels : true,
									showScale : true,
									onstatechange : function() {
										var slider_textH = Number($('#'
												+ obj[m].id)[0].value); // 变化的高度
										for ( var i = 0, len = $(
												"#" + obj[m].StandardH_id)
												.find("li").length; i < len; i++) { // 关联
											var eleVal = Number($(
													"#" + obj[m].StandardH_id)
													.find("li").eq(i).html());
											if (slider_textH == eleVal) {
												$("#" + obj[m].StandardH_id)
														.find("li").eq(i)
														.addClass('active')
														.siblings()
														.removeClass('active');
											} else {
												$("#" + obj[m].StandardH_id)
														.find("li").eq(i)
														.removeClass('active');
											}
										}
										// 调整滑块的高度
										obj[m]["oldHeight"] = obj[m]["curHeight"]; // 原来的旧值赋给当前调整的新值
										obj[m]["curHeight"] = slider_textH; // 当前的新值
										var a = obj[m]["oldHeight"]
												- obj[m]["curHeight"];
										var level = [ m ];
										for ( var lk = 0; lk < obj.length; lk++) { // 优先级的遍历
											if (lk != m) {
												level.push(lk);
											}
										}
										for ( var l = 1; l < level.length; l++) { // 从第二个调节
											if (a == 0) {
												break;
											}
											var index = level[l];
											var curObj = obj[index];
											var tmp = Number(curObj["curHeight"]
													+ a);
											if (tmp <= curObj["max"]
													&& tmp >= curObj["min"]) {
												curObj["oldHeight"] = curObj["curHeight"];
												curObj["curHeight"] = tmp;
												$('#' + curObj.id)
														.jRange(
																'setValue',
																""
																		+ curObj["curHeight"]);// 更改滑块的位置
												break;
											} else {
												if (tmp > curObj["max"]) {
													curObj["oldHeight"] = curObj["curHeight"];
													curObj["curHeight"] = curObj["max"];
													a = a + curObj["oldHeight"]
															- curObj["max"];
												} else if (tmp < curObj["min"]) {
													curObj["oldHeight"] = curObj["curHeight"];
													curObj["curHeight"] = curObj["min"];
													a = a
															+ curObj["min"]
															- curObj["oldHeight"];
												}
											}
											$('#' + curObj.id).jRange(
													'setValue',
													"" + curObj["curHeight"]);// 更改滑块的位置
										}
										if (a != 0) {
											console.log("error");
										}
									}
								})
				// 点击标准值与滑块做关联
				$("#" + obj[m].StandardH_id).on(
						"click",
						"li",
						function() {
							$(this).addClass('active').siblings().removeClass(
									"active");
							var LiTextH = $(this).text();
							$('#' + obj[m].id).jRange('setValue', LiTextH);// 更改滑块的位置
						})
			})(m);
		}
	}
	// 材质列表的数据结构渲染
	function materialFn(model_id) { // 型号id
		var tmp = [];
		var html = [];
		var str = "";
		data = {
			"resultCode" : 200,
			"resultInfo" : {
				"shutterList" : [ // 门板
				{
					"ShutterName" : "门板", // 门板名称
					"property" : "平开门", // 属性
				}, {
					"ShutterName" : "门板1",
					"property" : "抽屉",
				}, {
					"ShutterName" : "门板2",
					"property" : "下翻门",
				} ],
				"seriesList" : [ {
					"name" : "耐磨板",
					"childList" : [ {
						"name" : "红",
						"childList" : [ {
							"name" : "12*6",
							"childList" : [ {
								"name" : "横纹"
							}, {
								"name" : "横纹1"
							}, {
								"name" : "横纹2"
							} ]
						} ]
					}, {
						"name" : "黑",
						"childList" : [ {
							"name" : "12*6",
							"childList" : [ {
								"name" : "横纹"
							}, {
								"name" : "横纹2"
							}, {
								"name" : "横纹10"
							} ]
						} ]
					} ]
				}, {
					"name" : "耐磨板1",
					"childList" : [ {
						"name" : "红",
						"childList" : [ {
							"name" : "12*6",
							"childList" : [ {
								"name" : "横纹"
							} ]
						} ]
					} ]
				}, {
					"name" : "耐磨板10",
					"childList" : [ {
						"name" : "红1",
						"childList" : [ {
							"name" : "12*63",
							"childList" : [ {
								"name" : "横纹1"
							} ]
						} ]
					} ]
				} ]
			}
		}
		seriesData = data.resultInfo.seriesList;
		for ( var i in seriesData) {
			tmp.push(seriesData[i].name);
			var colors = [];
			var colorList = seriesData[i]["childList"];
			for ( var j in colorList) {
				var specs = [];
				var specList = colorList[j]["childList"];
				for ( var x in specList) {
					var models = [];
					var modelList = specList[x]["childList"];
					for ( var y in modelList) {
						models.push(modelList[y]["name"]);
					}
					specs.push(specList[x]["name"]);
					dsy.add("0-" + i + "-" + j + "-" + x, models);
				}
				dsy.add("0-" + i + "-" + j, specs);
				colors.push(colorList[j]["name"]);
			}
			dsy.add("0-" + i, colors);
		}
		dsy.add("0", tmp);
		for ( var i in seriesData) {
			str += '<option value="' + seriesData[i].name + '">'
					+ seriesData[i].name + '</option>';
		}
		for ( var i in data.resultInfo["shutterList"]) {
			var door = data.resultInfo["shutterList"][i];
			html.push('<h5>' + data.resultInfo.shutterList[i]["ShutterName"]
					+ '：<input type="checkbox" /></h5>');
			html
					.push('<div class="role"><img src="static/images/1_03.png" alt="" /><span>系列：</span><select class="series" id="series_'
							+ i + '" >' + str + '</select></div>');
			html
					.push('<div class="role"><img src="static/images/1_03.png" alt="" /><span>花色：</span><select class="colors" id="colors_'
							+ i + '"></select></div>');
			html
					.push('<div class="role"><img src="static/images/1_03.png" alt="" /><span>规格：</span><select class="specs" id="specs_'
							+ i + '"></select></div>');
			html
					.push('<div class="role"><img src="static/images/1_03.png" alt="" /><span>造型：</span><select class="models" id="models_'
							+ i + '"></select></div>');
			s.push([ ("series_" + i), ("colors_" + i), ("specs_" + i),
					("models_" + i) ]);
		}
		$("#materail_list").append(html.join(''));
		function setup() {
			for ( var i = 0; i < s.length; i++)
				for ( var j = 0; j < s[i].length; j++) {
					document.getElementById(s[i][j]).onchange = new Function(
							"change(" + i + "," + (j + 1) + ")");
					change(i, 0);
				}
		}
		setup();
		// 默认显示第一个select
		$("#materail_list").find("h5").eq(0).next().show();
		$("#materail_list").find("h5").eq(0).next().next().show();
		$("#materail_list").find("h5").eq(0).next().next().next().show();
		$("#materail_list").find("h5").eq(0).next().next().next().next().show();
		$("#materail_list").find("h5").eq(0).find("input")
				.prop("checked", true);
		var firstInput = $("#materail_list").find("h5").eq(0).find("input");
		firstInput.on("click", function() {
			if ($(this).prop("checked")) {
				$("#materail_list").find("h5").eq(0).next().show();
				$("#materail_list").find("h5").eq(0).next().next().show();
				$("#materail_list").find("h5").eq(0).next().next().next()
						.show();
				$("#materail_list").find("h5").eq(0).next().next().next()
						.next().show();
			} else {
				$("#materail_list").find("h5").eq(0).next().hide();
				$("#materail_list").find("h5").eq(0).next().next().hide();
				$("#materail_list").find("h5").eq(0).next().next().next()
						.hide();
				$("#materail_list").find("h5").eq(0).next().next().next()
						.next().hide();
			}
		})
		// 遍历所有的复选框
		var inputLength = $("#materail_list").find("h5").find("input");
		inputLength.on("click", function() {
			for ( var n = 0, len = inputLength.length; n < len; n++) {
				if ($(this).prop("checked")) {
					$(this).parents().next().show();
					$(this).parents().next().next().show();
					$(this).parents().next().next().next().show();
					$(this).parents().next().next().next().next().show();
				} else {
					$(this).parents().next().hide();
					$(this).parents().next().next().hide();
					$(this).parents().next().next().next().hide();
					$(this).parents().next().next().next().next().hide();
				}
			}
		})
	}

	// 保存的数据接口
	function saveUnitCabinetFn(model_Name) {
		$("#confirm_btn").on("click", function() {
			if (flag == true) {
				object.scheme = scheme;// 方案，原来的订单id
				object.productType = productType;// 定制家具
				object.roomDetailName = space_choice;// 空间选择
				object.brandName = brand_Name; // 品牌
				object.categoryName = categroy_Name;// 品类
				object.modelName = model_Name;// 型号名称
				object.pHeight = initial_H;// 产品的高
				object.pWidth = initial_W;// 产品的宽
				object.pDeep = initial_D;// 产品的深
				object.bHeigth = initial_floorH;// 地柜的高度
				object.tHeight = initial_H - initial_floorH;// 顶柜的高度
				furniture.push(object);
				console.log(furniture);
				/*
				 * $.ajax({
				 * url:json._url+"/"+json._nameCustommade+"/furniture/saveUnitCabinet",
				 * dataType:"json", type:"post", data:{
				 * furniture:JSON.stringify(furniture) }, success:function(){
				 * if(e.resultCode==200){ alert("保存成功！"); flag=false; }else{
				 * alert("请求页面数据失败！"); } }, error:function(){ alert("error12"); } })
				 */
			}
		})
	}
})
function Dsy() {
	this.Items = {};
}
Dsy.prototype.add = function(id, iArray) {
	this.Items[id] = iArray;
}
Dsy.prototype.Exists = function(id) {
	if (typeof (this.Items[id]) == "undefined")
		return false;
	return true;
}
var dsy = new Dsy();
var s = [];
var opt0 = [ "系列", "花色", "规格", "造型" ];
function change(index, v) {
	var str = "0";
	for (i = 0; i < v; i++) {
		str += ("-" + (document.getElementById(s[index][i]).selectedIndex - 1));
	}
	var ss = document.getElementById(s[index][v]);
	with (ss) {
		length = 0;
		options[0] = new Option(opt0[v], opt0[v]);
		if (v && document.getElementById(s[index][v - 1]).selectedIndex > 0
				|| !v) {
			if (dsy.Exists(str)) {
				ar = dsy.Items[str];
				for (i = 0; i < ar.length; i++)
					options[length] = new Option(ar[i], ar[i]);
				if (v)
					options[1].selected = true;
			}
		}
		if (++v < s[index].length) {
			change(index, v);
		}
	}
}
