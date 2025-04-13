package com.end2end.spring.util;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class HolidayUtil {
    private static Map<String, Object> getHolidayApi(String year, String month) throws IOException {
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

        Gson g = new GsonBuilder()
                .disableHtmlEscaping()  // HTML 이스케이프 비활성화
                .setPrettyPrinting()
                .create();
        return g.fromJson(sb.toString(), new TypeToken<Map<String, Object>>(){}.getType());
    }

    public static List<HolidayDTO> generateHolidayList(String year, String month) throws IOException {
        Map<String, Object> result = HolidayUtil.getHolidayApi(year, month);

        Map<String, Object> response = (Map<String, Object>) result.get("response");
        Map<String, Object> body = (Map<String, Object>) response.get("body");

        Double totalCount = (Double) body.get("totalCount");
        int totalCountInt = totalCount.intValue();

        if (totalCountInt == 0) {
            return new ArrayList<>();
        }

        Map<String, Object> items = (Map<String, Object>) body.get("items");

        if (totalCountInt == 1) {
            Map<String, Object> item = (Map<String, Object>) items.get("item");
            List<HolidayDTO> list = new ArrayList<>();

            Object dateValue = item.get("locdate");
            if (dateValue instanceof Number) {
                String formattedDate = String.format("%.0f", ((Number) dateValue).doubleValue());
                item.put("locdate", formattedDate);
            }
            list.add(HolidayDTO.of(item));
            return list;
        }

        List<Map<String, Object>> item = (List<Map<String, Object>>) items.get("item");

        for (Map<String, Object> map : item) {
            Object dateValue = map.get("locdate");
            if (dateValue instanceof Number) {
                String formattedDate = String.format("%.0f", ((Number) dateValue).doubleValue());
                map.put("locdate", formattedDate);
            }
        }

        return item.stream()
                .map(HolidayDTO::of)
                .collect(Collectors.toList());
    }

    public static boolean isHoliday(LocalDate date) throws IOException {
        if (date.getDayOfWeek() == DayOfWeek.SATURDAY || date.getDayOfWeek() == DayOfWeek.SUNDAY) {
            return true;
        }

        String year = String.valueOf(date.getYear());
        String month = String.format("%02d", date.getMonthValue());

        List<HolidayDTO> holidayList = HolidayUtil.generateHolidayList(year, month);

        for (HolidayDTO holiday : holidayList) {
            if (holiday.getDate().equals(new SimpleDateFormat("yyyyMMdd").format(date))) {
                return true;
            }
        }

        return false;
    }

    public static List<HolidayDTO> getPeriodHolidayList(LocalDate startDate, LocalDate endDate) throws IOException {
        List<HolidayDTO> holidayList = new ArrayList<>();

        LocalDate currentDate = startDate;
        while (!currentDate.isAfter(endDate)) {
            String currentYear = String.valueOf(currentDate.getYear());
            String currentMonth = String.format("%02d", currentDate.getMonthValue());

            holidayList.addAll(HolidayUtil.generateHolidayList(currentYear, currentMonth));

            currentDate = currentDate.plusMonths(1);
        }

        return holidayList;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @Builder
    public static class HolidayDTO {
        private String dateKind;
        private String dateName;
        private boolean isHoliday;
        private String date;
        private Double seq;

        public static HolidayDTO of(Map<String, Object> json) {
            return HolidayDTO.builder()
                    .dateKind((String) json.get("dateKind"))
                    .dateName((String) json.get("dateName"))
                    .isHoliday((json.get("isHoliday").equals("Y")))
                    .date((String) json.get("locdate"))
                    .seq((Double) json.get("seq"))
                    .build();
        }
    }

    public static int getWorkingDaysBetween(LocalDate startDate, LocalDate endDate) throws IOException {
        List<HolidayDTO> holidayList = getPeriodHolidayList(startDate, endDate);

        int workingDays = (int) startDate.datesUntil(endDate.plusDays(1))
                .filter(date -> date.getDayOfWeek() != DayOfWeek.SATURDAY
                        && date.getDayOfWeek() != DayOfWeek.SUNDAY)
                .count();

        return workingDays - holidayList.size();
    }
}
