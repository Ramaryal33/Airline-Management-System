package com.airline.staff.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Task {
    // Fields
    private int taskId;
    private String title;
    private String description;
    private int assignedTo;
    private int assignedBy;
    private Date dueDate;
    private String status;
    private String priority;
    private int progress;
    private Timestamp createdAt;
    private Timestamp completedAt;
    private Timestamp lastUpdatedAt;
    private int staffId; // New field like attendance

    // Default Constructor
    public Task() {}

    // Parameterized Constructor
    public Task(int taskId, String title, String description, int assignedTo, int assignedBy,
                Date dueDate, String status, String priority, int progress,
                Timestamp createdAt, Timestamp completedAt, Timestamp lastUpdatedAt, int staffId) {
        this.taskId = taskId;
        this.title = title;
        this.description = description;
        this.assignedTo = assignedTo;
        this.assignedBy = assignedBy;
        this.dueDate = dueDate;
        this.status = status;
        this.priority = priority;
        this.progress = progress;
        this.createdAt = createdAt;
        this.completedAt = completedAt;
        this.lastUpdatedAt = lastUpdatedAt;
        this.staffId = staffId;
    }

    // Getters and Setters
    public int getTaskId() {
        return taskId;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(int assignedTo) {
        this.assignedTo = assignedTo;
    }

    public int getAssignedBy() {
        return assignedBy;
    }

    public void setAssignedBy(int assignedBy) {
        this.assignedBy = assignedBy;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public int getProgress() {
        return progress;
    }

    public void setProgress(int progress) {
        this.progress = progress;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(Timestamp completedAt) {
        this.completedAt = completedAt;
    }

    public Timestamp getLastUpdatedAt() {
        return lastUpdatedAt;
    }

    public void setLastUpdatedAt(Timestamp lastUpdatedAt) {
        this.lastUpdatedAt = lastUpdatedAt;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }
}
