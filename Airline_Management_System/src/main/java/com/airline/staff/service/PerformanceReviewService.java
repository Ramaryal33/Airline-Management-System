package com.airline.staff.service;

import com.airline.config.DbConfig;
import com.airline.staff.model.PerformanceReview;

import java.sql.*;
import java.util.*;
import java.util.stream.Collectors;

public class PerformanceReviewService {

    // Insert a performance review with all fields from the model
    public void addReview(PerformanceReview review) {
        String sql = "INSERT INTO performance_review " +
                     "(staff_id, rating, performance_score, improvement_score, review_period, review_type, review_date, notes, reviewer_id) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbConfig.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, review.getStaffId());
            stmt.setString(2, review.getRating());
            stmt.setDouble(3, review.getPerformanceScore());
            stmt.setDouble(4, review.getImprovementScore());
            stmt.setString(5, review.getReviewPeriod());
            stmt.setString(6, review.getReviewType());
            stmt.setDate(7, review.getReviewDate());
            stmt.setString(8, review.getNotes());

            if (review.getReviewerId() != null) {
                stmt.setInt(9, review.getReviewerId());
            } else {
                stmt.setNull(9, Types.INTEGER);
            }

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Fetch all performance reviews for a specific staff member
    public List<PerformanceReview> getReviewsByStaffId(int staffId) {
        List<PerformanceReview> list = new ArrayList<>();
        String sql = "SELECT * FROM performance_review WHERE staff_id = ? ORDER BY review_date DESC";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, staffId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                list.add(mapPerformanceReview(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get all performance reviews in the system
    public List<PerformanceReview> getAllReviews() {
        List<PerformanceReview> list = new ArrayList<>();
        String sql = "SELECT * FROM performance_review ORDER BY review_date DESC";
        
        try (Connection conn = DbConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                list.add(mapPerformanceReview(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get performance distribution (count by rating)
    public Map<String, Long> getPerformanceDistribution() {
        Map<String, Long> distribution = new LinkedHashMap<>();
        String sql = "SELECT rating, COUNT(*) as count FROM performance_review GROUP BY rating";
        
        try (Connection conn = DbConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                distribution.put(rs.getString("rating"), rs.getLong("count"));
            }
            
            // Ensure all rating categories are present
            ensureAllCategories(distribution);
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return distribution;
    }

    // Get the top performer (highest performance score)
    public PerformanceReview getTopPerformer() {
        String sql = "SELECT * FROM performance_review ORDER BY performance_score DESC LIMIT 1";
        
        try (Connection conn = DbConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return mapPerformanceReview(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get average performance score across all reviews
    public double getAverageRating() {
        String sql = "SELECT AVG(performance_score) as avg_score FROM performance_review";
        
        try (Connection conn = DbConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getDouble("avg_score");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    // Helper method to map ResultSet to PerformanceReview
    private PerformanceReview mapPerformanceReview(ResultSet rs) throws SQLException {
        PerformanceReview pr = new PerformanceReview();
        pr.setReviewId(rs.getInt("review_id"));
        pr.setStaffId(rs.getInt("staff_id"));
        pr.setRating(rs.getString("rating"));
        pr.setPerformanceScore(rs.getDouble("performance_score"));
        pr.setImprovementScore(rs.getDouble("improvement_score"));
        pr.setReviewPeriod(rs.getString("review_period"));
        pr.setReviewType(rs.getString("review_type"));
        pr.setReviewDate(rs.getDate("review_date"));
        pr.setNotes(rs.getString("notes"));
        
        int reviewerId = rs.getInt("reviewer_id");
        pr.setReviewerId(rs.wasNull() ? null : reviewerId);
        
        return pr;
    }

    // Ensure all rating categories are present in the distribution map
    private void ensureAllCategories(Map<String, Long> distribution) {
        String[] categories = {"Excellent", "Good", "Average", "Poor"};
        for (String category : categories) {
            distribution.putIfAbsent(category, 0L);
        }
        
        // Sort by predefined order
        Map<String, Long> sorted = Arrays.stream(categories)
                .collect(Collectors.toMap(
                        category -> category,
                        category -> distribution.getOrDefault(category, 0L),
                        (e1, e2) -> e1,
                        LinkedHashMap::new));
        
        distribution.clear();
        distribution.putAll(sorted);
    }
}