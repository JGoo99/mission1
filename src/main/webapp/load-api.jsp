<%@ page import="com.example.mission1.db.loadApi.WifiApi" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import="com.example.mission1.db.loadApi.WifiDBService" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Open Api 정보 가져오기</title>
</head>
<body>

    <div>
        <%
            WifiDBService ws = new WifiDBService();
            WifiApi wifiApi = new WifiApi();
            String table = " wifi_info ";

            try {
                if (!ws.isEmpty(table)) {
                    ws.deleteAll(table);
                }
                wifiApi.getApi();
        %>

        <h1 style="text-align: center; margin-top: 20px">
            <%=wifiApi.getTotalCnt()%>개의 WIFI 정보를 정상적으로 저장하였습니다.
        </h1>

        <%
            } catch (ParseException e) {
                e.printStackTrace();
            }
        %>
    </div>
    
    <div style="text-align: center">
        <a href="index.jsp">홈 으로 가기</a>
    </div>

</body>
</html>
