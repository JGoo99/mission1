package com.example.mission1.db.dbService;

import com.example.mission1.db.loadApi.Wifi;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WifiDBService implements DBService {
  public WifiDBService() {
    try {
      Class.forName("org.mariadb.jdbc.Driver");
    } catch (ClassNotFoundException e) {
      throw new RuntimeException(e);
    }

  }

  // 전체 api 정보 다운로드
  public void dbLoad(List<Wifi> wifis) {
    Connection conn = null;
    PreparedStatement ps = null;

    StringBuilder sb = new StringBuilder();
    sb.append(" insert into wifi_info ").append(" (wifi_key, gu, wifi_name, address1, address2, instl_floor, instl_type, instl_office, service, net_type, instl_year, inout_door, conn_env, lon, lat, work_datetime, coordinate) ")
            .append(" values ");
    for (int i = 0; i < wifis.size(); i++) {
      sb.append(" (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, POINT( ? , ? ) ) ,");
    }
    sb.setLength(sb.length() - 1);

    String sql = sb.toString();

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);

      int num = 1;
      for (int i = 0; i < wifis.size(); i++) {
        Wifi wifi = wifis.get(i);

        ps.setString(num++, wifi.getWifi_key());
        ps.setString(num++, wifi.getGu());
        ps.setString(num++, wifi.getWifi_name());
        ps.setString(num++, wifi.getAddress1());
        ps.setString(num++, wifi.getAddress2());
        ps.setString(num++, wifi.getInstl_floor());
        ps.setString(num++, wifi.getInstl_type());
        ps.setString(num++, wifi.getInstl_office());
        ps.setString(num++, wifi.getService());
        ps.setString(num++, wifi.getNet_type());
        ps.setString(num++, wifi.getInstl_year());
        ps.setString(num++, wifi.getInout_door());
        ps.setString(num++, wifi.getConn_env());
        ps.setString(num++, wifi.getLon());
        ps.setString(num++, wifi.getLat());
        ps.setString(num++, wifi.getWork_datetime());
        ps.setString(num++, wifi.getLon());
        ps.setString(num++, wifi.getLat());
      }
      ps.executeUpdate();

    } catch (SQLException e) {
      throw new RuntimeException(e);
    } finally {

      try {
        if (conn != null && !conn.isClosed()) {
          conn.close();
        }

        if (ps != null && !ps.isClosed()) {
          ps.close();
        }

        if (ps != null && !ps.isClosed()) {
          ps.close();
        }

      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }
  }

  // table 비어있는지 확인
  public boolean isEmpty() {
    boolean empty = true;

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String sql = " select count(*) from wifi_info ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);

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
        if (ps != null && !ps.isClosed()) {
          ps.close();
        }
        if (conn != null && !conn.isClosed()) {
          conn.close();
        }

      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }
    return empty;
  }

  // 조회
  public ResultSet selectShortDistance(String myLon, String myLat) {
    List<Wifi> wifis = new ArrayList<>();

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String sql = " select *, format(st_distance(coordinate, point( ? , ? )), 4) as distance " +
            " from wifi_info " +
            " order by distance " +
            " limit 20 ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
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
        if (conn != null && !conn.isClosed()) {
          conn.close();
        }
        if (rs != null && !rs.isClosed()) {
          rs.close();
        }
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }

    return rs;
  }

  // 상세 정보 조회
  public ResultSet getWifiInfo(String wifi_key) {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String sql = " select * from wifi_info where wifi_key = ? ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
      ps.setString(1, wifi_key);

      rs = ps.executeQuery();

    } catch (SQLException e) {
      throw new RuntimeException(e);
    } finally {
      try {
        if (ps != null && !ps.isClosed()) {
          ps.close();
        }
        if (conn != null && !conn.isClosed()) {
          conn.close();
        }
        if (rs != null && !rs.isClosed()) {
          rs.close();
        }
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }

    return rs;
  }
}
