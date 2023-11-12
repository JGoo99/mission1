<%@ page import="com.example.mission1.db.dbService.BookmarkDBService_G" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.mission1.db.dbService.BookmarkDBService_W" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title> 즐겨찾기 삭제 </title>
  <style>
		table {
			width: 100%;
			border-top: 1px solid #444444;
			border-collapse: collapse;
			table-layout: fixed;
		}
		
		th, td {
			border: 1px solid #ddd;
			padding: 8px;
			font-size: 13px;
		}
		
		th {
			background-color: steelblue;
			text-align: center;
			color: white;
			width: 200px;
		}
		
		td {
			text-align: left;
		}
		
		caption {
			font-size: medium;
			padding: 4px;
			background: gainsboro;
			color: brown;
			font-weight: bold;
		}
		
		tr:nth-child(even) {
			background-color: #f2f2f2;
		}
  </style>
</head>

<body>

<div>
	<h1> 즐겨찾기 삭제 </h1>
</div>

<div>
	<jsp:include page="/include/menu.jsp"/>
</div>

<%-- 삭제할 와이파이 정보 테이블 --%>
<div>
<% 	BookmarkDBService_G bsg = new BookmarkDBService_G(); %>
<% 	BookmarkDBService_W bsw = new BookmarkDBService_W(); %>
<%	ResultSet rs = null; %>

<%-- 해당 즐겨찾기 정보 가져오기 --%>
<%
	try {
		rs = bsw.getGroup(request.getParameter("id"));
		
		if (rs.next()) {
%>
	
	<table style="margin-top: 20px">
		<caption> 해당 와이파이를 즐겨찾기에서 삭제하시겠습니까? </caption>
		<tr>
			<th> 즐겨찾기 그룹명 </th>
			<td><%=rs.getString("bookmark_name")%>
			</td>
		</tr>
		<tr>
			<th> 와이파이명 </th>
			<td><b><%=rs.getString("wifi_name")%>
			</b></td>
		</tr>
		<tr>
			<th> 주소 </th>
			<td><%=rs.getString("address")%>
			</td>
		</tr>
		<tr>
			<th> 등록일자 </th>
			<td><%=rs.getString("add_datetime")%>
			</td>
		</tr>
	</table>
	
<%-- 이전페이지로 돌아가기 버튼, 삭제 버튼 --%>
	<div style="display: block; margin-top: 10px; text-align: center">
		<button id="back"> 돌아가기 </button>
		<button id="delete_wifi"> 즐겨찾기에서 삭제 </button>
	</div>
	
<%
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if (rs != null && !rs.isClosed()) {
				rs.close();
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	%>
</div>

<%-- 삭제할 즐겨찾기의 정보를 url 파라미터로 전송 --%>
<div>
	<script>
		// 이전 페이지로 돌아가기
		const back = document.getElementById("back");
		back.onclick = function () {
			window.location.href = "wifi-list.jsp";
		};
		
		// 삭제할 즐겨찾기 정보 전송
		const delete_group = document.getElementById("delete_wifi");
		const id = new URL(location.href).searchParams.get("id");
		
		delete_group.onclick = function () {
			window.location.href = "wifi-delete.jsp?id=" + encodeURIComponent(id) + "&delete=y"
		};
	</script>
</div>

<%-- 즐겨찾기에서 와이아피 삭제 기능 구현 --%>
<div>
<%	String bookmarkWifiId = request.getParameter("id"); %>
<%	String deleteYn = request.getParameter("delete"); %>

<% 	if ((bookmarkWifiId != null && !bookmarkWifiId.equals("")) && (deleteYn != null && !deleteYn.equals(""))) { %>

<%-- 삭제 여부 : y -> 삭제 --%>
<%		if (deleteYn.equals("y")) {
			bsw.delete(bookmarkWifiId);
%>

<%-- 삭제 후 즐겨찾기 목록으로 이동 --%>
	<script>
		alert("삭제되었습니다.")
		location.href = 'http://localhost:8080/bookmark/wifi-list.jsp'
	</script>
	
<%
		}
	}
%>
</div>

</body>
</html>