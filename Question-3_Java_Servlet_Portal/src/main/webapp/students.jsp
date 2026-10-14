<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile Portal</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background: #f1f5f9;
            color: #1e293b;
        }
        .navbar {
            background: #1d4ed8;
            color: white;
            padding: 14px 28px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .nav-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 19px;
            font-weight: 700;
        }
        .user-nav {
            font-size: 14px;
        }
        .user-nav a {
            color: #e0e7ff;
            text-decoration: none;
            margin-left: 12px;
            font-weight: 600;
        }
        .user-nav a:hover {
            color: #ffffff;
            text-decoration: underline;
        }
        .layout {
            display: flex;
            min-height: calc(100vh - 60px);
        }
        .sidebar {
            width: 220px;
            background: #ffffff;
            border-right: 1px solid #e2e8f0;
            padding: 24px 0;
        }
        .sidebar-menu {
            list-style: none;
        }
        .sidebar-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 24px;
            color: #475569;
            text-decoration: none;
            font-weight: 600;
            font-size: 14.5px;
            transition: all 0.2s;
        }
        .sidebar-item:hover, .sidebar-item.active {
            background: #eff6ff;
            color: #1d4ed8;
            border-left: 4px solid #1d4ed8;
        }
        .main-content {
            flex: 1;
            padding: 30px;
            overflow-y: auto;
        }
        .content-header {
            margin-bottom: 24px;
        }
        .content-header h2 {
            font-size: 22px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 16px;
        }
        .search-bar {
            display: flex;
            gap: 10px;
            max-width: 600px;
            margin-bottom: 24px;
        }
        .search-bar input {
            flex: 1;
            padding: 10px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
            background: #fff;
        }
        .search-bar input:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37,99,235,0.15);
        }
        .search-bar button {
            padding: 10px 22px;
            background: #1d4ed8;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
        }
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 20px;
        }
        .student-card {
            background: #ffffff;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border: 1px solid #e2e8f0;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .avatar {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            object-fit: cover;
            margin: 0 auto 12px;
            border: 3px solid #dbeafe;
        }
        .avatar-fallback {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            margin: 0 auto 12px;
            background: #e0e7ff;
            color: #3730a3;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            font-weight: bold;
        }
        .student-card h3 {
            font-size: 17px;
            color: #0f172a;
            margin-bottom: 6px;
        }
        .student-card .info {
            font-size: 13.5px;
            color: #64748b;
            margin-bottom: 4px;
        }
        .badge {
            display: inline-block;
            background: #eff6ff;
            color: #1d4ed8;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            margin: 8px 0 14px;
        }
        .card-btn {
            background: #1d4ed8;
            color: #ffffff;
            padding: 9px 16px;
            border-radius: 7px;
            text-decoration: none;
            font-size: 13.5px;
            font-weight: 600;
            margin-top: 12px;
            display: block;
            transition: background 0.2s;
        }
        .card-btn:hover {
            background: #1e40af;
        }
        .docs-list {
            margin-top: 10px;
            text-align: left;
            border-top: 1px solid #f1f5f9;
            padding-top: 10px;
            font-size: 12.5px;
        }
        .docs-list a {
            color: #2563eb;
            text-decoration: none;
            display: block;
            margin-top: 4px;
            word-break: break-all;
        }
        .docs-list a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <header class="navbar">
        <div class="nav-brand">
            <span>&#127891;</span> Student Profile Portal
        </div>
        <div class="user-nav">
            Welcome, <strong><c:out value="${sessionScope.username}"/></strong> |
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </header>

    <div class="layout">
        <aside class="sidebar">
            <ul class="sidebar-menu">
                <li><a href="#" class="sidebar-item active">&#128101; Students</a></li>
                <li><a href="#" class="sidebar-item">&#128196; Documents</a></li>
                <li><a href="#" class="sidebar-item">&#128100; Profile</a></li>
            </ul>
        </aside>

        <main class="main-content">
            <div class="content-header">
                <h2>Student Profiles</h2>
                <div class="search-bar">
                    <input type="text" placeholder="Search by name or roll number...">
                    <button type="button">Search</button>
                </div>
            </div>

            <c:if test="${empty students}">
                <div style="background:white; padding:30px; border-radius:10px; text-align:center; color:#64748b;">
                    No student records found in the portal.
                </div>
            </c:if>

            <div class="grid">
                <c:forEach var="student" items="${students}">
                    <div class="student-card">
                        <div>
                            <!-- Check for profile image -->
                            <c:set var="hasImage" value="false"/>
                            <c:forEach var="file" items="${student.files}">
                                <c:if test="${(file.fileType == 'image/jpeg' || file.fileType == 'image/png') and !hasImage}">
                                    <img src="${pageContext.request.contextPath}/file?id=${file.id}"
                                         alt="Profile photo" class="avatar">
                                    <c:set var="hasImage" value="true"/>
                                </c:if>
                            </c:forEach>
                            <c:if test="${not hasImage}">
                                <div class="avatar-fallback">
                                    ${student.name.substring(0, 1)}
                                </div>
                            </c:if>

                            <h3><c:out value="${student.name}"/></h3>
                            <p class="info">Roll No: <strong><c:out value="${student.rollNumber}"/></strong></p>
                            <span class="badge"><c:out value="${student.course}"/></span>

                            <!-- PDF Documents -->
                            <div class="docs-list">
                                <strong>Documents:</strong>
                                <c:set var="docFound" value="false"/>
                                <c:forEach var="file" items="${student.files}">
                                    <c:if test="${file.fileType == 'application/pdf'}">
                                        <c:set var="docFound" value="true"/>
                                        <a href="${pageContext.request.contextPath}/file?id=${file.id}" target="_blank">
                                            &#128196; <c:out value="${file.originalName}"/>
                                        </a>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${not docFound}">
                                    <p style="color:#94a3b8; font-style:italic;">No certificates uploaded</p>
                                </c:if>
                            </div>
                        </div>

                        <a href="#" class="card-btn">View Profile</a>
                    </div>
                </c:forEach>
            </div>
        </main>
    </div>
</body>
</html>
