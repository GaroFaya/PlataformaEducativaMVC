<%
    if (session.getAttribute("rol") == null || !"admin".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
    }
%>
