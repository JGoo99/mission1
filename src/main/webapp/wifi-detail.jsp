<%@ page import="com.example.mission1.db.dbService.WifiDBService" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.example.mission1.db.dbService.SearchHistoryDBService" %>
<%@ page import="com.example.mission1.db.dbService.BookmarkDBService_G" %>
<%@ page import="com.example.mission1.db.dbService.BookmarkDBService_W" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title> 와이파이 상세 정보 </title>
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
			font-size: 15px;
		}

		td {
			text-align: left;
		}

		th {
			background-color: steelblue;
			width: 200px;
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
  <h1 style="margin-top: 22px"> 와이파이 상세 정보 </h1>
</div>

<div>
  <jsp:include page="include/menu.jsp"/>
</div>

<%-- 즐겨찾기 그룹 선택하여 추가하는 기능 구현 --%>
<% BookmarkDBService_G bsg = new BookmarkDBService_G(); %>
<% ResultSet rs2 = null; %>

<div>
  <select id="bookmarkName">
    <option value=""> 즐겨찾기 그룹 이름 선택</option>
<%
	try {
		rs2 = bsg.getAll();
		while (rs2.next()) {
%>
		<%-- 노출값: 북마크 그룹 이름 / 데이터: 식별 id  --%>
    <option value="<%=rs2.getString("bookmark_group_id")%>"><%=rs2.getString("bookmark_name")%></option>
<%
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
  </select>
  <button type="button" onclick="addBookmark()"> 즐겨찾기 추가하기 </button>
	
	<%-- 식별 id와 wifi_key 를 url 파라미터로 전송 --%>
  <script type="text/javascript">
    function addBookmark() {
      var id = document.getElementById("bookmarkName").value;
      if (id === "") {
        alert("즐겨찾기 그룹을 선택해주세요.")
      } else {
        window.location.href = "http://localhost:8080/bookmark/wifi-add.jsp?wifi_key=<%=request.getParameter("wifi_key")%>&id=" + encodeURIComponent(id);
      }
    }
  </script>
</div>

<%-- 와이파이 상세 정보 출력 --%>
<div>
<% WifiDBService ws = new WifiDBService(); %>
<% SearchHistoryDBService hs = new SearchHistoryDBService(); %>
<% ResultSet rs = null; %>

<%
	try {
		rs = ws.getWifiInfo(request.getParameter("wifi_key"));
%>

<% 	if (rs.next()) { %>
  <table>
<% 	String distance = request.getParameter("distance"); %>

<%-- 위치 검색으로 상세정보에 접근한 경우 distance 출력 --%>
<% 	if (distance != null && !distance.equals("")) { %>
    <tr>
      <th> 거리(m) </th>
      <td><%=request.getParameter("distance")%>
      </td>
    </tr>
    
<% 	} %>
    
    <tr>
      <th> 관리번호 </th>
      <td><%=rs.getString("wifi_key")%>
      </td>
    </tr>
    <tr>
      <th> 자치구 </th>
      <td><%=rs.getString("gu")%>
      </td>
    </tr>
    <tr>
      <th> 와이파이명 </th>
      <td><b><%=rs.getString("wifi_name")%>
      </b>
      </td>
    </tr>
    <tr>
      <th> 도로명주소 </th>
      <td><%=rs.getString("address1")%>
      </td>
    </tr>
    <tr>
      <th> 상세주소 </th>
      <td><%=rs.getString("address2")%>
      </td>
    </tr>
    <tr>
      <th> 설치위치(층) </th>
      <td><%=rs.getString("instl_floor")%>
      </td>
    </tr>
    <tr>
      <th> 설치유형 </th>
      <td><%=rs.getString("instl_type")%>
      </td>
    </tr>
    <tr>
      <th> 설치기관 </th>
      <td><%=rs.getString("instl_office")%>
      </td>
    </tr>
    <tr>
      <th> 서비스구분 </th>
      <td><%=rs.getString("service")%>
      </td>
    </tr>
    <tr>
      <th> 망종류 </th>
      <td><%=rs.getString("net_type")%>
      </td>
    </tr>
    <tr>
      <th> 설치년도 </th>
      <td><%=rs.getString("instl_year")%>
      </td>
    </tr>
    <tr>
      <th> 실내외구분 </th>
      <td><%=rs.getString("inout_door")%>
      </td>
    </tr>
    <tr>
      <th> WIFI 접속환경 </th>
      <td><%=rs.getString("conn_env")%>
      </td>
    </tr>
    <tr>
      <th> Y좌표(경도) </th>
      <td><%=rs.getString("lat")%>
      </td>
    </tr>
    <tr>
      <th> X좌표(위도) </th>
      <td><%=rs.getString("lon")%>
      </td>
    </tr>
    <tr>
      <th> 작업일자 </th>
      <td><%=rs.getString("work_datetime")%>
      </td>
    </tr>
  </table>
<%	} %>
  
  <%--		상세 정보 조회 기록 저장--%>
<% 	hs.recordSearchHistory(rs.getString("wifi_key")); %>

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
%>
</div>
</body>
</html>
