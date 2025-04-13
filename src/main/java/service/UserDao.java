package service;

import java.sql.*;
import java.util.*;

import util.DatabaseConnection;
import util.User;

public class UserDao {

    // Fetch all users from the database
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        String query = "SELECT * FROM users"; 

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            // Iterate over result set and create User objects
            while (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                userList.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return userList;
    }
    
    public List<User> searchUsers(String searchQuery) {
        List<User> userList = new ArrayList<>();
        String query = "SELECT * FROM users WHERE username LIKE ? OR email LIKE ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            String searchPattern = "%" + searchQuery + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);

            try (ResultSet rs = stmt.executeQuery()) {
                // Iterate over result set and create User objects
                while (rs.next()) {
                    User user = new User();
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPhoneNumber(rs.getString("phone"));
                    user.setAddress(rs.getString("address"));
                    userList.add(user);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return userList;
    }
}
