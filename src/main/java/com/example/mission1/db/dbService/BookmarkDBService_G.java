package com.example.mission1.db.dbService;

import java.sql.*;

public class BookmarkDBService_G implements DBService {
  public BookmarkDBService_G() {
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

    String sql = " select count(*) from bookmark_group ";

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
  public void create(String bookmarkName, String orderNum) {
    Connection conn = null;
    PreparedStatement ps = null;

    String sql = " insert into bookmark_group (bookmark_name, order_num, add_datetime) values (?, ?, now()) ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
      ps.setString(1, bookmarkName);
      ps.setString(2, orderNum);

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
  public void edit(String bookmarkGroupId, String bookmarkName, String orderNum) {
    Connection conn = null;
    PreparedStatement ps = null;

    String sql = " update bookmark_group " +
            " set bookmark_name = ?, order_num = ?, edit_datetime = now() " +
            " where bookmark_group_id = ? ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
      ps.setString(1, bookmarkName);
      ps.setString(2, orderNum);
      ps.setString(3, bookmarkGroupId);

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
  public void delete(String bookmarkGroupId) {
    Connection conn = null;
    PreparedStatement ps = null;

    String sql = " delete from bookmark_group where bookmark_group_id = ? ";

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

    String sql = " select * from bookmark_group order by order_num; ";

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

  // id로 조회
  public ResultSet getGroup(String bookmarkGroupId) {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String sql = " select * from bookmark_group where bookmark_group_id = ? ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
      ps.setString(1, bookmarkGroupId);

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

  /////// 추가 시 /////

  // 동일한 즐겨찾기 이름 찾기
  public boolean isAlreadyName(String bookmarkName) {
    boolean isAlready = false;
    
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    String sql = " select count(*) from bookmark_group where bookmark_name = ? ";
    
    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
      ps.setString(1, bookmarkName);
      
      rs = ps.executeQuery();
      
      if (rs.next()) {
        if (!rs.getString("count(*)").equals("0")) {
          isAlready = true;
        }
      }
      
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
    return isAlready;
  }

  // 동일한 순서 찾기
  public boolean isAlreadyOrder(String orderNum) {
  boolean isAlready = false;
  
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  
  String sql = " select count(*) from bookmark_group where order_num = ? ";
  
  try {
    conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
    ps = conn.prepareStatement(sql);
    ps.setString(1, orderNum);
    
    rs = ps.executeQuery();
    
    if (rs.next()) {
      if (!rs.getString("count(*)").equals("0")) {
        isAlready = true;
      }
    }
    
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
  return isAlready;
}


  /////// 수정 시 /////
  // 동일한 즐겨찾기 이름 찾기
  public boolean isAlreadyName(String bookmarkGroupId, String bookmarkName) {
    boolean isAlready = false;

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String sql = " select count(*) from bookmark_group where bookmark_name = ? " +
            " and bookmark_group_id != ? ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
      ps.setString(1, bookmarkName);
      ps.setString(2, bookmarkGroupId);

      rs = ps.executeQuery();

      if (rs.next()) {
        if (!rs.getString("count(*)").equals("0")) {
          isAlready = true;
        }
      }

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
    return isAlready;
  }

  // 동일한 순서 찾기
  public boolean isAlreadyOrder(String bookmarkGroupId, String orderNum) {
    boolean isAlready = false;

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String sql = " select count(*) from bookmark_group where order_num = ? " +
            " and bookmark_group_id != ? ";

    try {
      conn = DriverManager.getConnection(dbUrl, dbUserId, dbPwd);
      ps = conn.prepareStatement(sql);
      ps.setString(1, orderNum);
      ps.setString(2, bookmarkGroupId);

      rs = ps.executeQuery();

      if (rs.next()) {
        if (!rs.getString("count(*)").equals("0")) {
          isAlready = true;
        }
      }

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
    return isAlready;
  }
}
