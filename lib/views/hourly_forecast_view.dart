import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/app_colors.dart';
import 'package:weather_app_tutorial/constants/text_styles.dart';
import 'package:weather_app_tutorial/extensions/int.dart';
import 'package:weather_app_tutorial/providers/hourly_weather_provider.dart';
import 'package:weather_app_tutorial/utils/get_weather_icons.dart';

// Widget hiển thị dự báo thời tiết hàng giờ
class HourlyForecastView extends ConsumerWidget {
  const HourlyForecastView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lấy dữ liệu thời tiết hàng giờ thông qua provider
    final hourlyWeatherData = ref.watch(hourlyWeatherProvider);

    return hourlyWeatherData.when(
      data: (hourlyWeather) {
        // Hiển thị danh sách dự báo thời tiết hàng giờ
        return SizedBox(
          height: 100,
          child: ListView.builder(
            itemCount: hourlyWeather.cnt, // Số lượng dự báo theo giờ
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final weather = hourlyWeather.list[index];

              return HourlyForcastTitle(
                id: weather.weather[0].id, // Mã thời tiết để hiển thị icon
                hour: weather.dt.time, // Giờ dự báo
                temp: weather.main.temp.round(), // Nhiệt độ làm tròn
                isActive: index == 0, // Đánh dấu mục đầu tiên là đang hoạt động
              );
            },
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()));
      },
      loading: () {
        // Hiển thị vòng xoay tải khi dữ liệu đang được tải
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

// Widget để hiển thị thông tin dự báo thời tiết cho từng giờ
class HourlyForcastTitle extends StatelessWidget {
  const HourlyForcastTitle({
    super.key,
    required this.id, // Mã thời tiết để xác định icon
    required this.hour,
    required this.temp,
    required this.isActive,
  });

  final int id;
  final String hour;
  final int temp;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 16,
        top: 12,
        bottom: 12,
      ),
      child: Material(
        color: isActive ? AppColors.lightBlue : AppColors.accentBlue,
        borderRadius: BorderRadius.circular(15.0),
        elevation: isActive ? 8 : 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                getWeatherIcon(
                    weatherCode: id), // Hàm lấy icon dựa trên mã thời tiết
                width: 50,
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    hour,
                    style: const TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$temp°',
                    style: TextStyles.h3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
