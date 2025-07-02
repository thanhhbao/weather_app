import 'package:geolocator/geolocator.dart';

// Hàm bất đồng bộ để lấy vị trí hiện tại của thiết bị
Future<Position> getLocation() async {
  LocationPermission
      permission; // Khai báo biến để lưu trạng thái quyền truy cập vị trí

  // Kiểm tra quyền truy cập vị trí hiện tại
  permission = await Geolocator.checkPermission();

  // Nếu quyền truy cập bị từ chối
  if (permission == LocationPermission.denied) {
    // Yêu cầu người dùng cấp quyền truy cập vị trí
    permission = await Geolocator.requestPermission();

    // Nếu người dùng vẫn từ chối quyền truy cập
    if (permission == LocationPermission.denied) {
      // Trả về một lỗi thông báo rằng quyền truy cập vị trí đã bị từ chối
      return Future.error('Location permissions are denied');
    }
  }

  // Nếu quyền truy cập bị từ chối vĩnh viễn
  if (permission == LocationPermission.deniedForever) {
    // Trả về một lỗi thông báo rằng không thể yêu cầu quyền vì đã bị từ chối vĩnh viễn
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // Nếu quyền truy cập đã được cấp, lấy vị trí hiện tại và trả về kết quả
  return await Geolocator.getCurrentPosition();
}
