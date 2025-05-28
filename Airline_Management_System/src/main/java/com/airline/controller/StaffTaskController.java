// File: StaffTaskController.java
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

    private TaskService taskService;

    @Override
    public void init() {
        taskService = new TaskService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null || action.isEmpty()) {
                listTasks(request, response);
            } else {
                switch (action) {
                    case "new":
                        showAddForm(request, response);
                        break;
                    case "edit":
                        showEditForm(request, response);
                        break;
                    case "delete":
                        deleteTask(request, response);
                        break;
                    default:
                        listTasks(request, response);
                        break;
                }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listTasks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Task> taskList = taskService.getAllTasks();
        request.setAttribute("taskList", taskList);
        request.getRequestDispatcher("/WEB-INF/page/staffTask.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("action", "add");
        request.getRequestDispatcher("/WEB-INF/page/staffTask.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int taskId = Integer.parseInt(request.getParameter("id"));
        Task task = taskService.getTaskById(taskId);
        request.setAttribute("task", task);
        request.setAttribute("action", "update");
        request.getRequestDispatcher("/WEB-INF/page/staffTask.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String taskIdStr = request.getParameter("taskId");

        Task task = new Task();
        if (taskIdStr != null && !taskIdStr.isEmpty()) {
            task.setTaskId(Integer.parseInt(taskIdStr));
        }

        task.setTitle(request.getParameter("title"));
        task.setDescription(request.getParameter("description"));
        task.setAssignedTo(Integer.parseInt(request.getParameter("assignedTo")));
        task.setAssignedBy(Integer.parseInt(request.getParameter("assignedBy")));
        task.setDueDate(java.sql.Date.valueOf(request.getParameter("dueDate")));
        task.setStatus(request.getParameter("status"));
        task.setPriority(request.getParameter("priority"));
        task.setProgress(Integer.parseInt(request.getParameter("progress")));

        Timestamp now = new Timestamp(System.currentTimeMillis());
        task.setLastUpdatedAt(now);

        if ("add".equalsIgnoreCase(action)) {
            task.setCreatedAt(now);
            task.setCompletedAt(null);
            taskService.createTask(task);
        } else if ("update".equalsIgnoreCase(action)) {
            if ("Completed".equalsIgnoreCase(task.getStatus())) {
                task.setCompletedAt(now);
            } else {
                task.setCompletedAt(null);
            }
            taskService.updateTask(task);
        }

        response.sendRedirect("staffTask");
    }

    private void deleteTask(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int taskId = Integer.parseInt(request.getParameter("id"));
        taskService.deleteTask(taskId);
        response.sendRedirect("staffTask");
    }
}
