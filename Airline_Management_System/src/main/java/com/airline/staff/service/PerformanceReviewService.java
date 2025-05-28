package com.airline.staff.service;

import com.airline.config.DbConfig;
import com.airline.staff.model.PerformanceReview;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PerformanceReviewService {

    public PerformanceReview getReviewById(int reviewId) {
        String sql = "SELECT * FROM performance_review WHERE review_id=?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reviewId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapReview(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addReview(PerformanceReview r) {
        String sql = "INSERT INTO performance_review (staff_id, rating, performance_score, improvement_score, review_period, review_type, review_date, notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, r.getStaffId());
            stmt.setString(2, r.getRating());
            stmt.setDouble(3, r.getPerformanceScore());
            stmt.setDouble(4, r.getImprovementScore());
            stmt.setString(5, r.getReviewPeriod());
            stmt.setString(6, r.getReviewType());
            stmt.setDate(7, r.getReviewDate());
            stmt.setString(8, r.getNotes());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateReview(PerformanceReview r) {
        String sql = "UPDATE performance_review SET staff_id=?, rating=?, performance_score=?, improvement_score=?, review_period=?, review_type=?, review_date=?, notes=? WHERE review_id=?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, r.getStaffId());
            stmt.setString(2, r.getRating());
            stmt.setDouble(3, r.getPerformanceScore());
            stmt.setDouble(4, r.getImprovementScore());
            stmt.setString(5, r.getReviewPeriod());
            stmt.setString(6, r.getReviewType());
            stmt.setDate(7, r.getReviewDate());
            stmt.setString(8, r.getNotes());
            stmt.setInt(9, r.getReviewId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteReview(int reviewId) {
        String sql = "DELETE FROM performance_review WHERE review_id=?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, reviewId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<PerformanceReview> getAllReviews() {
        List<PerformanceReview> list = new ArrayList<>();
        String sql = "SELECT * FROM performance_review";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapReview(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<PerformanceReview> getReviewsByStaffId(int staffId) {
        List<PerformanceReview> list = new ArrayList<>();
        String sql = "SELECT * FROM performance_review WHERE staff_id=?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, staffId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapReview(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private PerformanceReview mapReview(ResultSet rs) throws SQLException {
        PerformanceReview r = new PerformanceReview();
        r.setReviewId(rs.getInt("review_id"));
        r.setStaffId(rs.getInt("staff_id"));
        r.setRating(rs.getString("rating"));
        r.setPerformanceScore(rs.getDouble("performance_score"));
        r.setImprovementScore(rs.getDouble("improvement_score"));
        r.setReviewPeriod(rs.getString("review_period"));
        r.setReviewType(rs.getString("review_type"));
        r.setReviewDate(rs.getDate("review_date"));
        r.setNotes(rs.getString("notes"));
        return r;
    }
}
