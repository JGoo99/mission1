<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #ddd;
            text-align: center;
            padding: 8px;
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
        <a href="wifi-api.jsp">Open Api 정보 가져오기</a> |
        <a href="bookmark.jsp">즐겨 찾기 보기</a> |
        <a href="bookmark-group.jsp">즐겨 찾기 그룹 관리</a>
    </div>

    <div style="display:flex; align-items: center; margin-top: 20px">
        <section>
            <label>
                <b>LAT</b>: <input type="text" value="0.0" id="lat" style="width:120px; height:14px; font-size:15px;" />
            </label>
            <span style="margin-right:3px">,</span>
            <label>
                <b>LNT</b>: <input type="text" value="0.0" id="lon" style="width:120px; height:14px; font-size:15px;" />
            </label>
        </section>


        <section style="margin-left:5px">
            <button onclick="searchLocation()">내 위치 가져오기</button>
            <script src="location.js"></script>

            <button>근처 WIFI 정보 보기</button>
        </section>
    </div>

    <div>
        <table style="margin-top: 5px">
            <thead>
                <tr style="font-size: 14px">
                    <th>거리(Km)</th>
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
                    <th>WIFI 접속환경</th>
                    <th>Y좌표</th>
                    <th>X좌표</th>
                    <th>작업일자</th>
                </tr>
            </thead>
            <tbody>

            </tbody>
            <tfoot>
                <tr>
                    <td colspan="17" style="text-align:center; width: 30%">위치 정보를 입력한 후에 조회해 주세요.</td>
                </tr>
            </tfoot>
        </table>
    </div>

</body>
</html>