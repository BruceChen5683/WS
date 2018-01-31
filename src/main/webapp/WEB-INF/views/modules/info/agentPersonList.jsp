<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>代理人管理</title>
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
		<li class="active"><a href="${ctx}/info/agentPerson/">代理人列表</a></li>
		<shiro:hasPermission name="info:agentPerson:edit"><li><a href="${ctx}/info/agentPerson/form">代理人添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="agentPerson" action="${ctx}/info/agentPerson/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>身份证号：</label>
				<form:input path="idCard" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>手机号：</label>
				<form:input path="cellphone" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>姓名</th>
				<shiro:hasPermission name="info:agentPerson:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="agentPerson">
			<tr>
				<td><a href="${ctx}/info/agentPerson/form?id=${agentPerson.id}">
					${agentPerson.name}
				</a></td>
				<shiro:hasPermission name="info:agentPerson:edit"><td>
    				<a href="${ctx}/info/agentPerson/form?id=${agentPerson.id}">修改</a>
					<a href="${ctx}/info/agentPerson/delete?id=${agentPerson.id}" onclick="return confirmx('确认要删除该代理人吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>