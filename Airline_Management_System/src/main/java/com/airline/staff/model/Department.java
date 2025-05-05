package com.airline.staff.model;

public class Department {
    private int departmentId;
    private String name;
    private Integer managerId;
    private String description;

    public Department() {}

    public Department(int departmentId, String name, Integer managerId, String description) {
        this.departmentId = departmentId;
        this.name = name;
        this.managerId = managerId;
        this.description = description;
    }

    public int getDepartmentId() { return departmentId; }
    public void setDepartmentId(int departmentId) { this.departmentId = departmentId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Integer getManagerId() { return managerId; }
    public void setManagerId(Integer managerId) { this.managerId = managerId; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
