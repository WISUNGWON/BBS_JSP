<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Web Site</title>
</head> 
<body>
	<h1>넘어왔다</h1>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('You Need to Login.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}         int bbsID = 0;
        if (request.getParameter("bbsID") != null){
            bbsID = Integer.parseInt(request.getParameter("bbsID"));
        }
        if (bbsID == 0) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('Invaild Access')");
            script.println("location.href = 'bbs.jsp'");
            script.println("</script>");
        } 
        Bbs bbs = new BbsDAO().getBbs(bbsID);
        if (!userID.equals(bbs.getUserID())) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('Invaild Access')");
            script.println("location.href = 'bbs.jsp'");
            script.println("</script>");
        } else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.delete(bbsID);
				if (result == -1){ // 데이터 베이스에 오류발생
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('Fail to Delete.')");	
					script.println("history.back()");	
					script.println("</script>");
				}
				else {   	
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
				}
		
		}	
	%>
</body>
</html>