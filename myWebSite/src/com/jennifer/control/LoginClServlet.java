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
			String u=request.getParameter("username");  //Login.jsp传进的值
			String p=request.getParameter("password");
			System.out.println("当前传进来u="+u+",p="+p);
			UserBeanCl ubcl=new UserBeanCl();
			if(ubcl.checkUser(u, p)){
				//合法，登录成功
				//一、cookie设置
				String keep=request.getParameter("keep");
				if(keep!=null){
					Cookie name=new Cookie("myName",u); //将用户名和密码保存在客户端
			   	    Cookie pass=new Cookie("myPasswd",p);//1、创建cookie
				    name.setMaxAge(24*3600);//2、设置时间
				    pass.setMaxAge(24*3600);
				    response.addCookie(name);//3、回写到客户端
				    response.addCookie(pass);						
				}
				//二、session防止非法用户直接进入结果页面
				HttpSession hs=request.getSession(true);
				String sessionId=hs.getId();
				System.out.println("LoginClServlet里面中获得的sessionId="+sessionId);
				//修改session的存在时间
				hs.setMaxInactiveInterval(20); //设置为负数时，表示永远不超时；设置为0，相当清空session,连对象hs都获不到(可用于安全注销)
				hs.setAttribute("userName",u);
				
				//三、添加网页访问次数，（通过ServletContext和Servlet本身生命周期来完成）
				String times=(String)this.getServletContext().getAttribute("visitTimes");
				this.getServletContext().setAttribute("visitTimes",String.valueOf((Integer.parseInt(times)+1)));	
				
				//四、跳转到结果页面，转发的形式
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
		//System.out.println("访问了init(),获得了名为visitTimes的ServletContext");
		FileReader fr=null;
		BufferedReader br=null;
		String times="1";
		try{
			//首次访问时，将网站的访问次数从文件 读到 ServletContext中保存
			fr=new FileReader("D:\\myCounter.txt");
			br=new BufferedReader(fr);
			String temp;
			if((temp=br.readLine())!=null){
				times=temp;
				System.out.println("首次执行？");
			}
			System.out.println("文件读出的次数为："+times);
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
		//服务器关闭时，把ServletContext中最新的值， 写到文件中
		FileWriter fw=null;
		BufferedWriter bw=null;
		try{
			fw=new FileWriter("D:\\myCounter.txt");
			bw=new BufferedWriter(fw);
			bw.write(this.getServletContext().getAttribute("visitTimes")+"");
			//System.out.println("访问了destroy(),把名为visitTimes的ServletContext的值写入文件");
			System.out.println("写入文件的次数为："+this.getServletContext().getAttribute("visitTimes")+"");
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
