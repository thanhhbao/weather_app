import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:weather_app_tutorial/constants/constants.dart';
import 'package:weather_app_tutorial/models/hourly_weather.dart';
import 'package:weather_app_tutorial/models/weekly_weather.dart';
import 'package:weather_app_tutorial/services/geolocator.dart';
import 'package:weather_app_tutorial/utils/logging.dart';

import '../models/weather.dart';

@immutable // Lớp này không thể thay đổi sau khi được khởi tạo.
class ApiHelper {
  static const baseUrl = 'http://api.openweathermap.org/data/2.5';
  static const weeklyWeatherUrl =
      'https://api.open-meteo.com/v1/forecast?current=&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto'; // URL cho dự báo thời tiết hàng tuần từ Open-Meteo

  static double lat = 0.0;
  static double lon = 0.0;
  static final dio = Dio();
  // Dio là một thư viện HTTP để gửi yêu cầu và nhận phản hồi.

  // Phương thức lấy vị trí của người dùng và cập nhật vĩ độ và kinh độ.
  static Future<void> fetchLocation() async {
    final location =
        await getLocation(); // Gọi phương thức từ dịch vụ geolocator để lấy vị trí
    lat = location.latitude; // Cập nhật vĩ độ
    lon = location.longitude; // Cập nhật kinh độ
  }

  // Phương thức lấy thời tiết hiện tại
  static Future<Weather> getCurrentWeather() async {
    await fetchLocation(); // Lấy vị trí trước khi gọi API
    final url =
        _constructWeatherUrl(); // Xây dựng URL để truy xuất thời tiết hiện tại
    final response = await _fetchData(url); // Gửi yêu cầu và nhận dữ liệu
    return Weather.fromJson(
        response); // Chuyển đổi dữ liệu JSON thành đối tượng Weather
  }

  // Phương thức lấy dự báo thời tiết theo giờ
  static Future<HourlyWeather> getHourlyForecast() async {
    await fetchLocation(); // Lấy vị trí trước khi gọi API
    final url = _constructForecastUrl(); // Xây dựng URL cho dự báo theo giờ
    final response = await _fetchData(url); // Gửi yêu cầu và nhận dữ liệu
    return HourlyWeather.fromJson(
        response); // Chuyển đổi dữ liệu JSON thành đối tượng HourlyWeather
  }

  // Phương thức lấy dự báo thời tiết hàng tuần
  static Future<WeeklyWeather> getWeeklyForecast() async {
    await fetchLocation(); // Lấy vị trí trước khi gọi API
    final url =
        _constructWeeklyForecastUrl(); // Xây dựng URL cho dự báo thời tiết hàng tuần
    final response = await _fetchData(url); // Gửi yêu cầu và nhận dữ liệu
    return WeeklyWeather.fromJson(
        response); // Chuyển đổi dữ liệu JSON thành đối tượng WeeklyWeather
  }

  // Phương thức lấy thời tiết theo tên thành phố
  static Future<Weather> getWeatherByCityName({
    required String cityName, // Tên thành phố được truyền vào dưới dạng tham số
  }) async {
    final url = _constructWeatherByCityUrl(
        cityName); // Xây dựng URL cho thành phố cụ thể
    final response = await _fetchData(url); // Gửi yêu cầu và nhận dữ liệu
    return Weather.fromJson(
        response); // Chuyển đổi dữ liệu JSON thành đối tượng Weather
  }

  // Phương thức xây dựng URL cho thời tiết hiện tại dựa trên vĩ độ và kinh độ
  static String _constructWeatherUrl() =>
      '$baseUrl/weather?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

  // Phương thức xây dựng URL cho dự báo theo giờ
  static String _constructForecastUrl() =>
      '$baseUrl/forecast?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

  // Phương thức xây dựng URL cho thời tiết theo tên thành phố
  static String _constructWeatherByCityUrl(String cityName) =>
      '$baseUrl/weather?q=$cityName&units=metric&appid=${Constants.apiKey}';

  // Phương thức xây dựng URL cho dự báo thời tiết hàng tuần
  static String _constructWeeklyForecastUrl() =>
      '$weeklyWeatherUrl&latitude=$lat&longitude=$lon';

  // Phương thức gửi yêu cầu HTTP và lấy dữ liệu từ API
  static Future<Map<String, dynamic>> _fetchData(String url) async {
    try {
      final response = await dio.get(url); // Gửi yêu cầu HTTP GET đến URL
      if (response.statusCode == 200) {
        return response.data; // Nếu thành công, trả về dữ liệu
      } else {
        printWarning(
            'Failed to load data: ${response.statusCode}'); // In cảnh báo nếu mã trạng thái không phải 200
        throw Exception(
            'Failed to load data'); // Ném lỗi nếu không thể lấy dữ liệu
      }
    } catch (e) {
      printWarning(
          'Error fetching data from $url: $e'); // In cảnh báo nếu có lỗi khi gửi yêu cầu
      throw Exception(
          'Error fetching data'); // Ném lỗi nếu có sự cố khi gửi yêu cầu
    }
  }
}
