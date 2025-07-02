import 'package:flutter/material.dart';
import 'package:weather_app_tutorial/models/other_city.dart';

class OtherCitiesView extends StatelessWidget {
  const OtherCitiesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: otherCities.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        final city = otherCities[index];

        // return InkWell(
        //   onTap: () {
        //     Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (_) => WeatherDetailScreen(
        //           cityName: city.name,
        //         ),
        //       ),
        //     );
        //   },
        //   child: CityWeatherTile(
        //     index: index,
        //     city: city,
        //   ),
        // );
      },
    );
  }
}
