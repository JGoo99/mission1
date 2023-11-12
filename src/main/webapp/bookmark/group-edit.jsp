<%@ page import="com.example.mission1.db.dbService.BookmarkDBService_G" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title> 즐겨찾기 그룹 수정 </title>
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
			background: lightslategray;
			color: white;
		}
		
		tr:nth-child(even) {
			background-color: #f2f2f2;
		}
  </style>
</head>
<body>

<div>
	<h1> 즐겨찾기 그룹 수정 </h1>
</div>

<div>
	<jsp:include page="/include/menu.jsp"/>
</div>

<%-- 수정 정보 입력 테이블 --%>
<div>
<% BookmarkDBService_G bsg = new BookmarkDBService_G(); %>
<% ResultSet rs = null; %>

<%
  try {
    rs = bsg.getGroup(request.getParameter("id"));
    
    if (rs.next()) {
%>
  
  <%-- 수정할 데이터 입력 --%>
  <table style="margin-top: 20px">
    <tr>
      <th> 즐겨 찾기 이름</th>
      <td><input type="text" value="<%=rs.getString("bookmark_name")%>" id="bookmark_group_name"></td>
    </tr>
    <tr>
      <th> 즐겨 찾기 순서</th>
      <td><input type="text" value="<%=rs.getString("order_num")%>" id="order_num"></td>
    </tr>
  </table>
  
  <%-- 이전 페이지로 돌아가기 버튼, 수정 버튼 --%>
  <div style="display: block; margin-top: 10px; text-align: center">
    <button id="back"> 돌아가기</button>
    <button id="edit_group"> 즐겨 찾기 그룹 수정</button>
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

<%-- 수정 데이터를 url 파라미터로 전송 --%>
<div>
  <script>
    // 이전페이지로 돌아가기
    const back = document.getElementById("back");
    back.onclick = function () {
      window.location.href = "group-list.jsp";
    };
    
    // 수정할 즐겨찾기 그룹 식별 id / 그룹 이름 / 순서를 받아서 넘김
    const edit_group = document.getElementById("edit_group");
    const name = document.getElementById("bookmark_group_name");
    const order = document.getElementById("order_num");
    
    edit_group.onclick = function () {
      const id = new URL(location.href).searchParams.get("id");
      
      if (name.value !== "" && order.value !== "") {
        window.location.href = "http://localhost:8080/bookmark/group-edit.jsp?name=" + encodeURIComponent(name.value) + "&order=" + encodeURIComponent(order.value) + "&id=" + encodeURIComponent(id);
      } else {
        alert("즐겨찾기 이름/순서가 입력되지 않았습니다. 다시 입력해주세요.")
        location.reload();
      }
    };
  </script>
</div>

<%-- 즐겨찾기 (이름, 순서) 수정 기능 구현 --%>
<div>
<%  String bookmarkGroupId = request.getParameter("id"); %>
<%  String bookmarkName = request.getParameter("name"); %>
<%  String orderNum = request.getParameter("order"); %>

<%  if ((bookmarkGroupId != null && !bookmarkGroupId.equals("")) && bookmarkName != null && orderNum != null) { %>

<%-- 해당 즐겨찾기 제외, 같은 이름이 존재하는 경우 --%>
<%    if (bsg.isAlreadyName(bookmarkGroupId, bookmarkName)) { %>
  <script>
    alert("해당 즐겨찾기 그룹명이 이미 존재합니다.")
    name.value = "";
    name.focus();
  </script>
  
<%-- 해당 즐겨찾기 제외, 같은 순서가 존재하는 경우 --%>
<%    } else if (bsg.isAlreadyOrder(bookmarkGroupId, orderNum)) { %>
  <script>
    alert("해당 순서의 즐겨찾기 그룹이 이미 존재합니다.")
    order.value = "";
    order.focus();
  </script>
  
<%-- 즐겨찾기 수정 --%>
<%
      } else {
        bsg.edit(bookmarkGroupId, bookmarkName, orderNum);
%>
  <script>
    alert("즐겨찾기 그룹이 수정되었습니다.")
    location.href = "group-list.jsp"
  </script>
<%
    }
  }
%>
</div>

</body>
</html>
