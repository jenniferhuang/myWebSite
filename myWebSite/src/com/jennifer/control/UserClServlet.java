package com.jennifer.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jennifer.model.UserBeanCl;

public class UserClServlet extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String flag=request.getParameter("flag");
		UserBeanCl ubc=new UserBeanCl();
		//System.out.println("������־flag="+flag);
		if(flag.equals("page")){
			//System.out.println("�����ҳ��ʾ");
			String pageNow=request.getParameter("pageNow"); //Main.jsp����ֵ1��Wel.jsp�����û����������ֵ
			String pageSize=request.getParameter("pageSize");
			//System.out.println("���յ���pageNow="+pageNow+",pageSize="+pageSize);			
			ArrayList al=ubc.pageCl(Integer.parseInt(pageSize), Integer.parseInt(pageNow));
			String pageCount=String.valueOf(ubc.getPageCount());
			//System.out.println("����Model��󣬵õ���¼�ĸ���="+al.size());
			request.setAttribute("result", al);
			request.setAttribute("pageCount", pageCount);
			request.setAttribute("pageNow", pageNow);		
			request.getRequestDispatcher("Wel.jsp").forward(request, response);
			
		}else if(flag.equals("delete")){//ɾ��
			String userId=request.getParameter("userId");
			if(ubc.DelUser(userId)){
				request.getRequestDispatcher("OK.jsp").forward(request, response);
			}else{
				request.getRequestDispatcher("Err.jsp").forward(request, response);
			}
			
		}else if(flag.equals("update")){//�޸�
			if(ubc.UpdateUser(request.getParameter("userId"),request.getParameter("passwd"),request.getParameter("email"),request.getParameter("grade"))){
				//�޸ĳɹ�
				request.getRequestDispatcher("OK.jsp").forward(request, response);
			}else{
				//�޸�ʧ��
				request.getRequestDispatcher("Err.jsp").forward(request, response);
			}	
		}else if(flag.equals("add")){
			if(ubc.AddUser(request.getParameter("username"), request.getParameter("passwd"), request.getParameter("email"), Integer.parseInt(request.getParameter("grade")))){
				request.getRequestDispatcher("OK.jsp").forward(request, response);
				
			}else{
				request.getRequestDispatcher("Err.jsp").forward(request, response);
			}
			
		}
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
//
//		response.setContentType("text/html");
//		PrintWriter out = response.getWriter();
//		out
//				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
//		out.println("<HTML>");
//		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
//		out.println("  <BODY>");
//		out.print("    This is ");
//		out.print(this.getClass());
//		out.println(", using the POST method");
//		out.println("  </BODY>");
//		out.println("</HTML>");
//		out.flush();
//		out.close();
	}

}
