package com.airline.controller;

import com.airline.staff.model.PerformanceReview;
import com.airline.staff.service.PerformanceReviewService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/staffPerformanceReview")
public class PerformanceReviewController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final PerformanceReviewService reviewService = new PerformanceReviewService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    request.setAttribute("review", new PerformanceReview());
                    request.getRequestDispatcher("/WEB-INF/page/staffPeformanceReview.jsp").forward(request, response);
                    break;

                case "edit":
                    int editId = Integer.parseInt(request.getParameter("id"));
                    PerformanceReview review = reviewService.getReviewById(editId);
                    request.setAttribute("review", review);
                    request.getRequestDispatcher("/WEB-INF/page/staffPeformanceReview.jsp").forward(request, response);
                    break;

                case "delete":
                    int delId = Integer.parseInt(request.getParameter("id"));
                    reviewService.deleteReview(delId);
                    response.sendRedirect("staffPerformanceReview");
                    break;

                default: // list
                    List<PerformanceReview> list = reviewService.getAllReviews();
                    request.setAttribute("reviewList", list);
                    request.getRequestDispatcher("/WEB-INF/page/staffPeformanceReview.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("staffPerformanceReview?error=true");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            PerformanceReview review = new PerformanceReview();
            populateReviewFromRequest(review, request);

            if ("edit".equalsIgnoreCase(action)) {
                review.setReviewId(Integer.parseInt(request.getParameter("reviewId")));
                reviewService.updateReview(review);
            } else {
                reviewService.addReview(review);
            }

            response.sendRedirect("staffPerformanceReview");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Something went wrong while saving the review.");
            request.getRequestDispatcher("/WEB-INF/page/staffPeformanceReview.jsp").forward(request, response);
        }
    }

    private void populateReviewFromRequest(PerformanceReview review, HttpServletRequest req) {
        review.setStaffId(Integer.parseInt(req.getParameter("staffId")));
        review.setRating(req.getParameter("rating"));
        review.setPerformanceScore(Double.parseDouble(req.getParameter("performanceScore")));
        review.setImprovementScore(Double.parseDouble(req.getParameter("improvementScore")));
        review.setReviewPeriod(req.getParameter("reviewPeriod"));
        review.setReviewType(req.getParameter("reviewType"));
        review.setReviewDate(Date.valueOf(req.getParameter("reviewDate")));
        review.setNotes(req.getParameter("notes"));
    }
}
