import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

//
//Future<PermissionStatus> getLocationPermission() async {
//  Future<List<Permissions>> getPermissionStatus() async =>
//      await Permission.getPermissionsStatus([PermissionName.Location]);
//
//  Future<List<Permissions>> requestPermission() async =>
//      await Permission.requestPermissions([PermissionName.Location]);
//  List<Permissions> hasPermissions = await getPermissionStatus();
//  bool hasPermission =
//      hasPermissions[0].permissionStatus == PermissionStatus.allow;
//  if (!hasPermission) {
//    Permissions status = (await requestPermission())[0];
//    if (status.permissionStatus == PermissionStatus.allow) {
//      return PermissionStatus.allow;
//    }
//  } else
//    return PermissionStatus.allow;
//}
//
//void openLocationSetting() async {
//  final AndroidIntent intent = AndroidIntent(
//    action: 'android.settings.LOCATION_SOURCE_SETTINGS',
//  );
//  await intent.launch();
//}
//
//Future<UserInfo> updateLocationForUser(UserInfo userInfo) async {
//  bool result = await Geolocator().isLocationServiceEnabled();
//  if (result) {
//    Position position = await Geolocator()
//        .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
//    var geocoding = GoogleMapsGeocoding(apiKey: FirebaseService.GOOGLE_API_KEY);
//    var location = Location(position.latitude, position.longitude);
//    var geoCoding = await geocoding.searchByLocation(location);
//    userInfo.location =
//        position.latitude.toString() + "," + position.longitude.toString();
//    userInfo.locationName = geoCoding.results.first.formattedAddress;
//    return userInfo;
//  } else {
//    if(Platform.isAndroid) openLocationSetting();
//    return userInfo;
//    // location service is not enabled, restricted, or location permission is denied
//  }
//}

//Future<UserInfo> getLocation(UserInfo userInfo) async {
//  if(Platform.isAndroid){
//    var permissionStatus = await getLocationPermission();
//    if (permissionStatus == PermissionStatus.allow)
//      return await updateLocationForUser(userInfo);
//  }else
//    return await updateLocationForUser(userInfo);
//}
//
//Future<void> getOnlyLocation()async {
//  if(Platform.isAndroid) {
//    await getLocationPermission();
//  }
//}
//
//Future<UserInfo> getLocationAndSetUser(UserInfo userInfo) async {
//  if (Platform.isAndroid) {
//    var permissionStatus = await getLocationPermission();
//    if (permissionStatus == PermissionStatus.allow) {
//      userInfo = await updateLocation(userInfo);
//      print("UPDATE_LOCATION");
//    }
//    return userInfo;
//  }
//  else {
//    userInfo = await updateLocation(userInfo);
//    print("UPDATE_LOCATION");
//    return userInfo;
//  }
//}
//
//Future<UserInfo> updateLocation(UserInfo userInfo) async {
//  userInfo = await updateLocationForUser(userInfo);
//  userInfo = await ApiManager.singleton.updateUser(userInfo);
//  AppDataModel.instance.setUserInfo(userInfo);
//  return userInfo;
//}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      .buffer
      .asUint8List();
}

Future<Uint8List> getDefault(Color color) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  var empty = await getBytesFromAsset("assets/marker.png", 100);
  var imageEmpty = await loadImage(empty);
  canvas.drawImage(imageEmpty, new Offset(0.0, 0.0), Paint()
    ..colorFilter = ColorFilter.mode(color, BlendMode.srcATop));
  final img = await pictureRecorder.endRecording().toImage(150, 150);
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  return data.buffer.asUint8List();
}

Future<ui.Image> loadImage(List<int> img) async {
  final Completer<ui.Image> completer = new Completer();
  ui.decodeImageFromList(img, (ui.Image img) {
    return completer.complete(img);
  });
  return completer.future;
}

Future<Uint8List> getCompanyMarker(String urlAvatar) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  var request = await http.get(urlAvatar);
  var bytes = request.bodyBytes;
  ui.Codec codec = await ui.instantiateImageCodec(bytes.buffer.asUint8List(),
      targetWidth: 100);
  ui.FrameInfo fi = await codec.getNextFrame();
  var markerIco =
      (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer;
  var empty = await getBytesFromAsset("assets/empty_marker_remark.png", 150);

  var imageEmpty = await loadImage(empty);
  var imageAvatar = await loadImage(new Uint8List.view(markerIco));
  Path path = Path()
    ..addOval(Rect.fromLTWH(25.0, 12.0, imageAvatar.width.toDouble(),
        imageAvatar.height.toDouble()));
  canvas.drawImage(imageEmpty, new Offset(0.0, 0.0), new Paint());
  canvas.clipPath(path);
  canvas.drawImage(imageAvatar, new Offset(25.0, 12.0), new Paint());
  final img = await pictureRecorder.endRecording().toImage(150, 150);
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  return data.buffer.asUint8List();
}
