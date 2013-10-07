package com.jennifer.control;

import java.io.*;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jennifer.model.UserBeanCl;

public class LoginClServlet extends HttpServlet {

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
		try {
			request.setCharacterEncoding("gb2312");
			String u=request.getParameter("username");  //Login.jsp������ֵ
			String p=request.getParameter("password");
			System.out.println("��ǰ������u="+u+",p="+p);
			UserBeanCl ubcl=new UserBeanCl();
			if(ubcl.checkUser(u, p)){
				//�Ϸ�����¼�ɹ�
				//һ��cookie����
				String keep=request.getParameter("keep");
				if(keep!=null){
					Cookie name=new Cookie("myName",u); //���û��������뱣���ڿͻ���
			   	    Cookie pass=new Cookie("myPasswd",p);//1������cookie
				    name.setMaxAge(24*3600);//2������ʱ��
				    pass.setMaxAge(24*3600);
				    response.addCookie(name);//3����д���ͻ���
				    response.addCookie(pass);						
				}
				//����session��ֹ�Ƿ��û�ֱ�ӽ�����ҳ��
				HttpSession hs=request.getSession(true);
				String sessionId=hs.getId();
				System.out.println("LoginClServlet�����л�õ�sessionId="+sessionId);
				//�޸�session�Ĵ���ʱ��
				hs.setMaxInactiveInterval(20); //����Ϊ����ʱ����ʾ��Զ����ʱ������Ϊ0���൱���session,������hs���񲻵�(�����ڰ�ȫע��)
				hs.setAttribute("userName",u);
				
				//���������ҳ���ʴ�������ͨ��ServletContext��Servlet����������������ɣ�
				String times=(String)this.getServletContext().getAttribute("visitTimes");
				this.getServletContext().setAttribute("visitTimes",String.valueOf((Integer.parseInt(times)+1)));	
				
				//�ġ���ת�����ҳ�棬ת������ʽ
				request.getRequestDispatcher("Main.jsp").forward(request, response);
				
			}else{
				response.sendRedirect("Login.jsp?err=1");
				//request.getRequestDispatcher("Login.jsp").forward(request, response);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
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
	
	
	public void init(){
		//System.out.println("������init(),�������ΪvisitTimes��ServletContext");
		FileReader fr=null;
		BufferedReader br=null;
		String times="1";
		try{
			//�״η���ʱ������վ�ķ��ʴ������ļ� ���� ServletContext�б���
			fr=new FileReader("D:\\myCounter.txt");
			br=new BufferedReader(fr);
			String temp;
			if((temp=br.readLine())!=null){
				times=temp;
				System.out.println("�״�ִ�У�");
			}
			System.out.println("�ļ������Ĵ���Ϊ��"+times);
			this.getServletContext().setAttribute("visitTimes",times);			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				br.close();
				fr.close();
			}catch(Exception e2){
				e2.printStackTrace();
			}

		}
	}
	
	public void destroy(){
		//�������ر�ʱ����ServletContext�����µ�ֵ�� д���ļ���
		FileWriter fw=null;
		BufferedWriter bw=null;
		try{
			fw=new FileWriter("D:\\myCounter.txt");
			bw=new BufferedWriter(fw);
			bw.write(this.getServletContext().getAttribute("visitTimes")+"");
			//System.out.println("������destroy(),����ΪvisitTimes��ServletContext��ֵд���ļ�");
			System.out.println("д���ļ��Ĵ���Ϊ��"+this.getServletContext().getAttribute("visitTimes")+"");
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				bw.close();
				fw.close();				
			}catch(Exception e2){
				e2.printStackTrace();
			}			
		}
		
	}

}
