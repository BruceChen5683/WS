var json = {
	_url : "tomcat",
	// _imgurl:"scmachine",
	// _nameSecuser:"sc-secuser",
	// _nameCustommade:"sc-custommade"
	// _url:"http://test.sc.cc",
	// _url:"tomcat",
	_nameSecuser : "sc-secuser",
	_nameCustommade : "custommade"
}
function httpPost(url, data, suc, err) {
	$.ajax({
		url : url,
		dataType : "json",
		type : "post",
		data : data,
		success : function(data) {
			if (suc) {
				suc(data);
			}
		},
		error : function(e) {
			if (err) {
				err(data);
			}
		}
	});
}
