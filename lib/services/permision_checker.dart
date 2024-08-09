import 'package:permission_handler/permission_handler.dart';

permissionChecker() async {
  await Permission.sensors.request();
  await Permission.storage.request();
  await Permission.activityRecognition.request();
  await Permission.location.request();
}
