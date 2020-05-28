import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackai/src/core/provider/base_viewmodel.dart';
import 'package:hackai/src/data/repositories/ml/ml_repository.dart';
import 'package:hackai/src/di/dependency_injection.dart';
import 'package:hackai/src/domain/data_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mlkit/mlkit.dart';
import 'package:permission_handler/permission_handler.dart';

class Category {
  final String text;
  final String ukrText;
  final Color color;

  Category(this.text, this.ukrText, this.color);
}

class UploadViewModel extends BaseViewModel {
  final List<Category> availableCategories = [
    Category("vehicle", "Авто", Colors.blueAccent),
    Category("fire", "Вогонь", Colors.orange),
    Category("plant", "Рослина", Colors.greenAccent),
    Category("crash", "ДТП", Colors.redAccent),
    Category("collision", "ДТП", Colors.redAccent),
    Category("room", "Кімната", Colors.yellow),
  ];
  final MLRepository _mlRepository = injector.get();

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
    try {
      bool permission = await checkPermissions();
      if (!permission) return;

      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      location = LatLng(position.latitude, position.longitude);

      notifyListeners();
      image = await ImagePicker.pickImage(source: ImageSource.camera);
      FirebaseVisionLabelDetector detector =
          FirebaseVisionLabelDetector.instance;
      if (image == null) return;
      showProgress();
      currentLabels = await detector.detectFromPath(image?.path);
      hideProgress();
    } catch (err) {
      print(err);
      hideProgress();
    }
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

  void uploadData() async {
    try {
      showProgress();
      String userId = (await FirebaseAuth.instance.currentUser()).uid;
      bool has = false;
      for (var label in currentLabels) {
        if (label.confidence >= 0.85 &&
            availableCategories
                .map((e) => e.text)
                .contains(label.label.toLowerCase())) {
          has = true;
          DataModel dataModel = DataModel();
          dataModel.timestamp = DateTime.now().millisecondsSinceEpoch;
          dataModel.latitude = location.latitude;
          dataModel.longitude = location.longitude;
          dataModel.userId = userId;
          dataModel.confidence = label.confidence;
          dataModel.text = label.label.toLowerCase();
          dataModel.ukrText = availableCategories
              .firstWhere(
                  (element) => element.text == label.label.toLowerCase())
              .ukrText;
          dataModel.color = availableCategories
              .firstWhere(
                  (element) => element.text == label.label.toLowerCase())
              .color
              .value;
          await _mlRepository.uploadData(dataModel);
        }
      }
      if (!has) showMessage("Фото не містить важливих сутностей");
      hideProgress();
    } catch (err) {
      handleError(err);
      hideProgress();
    }
  }
}
