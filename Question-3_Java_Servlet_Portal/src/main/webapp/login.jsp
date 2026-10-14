<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Portal Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background: linear-gradient(rgba(15, 23, 42, 0.45), rgba(15, 23, 42, 0.55)),
                        url('https://images.unsplash.com/photo-1541339907198-e08756dedf3f?auto=format&fit=crop&w=1600&q=80') center/cover no-repeat;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .login-card {
            background: #ffffff;
            padding: 40px 36px;
            width: 100%;
            max-width: 390px;
            border-radius: 16px;
            box-shadow: 0 20px 45px rgba(0, 0, 0, 0.25);
            text-align: center;
        }
        .portal-icon {
            font-size: 44px;
            color: #1d4ed8;
            margin-bottom: 12px;
        }
        h2 {
            font-size: 22px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 6px;
        }
        .subtitle {
            font-size: 13.5px;
            color: #64748b;
            margin-bottom: 24px;
        }
        .input-group {
            position: relative;
            margin-bottom: 16px;
            text-align: left;
        }
        .input-group span {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            font-size: 15px;
        }
        .input-group input {
            width: 100%;
            padding: 12px 14px 12px 42px;
            border: 1.5px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
            background: #f8fafc;
            transition: all 0.2s ease;
        }
        .input-group input:focus {
            outline: none;
            border-color: #2563eb;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }
        button {
            width: 100%;
            padding: 12px;
            background: #2563eb;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s ease;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }
        button:hover {
            background: #1d4ed8;
        }
        .demo-box {
            margin-top: 24px;
            padding-top: 18px;
            border-top: 1px dashed #e2e8f0;
            font-size: 12.5px;
            color: #64748b;
        }
        .demo-box strong {
            color: #1e293b;
        }
        .error-msg {
            background: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 13px;
            margin-bottom: 16px;
        }
    </style>
</head>
<body>
    <div class="login-card">
        <div class="portal-icon">&#127891;</div>
        <h2>Student Profile Portal</h2>
        <p class="subtitle">Login to view student profiles and documents</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error-msg">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="input-group">
                <span>&#128100;</span>
                <input type="text" name="username" placeholder="Username (admin)" required>
            </div>

            <div class="input-group">
                <span>&#128274;</span>
                <input type="password" name="password" placeholder="Password (admin123)" required>
            </div>

            <button type="submit">Login</button>
        </form>

        <div class="demo-box">
            <p><strong>Demo Credentials:</strong></p>
            <p>Username: <code>admin</code></p>
            <p>Password: <code>admin123</code></p>
        </div>
    </div>
</body>
</html>
