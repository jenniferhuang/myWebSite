<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'AddUser.jsp' starting page</title>
    
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
  <center>
    <h2>�������û���Ϣ</h2> <br>
  <form action="UserClServlet?flag=add" method="post">
  <table border="1" align="center" >
    <tr bgcolor="pink"><td> �û�����</td><td><input type=text name=username ></td></tr>
    <tr bgcolor="silver"><td> ��&nbsp;�룺</td><td><input type=password name=passwd ></td></tr>
    <tr bgcolor="pink"><td> ��&nbsp;�䣺</td><td><input type=text name=email></td></tr>
    <tr bgcolor="silver"><td> ��&nbsp;����</td><td><input type=text name=grade></td></tr>
    <tr><td><input type="submit" value="����û�"/></td><td><input type="reset" value="����"/></td></tr>
  </table>
  </form>
  
  </center>
  </body>
</html>
