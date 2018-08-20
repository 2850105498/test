<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>员工列表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径：
不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
		http://localhost:3306/crud
 -->
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>

<body>
	<!-- 搭建页面显示 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<dir class="col-md-12">
				<h1>SSM-CRUD</h1>
			</dir>
		</div>
		<!-- 两个按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>

		<!-- 显示数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<th>${emp.empId }</th>
							<th>${emp.empName }</th>
							<th>${emp.gender=="M"?"男":"女" }</th>
							<th>${emp.email }</th>
							<th>${emp.department.deptName }</th>
							<th>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</th>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- 分页信息 -->
		<div class="row">
			<!-- 分页信息 -->
			<div class="col-md-6">
				当前${pageInfo.pageNum }页，总${pageInfo.pages },总${pageInfo.total }条记录
			</div>
			<!-- 分页条 -->
			<div class="col-md-6 ">
				<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
					<!-- 2、判断 是否有上一页 -->
					<c:if test="${pageInfo.hasPreviousPage}">
						<!-- 2.1、${APP_PATH}/emps?pn=${pageInfo.pageNum-1 }表示传递的是前一页 -->
						<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1 }" aria-label="Previous"><spanaria-hidden="true">&laquo;</span></a></li>
					</c:if>
					<!-- 1、用forEach循环遍历页码navigatepageNums  -->
					<c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
						<!--1.1、判断现在的页面page_Num是不是当前页pageInfo.pageNum，是的话就用class="active"高亮显示出来 -->
						<c:if test="${page_Num==pageInfo.pageNum }">
							<li class="active"><a href="#">${page_Num }</a></li>
						</c:if>
						<!--1.2判断现在的页面page_Num是不是当前页pageInfo.pageNum，不是的话不做操作 -->
						<c:if test="${page_Num!=pageInfo.pageNum }">
							<!-- 1.2.1将页码数通过${APP_PATH}/emps?pn=${page_Num }传递给后台 -->
							<li ><a href="${APP_PATH}/emps?pn=${page_Num }">${page_Num }</a></li>
						</c:if>
					</c:forEach>
					<!-- 3、判断是否下一页 -->
					<c:if test="${pageInfo.hasNextPage}">
						<!-- 3.1、${APP_PATH}/emps?pn=${pageInfo.pageNum+1 }：当前页+1 -->
						<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1 }" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
					</c:if>
					<!-- 4、取最后一页 -->
					<li ><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
				</ul>
				</nav>
			</div>
		</div>

	</div>

</body>
</html>
