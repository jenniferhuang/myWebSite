package com.jennifer.model;

public class UserBean {
	private int userId;
	private String userName;
	private String passwd;
	private String email;
	private int grade;
	
	public void setUserId(int userId){
		this.userId=userId;
	}
	public int getUserId(){
		return this.userId;
	}
	
	public void setUserName(String userName){
		this.userName=userName;		
	}
	public String getUserName(){
		return this.userName;
	}
	
	
	public void setPasswd(String passwd){
		this.passwd=passwd;		
	}
	public String getPasswd(){
		return this.passwd;
	}
	
	public void setEmail(String email){
		this.email=email;		
	}
	public String getEmail(){
		return this.email;
	}  
		
	public void setGrade(int grade){
		this.grade=grade;
	}
	public int getGrade(){
		return this.grade;
	}		
		 

}
