package com.college;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/students")
public class StudentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !Boolean.TRUE.equals(session.getAttribute("loggedIn"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Map<Integer, Student> students = new LinkedHashMap<>();
        String sql = "SELECT s.id, s.name, s.roll_number, s.course, " +
                "f.id AS file_id, f.original_name, f.file_type " +
                "FROM students s " +
                "LEFT JOIN student_files f ON s.id = f.student_id " +
                "ORDER BY s.id, f.id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int studentId = rs.getInt("id");
                Student student = students.get(studentId);
                if (student == null) {
                    student = new Student(
                            studentId,
                            rs.getString("name"),
                            rs.getString("roll_number"),
                            rs.getString("course"));
                    students.put(studentId, student);
                }
                int fileId = rs.getInt("file_id");
                if (!rs.wasNull()) {
                    StudentFile file = new StudentFile(
                            fileId,
                            rs.getString("original_name"),
                            rs.getString("file_type"));
                    student.addFile(file);
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Unable to retrieve student records from database.", e);
        }

        request.setAttribute("students", students.values());
        request.getRequestDispatcher("/students.jsp").forward(request, response);
    }
}
