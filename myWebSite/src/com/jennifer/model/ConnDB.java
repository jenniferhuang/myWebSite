package com.jennifer.model;

import java.sql.*;

import javax.naming.Context;
import javax.sql.DataSource;

public class ConnDB {
	private static final String DRIVER="oracle.jdbc.OracleDriver";
	private static final String DRIVER_URL="jdbc:oracle:thin:@127.0.0.1:1521:orcl";
	private static final String USERNAME="huangzf";
	private static final String PASSWORD="huangzf";
	Connection ct=null;
	 public Connection initConnection(){
    	try {
    		//连接数据库					
			Class.forName(DRIVER);
			ct=DriverManager.getConnection(DRIVER_URL,USERNAME,PASSWORD);    	
			//Context con=new javax.naming.InitialContext();
			//DataSource ds=(DataSource)con.lookup("java:comp/env/jennifer");
			//ct=ds.getConnection();	
    		}catch (Exception ex) {   			
    			ex.printStackTrace();    			
    		}
    	return ct;
    }

}
