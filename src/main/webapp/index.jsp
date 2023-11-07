<%@ page import="com.example.mission1.db.loadApi.WifiDBService" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            table-layout: fixed;
        }

        th, td {
            border: 1px solid #ddd;
            text-align: center;
            padding: 8px;
            font-size: 13px;
        }

        th {
            background-color: #04AA6D;
            color: white;
        }

        tr:hover {background-color: #f2f2f2;}
    </style>
</head>
<body>
    <div>
        <h1>와이파이 정보 구하기</h1>
    </div>

    <div>
        <a href="index.jsp">홈</a> |
        <a href="history.jsp">위치 히스토리 목록</a> |
        <a href="load-api.jsp">Open Api 정보 가져오기</a> |
        <a href="bookmark.jsp">즐겨 찾기 보기</a> |
        <a href="bookmark-group.jsp">즐겨 찾기 그룹 관리</a>
    </div>

    <div style="display:flex; align-items: center; margin-top: 20px">
        <label for="lon"><b>LON</b>:</label>
        <input type="text" placeholder="0.0" value="${param.lon}" id="lon" name="lon" style="width:120px; height:14px; font-size:15px;" />

        <span style="margin-right:3px">,</span>

        <label for="lat"><b>LAT</b>:</label>
        <input type="text" placeholder="0.0" value="${param.lat}" id="lat" name="lat" style="width:120px; height:14px; font-size:15px;" />

        <section style="margin-left:5px">
            <button id = "myLocation">내 위치 가져오기</button>

            <button id="searchWifi">근처 WIFI 정보 보기</button>

            <script src="location.js"></script>
        </section>
    </div>

    <div>
        <table style="margin-top: 5px; table-layout: fixed; word-break: break-all; height: auto">
            <thead>
                <tr style="font-size: 14px";>
                    <th style="width: 46px">거리(m)</th>
                    <th>관리번호</th>
                    <th>자치구</th>
                    <th>와이파이명</th>
                    <th>도로명주소</th>
                    <th>상세주소</th>
                    <th>설치위치(층)</th>
                    <th>설치유형</th>
                    <th>설치기관</th>
                    <th>서비스구분</th>
                    <th>망종류</th>
                    <th>설치년도</th>
                    <th>실내외구분</th>
                    <th>WIFI<br>접속환경</th>
                    <th>Y좌표</th>
                    <th>X좌표</th>
                    <th>작업일자</th>
                </tr>
            </thead>
            <%
                WifiDBService ws = new WifiDBService();

                String myLon = request.getParameter("lon");
                String myLat = request.getParameter("lat");

                if (myLon == null || myLat == null) {
            %>

            <tfoot>
            <tr>
                <td colspan="17" style="text-align:center; width: 30%">위치 정보를 입력한 후에 조회해 주세요.</td>
            </tr>
            </tfoot>

            <%

                } else {

                    if (ws.isEmpty(" wifi_info ")) {

            %>

            <tfoot>
            <tr>
                <td colspan="17" style="text-align:center; width: 30%">
                    <a href="load-api.jsp">Open Api 정보 가져오기</a>를 클릭 후 와이파이 정보를 다운로드 받아주세요.
                </td>
            </tr>
            </tfoot>

            <%

                    } else {

                        out.print("<tbody>");

                        ResultSet rs = ws.selectShortDistance(myLon, myLat);
                        try {
                            while (rs.next()) {

        %>
            <tr>
            <td><%=rs.getString("distance")%></td>
            <td><%=rs.getString("wifi_key")%></td>
            <td><%=rs.getString("gu")%></td>
            <td><%=rs.getString("wifi_name")%></td>
            <td><%=rs.getString("address1")%></td>
            <td><%=rs.getString("address2")%></td>
            <td><%=rs.getString("instl_floor")%></td>
            <td><%=rs.getString("instl_type")%></td>
            <td><%=rs.getString("instl_office")%></td>
            <td><%=rs.getString("service")%></td>
            <td><%=rs.getString("net_type")%></td>
            <td><%=rs.getString("instl_year")%></td>
            <td><%=rs.getString("inout_door")%></td>
            <td><%=rs.getString("conn_env")%></td>
            <td><%=rs.getString("lat")%></td>
            <td><%=rs.getString("lon")%></td>
            <td><%=rs.getString("work_datetime")%></td>
            </tr>
        <%
                            }
                            out.print("</tbody>");
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
        %>
        </table>
        <br><br>
    </div>

</body>
</html>