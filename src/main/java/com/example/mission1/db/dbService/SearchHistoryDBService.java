package com.example.mission1.db.dbService;

import java.sql.*;

public class SearchHistoryDBService implements DBService {
  public SearchHistoryDBService() {
    try {
      Class.forName("org.mariadb.jdbc.Driver");
    } catch (ClassNotFoundException e) {
      throw new RuntimeException(e);
    }
  }

  // 테이블이 비어있는지 확인
  public boolean isEmpty(String LocationOrWifi) {
    boolean empty = true;

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    StringBuilder sb = new StringBuilder();
    sb.append(" select count(*) from search_history where wifi_key is ");
    if (LocationOrWifi.equals("Wifi")) {
      sb.append(" not ");
    }
    sb.append(" null ");

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sb.toString());

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


  ///// 위치 검색 기록 /////

  // 저장
  public void recordSearchHistory(String myLon, String myLat) {
    Connection conn = null;
    PreparedStatement ps = null;

    String sql = " insert into search_history (lon, lat, search_datetime) values (?, ?, now()) ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
      ps.setString(1, myLon);
      ps.setString(2, myLat);

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
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }
  }

  // 조회
  public ResultSet getSearchHistory() {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String sql =
            " select * from ( " +
                    "    select * from search_history " +
                    "    where wifi_key is null " +
                    "    group by lon, lat " +
                    " ) tb " +
                    " order by search_datetime desc " +
                    " limit 5 ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);

      rs = ps.executeQuery();

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
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }
    return rs;
  }

  // 삭제
  public void deleteSearchHistory(String myLon, String myLat) {
    Connection conn = null;
    PreparedStatement ps = null;

    String sql = " delete from search_history where lon = ? and lat = ? ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
      ps.setString(1, myLon);
      ps.setString(2, myLat);
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
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }
  }


  ///// 와이파이 상세정보 조회 기록 /////

  // 저장
  public void recordSearchHistory(String wifi_key) {
    Connection conn = null;
    PreparedStatement ps = null;

    String sql = " insert into search_history (wifi_key, search_datetime) values (?, now()) ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
      ps.setString(1, wifi_key);

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
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }
  }

  // 조회
  public ResultSet getSearchWifiHistory() {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String sql =
            " select wi.wifi_key, wi.wifi_name, wi.gu, wi.address1 as address, sh.search_datetime, sh.search_id " +
                    " from search_history sh " +
                    "    join wifi_info wi on sh.wifi_key = wi.wifi_key " +

                    " where (sh.wifi_key, sh.search_datetime) in ( " +
                    "    select wifi_key, max(search_datetime) as search_datetime " +
                    "    from search_history " +
                    "    group by wifi_key " +
                    "    ) " +

                    " order by sh.search_datetime desc " +
                    " limit 5 ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);

      rs = ps.executeQuery();

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
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }
    return rs;
  }

  // 삭제
  public void deleteSearchHistory(String wifi_key) {
    Connection conn = null;
    PreparedStatement ps = null;

    String sql = " delete from search_history where wifi_key = ? ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
      ps.setString(1, wifi_key);
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
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }
  }
}
