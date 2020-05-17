import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackai/src/core/provider/base_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mlkit/mlkit.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadViewModel extends BaseViewModel {

  LatLng _location;

  LatLng get location => _location;

  set location(LatLng location) {
    _location = location;
    notifyListeners();
  }
  File _image;

  File get image => _image;

  set image(File image) {
    _image = image;
    notifyListeners();
  }

  bool _isMLFinished = false;
  List<VisionLabel> currentLabels;

  bool get isMLFinished => _isMLFinished;

  set isMLFinished(bool isMLFinished) {
    _isMLFinished = isMLFinished;
    notifyListeners();
  }

  void check() async {
    bool permission = await checkPermissions();
    if (!permission) return;

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    location = LatLng(position.latitude, position.longitude);

    notifyListeners();
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    FirebaseVisionLabelDetector detector = FirebaseVisionLabelDetector.instance;
    if (image == null) return;
    showProgress();
    currentLabels = await detector.detectFromPath(image?.path);
    hideProgress();
  }

  Future<bool> checkPermissions() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> result = await PermissionHandler()
          .requestPermissions([PermissionGroup.location]);
      if (result[PermissionGroup.location] == PermissionStatus.granted) {
        notifyListeners();
        return true;
      }
      return false;
    }
    return true;
  }
}
