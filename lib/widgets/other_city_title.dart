import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/models/other_city.dart';
import 'package:weather_app_tutorial/providers/get_weather_by_city_provider.dart';

import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/utils/get_weather_icons.dart';

class CityWeatherTile extends ConsumerWidget {
  const CityWeatherTile({
    super.key,
    required this.city,
    required this.index,
  });

  final OtherCity city;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherByCityNameProvider(city.name));

    return currentWeather.when(
      data: (weather) {
        // Kiểm tra `weather.main.temp` có null không
        final temperature = weather.main.temp != null
            ? '${weather.main.temp!.round()}°'
            : 'N/A';
        // Kiểm tra danh sách `weather.weather` không rỗng
        final description = weather.weather.isNotEmpty
            ? weather.weather[0].description
            : 'No data';
        // Kiểm tra và lấy icon thời tiết hợp lệ
        final weatherIconPath = getWeatherIcon(
          weatherCode: weather.weather.isNotEmpty
              ? weather.weather[0].id
              : 800, // 800: clear sky mặc định
        );

        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Material(
            color: index == 0 ? AppColors.lightBlue : AppColors.accentBlue,
            elevation: index == 0 ? 12 : 0,
            borderRadius: BorderRadius.circular(25.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              temperature,
                              style: TextStyles.h2,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              description,
                              style: TextStyles.subtitleText,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      // Hiển thị icon thời tiết
                      Image.asset(
                        weatherIconPath,
                        width: 50,
                      ),
                    ],
                  ),
                  Text(
                    weather.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(.8),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        // In ra lỗi để kiểm tra
        print('Error: $error');
        print('Stack Trace: $stackTrace');
        return Center(
          child: Text('Đã xảy ra lỗi: $error'),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
