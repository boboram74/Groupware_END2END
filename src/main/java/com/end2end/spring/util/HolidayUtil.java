package com.end2end.spring.util;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

public class HolidayUtil {
    public static Map<String, Object> getHolidayApi(String year, String month) throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=" + Statics.apiServiceKey); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("solYear","UTF-8") + "=" + URLEncoder.encode(year, "UTF-8")); /*연*/
        urlBuilder.append("&" + URLEncoder.encode("solMonth","UTF-8") + "=" + URLEncoder.encode(month, "UTF-8")); /*월*/
        urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));

        URL url = new URL(urlBuilder.toString());
        System.out.println(url.toString());


        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json; charset=UTF-8");

        String contentType = conn.getHeaderField("Content-Type");
        System.out.println("Response Content-Type: " + contentType);

        BufferedReader br;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        } else {
            br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
        }

        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }
        br.close();
        conn.disconnect();

        System.out.println("sb: "+ sb);

        Gson g = new GsonBuilder()
                .disableHtmlEscaping()  // HTML 이스케이프 비활성화
                .setPrettyPrinting()
                .create();
        return g.fromJson(sb.toString(), new TypeToken<Map<String, Object>>(){}.getType());
    }

    public static List<Map<String, Object>> generateHolidayList(Map<String, Object> json) {
        Map<String, Object> response = (Map<String, Object>) json.get("response");
        Map<String, Object> body = (Map<String, Object>) response.get("body");
        Map<String, Object> items = (Map<String, Object>) body.get("items");
        List<Map<String, Object>> item = (List<Map<String, Object>>) items.get("item");

        for (Map<String, Object> map : item) {
            Object dateValue = map.get("locdate");
            if (dateValue instanceof Number) {
                String formattedDate = String.format("%.0f", ((Number) dateValue).doubleValue());
                map.put("locdate", formattedDate);
            }

        }

        return item;
    }
}
