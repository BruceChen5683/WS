function getBrands(productType, cb) {
	var url = ctx + "/cus/brand/getBrands";
	var data = {
		"productType" : productType
	};
	httpPost(url, data, function(res) {
		if (cb) {
			cb(res);
		}
	}, function(e) {
		alert(e);
	})
}

function getProductCategorys(productType, cb) {
	var url = ctx + "/cus/productCategory/getCategorys";
	var data = {
		"productType" : productType
	};
	httpPost(url, data, function(res) {
		if (cb) {
			cb(res);
		}
	}, function(e) {
		alert(e);
	})
}
function getProductModels(product, cb) {
	console.log(product);
	var url = ctx + "/cus/productModel/getModels";
	var data = {
		"productType" : product["productType"],
		"brandName" : product["brandName"],
		"categoryName" : product["categoryName"]
	};
	httpPost(url, data, function(res) {
		if (cb) {
			cb(res);
		}
	}, function(e) {
		alert(e);
	})
}