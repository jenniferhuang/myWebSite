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
		   return window.confirm("ȷ��Ҫɾ������û���");
	    }
    </script>
    
    
    <script type="text/javascript" language="javascript">
	    function goConfirm(){
	      var pageNow=document.getElementById("pageNow").value;
	      window.alert(${pageCount});
	     //var pageNow=document.getElementsById("pageNow").value;
	       window.alert("/myWebSite/UserClServlet?pageNow="+pageNow+"&pageSize=5&flag=page");
	    
	      if(pageNow<1||pageNow>${pageCount}){
	        window.alert("ҳ��������Χ");
	        return false;
	      }
	     //ͨ��js��ת��servlet/actionʱ�������ַ�ʽ��1��window.open()  2,window.location.href
	     window.location.href="/myWebSite/UserClServlet?pageNow="+pageNow+"&pageSize=5&flag=page";
	    }

	</script>
	
	

  </head>
  
  <body bgcolor=#CED3FF>
  <img  src="imgs/logo.jpg">
  <a href="Login.jsp">�������µ�¼</a>&nbsp;&nbsp;<a href="Main.jsp">����������</a>
  <hr>
  <center>
    <h1>����ҳ��jstl</h1> <br>
    
    <c:set var="pageSize" value="5" scope="session"></c:set>
    <%-- 
    <%
    int pageSize=5;
    int pageCount=Integer.parseInt(String.valueOf(request.getAttribute("pageCount"))); //����ֱ����EL���ʽ��ȡ
    int pageNow=Integer.parseInt(String.valueOf(request.getAttribute("pageNow")));
    ArrayList<UserBean> al=(ArrayList<UserBean>)request.getAttribute("result");
     %>
     --%>
     <!-- ��ҳ��ʾ��� -->
     <table>
     <tr bgcolor="purple"><th>userid</th><th>username</th><th>passwd</th><th>email</th><th>grade</th><th>�޸��û�</th><th>ɾ���û�</th></tr>
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
     <td ><a href="UpdateUser.jsp?userId=<%=ub.getUserId()%>&userName=<%=ub.getUserName() %>&passwd=<%=ub.getPasswd() %>&email=<%=ub.getEmail() %>&grade=<%=ub.getGrade()%>">�޸��û�</a></td>
     <td><a href="UserClServlet?userId=<%= ub.getUserId()%>&flag=delete" onclick="return confirmDel(); ">ɾ���û�</a></td>
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
     <td ><a href="UpdateUser.jsp?userId=${ub.userId }&userName=${ub.userName}&passwd=${ub.passwd }&email=${ub.email}&grade=${ub.grade}">�޸��û�</a></td>
     <td><a href="UserClServlet?userId=${ub.userId }&flag=delete" onclick="return confirmDel(); ">ɾ���û�</a></td>
     </tr>
     </c:forEach>
     </table>
     
     <!-- result��pageNow��pageCount���Ǵӿ��Ʋ�UserClServlet�������ģ�pageSize�ڱ�ҳ�Ѿ����á� -->
     <c:if test="${pageNow!=1}">
       <a href="UserClServlet?pageNow=${pageNow-1}&pageSize=${pageSize}&flag=page">��һҳ</a>
       
     </c:if>
     
     <c:forEach begin="1" end="${pageCount}" var="i">
     <c:out value="��ǰi��ֵ${i},,${pageNow }"></c:out>
     <c:if test="${pageNow}!=${i}">
      <a href="UserClServlet?pageNow=${i}&pageSize=${pageSize}&flag=page">${i}</a>
      </c:if>
      <c:if test="${pageNow}==${i}">
      <a style="border-color: red;" href="UserClServlet?pageNow=${i}&pageSize=${pageSize}&flag=page">${i}</a>
      </c:if>
     </c:forEach>
     <c:if test="${pageNow!=pageCount}">
       <a href="UserClServlet?pageNow=${pageNow+1}&pageSize=${pageSize}&flag=page">��һҳ</a>
     </c:if>
     ��ǰҳ:${pageNow }/��ҳ����${pageCount }��
     ��ת����<input type="text" id="pageNow"  name="pageNow"><input type="button" onclick="goConfirm();" value="��"/>
     
     <br/><br></br>����վ����ǰ�����ʵ��ܴ�����
     ${visitTimes}
    <%--
    <%if(pageNow!=1){
    %>
    <a href=UserClServlet?pageNow=<%=pageNow-1%>&pageSize=<%=pageSize%>&flag=page>��һҳ</a>
    <%
    } else{
    %>
    <a href='javascript:void(0)' disable='true'>��һҳ</a>
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
    <a href=UserClServlet?pageNow=<%=pageNow+1%>&pageSize=<%=pageSize%>&flag=page>��һҳ</a>
    <%
    } else{
    %>
    <a href='javascript:void(0)' disable='true'>��һҳ</a>
    <%
    }
     %>
    <br/><br></br>����վ����ǰ�����ʵ��ܴ�����
    <%
    out.println(String.valueOf(this.getServletContext().getAttribute("visitTimes")));
    %>    
     --%>
     
 </center>
  </body>
</html>
