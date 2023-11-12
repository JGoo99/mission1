package com.example.mission1.db.dbService;

import java.sql.*;

public class BookmarkDBService_W implements DBService {
  public BookmarkDBService_W() {
    try {
      Class.forName("org.mariadb.jdbc.Driver");
    } catch (ClassNotFoundException e) {
      throw new RuntimeException(e);
    }
  }

  // table 비어있는지 확인
  public boolean isEmpty() {
    boolean empty = true;

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String sql = " select count(*) from bookmark_wifi ";

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

  // 저장
  public void add(String bookmarkGroupId, String wifiKey) {
    Connection conn = null;
    PreparedStatement ps = null;

    String sql = " insert into bookmark_wifi (bookmark_group_id, wifi_key, add_datetime) values (?, ?, now()) " ;

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
      ps.setString(1, bookmarkGroupId);
      ps.setString(2, wifiKey);

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

  // 수정
  public void edit(String bookmarkWifiId, String bookmarkGroupId) {
    Connection conn = null;
    PreparedStatement ps = null;

    String sql =
            " update bookmark_wifi set bookmark_group_id = ? where bookmark_wifi_id = ? ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
      ps.setString(1, bookmarkGroupId);
      ps.setString(2, bookmarkWifiId);

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

  // 삭제
  public void delete(String bookmarkWifiId) {
    Connection conn = null;
    PreparedStatement ps = null;

    String sql = " delete from bookmark_wifi where bookmark_wifi_id = ? ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
      ps.setString(1, bookmarkWifiId);

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

  // 즐겨찾기 그룹 내의 와이파이 전체 삭제
  public void deleteBeforeGroup(String bookmarkGroupId) {
    Connection conn = null;
    PreparedStatement ps = null;

    String sql = " delete from bookmark_wifi where bookmark_group_id = ? ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
      ps.setString(1, bookmarkGroupId);

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

  // 전체 조회
  public ResultSet getAll() {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String sql =
            " select " +
            " bw.bookmark_wifi_id as id, " +
            " bg.bookmark_name as bookmark_name, " +
            " wi.wifi_name as wifi_name, " +
            " bw.add_datetime as add_datetime, " +
            " wi.wifi_key as wifi_key " +
            "from bookmark_wifi bw " +
            "    join wifi_info wi on wi.wifi_key = bw.wifi_key " +
            "    join bookmark_group bg on bg.bookmark_group_id = bw.bookmark_group_id " +
            " order by bg.order_num ";

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

  // 그룹 id 로 조회
  public ResultSet getGroup(String bookmarkWifiId) {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String sql =
            " select bw.bookmark_wifi_id as id, bg.bookmark_name as bookmark_name, wi.wifi_name as wifi_name, " +
            "        bw.add_datetime as add_datetime, wi.address1 as address " +
            "from bookmark_wifi bw " +
            "    join wifi_info wi on wi.wifi_key = bw.wifi_key " +
            "    join bookmark_group bg on bg.bookmark_group_id = bw.bookmark_group_id " +
            " where bookmark_wifi_id = ? ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
      ps.setString(1, bookmarkWifiId);

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

}
