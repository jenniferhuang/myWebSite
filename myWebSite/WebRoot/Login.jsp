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
  //if( request.getParameter("err").equals("1")){//request.getParameter("err")����Ϊnull,Ϊ��ʱ��ֱ�ӷ���.equals("")����ָ��
  String err=request.getParameter("err");
  if(err!=null){
    if(err.equals("1")){
  %>
    <h1><font color="red">�û�����������������������룡</font></h1>
  <%
    }else if(err.equals("2")){
    %>
    <h1><font color="red">��¼��ʱ����������δ��¼�����ȴӵ�¼ҳ�����</font></h1>
    <%
    }
  }
   %>
   
   
   <h2>��¼ҳ��</h2><br>
   <form action=LoginClServlet method="post">
   �û�����<input type="text" name="username"><br>
  ��&nbsp;&nbsp;�룺<input type="password" name="password"><br>
  <input type="checkbox" name=keep value=1>һ���ڲ������µ�¼<br>
  <input type="submit" value="��¼">&nbsp;
  <input type="reset" value="����">
   </form>
   </center>
  </body>
</html>












