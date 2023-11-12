<%@ page import="com.example.mission1.db.dbService.BookmarkDBService_G" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>즐겨찾기 그룹 관리</title>
	<style>
    table {
      width: 100%;
      border-top: 1px solid #444444;
      border-collapse: collapse;
    }
    
    th, td {
      border: 1px solid #ddd;
      text-align: center;
      padding: 8px;
      font-size: 13px;
    }
    
    th {
      background-color: steelblue;
      color: white;
    }
    
    tr:nth-child(even) {
      background-color: #f2f2f2;
    }
    
    tr:hover {
      background-color: #dfe2ec;
    }
	</style>
</head>

<body>

<div>
	<h1> 즐겨찾기 그룹 관리 </h1>
</div>

<div>
	<jsp:include page="/include/menu.jsp"/>
</div>

<%-- 즐겨찾기 그룹 추가 버튼 --%>
<div>
	<button style="margin-top: 20px;" onclick="location.href='group-add.jsp'">즐겨찾기 그룹 추가</button>
</div>

<%-- 즐겨찾기 테이블 출력 --%>
<div>
<%	BookmarkDBService_G bsg = new BookmarkDBService_G(); %>
<%	ResultSet rs = null; %>
	
	<table>
		<tr>
			<th>ID</th>
			<th>즐겨찾기 이름</th>
			<th>순서</th>
			<th>등록일자</th>
			<th>수정일자</th>
			<th>비고</th>
		</tr>
		
<%-- 즐겨찾기 그룹이 없는 경우 --%>
<%	if (bsg.isEmpty()) { %>
		<tr>
			<td colspan="6" style="text-align:center; width: 30%">즐겨찾기 그룹을 생성해주세요.</td>
		</tr>
		
<%-- 즐겨찾기 db 가져오기 --%>
<%
		} else {
			try {
				rs = bsg.getAll();
%>

<%-- 즐겨찾기 목록 출력 --%>
<%			while (rs.next()) { %>
		<tr>
			<td><%=rs.getString("bookmark_group_id")%>
			</td>
			<td><%=rs.getString("bookmark_name")%>
			</td>
			<td><%=rs.getString("order_num")%>
			</td>
			<td><%=rs.getString("add_datetime")%>
			</td>
			<td><%=(rs.getString("edit_datetime") != null) ? rs.getString("edit_datetime") : "not edited" %>
			</td>
			<td>
				<input type="button" value="수정"
							 onclick="location.href='group-edit.jsp?id=<%=rs.getString("bookmark_group_id")%>'">
				<input type="button" value="삭제"
							 onclick="location.href='group-delete.jsp?id=<%=rs.getString("bookmark_group_id")%>'">
			</td>
		</tr>
<%			}
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
		}
%>
	</table>
</div>

</body>
</html>
