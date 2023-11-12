<%@ page import="com.example.mission1.db.dbService.BookmarkDBService_G" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title> 즐겨찾기 그룹 추가 </title>
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
	<h1> 즐겨찾기 그룹 추가 </h1>
</div>

<div>
	<jsp:include page="/include/menu.jsp"/>
</div>

<%-- 이름, 순서 input --%>
<div>
  <table style="margin-top: 20px">
    <tr>
      <th> 즐겨 찾기 이름 </th>
      <td><input type="text" value="${param.name}" id="bookmark_group_name"></td>
    </tr>
    <tr>
      <th> 즐겨 찾기 순서 </th>
      <td><input type="text" value="${param.order}" id="order_num"></td>
    </tr>
  </table>
</div>

<%-- 추가 버튼 --%>
<div style="margin: auto">
  <button style="display: block; margin: auto; margin-top: 20px" id="add_group"> 즐겨 찾기 추가</button>
</div>

<%-- 추가 버튼 클릭 시 url 파라미터로 값 넘기는 기능 구현 --%>
<div>
  <script>
    const add_group = document.getElementById("add_group");
    
    add_group.onclick = function () {
      const name = document.getElementById("bookmark_group_name");
      const order = document.getElementById("order_num");
      
      if (name.value !== "" && order.value !== "") {
        window.location.href = "http://localhost:8080/bookmark/group-add.jsp?name=" + encodeURIComponent(name.value) + "&order=" + encodeURIComponent(order.value);
      } else  {
        alert("즐겨찾기 이름/순서가 입력되지 않았습니다. 다시 입력해주세요.")
        location.reload();
      }
    };
  </script>
  
<%-- 즐겨찾기 이름, 순서 --%>
<%  BookmarkDBService_G bsg = new BookmarkDBService_G(); %>
<%  String bookmarkName = request.getParameter("name"); %>
<%  String orderNum = request.getParameter("order"); %>

<%  if (bookmarkName != null && orderNum != null) { %>

<%-- 같은 그룹명이 존재하는 경우 --%>
<%    if (bsg.isAlreadyName(bookmarkName)) { %>
  <script>
    alert("해당 즐겨찾기 그룹명이 이미 존재합니다.")
  </script>
  
<%-- 같은 순서가 존재하는 경우 --%>
<%    } else if (bsg.isAlreadyOrder(orderNum)) { %>
  <script>
    alert("해당 순서의 즐겨찾기 그룹이 이미 존재합니다.")
  </script>
  
<%-- 즐겨찾기 생성 --%>
<%    } else { %>
<%      bsg.create(bookmarkName, orderNum); %>
  <script type="text/javascript">
    alert("즐겨찾기 그룹이 추가되었습니다.")
    location.href = "group-list.jsp"
  </script>
<%
    }
  }
%>
</div>

</body>
</html>

