/************************************************************
 * Copyright 2025 Humber
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy
 * of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 ************************************************************/

package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import servlet.User;
import util.DatabaseConnection;

public class UserAuthService {
	public boolean registerUser(User user) {
		String query = "INSERT INTO users (username, password, phone, email, address, admin) VALUES (?, ?, ?, ?, ?, ?)";
		try(Connection connection = DatabaseConnection.getConnection()){
			PreparedStatement stmt = connection.prepareStatement(query);
			stmt.setString(1,user.getUsername());
			stmt.setString(2,user.getPassword());
			stmt.setString(3,user.getPhoneNumber());
			stmt.setString(4,user.getEmail());
			stmt.setString(5,user.getAddress());
			stmt.setString(6,user.getAdmin());
			
			return stmt.executeUpdate() > 0;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean loginUser(String email, String password) {
		String query = "select * from users where email = ? AND password = ?";
		try {
			Connection conn = DatabaseConnection.getConnection();
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
}
