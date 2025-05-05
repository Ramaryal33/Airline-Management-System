package com.airline.staff.service;

import com.airline.staff.model.Task;
import com.airline.config.DbConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskService {

    public void createTask(Task task) {
        String sql = "INSERT INTO task " +
                     "(title, description, assigned_to, assigned_by, due_date, status, priority, progress, created_at, completed_at, last_updated_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
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

    public Task getTaskById(int taskId) {
        String sql = "SELECT * FROM task WHERE task_id = ?";
        try (Connection conn = DbConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
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

    public void updateTask(Task task) {
        String sql = "UPDATE task SET title=?, description=?, assigned_to=?, assigned_by=?, due_date=?, status=?, " +
                     "priority=?, progress=?, completed_at=?, last_updated_at=? WHERE task_id=?";
        try (Connection conn = DbConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
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

    public void deleteTask(int taskId) {
        String sql = "DELETE FROM task WHERE task_id=?";
        try (Connection conn = DbConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, taskId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Task mapTask(ResultSet rs) throws SQLException {
        Task task = new Task();
        task.setTaskId(rs.getInt("task_id"));
        task.setTitle(rs.getString("title"));
        task.setDescription(rs.getString("description"));
        task.setAssignedTo(rs.getInt("assigned_to"));
        task.setAssignedBy(rs.getInt("assigned_by"));
        task.setDueDate(rs.getDate("due_date"));
        task.setStatus(rs.getString("status"));
        task.setPriority(rs.getString("priority"));
        task.setProgress(rs.getInt("progress"));
        task.setCreatedAt(rs.getTimestamp("created_at"));
        task.setCompletedAt(rs.getTimestamp("completed_at"));
        task.setLastUpdatedAt(rs.getTimestamp("last_updated_at"));
        return task;
    }
}
