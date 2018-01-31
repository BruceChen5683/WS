<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/info/comMerchant/">商户列表</a></li>
		<shiro:hasPermission name="info:comMerchant:edit"><li><a href="${ctx}/info/comMerchant/form">商户添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="comMerchant" action="${ctx}/info/comMerchant/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>地区：</label>
				<form:input path="region" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>分类id：</label>
				<form:input path="categoryId" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>主营业务：</label>
				<form:input path="mainProducts" htmlEscape="false" maxlength="512" class="input-medium"/>
			</li>
			<li><label>广告词：</label>
				<form:input path="adWord" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>固定电话：</label>
				<form:input path="phone" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>名称</th>
				<shiro:hasPermission name="info:comMerchant:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="comMerchant">
			<tr>
				<td><a href="${ctx}/info/comMerchant/form?id=${comMerchant.id}">
					${comMerchant.name}
				</a></td>
				<shiro:hasPermission name="info:comMerchant:edit"><td>
    				<a href="${ctx}/info/comMerchant/form?id=${comMerchant.id}">修改</a>
					<a href="${ctx}/info/comMerchant/delete?id=${comMerchant.id}" onclick="return confirmx('确认要删除该商户吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>