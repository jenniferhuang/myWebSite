<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@page import="com.jennifer.model.UserBean,com.jennifer.control.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Wel.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" language="javascript">

		function confirmDel(){
		   return window.confirm("确定要删除这个用户吗？");
	    }
    </script>
    
    
    <script type="text/javascript" language="javascript">
	    function goConfirm(){
	      var pageNow=document.getElementById("pageNow").value;
	      window.alert(${pageCount});
	     //var pageNow=document.getElementsById("pageNow").value;
	       window.alert("/myWebSite/UserClServlet?pageNow="+pageNow+"&pageSize=5&flag=page");
	    
	      if(pageNow<1||pageNow>${pageCount}){
	        window.alert("页数超过范围");
	        return false;
	      }
	     //通过js跳转到servlet/action时，有两种方式，1，window.open()  2,window.location.href
	     window.location.href="/myWebSite/UserClServlet?pageNow="+pageNow+"&pageSize=5&flag=page";
	    }

	</script>
	
	

  </head>
  
  <body bgcolor=#CED3FF>
  <img  src="imgs/logo.jpg">
  <a href="Login.jsp">返回重新登录</a>&nbsp;&nbsp;<a href="Main.jsp">返回主界面</a>
  <hr>
  <center>
    <h1>管理页面jstl</h1> <br>
    
    <c:set var="pageSize" value="5" scope="session"></c:set>
    <%-- 
    <%
    int pageSize=5;
    int pageCount=Integer.parseInt(String.valueOf(request.getAttribute("pageCount"))); //换成直接在EL表达式中取
    int pageNow=Integer.parseInt(String.valueOf(request.getAttribute("pageNow")));
    ArrayList<UserBean> al=(ArrayList<UserBean>)request.getAttribute("result");
     %>
     --%>
     <!-- 分页显示结果 -->
     <table>
     <tr bgcolor="purple"><th>userid</th><th>username</th><th>passwd</th><th>email</th><th>grade</th><th>修改用户</th><th>删除用户</th></tr>
     <%-- 
     <%
     String []colors={"yellow","grey","pink"};
     for(int i=0;i<al.size();i++){
     UserBean ub=new UserBean();
     ub=(UserBean)al.get(i);
     %>
     <tr bgcolor=<%=colors[i%colors.length] %>>
     <td><%=ub.getUserId()%></td>
     <td><%=ub.getUserName()%></td>
     <td><%=ub.getPasswd()%></td>
     <td><%=ub.getEmail() %></td>
     <td><%=ub.getGrade()%></td>
     <td ><a href="UpdateUser.jsp?userId=<%=ub.getUserId()%>&userName=<%=ub.getUserName() %>&passwd=<%=ub.getPasswd() %>&email=<%=ub.getEmail() %>&grade=<%=ub.getGrade()%>">修改用户</a></td>
     <td><a href="UserClServlet?userId=<%= ub.getUserId()%>&flag=delete" onclick="return confirmDel(); ">删除用户</a></td>
     </tr>
     <%
     } 
     %>
     --%>
     <c:forEach items="${result}" var="ub">
     <tr>
     <td>${ub.userId }</td>
     <td>${ub.userName}</td>
     <td>${ub.passwd }</td>
     <td>${ub.email}</td>
     <td>${ub.grade}</td>
     <td ><a href="UpdateUser.jsp?userId=${ub.userId }&userName=${ub.userName}&passwd=${ub.passwd }&email=${ub.email}&grade=${ub.grade}">修改用户</a></td>
     <td><a href="UserClServlet?userId=${ub.userId }&flag=delete" onclick="return confirmDel(); ">删除用户</a></td>
     </tr>
     </c:forEach>
     </table>
     
     <!-- result、pageNow、pageCount都是从控制层UserClServlet传过来的，pageSize在本页已经设置。 -->
     <c:if test="${pageNow!=1}">
       <a href="UserClServlet?pageNow=${pageNow-1}&pageSize=${pageSize}&flag=page">上一页</a>
       
     </c:if>
     
     <c:forEach begin="1" end="${pageCount}" var="i">
     <c:out value="当前i的值${i},,${pageNow }"></c:out>
     <c:if test="${pageNow}!=${i}">
      <a href="UserClServlet?pageNow=${i}&pageSize=${pageSize}&flag=page">${i}</a>
      </c:if>
      <c:if test="${pageNow}==${i}">
      <a style="border-color: red;" href="UserClServlet?pageNow=${i}&pageSize=${pageSize}&flag=page">${i}</a>
      </c:if>
     </c:forEach>
     <c:if test="${pageNow!=pageCount}">
       <a href="UserClServlet?pageNow=${pageNow+1}&pageSize=${pageSize}&flag=page">下一页</a>
     </c:if>
     当前页:${pageNow }/总页数：${pageCount }；
     跳转到：<input type="text" id="pageNow"  name="pageNow"><input type="button" onclick="goConfirm();" value="跳"/>
     
     <br/><br></br>该网站被当前被访问的总次数：
     ${visitTimes}
    <%--
    <%if(pageNow!=1){
    %>
    <a href=UserClServlet?pageNow=<%=pageNow-1%>&pageSize=<%=pageSize%>&flag=page>上一页</a>
    <%
    } else{
    %>
    <a href='javascript:void(0)' disable='true'>上一页</a>
    <%
    }
    for(int i=1;i<=pageCount;i++){
    %>
    <a href=UserClServlet?pageNow=<%=i%>&pageSize=<%=pageSize%>&flag=page><%=i %></a>
    <%
    }
    %>    
    <%if(pageNow!=pageCount){
    %>
    <a href=UserClServlet?pageNow=<%=pageNow+1%>&pageSize=<%=pageSize%>&flag=page>下一页</a>
    <%
    } else{
    %>
    <a href='javascript:void(0)' disable='true'>下一页</a>
    <%
    }
     %>
    <br/><br></br>该网站被当前被访问的总次数：
    <%
    out.println(String.valueOf(this.getServletContext().getAttribute("visitTimes")));
    %>    
     --%>
     
 </center>
  </body>
</html>
