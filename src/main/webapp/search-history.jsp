<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.mission1.db.dbService.SearchHistoryDBService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title> 검색 기록 조회 </title>
  <style>
    table {
      width: 100%;
      border-top: 1px solid #444444;
      border-collapse: collapse;
      table-layout: fixed;
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
    
    caption {
      font-size: medium;
      padding: 4px;
      background: lightslategray;
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
<% SearchHistoryDBService hs = new SearchHistoryDBService(); %>
<% ResultSet rs = null; %>

<div>
  <h1> 검색 기록 조회 </h1>
</div>

<div>
  <jsp:include page="include/menu.jsp"/>
</div>


<%-- 위치 검색 기록 테이블 --%>
<% try { %>
<div>
  <table>
    <caption style="margin-top: 20px"><b> 위치 검색 기록 </b></caption>
    <tr>
      <th> ID</th>
      <th> X좌표(경도)</th>
      <th> Y좌표(위도)</th>
      <th> 검색일자</th>
      <th> 비고</th>
    </tr>
    
<%-- 위치 검색 기록이 없는 경우 --%>
<%  if (hs.isEmpty("Location")) { %>
    <tr>
      <td colspan="5" style="text-align:center; width: 30%"> 위치 검색 기록 정보가 없습니다.</td>
    </tr>
    
    <%-- 위치 검색 기록 출력 --%>
<%
    } else {
      rs = hs.getSearchHistory();
      while (rs.next()) {
%>
    <tr>
      <td><%=rs.getString("search_id")%>
      </td>
      <td><%=rs.getString("lon")%>
      </td>
      <td><%=rs.getString("lat")%>
      </td>
      <td><%=rs.getString("search_datetime")%>
      </td>
      <%-- 삭제 버튼 --%>
      <td><input type="button" value="삭제"
                 onclick="location.href='search-history.jsp?lon=<%=rs.getString("lon")%>&lat=<%=rs.getString("lat")%>'">
      </td>
    </tr>
<%
      }
    }
  } catch (SQLException e) {
    e.printStackTrace();
  }
%>
  </table>
</div>


<%--와이파이 상세정보 조회 기록 테이블--%>
<% hs = new SearchHistoryDBService(); %>
<% ResultSet rs2 = null; %>

<div>
  <table style="margin-top: 60px">
    <caption><b>와이파이 조회 기록</b></caption>
    <tr>
      <th>ID</th>
      <th>WIFI</th>
      <th>자치구</th>
      <th>도로명주소</th>
      <th>조회일자</th>
      <th>비고</th>
    </tr>
    
<% try { %>
<%-- 와이파이 상세정보 조회 기록이 없는 경우 --%>
<%      if (hs.isEmpty("Wifi")) { %>
    <tr>
      <td colspan="6" style="text-align:center; width: 30%"> 와이파이 상세정보 조회 기록 정보가 없습니다.</td>
    </tr>
    
<%-- 와이파이 상세정보 조회 기록 출력 --%>
<%      } else { %>
<%          rs2 = hs.getSearchWifiHistory(); %>
<%          while (rs2.next()) { %>
    <tr>
      <td><%=rs2.getString("search_id")%>
      </td>
      <td><%-- 와이파이 상세정보 버튼 --%>
        <a href="wifi-detail.jsp?wifi_key=<%=rs2.getString("wifi_key")%>"><%=rs2.getString("wifi_name")%>
        </a>
      </td>
      <td><%=rs2.getString("gu")%>
      </td>
      <td><%=rs2.getString("address")%>
      </td>
      <td><%=rs2.getString("search_datetime")%>
      </td>
      <%-- 삭제 버튼 --%>
      <td><input type="button" value="삭제"
                 onclick="location.href='search-history.jsp?wifi_key=<%=rs2.getString("wifi_key")%>'"></td>
    </tr>
    
<%          }
        }
    } catch (SQLException e) {
      e.printStackTrace();
    }
%>
  </table>
</div>


<%-- 기록 삭제 기능 구현 --%>
<div>
<% String myLon = request.getParameter("lon"); %>
<% String myLat = request.getParameter("lat"); %>
<% String wifi_key = request.getParameter("wifi_key"); %>

<%-- 위치 검색 기록 삭제 --%>
<% if ((myLon != null && myLat != null) && (!myLon.equals("") && !myLat.equals(""))) { %>
<% hs.deleteSearchHistory(myLon, myLat); %>
  <script>location.href = 'search-history.jsp';</script>
  
<%-- 와이파이 상세정보 조회 기록 삭제 --%>
<% } else if (wifi_key != null && !wifi_key.equals("")) { %>
<% hs.deleteSearchHistory(wifi_key); %>
  <script>location.href = 'search-history.jsp';</script>
<% } %>
</div>

</body>
</html>
