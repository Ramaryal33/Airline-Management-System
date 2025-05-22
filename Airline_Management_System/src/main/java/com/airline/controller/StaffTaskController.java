package com.airline.controller;

import com.airline.staff.model.Task;
import com.airline.staff.service.TaskService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@SuppressWarnings("serial")
@WebServlet("/staffTask")
public class StaffTaskController extends HttpServlet {

    private final TaskService taskService = new TaskService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Task> taskList = taskService.getAllTasks();
        request.setAttribute("taskList", taskList);
        request.getRequestDispatcher("/WEB-INF/page/staffTask.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            Task task = new Task();
            task.setTitle(request.getParameter("title"));
            task.setDescription(request.getParameter("description"));
            task.setAssignedTo(Integer.parseInt(request.getParameter("assignedTo")));
            task.setAssignedBy(Integer.parseInt(request.getParameter("assignedBy")));
            task.setDueDate(java.sql.Date.valueOf(request.getParameter("dueDate")));
            task.setStatus(request.getParameter("status"));
            task.setPriority(request.getParameter("priority"));
            task.setProgress(Integer.parseInt(request.getParameter("progress")));
            task.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            task.setCompletedAt(null);
            task.setLastUpdatedAt(new Timestamp(System.currentTimeMillis()));
            task.setStaffId(Integer.parseInt(request.getParameter("staffId")));

            taskService.addTask(task);
        }

        response.sendRedirect("staffTask");
    }
}
