import 'package:weather_app_tutorial/views/other_cities_view.dart';

class OtherCity {
  final String name;
  final double lat;
  final double lon;

  OtherCity({required this.name, required this.lat, required this.lon});
}

List<OtherCity> otherCities = [
  OtherCity(name: 'Hà Nội', lat: 21.0285, lon: 105.8542),
  OtherCity(name: 'Đà Nẵng', lat: 16.0471, lon: 108.2068),
  OtherCity(name: 'Hải Phòng', lat: 20.8449, lon: 106.6881),
  OtherCity(name: 'Cần Thơ', lat: 10.0452, lon: 105.7469),
  OtherCity(name: 'Huế', lat: 16.4637, lon: 107.5909),
  OtherCity(name: 'Nha Trang', lat: 12.2388, lon: 109.1967),
  OtherCity(name: 'Vũng Tàu', lat: 10.4114, lon: 107.1362),
  OtherCity(name: 'Đà Lạt', lat: 11.9416, lon: 108.4385),
];
