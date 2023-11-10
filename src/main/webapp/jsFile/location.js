
// 내 위치정보 (경도, 위도) 반환
var myLocation = document.getElementById("myLocation");

myLocation.onclick = function () {
    getUserLocation();
};

function success({coords}) {
    const longitude = coords.longitude; // 경도
    const latitude = coords.latitude;   // 위도

    document.getElementById("lon").value = longitude;
    document.getElementById("lat").value = latitude;
}

function getUserLocation() {
    if (!navigator.geolocation) {
        throw "위치 정보가 지원되지 않습니다.";
    }
    navigator.geolocation.getCurrentPosition(success);
}


// 내 위치정보 검색
var searchWifi = document.getElementById("searchWifi");

searchWifi.onclick = function () {
    var lon = document.getElementById("lon").value;
    var lat = document.getElementById("lat").value;

    var url = "/?lon=" + encodeURIComponent(lon) + "&lat=" + encodeURIComponent(lat);

    window.location.href = url;
};
