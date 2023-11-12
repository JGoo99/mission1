package com.example.mission1.db.loadApi;

import com.google.gson.annotations.SerializedName;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Wifi {
  @SerializedName("X_SWIFI_MGR_NO")       // 관리번호
  private String wifi_key;

  @SerializedName("X_SWIFI_WRDOFC")       // 자치구
  private String gu;

  @SerializedName("X_SWIFI_MAIN_NM")      // 와이파이명
  private String wifi_name;

  @SerializedName("X_SWIFI_ADRES1")       // 도로명주소
  private String address1;

  @SerializedName("X_SWIFI_ADRES2")       // 상세주소
  private String address2;

  @SerializedName("X_SWIFI_INSTL_FLOOR")  // 설치위치(층)
  private String instl_floor;

  @SerializedName("X_SWIFI_INSTL_TY")     // 설치유형
  private String instl_type;

  @SerializedName("X_SWIFI_INSTL_MBY")    // 설치기관
  private String instl_office;

  @SerializedName("X_SWIFI_SVC_SE")       // 서비스구분
  private String service;

  @SerializedName("X_SWIFI_CMCWR")        // 망종류
  private String net_type;

  @SerializedName("X_SWIFI_CNSTC_YEAR")   // 설치년도
  private String instl_year;

  @SerializedName("X_SWIFI_INOUT_DOOR")   // 실내외구분
  private String inout_door;

  @SerializedName("X_SWIFI_REMARS3")      // WIFI 접속환경
  private String conn_env;

  @SerializedName("LAT")                  // Y좌표 -- api 잘못됨
  private String lon;

  @SerializedName("LNT")                  // X좌표
  private String lat;

  @SerializedName("WORK_DTTM")            // 작업일자
  private String work_datetime;
}
