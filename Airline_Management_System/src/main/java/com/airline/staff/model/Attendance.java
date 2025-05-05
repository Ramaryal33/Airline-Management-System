package com.airline.staff.model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class Attendance {
    private int attendanceId;
    private int staffId;
    private Date date;
    private Time clockIn;
    private Time clockOut;
    private String status;         // Present, Absent, Leave, etc.
    private double workingHours;   // New
    private String remarks;        // New
    private Timestamp createdAt;   // New
    private Timestamp updatedAt;   // New

    public Attendance() {}

    public Attendance(int attendanceId, int staffId, Date date, Time clockIn, Time clockOut,
                      String status, double workingHours, String remarks,
                      Timestamp createdAt, Timestamp updatedAt) {
        this.attendanceId = attendanceId;
        this.staffId = staffId;
        this.date = date;
        this.clockIn = clockIn;
        this.clockOut = clockOut;
        this.status = status;
        this.workingHours = workingHours;
        this.remarks = remarks;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters

    public int getAttendanceId() { return attendanceId; }
    public void setAttendanceId(int attendanceId) { this.attendanceId = attendanceId; }

    public int getStaffId() { return staffId; }
    public void setStaffId(int staffId) { this.staffId = staffId; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public Time getClockIn() { return clockIn; }
    public void setClockIn(Time clockIn) { this.clockIn = clockIn; }

    public Time getClockOut() { return clockOut; }
    public void setClockOut(Time clockOut) { this.clockOut = clockOut; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public double getWorkingHours() { return workingHours; }
    public void setWorkingHours(double workingHours) { this.workingHours = workingHours; }

    public String getRemarks() { return remarks; }
    public void setRemarks(String remarks) { this.remarks = remarks; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
}
