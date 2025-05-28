package com.airline.staff.service;

import com.airline.staff.model.Task;
import com.airline.config.DbConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskService {

    // Create a new task
    public void createTask(Task task) {
        String sql = "INSERT INTO task " +
                "(title, description, assignedTo, assignedBy, dueDate, status, priority, progress, createdAt, completedAt, lastUpdatedAt) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, task.getTitle());
            stmt.setString(2, task.getDescription());
            stmt.setInt(3, task.getAssignedTo());
            stmt.setInt(4, task.getAssignedBy());
            stmt.setDate(5, task.getDueDate());
            stmt.setString(6, task.getStatus());
            stmt.setString(7, task.getPriority());
            stmt.setInt(8, task.getProgress());
            stmt.setTimestamp(9, task.getCreatedAt());
            stmt.setTimestamp(10, task.getCompletedAt());
            stmt.setTimestamp(11, task.getLastUpdatedAt());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get task by ID
    public Task getTaskById(int taskId) {
        String sql = "SELECT * FROM task WHERE taskId = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, taskId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapTask(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all tasks
    public List<Task> getAllTasks() {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM task";

        try (Connection conn = DbConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                tasks.add(mapTask(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }

    // Update a task
    public void updateTask(Task task) {
        String sql = "UPDATE task SET title=?, description=?, assignedTo=?, assignedBy=?, dueDate=?, status=?, " +
                "priority=?, progress=?, completedAt=?, lastUpdatedAt=? WHERE taskId=?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, task.getTitle());
            stmt.setString(2, task.getDescription());
            stmt.setInt(3, task.getAssignedTo());
            stmt.setInt(4, task.getAssignedBy());
            stmt.setDate(5, task.getDueDate());
            stmt.setString(6, task.getStatus());
            stmt.setString(7, task.getPriority());
            stmt.setInt(8, task.getProgress());
            stmt.setTimestamp(9, task.getCompletedAt());
            stmt.setTimestamp(10, task.getLastUpdatedAt());
            stmt.setInt(11, task.getTaskId());

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete task by ID
    public void deleteTask(int taskId) {
        String sql = "DELETE FROM task WHERE taskId = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, taskId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Helper method to map ResultSet to Task model
    private Task mapTask(ResultSet rs) throws SQLException {
        Task task = new Task();
        task.setTaskId(rs.getInt("taskId"));
        task.setTitle(rs.getString("title"));
        task.setDescription(rs.getString("description"));
        task.setAssignedTo(rs.getInt("assignedTo"));
        task.setAssignedBy(rs.getInt("assignedBy"));
        task.setDueDate(rs.getDate("dueDate"));
        task.setStatus(rs.getString("status"));
        task.setPriority(rs.getString("priority"));
        task.setProgress(rs.getInt("progress"));
        task.setCreatedAt(rs.getTimestamp("createdAt"));
        task.setCompletedAt(rs.getTimestamp("completedAt"));
        task.setLastUpdatedAt(rs.getTimestamp("lastUpdatedAt"));
        return task;
    }
}
