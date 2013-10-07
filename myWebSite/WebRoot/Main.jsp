<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Main.jsp' starting page</title>
    
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
  <%
  /**
    判断session和cookie是否有效
  **/
  String u=(String)session.getAttribute("userName");
  if(u==null){//session失效 或者 直接访问该页面，没有userName的session
  Cookie cookies[]=request.getCookies();
  String myName="";
  String myPasswd="";
  for(int i=0;i<cookies.length;i++){
    if(cookies[i].getName().equals("myName")){
      myName=cookies[i].getValue();
    }else if(cookies[i].getName().equals("myPasswd")){
      myPasswd=cookies[i].getValue();
    }
  }
  System.out.println("获得cookie的用户名"+myName+"，密码："+myPasswd);
  if(!myName.equals("")&&!myPasswd.equals("")){//取到了对应cookie
     response.sendRedirect("LoginClServlet?username="+myName+"&password="+myPasswd+"");
  
  }else{//没有对应这两个cookie
      response.sendRedirect("Login.jsp?err=2");
  
  }
  }
  
   %>
  
  
  
  
  
  
  <img  src="imgs/logo.jpg">
   <center>
   <h2 >主界面 </h2><br>  
   <a href=UserClServlet?pageSize=5&pageNow=1&flag=page>管理用户</a><br>
   <a href="AddUser.jsp">添加用户</a><br/>
   <a href=?>查找用户</a><br/>
   <a href=?>安全退出</a>
   </center>
   
  </body>
</html>
