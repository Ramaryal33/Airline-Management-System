// UPDATED UserService.java
package com.airline.service;

import com.airline.config.DbConfig;
import com.airline.model.User;
import com.airline.util.PasswordUtil;

import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.logging.Logger;

public class UserService {
    private static final Logger logger = Logger.getLogger(UserService.class.getName());

    // Authenticate the user based on email and password
    public User authenticateByEmailOnly(String email, String password)
            throws SQLException, NoSuchAlgorithmException {

        String sql = "SELECT * FROM users WHERE Email = ? AND Active = 1";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("Password");
                    if (PasswordUtil.checkPassword(password, storedPassword)) {
                        logger.info("Authenticated via email: " + email);
                        return mapUserFromResultSet(rs);
                    } else {
                        logger.warning("Password mismatch (email login) for: " + email);
                    }
                } else {
                    logger.warning("User not found or inactive (email login): " + email);
                }
            }

        } catch (SQLException e) {
            logger.severe("SQL error (email-only auth): " + e.getMessage());
            throw e;
        }
        return null;
    }

    // Get minimal user info for dropdowns
    public List<User> getBasicUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT ID, FullName FROM users WHERE userType = 'user' AND Active = 1";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("ID"));
                user.setFullName(rs.getString("FullName"));
                users.add(user);
            }

        } catch (SQLException e) {
            logger.severe("SQL error in getBasicUsers: " + e.getMessage());
        }

        return users;
    }

    // Map the result set into a User object
    private User mapUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("ID"));
        user.setFullName(rs.getString("FullName"));
        user.setEmail(rs.getString("Email"));
        user.setPhone(rs.getString("Phone"));
        user.setPassword(rs.getString("Password"));
        user.setUserType(rs.getString("userType"));
        user.setActive(rs.getBoolean("Active"));
        return user;
    }

    public boolean sendTemporaryPassword(String email) throws SQLException, NoSuchAlgorithmException {
        String tempPassword = generateRandomPassword(8);
        String hashedPassword = PasswordUtil.hashPassword(tempPassword);

        String sql = "UPDATE users SET Password = ? WHERE Email = ?";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, hashedPassword);
            stmt.setString(2, email);

            int updated = stmt.executeUpdate();
            if (updated > 0) {
                System.out.println("Temporary password for " + email + ": " + tempPassword);
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }

        return false;
    }

    private String generateRandomPassword(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$";
        StringBuilder sb = new StringBuilder();
        Random rand = new Random();

        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(rand.nextInt(chars.length())));
        }

        return sb.toString();
    }
}