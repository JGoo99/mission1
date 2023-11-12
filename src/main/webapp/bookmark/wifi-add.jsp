<%@ page import="com.example.mission1.db.dbService.BookmarkDBService_W" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title> 즐겨찾기 추가 </title>
</head>
<body>

<%-- 즐겨찾기 그룹에 와이파이 추가 기능 구현 --%>
<div>
<%	String id = request.getParameter("id"); %>
<%	String key = request.getParameter("wifi_key"); %>
<%	BookmarkDBService_W bs = new BookmarkDBService_W(); %>

<%-- url 파라미터로 값이 넘어오면 --%>
<%	if ((id != null && key != null) && !id.equals("") && !key.equals("")) { %>

<%-- 즐겨찾기에 추가 --%>
<%
		try {
			bs.add(id, key);
%>
	<%-- 즐겨찾기 목록 페이지로 이동 --%>
	<script>location.href='http://localhost:8080/bookmark/wifi-list.jsp'</script>

<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>
</div>

</body>
</html>
