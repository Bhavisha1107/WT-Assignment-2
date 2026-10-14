package com.college;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/file")
public class FileServlet extends HttpServlet {
    private static final Path UPLOAD_DIR =
            Paths.get("C:/studentportal-uploads")
                    .toAbsolutePath().normalize();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !Boolean.TRUE.equals(session.getAttribute("loggedIn"))) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int fileId;
        try {
            fileId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        String filePath = null;
        String fileType = null;
        String sql = "SELECT file_path, file_type FROM student_files WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, fileId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    filePath = rs.getString("file_path");
                    fileType = rs.getString("file_type");
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Unable to retrieve file.", e);
        }

        if (filePath == null || fileType == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        if (!fileType.equals("image/jpeg") &&
                !fileType.equals("image/png") &&
                !fileType.equals("application/pdf")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        Path fileName = Paths.get(filePath);
        if (fileName.isAbsolute() ||
                fileName.getNameCount() != 1 ||
                filePath.contains("/") ||
                filePath.contains("\\")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        Path fullPath = UPLOAD_DIR.resolve(fileName).normalize();
        if (!fullPath.startsWith(UPLOAD_DIR) || !Files.isRegularFile(fullPath)) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        response.setContentType(fileType);
        response.setHeader("X-Content-Type-Options", "nosniff");
        response.setContentLengthLong(Files.size(fullPath));

        try (InputStream in = Files.newInputStream(fullPath)) {
            in.transferTo(response.getOutputStream());
        }
    }
}
