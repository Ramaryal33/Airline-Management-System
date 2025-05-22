package com.airline.staff.model;

public class Department {
    private int departmentId;
    private String dname;
    private String description;

    public Department() {}

    public Department(int departmentId, String dname, String description) {
        this.departmentId = departmentId;
        this.dname = dname;
        this.description = description;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }

    public String getDname() {
        return dname;
    }

    public void setDname(String dname) {
        this.dname = dname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
