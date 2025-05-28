package com.airline.staff.model;

import java.sql.Date;

public class PerformanceReview {

    private int reviewId;
    private int staffId;
    private String rating;            // e.g., "Excellent", "Good"
    private double performanceScore;  // e.g., 82.5
    private double improvementScore;  // e.g., +5.0
    private String reviewPeriod;      // e.g., "Q1 2025"
    private String reviewType;        // e.g., "Manager", "Peer" (optional)
    private Date reviewDate;
    private String notes;
        // nullable

    public PerformanceReview() {}

    public PerformanceReview(int reviewId, int staffId, String rating, double performanceScore,
                             double improvementScore, String reviewPeriod, String reviewType,
                             Date reviewDate, String notes, Integer reviewerId) {
        this.reviewId = reviewId;
        this.staffId = staffId;
        this.rating = rating;
        this.performanceScore = performanceScore;
        this.improvementScore = improvementScore;
        this.reviewPeriod = reviewPeriod;
        this.reviewType = reviewType;
        this.reviewDate = reviewDate;
        this.notes = notes;
       
    }

    // Getters and Setters

    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }

    public int getStaffId() { return staffId; }
    public void setStaffId(int staffId) { this.staffId = staffId; }

    public String getRating() { return rating; }
    public void setRating(String rating) { this.rating = rating; }

    public double getPerformanceScore() { return performanceScore; }
    public void setPerformanceScore(double performanceScore) { this.performanceScore = performanceScore; }

    public double getImprovementScore() { return improvementScore; }
    public void setImprovementScore(double improvementScore) { this.improvementScore = improvementScore; }

    public String getReviewPeriod() { return reviewPeriod; }
    public void setReviewPeriod(String reviewPeriod) { this.reviewPeriod = reviewPeriod; }

    public String getReviewType() { return reviewType; }
    public void setReviewType(String reviewType) { this.reviewType = reviewType; }

    public Date getReviewDate() { return reviewDate; }
    public void setReviewDate(Date reviewDate) { this.reviewDate = reviewDate; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    
}
