<%@ page import="com.example.mission1.db.dbService.WifiDBService" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.example.mission1.db.dbService.SearchHistoryDBService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title> WIFI 정보 구하기 </title>
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
<% WifiDBService ws = new WifiDBService(); %>
<% SearchHistoryDBService hs = new SearchHistoryDBService(); %>
<% String myLon = request.getParameter("lon"); %>
<% String myLat = request.getParameter("lat"); %>

<div>
  <h1> 와이파이 정보 구하기 </h1>
</div>

<%-- 메뉴바 --%>
<div>
  <jsp:include page="include/menu.jsp"/>
</div>

<%-- 경도 위도 위치가져오기버튼 검색버튼 --%>
<div style="display:flex; align-items: center; margin-top: 20px">
  <%-- 경도 --%>
  <label for="lon"><b>LON</b>:</label>
  <input type="text" placeholder="0.0" value="${param.lon}" id="lon" name="lon"
         style="width:120px; height:14px; font-size:15px;"/>
  
  <span style="margin-right:3px">,</span>
  
  <%-- 위도 --%>
  <label for="lat"><b>LAT</b>:</label>
  <input type="text" placeholder="0.0" value="${param.lat}" id="lat" name="lat"
         style="width:120px; height:14px; font-size:15px;"/>
    
  <%-- 버튼 --%>
  <section style="margin-left:5px">
    <button id="myLocation"> 내 위치 가져오기</button>
    
    <button id="searchWifi"> 근처 WIFI 정보 보기</button>
    
    <script src="jsFile/location.js"></script>
  </section>
</div>

<%-- 가까운 와이파이 20개 보여주기 테이블 --%>
<div>
  <table style="margin-top: 5px; table-layout: fixed; word-break: break-all; height: auto">
    <tr style="font-size: 14px">
      <th style="width: 46px"> 거리(m)</th>
      <th style="width: 55px"> 관리번호</th>
      <th style="width: 40px"> 자치구</th>
      <th style="width: 170px"> 와이파이명</th>
      <th> 도로명주소</th>
      <th> 상세주소</th>
      <th> 설치위치(층)</th>
      <th> 설치유형</th>
      <th> 설치기관</th>
      <th> 서비스구분</th>
      <th> 망종류</th>
      <th style="width: 30px"> 설치년도</th>
      <th style="width: 35px"> 실내외구분</th>
      <th> WIFI<br>접속환경</th>
      <th> X좌표(경도)</th>
      <th> Y좌표(위도)</th>
      <th style="width: 64px"> 작업일자</th>
    </tr>
    
<%-- 위치정보 입력 안 한 경우 --%>
<% if ((myLon == null || myLat == null) || (myLon.equals("") || myLat.equals(""))) { %>
    <tr>
      <td colspan="17" style="text-align:center; width: 30%"> 위치 정보를 입력한 후에 조회해 주세요.</td>
    </tr>
    
<%-- api 다운받지 않은 경우 --%>
<% } else { %>
<%    if (ws.isEmpty()) { %>
    <tr>
      <td colspan="17" style="text-align:center; width: 30%">
        <a href="load-api.jsp"> Open Api 정보 가져오기 </a>를 클릭 후 와이파이 정보를 다운로드 받아주세요.
      </td>
    </tr>
    
    <script> alert("Open Api 정보가 없습니다.") </script>
    
<%    } else {
        ResultSet rs = null;
        try {
          rs = ws.selectShortDistance(myLon, myLat);
%>
    
    <%-- 와이파이 목록 20개 출력 --%>
<%        while (rs.next()) { %>
    <tr>
      <td><%=rs.getString("distance")%>
      </td>
      <td><%=rs.getString("wifi_key")%>
      </td>
      <td><%=rs.getString("gu")%>
      </td>
      <td>
        <%-- 와이파이 상세정보 --%>
        <a
          href="wifi-detail.jsp?wifi_key=<%=rs.getString("wifi_key")%>&distance=<%=rs.getString("distance")%>"><%=rs.getString("wifi_name")%>
        </a>
      </td>
      <td><%=rs.getString("address1")%>
      </td>
      <td><%=rs.getString("address2")%>
      </td>
      <td><%=rs.getString("instl_floor")%>
      </td>
      <td><%=rs.getString("instl_type")%>
      </td>
      <td><%=rs.getString("instl_office")%>
      </td>
      <td><%=rs.getString("service")%>
      </td>
      <td><%=rs.getString("net_type")%>
      </td>
      <td><%=rs.getString("instl_year")%>
      </td>
      <td><%=rs.getString("inout_door")%>
      </td>
      <td><%=rs.getString("conn_env")%>
      </td>
      <td><%=rs.getString("lon")%>
      </td>
      <td><%=rs.getString("lat")%>
      </td>
      <td><%=rs.getString("work_datetime")%>
      </td>
    </tr>
<%        } %>

<%-- 위치 검색 기록 저장 --%>
<%        hs.recordSearchHistory(myLon, myLat); %>

<%
        } catch (Exception e) {
           e.printStackTrace();
        } finally {
          try {
            if (rs != null && !rs.isClosed()) {
              rs.close();
            }
          } catch (Exception e) {
            e.printStackTrace();
          }
        }
      }
    }
%>
  </table>
  <br><br>
</div>

</body>
</html>