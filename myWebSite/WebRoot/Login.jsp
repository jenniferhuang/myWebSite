<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Login.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body bgcolor=#CED3FF>
  <img  src="imgs/logo.jpg"><br>
  <center>
  <%
  //if( request.getParameter("err").equals("1")){//request.getParameter("err")可能为null,为空时，直接访问.equals("")报空指针
  String err=request.getParameter("err");
  if(err!=null){
    if(err.equals("1")){
  %>
    <h1><font color="red">用户名或者密码错误，请重新输入！</font></h1>
  <%
    }else if(err.equals("2")){
    %>
    <h1><font color="red">登录超时，或者您还未登录，请先从登录页面进入</font></h1>
    <%
    }
  }
   %>
   
   
   <h2>登录页面</h2><br>
   <form action=LoginClServlet method="post">
   用户名：<input type="text" name="username"><br>
  密&nbsp;&nbsp;码：<input type="password" name="password"><br>
  <input type="checkbox" name=keep value=1>一天内不再重新登录<br>
  <input type="submit" value="登录">&nbsp;
  <input type="reset" value="重置">
   </form>
   </center>
  </body>
</html>












