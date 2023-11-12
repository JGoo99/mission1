package com.example.mission1.db.loadApi;

import com.example.mission1.db.dbService.WifiDBService;
import com.google.gson.Gson;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class WifiApi {
  private final String KEY = "4c49685462676f6f39387877437344";
  public String getKEY() {
    return KEY;
  }
  public int getTotalCnt() throws ParseException {
    URL url = null;
    HttpURLConnection con = null;
    StringBuilder sb = new StringBuilder();
    JSONObject result = null;

    String apiUrl = "http://openapi.seoul.go.kr:8088/" + KEY + "/json/TbPublicWifiInfo/1/1/";

    try {
      url = new URL(apiUrl);
      con = (HttpURLConnection) url.openConnection();
      con.setRequestMethod("GET");
      con.setRequestProperty("Content-type", "application/json");
      con.setDoOutput(true);

      BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
      while (br.ready()) {
        sb.append(br.readLine());
      }
      con.disconnect();

    } catch (Exception e) {
      e.printStackTrace();
    }

    result = (JSONObject) new JSONParser().parse(sb.toString());

    JSONObject data = (JSONObject) result.get("TbPublicWifiInfo");
    int total = Integer.parseInt(data.get("list_total_count").toString());

    return total;
  }

  public void getApi() throws ParseException {
    URL url = null;
    HttpURLConnection con = null;
    StringBuilder sb = null;
    JSONObject result = null;
    WifiDBService ws = new WifiDBService();
    int size = 1000;

    int start = 0;
    int end = 0;

    int totalCnt = getTotalCnt();
    int pageEnd = totalCnt / size;
    int pageRemain = totalCnt % size;

    for (int i = 0; i < pageEnd + 1; i++) {
      start = size * i + 1;
      end = size * (i + 1);

      if (i == pageEnd) {
        end = start + pageRemain - 1;
      }
      String apiUrl = "http://openapi.seoul.go.kr:8088/" + getKEY() + "/json/TbPublicWifiInfo/"
              + start + "/" + end + "/";

      try {
        url = new URL(apiUrl);
        con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Content-type", "application/json");
        con.setDoOutput(true);

        sb = new StringBuilder();
        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
        while (br.ready()) {
          sb.append(br.readLine());
        }
        con.disconnect();

      } catch (Exception e) {
        e.printStackTrace();
      }

      result = (JSONObject) new JSONParser().parse(sb.toString());

      JSONObject data = (JSONObject) result.get("TbPublicWifiInfo");
      JSONArray array = (JSONArray) data.get("row");

      Gson gson = new Gson();
      JSONObject tmp = null;
      List<Wifi> wifis = new ArrayList<>();

      for (int j = 0; j < array.size(); j++) {
        tmp = (JSONObject) array.get(j);
        Wifi wifi = gson.fromJson(tmp.toJSONString(), Wifi.class);

        wifis.add(wifi);
      }

      ws.dbLoad(wifis);
    }
  }
}
