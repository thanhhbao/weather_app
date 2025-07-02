import 'package:flutter/material.dart';

import '/constants/text_styles.dart';
import '/extensions/double.dart';
import '/models/weather.dart';

// Widget Stateless hiển thị thông tin thời tiết, như nhiệt độ, tốc độ gió, và độ ẩm
class WeatherInfo extends StatelessWidget {
  const WeatherInfo({
    super.key,
    required this.weather, // Dữ liệu thời tiết cần hiển thị, được truyền vào dưới dạng tham số bắt buộc
  });

  final Weather weather; // Mô hình Weather chứa dữ liệu thời tiết chính

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Ô thông tin hiển thị nhiệt độ
          WeatherInfoTile(
            title: 'Temp',
            value: '${weather.main.temp}°',
          ),
          // Ô thông tin hiển thị tốc độ gió
          WeatherInfoTile(
            title: 'Wind', // Nhãn của ô thông tin gió
            value:
                '${weather.wind.speed.kmh} km/h', // Chuyển đổi tốc độ thành km/h bằng phương thức mở rộng
          ),
          // Ô thông tin hiển thị độ ẩm
          WeatherInfoTile(
            title: 'Humidity',
            value: '${weather.main.humidity}%',
          ),
        ],
      ),
    );
  }
}

// Widget Stateless đại diện cho một ô thông tin thời tiết cụ thể
class WeatherInfoTile extends StatelessWidget {
  const WeatherInfoTile({
    super.key,
    required this.title, // Tiêu đề của ô, như 'Temp', 'Wind', v.v.
    required this.value, // Giá trị cần hiển thị, như nhiệt độ hoặc tốc độ gió
  }) : super();

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyles.subtitleText,
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: TextStyles.h3,
        )
      ],
    );
  }
}
