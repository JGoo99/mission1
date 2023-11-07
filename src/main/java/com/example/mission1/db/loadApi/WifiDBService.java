package com.example.mission1.db.loadApi;

import com.example.mission1.db.DBDto.Wifi;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WifiDBService {
  String IP = "172.30.1.38";
  String dbName = "wifidb";
  String dbUrl = "jdbc:mariadb://" + IP + ":3306/" + dbName;
  String dbUserId = "wifiuser";
  String dbPwd = "wifi";

  // 전체 api 정보 다운로드
  public void dbLoad(List<Wifi> wifis) {
    try {
      Class.forName("org.mariadb.jdbc.Driver");
    } catch (ClassNotFoundException e) {
      throw new RuntimeException(e);
    }

    Connection connection = null;
    PreparedStatement preparedStatement = null;

    StringBuilder sb = new StringBuilder();
    sb.append(" insert into wifi_info ").append(" (wifi_key, gu, wifi_name, address1, address2, instl_floor, instl_type, instl_office, service, net_type, instl_year, inout_door, conn_env, lat, lon, work_datetime, location) ")
            .append(" values ");
    for (int i = 0; i < wifis.size(); i++) {
      sb.append(" (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, POINT( ? , ? ) ) ,");
    }
    sb.setLength(sb.length() - 1);

    String sql = sb.toString();

    try {
      connection = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      preparedStatement = connection.prepareStatement(sql);

      int num = 1;
      for (int i = 0; i < wifis.size(); i++) {
        Wifi wifi = wifis.get(i);

        preparedStatement.setString(num++, wifi.getWifi_key());
        preparedStatement.setString(num++, wifi.getGu());
        preparedStatement.setString(num++, wifi.getWifi_name());
        preparedStatement.setString(num++, wifi.getAddress1());
        preparedStatement.setString(num++, wifi.getAddress2());
        preparedStatement.setString(num++, wifi.getInstl_floor());
        preparedStatement.setString(num++, wifi.getInstl_type());
        preparedStatement.setString(num++, wifi.getInstl_office());
        preparedStatement.setString(num++, wifi.getService());
        preparedStatement.setString(num++, wifi.getNet_type());
        preparedStatement.setString(num++, wifi.getInstl_year());
        preparedStatement.setString(num++, wifi.getInout_door());
        preparedStatement.setString(num++, wifi.getConn_env());
        preparedStatement.setString(num++, wifi.getLat());
        preparedStatement.setString(num++, wifi.getLon());
        preparedStatement.setString(num++, wifi.getWork_datetime());
        preparedStatement.setString(num++, wifi.getLon());
        preparedStatement.setString(num++, wifi.getLat());
      }
      preparedStatement.executeUpdate();

    } catch (SQLException e) {
      throw new RuntimeException(e);
    } finally {

      try {
        if (connection != null && !connection.isClosed()) {
          connection.close();
        }
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }

      try {
        if (preparedStatement != null && !preparedStatement.isClosed()) {
          preparedStatement.close();
        }
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }
  }

  // 현재 table 이 비어있는지 확인
  public boolean isEmpty(String table) {
    boolean empty = true;

    try {
      Class.forName("org.mariadb.jdbc.Driver");
    } catch (ClassNotFoundException e) {
      throw new RuntimeException(e);
    }

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String sql = " select count(*) from " + table;

    try {
      connection = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = connection.prepareStatement(sql);

      rs = ps.executeQuery();

      if (rs.next()) {
        String str = rs.getString("count(*)");

        if (!str.equals("0")) {
          empty = false;
        }
      }

    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      try {
        if (rs != null && !rs.isClosed()) {
          rs.close();
        }
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
      try {
        if (ps != null && !ps.isClosed()) {
          ps.close();
        }
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
      try {
        if (connection != null && !connection.isClosed()) {
          connection.close();
        }
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }
    return empty;
  }

  // 테이블 데이터 전체 삭제
  public void deleteAll(String table) {
    try {
      Class.forName("org.mariadb.jdbc.Driver");
    } catch (ClassNotFoundException e) {
      throw new RuntimeException(e);
    }

    Connection connection = null;
    PreparedStatement ps = null;

    String sql = " delete from " + table;

    try {
      connection = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = connection.prepareStatement(sql);

      System.out.println(ps.executeUpdate() + "개 삭제 완료");

    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      try {
        if (ps != null && !ps.isClosed()) {
          ps.close();
        }
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
      try {
        if (connection != null && !connection.isClosed()) {
          connection.close();
        }
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }
  }


  // 내 위치와 가까운 20개의 와이파이 정보 리턴
  public ResultSet selectShortDistance(String myLon, String myLat) {
    List<Wifi> wifis = new ArrayList<>();

    try {
      Class.forName("org.mariadb.jdbc.Driver");
    } catch (ClassNotFoundException e) {
      throw new RuntimeException(e);
    }

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String sql = " select *, format(st_distance(location, point( ? , ? )), 4) as distance " +
            " from wifi_info " +
            " order by distance " +
            " limit 20 ";

    try {
      connection = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = connection.prepareStatement(sql);
      ps.setString(1, myLon);
      ps.setString(2, myLat);
      rs = ps.executeQuery();

    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      try {
        if (ps != null && !ps.isClosed()) {
          ps.close();
        }
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
      try {
        if (connection != null && !connection.isClosed()) {
          connection.close();
        }
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }
    return rs;
  }
}
