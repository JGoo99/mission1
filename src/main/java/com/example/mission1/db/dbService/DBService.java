package com.example.mission1.db.dbService;

public interface DBService {
  String IP = "127.0.0.1";
  String dbName = "wifidb";
  String dbUrl = "jdbc:mariadb://" + IP + ":3306/" + dbName;
  String dbUserId = "wifiuser";
  String dbPwd = "wifi";
}
