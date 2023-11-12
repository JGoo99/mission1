
// 내 위치정보 (경도, 위도) 반환
const myLocation = document.getElementById("myLocation");

myLocation.onclick = function () {
    getUserLocation();
};

function success({coords}) {
    const longitude = coords.longitude; // 경도
    const latitude = coords.latitude;   // 위도

    // 경도, 위도 input 의 value 로 전달
    document.getElementById("lon").value = longitude;
    document.getElementById("lat").value = latitude;
}

// 위치정보 수락
function getUserLocation() {
    if (!navigator.geolocation) {
        throw "위치 정보가 지원되지 않습니다.";
    }
    navigator.geolocation.getCurrentPosition(success);
}


// 내 위치정보 검색
const searchWifi = document.getElementById("searchWifi");

searchWifi.onclick = function () {
    const lon = document.getElementById("lon").value;
    const lat = document.getElementById("lat").value;
    
    if (lon === "" || lat === "") {
        alert("위치 정보를 입력한 후에 조회해 주세요.")
    } else {
        const url = "/?lon=" + encodeURIComponent(lon) + "&lat=" + encodeURIComponent(lat);
        
        // url 의 파라미터로 경도, 위도 전송
        window.location.href = url;
    }
};
