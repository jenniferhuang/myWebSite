<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'UpdateUser.jsp' starting page</title>
    
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
    <h2>�޸�ҳ��</h2> <br>
  <form action="UserClServlet?flag=update" method="post">
    �û�ID��<input readonly type=text name=userId value=<%=request.getParameter("userId")%>><br>
    �û�����<input readonly type=text name=username value=<%=request.getParameter("userName") %>><br>  
    ��&nbsp;�룺<input type=password name=passwd value=<%=request.getParameter("passwd")%>><br>
    ��&nbsp;�䣺<input type=text name=email value=<%=request.getParameter("email") %>><br>  
    ��&nbsp;����<input type=text name=grade value=<%=request.getParameter("grade") %>><br>
  <input type=submit value=�ύ�޸�><br>
  </form>
  
  </center>
  </body>
</html>
