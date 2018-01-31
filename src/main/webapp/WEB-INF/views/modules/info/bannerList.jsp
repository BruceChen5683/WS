<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>banner广告图管理</title>
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
		<li class="active"><a href="${ctx}/info/banner/">banner广告图列表</a></li>
		<shiro:hasPermission name="info:banner:edit"><li><a href="${ctx}/info/banner/form">banner广告图添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="banner" action="${ctx}/info/banner/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>区域：</label>
				<form:input path="region" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>商户id：</label>
				<form:input path="merchantId" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<shiro:hasPermission name="info:banner:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="banner">
			<tr>
				<shiro:hasPermission name="info:banner:edit"><td>
    				<a href="${ctx}/info/banner/form?id=${banner.id}">修改</a>
					<a href="${ctx}/info/banner/delete?id=${banner.id}" onclick="return confirmx('确认要删除该banner广告图吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>