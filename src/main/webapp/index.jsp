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

<title>My JSP 'index.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
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
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页信息 -->
		<div class="row">
			<!-- 分页信息 -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>

	</div>
	<script type="text/javascript">
		//1、页面加载完成以后，直接去发送一个ajax请求，要到分页数据
		$(function(){
			//去首页
			to_page(1);
		});
		
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);
					//1、解析员工数据
					build_emps_table(result);
					//2、解析并显示分页信息
					build_page_info(result);
					//3、解析分页条
					build_emps_nav(result);
				}
			});
		}
		
		//一、员工表格
		function build_emps_table(result){
			//清空table
			$("#emps_table tbody").empty();
			//获取员工信息的集合list
			var emps =result.extend.pageInfo.list;
			//index：是索引，item是取得的数据
			$.each(emps,function(index,item){
				//员工信息
				var empIdTd=$("<td></td>").append(item.empId);
				var empNameTd=$("<td></td>").append(item.empName);
				var genderTd=$("<td></td>").append(item.gender=='M'?"男":"女");
				var emailTd=$("<td></td>").append(item.email);
				var deptNameTd=$("<td></td>").append(item.department.deptName);
				/*
				*<button class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
				删除
				</button>
				*/
				//两个按钮editBtn,delBtn，在btn中一个单元格
				var editBtn=$("<button></button>").addClass("btn btn-danger btn-sm").append($("<span></span>"))
							.addClass("glyphicon glyphicon-trash").append("编辑")
				var delBtn=$("<button></button>").addClass("btn btn-primary btn-sm").append($("<span></span>"))
							.addClass("glyphicon glyphicon-pencil").append("删除")
				var btn=$("<td></td>").append(editBtn).append(delBtn);
				//append方法执行完成以后还是返回原来的元素
						$("<tr></tr>")
						.append(empIdTd)
						.append(empNameTd)
						.append(genderTd)
						.append(emailTd)
						.append(deptNameTd)
						.append(btn)
						.appendTo("#emps_table tbody");
					});
		}
		//二、解析分页信息
		function build_page_info(result){
			//清空
			$("#page_info_area").empty();
			$("#page_info_area")
			.append("当前"+result.extend.pageInfo.pageNum+"页,"+"总"+result.extend.pageInfo.pages+",总"+result.extend.pageInfo.total+"条记录");
		}
		//三、解析分页条
		function build_emps_nav(result){
			//清空
			$("#page_nav_area").empty();
			var ul=$("<ul></ul>").addClass("pagination")
			//首页
			var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			//“<”
			var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
			//判断是否有前一页
			if(result.extend.pageInfo.hasPreviousPage==false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				//鼠标点击事件，去第一页
				firstPageLi.click(function(){
					to_page(1);
				});
				//鼠标点击事件，去当前页的前一页
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				});
			}

			
			//“>”
			var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
			//末页
			var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			//判断是否有前一页
			if(result.extend.pageInfo.hasNextPage==false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				//鼠标点击事件，去第一页
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				});
				//鼠标点击事件，去当前页的前一页
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});	
			}
		
			/*
			*分页导航显示
			*/
			//添加首页和前一页的提示
			ul.append(firstPageLi).append(prePageLi);
			//页码号1，2,3,4,5
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi=$("<li></li>").append($("<a></a>").append(item));
				//判断是否当前页，是的话用active标识
				if(result.extend.pageInfo.pageNum==item){
					numLi.addClass("active")
				}
				numLi.click(function(){
					to_page(item);
				});
				
				ul.append(numLi)
			});
			//添加首页和前一页的提示
			ul.append(nextPageLi).append(lastPageLi);
			//把ul加入到nav中
			var navEle=$("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}		
	</script>
</body>
</html>
