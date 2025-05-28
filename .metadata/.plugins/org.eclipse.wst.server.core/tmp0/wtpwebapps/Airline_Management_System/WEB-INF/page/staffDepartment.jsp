<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h1 style="text-align:center;">Department Management</h1>

<div style="text-align:center; margin-bottom:20px;">
    <button onclick="document.getElementById('addForm').style.display='block';"
            style="padding:10px 20px; background-color:green; color:white; border:none; border-radius:5px; cursor:pointer;">
        Add Department
    </button>
</div>

<!-- ADD DEPARTMENT FORM (Initially Hidden) -->
<div id="addForm" style="display:none; width:400px; margin:auto; margin-bottom:30px;">
    <form action="department" method="post">
        <input type="hidden" name="action" value="add" />
        <div style="margin-bottom:10px;">
            <label>Name:</label>
            <input type="text" name="name" style="width:100%;" required />
        </div>
        <div style="margin-bottom:10px;">
            <label>Description:</label>
            <textarea name="description" style="width:100%;"></textarea>
        </div>
        <div style="text-align:center;">
            <button type="submit" style="background-color:blue; color:white; padding:5px 15px;">Save</button>
            <button type="button" onclick="document.getElementById('addForm').style.display='none';"
                    style="background-color:red; color:white; padding:5px 15px; margin-left:10px;">
                Cancel
            </button>
        </div>
    </form>
</div>

<!-- DEPARTMENT TABLE -->
<table border="1" style="width:80%; margin:auto; border-collapse:collapse;">
    <tr style="background-color:#f2f2f2;">
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="dept" items="${departmentList}">
        <tr>
            <td>${dept.departmentId}</td>
            <td>${dept.name}</td>
            <td>${dept.description}</td>
            <td>
                <a href="department?action=edit&id=${dept.departmentId}" style="color:blue;">Edit</a> |
                <form action="department" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete" />
                    <input type="hidden" name="id" value="${dept.departmentId}" />
                    <button type="submit" style="color:red; border:none; background:none; cursor:pointer;">Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>
