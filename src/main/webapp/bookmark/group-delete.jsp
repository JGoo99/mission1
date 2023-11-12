<%@ page import="com.example.mission1.db.dbService.BookmarkDBService_G" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.mission1.db.dbService.BookmarkDBService_W" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title> 즐겨찾기 그룹 삭제 </title>
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
	<h1> 즐겨찾기 그룹 삭제 </h1>
</div>

<div>
	<jsp:include page="/include/menu.jsp"/>
</div>

<% BookmarkDBService_G bsg = new BookmarkDBService_G(); %>
<% BookmarkDBService_W bsw = new BookmarkDBService_W(); %>
<% ResultSet rs = null; %>

<%-- group 식별 id로 해당 즐겨찾기그룹 가져오기 --%>
<%
	try {
		rs = bsg.getGroup(request.getParameter("id"));

		if (rs.next()) {
%>
<div>
	<table style="margin-top: 20px">
		<caption> 즐겨찾기 그룹을 삭제하시겠습니까? </caption>
		<tr>
			<th> 즐겨찾기 이름 </th>
			<td><%=rs.getString("bookmark_name")%>
			</td>
		</tr>
		<tr>
			<th> 즐겨찾기 순서 </th>
			<td><%=rs.getString("order_num")%>
			</td>
		</tr>
	</table>
</div>

<%-- 이전 페이지로 돌아가기 버튼, 삭제 버튼 --%>
<div style="display: block; margin-top: 10px; text-align: center">
  <button id="back"> 돌아가기 </button>
  <button id="delete_group"> 즐겨 찾기 그룹 삭제 </button>
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

<%-- 이전 페이지로 돌아가기 기능, 즐겨찾기 그룹 삭제 기능 구현 --%>
<div>
	<script>
		// 이전페이지로 돌아가기
		const back = document.getElementById("back");
		back.onclick = function () {
			window.location.href = "group-list.jsp";
		};
		
		// 즐겨찾기 그룹 식별 아이디랑 삭제 여부 url 로 전송
		const delete_group = document.getElementById("delete_group");
		const id = new URL(location.href).searchParams.get("id");
		
		delete_group.onclick = function () {
			window.location.href = "group-delete.jsp?id=" + encodeURIComponent(id) + "&delete=y"
		};
	</script>
	
<% String bookmarkGroupId = request.getParameter("id"); %>
<% String deleteYn = request.getParameter("delete"); %>

<% if ((bookmarkGroupId != null && !bookmarkGroupId.equals("")) && (deleteYn != null && !deleteYn.equals(""))) { %>

<%-- 삭제 여부 y -> 삭제 --%>
<% if (deleteYn.equals("y")) {
			bsw.deleteBeforeGroup(bookmarkGroupId); // 즐겨찾기 그룹에 해당하는 와이파이 전부 삭제
			bsg.delete(bookmarkGroupId);            // 즐겨찾기 그룹 삭제
%>

	<script>
		alert("삭제되었습니다.")
		location.href = 'http://localhost:8080/bookmark/group-list.jsp'
	</script>
<%
		}
	}
%>
</div>

</body>
</html>