<%@ page import="com.example.mission1.db.loadApi.WifiApi" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import="com.example.mission1.db.dbService.WifiDBService" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
	<title> Open Api 정보 가져오기 </title>
</head>
<body>
<% WifiDBService ws = new WifiDBService(); %>
<% WifiApi wifiApi = new WifiApi(); %>

<% try { %>
<%-- 이미 db가 차있는 경우 --%>
<% if (!ws.isEmpty()) { %>
	<div>
		<script type="text/javascript">
			alert("이미 Open Api의 WIFI 정보를 저장하였습니다.");
			location.href = "index.jsp";
		</script>
	</div>
	
<%-- api 다운로드 --%>
<% } else { %>
<%		wifiApi.getApi(); %>

<%-- 다운로드 완료된 경우 --%>
	<div>
		<h1 style="text-align: center; margin-top: 20px">
			<%=wifiApi.getTotalCnt()%>개의 WIFI 정보를 정상적으로 저장하였습니다.
		</h1>
	</div>
	
	<div style="text-align: center">
		<a href="index.jsp"> 홈 으로 가기 </a>
	</div>

<%
		}
	} catch (ParseException e) {
		e.printStackTrace();
	}
%>
</body>
</html>
