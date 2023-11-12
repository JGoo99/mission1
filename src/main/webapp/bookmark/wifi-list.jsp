<%@ page import="com.example.mission1.db.dbService.BookmarkDBService_W" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title> 즐겨찾기 목록 </title>
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
  <h1> 즐겨찾기 목록 </h1>
</div>

<div>
  <jsp:include page="/include/menu.jsp"/>
</div>

<%-- 즐겨찾기 목록 테이블 출력 --%>
<div>
<%  BookmarkDBService_W bsw = new BookmarkDBService_W(); %>
<%  ResultSet rs = null; %>
  
  <table style="margin-top: 20px">
    <tr>
      <th> ID </th>
      <th> 즐겨찾기 이름 </th>
      <th> 와이파이명 </th>
      <th> 등록일자 </th>
      <th> 비고 </th>
    </tr>
    
<%-- 즐겨찾기 목록이 없다면 --%>
<%  if (bsw.isEmpty()) { %>
    <tr>
      <td colspan="5" style="text-align:center; width: 30%"> 즐겨찾기를 추가해주세요. </td>
    </tr>

<%-- 즐겨찾기 목록 가져오기 --%>
<%
    } else {
      try {
        rs = bsw.getAll();
%>

<%-- 즐겨찾기 목록 출력 --%>
<%      while (rs.next()) { %>
    <tr>
      <td><%=rs.getString("id")%></td>
      <td><%=rs.getString("bookmark_name")%></td>
      <td>
        <%-- 와이파이 상세정보 --%>
        <a href="http://localhost:8080/wifi-detail.jsp?wifi_key=<%=rs.getString("wifi_key")%>"><%=rs.getString("wifi_name")%></a>
      </td>
      <td><%=rs.getString("add_datetime")%></td>
      <td>
        <%-- 삭제 버튼 --%>
        <input type="button" value="삭제" onclick="location.href='wifi-delete.jsp?id=<%=rs.getString("id")%>'">
      </td>
    </tr>
<%      }
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
