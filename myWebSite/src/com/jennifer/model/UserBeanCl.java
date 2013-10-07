package com.jennifer.model;
import java.sql.*;
import java.util.*;
public class UserBeanCl {
	Connection ct=null;
	PreparedStatement pst=null;
	ResultSet rs=null;
	int rowCount;
	int pageCount;
	

	/**
	 *ҵ���߼�--�����ҳ����
	 */
	//����������
	public int getPageCount(){
		return this.pageCount;
	}
	
	//���ط�ҳ��ѯ���
	public ArrayList pageCl(int pageSize,int pageNow){
		
		ArrayList al=new ArrayList();		
		try{
			ConnDB cd=new ConnDB();
			ct=cd.initConnection();
			String sqlCount="select count(*) from users";  //��ѯ���ݿ⣬�õ�������rowCount
	    	pst=ct.prepareStatement(sqlCount);
			rs=pst.executeQuery();
			while(rs.next()){				
				this.rowCount=rs.getInt(1);				
			}
			if(rowCount%pageSize==0){
				pageCount=rowCount/pageSize;
			}else{
				pageCount=rowCount/pageSize+1;
			}			
			System.out.println("������rowCount��"+rowCount+"��ҳ��pageCount��"+pageCount);		
			
			//=====��ҳ��ѯ���ݿ�	
			String sql2=" select * from(select A.*,rownum rn from(select * from users order by userid) A where rownum<=?) where rn>=? order by userid";
			String params[]={String.valueOf(pageSize*(pageNow-1)+pageSize),String.valueOf(pageSize*(pageNow-1)+1)};
			pst=ct.prepareStatement(sql2);			
			for(int i=0;i<params.length;i++){
				pst.setString(i+1, params[i]);
			}
			rs=pst.executeQuery();//sql���±䣬pst�仯��rs�仯
			while(rs.next()){
				UserBean ub=new UserBean();
				ub.setUserId(rs.getInt(1));
				ub.setUserName(rs.getString(2));
				ub.setPasswd(rs.getString(3));
				ub.setEmail(rs.getString(4));
				ub.setGrade(rs.getInt(5));
				al.add(ub);
			}		
		
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}		
		return al;		
	}
	
	
	//ҵ���߼�����--��֤�û��Ƿ�Ϸ�
	public Boolean checkUser(String user,String passwd){
		Boolean b=false;
		try{
			ConnDB cd=new ConnDB();
			ct=cd.initConnection();
			String sql="select * from users where username=? and passwd=?";
			String params[]={user,passwd};	
			pst=ct.prepareStatement(sql);
			for(int i=0;i<params.length;i++){
				pst.setString(i+1, params[i]);
			}
			rs=pst.executeQuery();
			if(rs.next()){
				b=true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}
		return b;
	}
	
	
	//�����û�
	public ArrayList SearUser(int pageSize,int pageNow,String username,String findType){
		
		ArrayList al=new ArrayList();		
		try{
			ConnDB cd=new ConnDB();
			ct=cd.initConnection();
			String sqlCount;
			String sql2;
			if(findType.equals("��ȷ����")){
				sqlCount="select count(*) from users where username=?";  //��ѯ���ݿ⣬�õ�������rowCount
				sql2=" select * from(select A.*,rownum rn from(select * from users where username=? order by userid) A where rownum<=?) where rn>=? order by userid";

			}else{
				sqlCount="select count(*) from users where username like ?";
				sql2=" select * from(select A.*,rownum rn from(select * from users where username like ? order by userid) A where rownum<=?) where rn>=? order by userid";
				username="%"+username+"%";		
			}	
			pst=ct.prepareStatement(sqlCount);
			pst.setString(1,username);	    
	    	
			rs=pst.executeQuery();
			while(rs.next()){				
				this.rowCount=rs.getInt(1);				
			}
			if(rowCount%pageSize==0){
				pageCount=rowCount/pageSize;
			}else{
				pageCount=rowCount/pageSize+1;
			}			
			System.out.println("������rowCount��"+rowCount+"��ҳ��pageCount��"+pageCount);		
			
			//=====��ҳ��ѯ���ݿ�	
			String params[]={username,String.valueOf(pageSize*(pageNow-1)+pageSize),String.valueOf(pageSize*(pageNow-1)+1)};
			pst=ct.prepareStatement(sql2);			
			for(int i=0;i<params.length;i++){
				pst.setString(i+1, params[i]);
			}
			rs=pst.executeQuery();//sql���±䣬pst�仯��rs�仯
			while(rs.next()){
				UserBean ub=new UserBean();
				ub.setUserId(rs.getInt(1));
				ub.setUserName(rs.getString(2));
				ub.setPasswd(rs.getString(3));
				ub.setEmail(rs.getString(4));
				ub.setGrade(rs.getInt(5));
				al.add(ub);
			}		
		
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}		
		return al;		
	}
	
	
	
		
	
	//�޸��û�
	public Boolean UpdateUser(String userId,String passwd,String email,String grade){
		Boolean b=false;
		try{
			ConnDB cd=new ConnDB();
			ct=cd.initConnection();
			String sql="update users set passwd=?, email=?, grade=? where userId=?";
			pst=ct.prepareStatement(sql);
			pst.setString(1,passwd);
			pst.setString(2,email);
			pst.setString(3,grade);
			pst.setString(4,userId);
			System.out.println("�������Ĳ���userId=��"+userId+"passwd="+passwd+"email="+email+"grade="+grade);
			System.out.println("sql==="+sql);
			int num=pst.executeUpdate();
			if(num==1){
				b=true;
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}
		return b;
	}
	
	
	
	//ɾ���û�
	public Boolean DelUser(String userId){
		Boolean b=false;
		try{
			ConnDB cd=new ConnDB();
			ct=cd.initConnection();
			String sql="delete from users where userId=?";
			pst=ct.prepareStatement(sql);
			pst.setString(1,userId);
			int num=pst.executeUpdate();
			if(num==1){
				b=true;
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}
		return b;
	}
	
	//����û�
	public Boolean AddUser(String username,String passwd,String email,int grade){
		Boolean b=false;
		try{
			ConnDB cd=new ConnDB();
			ct=cd.initConnection();
			String sql="insert into users(username,passwd,email,grade)values(?,?,?,?)";
			pst=ct.prepareStatement(sql);
			pst.setString(1,username);
			pst.setString(2, passwd);
			pst.setString(3, email);
			pst.setInt(4, grade);
			int num=pst.executeUpdate();
			if(num==1){
				b=true;
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close();
		}
		return b;
	}
    
   //�ر����ݿ���Դ
	public void close(){
		try {
			if(rs!=null) rs.close();
			if(pst!=null) pst.close();
			if(ct!=null) ct.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
    
}