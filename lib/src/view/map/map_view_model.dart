import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackai/src/core/provider/base_viewmodel.dart';
import 'package:hackai/src/data/repositories/ml/ml_repository.dart';
import 'package:hackai/src/di/dependency_injection.dart';
import 'package:hackai/src/domain/data_model.dart';
import 'package:hackai/src/view/map/maps_helper.dart';

class MapViewModel extends BaseViewModel {
  final LatLng initialCameraPOs = LatLng(49.234326, 28.449364);
  final MLRepository _mlRepository = injector.get();
  var markers = Set<Marker>();
  List<DataModel> data;

  MapViewModel() {
    init();
  }


  void init() async {
    try {
      data = await _mlRepository.getData();
      for (var it in data) {
        markers.add(Marker(
            infoWindow: InfoWindow(title: it.ukrText),
            markerId: MarkerId(it.id),
            icon: (BitmapDescriptor.fromBytes(
                await getDefault(Color(it.color ?? Colors.black)))),
            onTap: () {},
            position: LatLng(it.latitude, it.longitude)));
      }
    } catch (err) {
      handleError(err);
    }
//
//    markers.add(Marker(
//        markerId: MarkerId("2"),
//        onTap: () {},
//        position: LatLng(49.234326, 28.449364)));
//    markers.add(Marker(
//        markerId: MarkerId("3"),
//        onTap: () {},
//        position: LatLng(49.234835, 28.429768)));
//    markers.add(Marker(
//        markerId: MarkerId("4"),
//        onTap: () {},
//        position: LatLng(49.214802, 28.434888)));
    notifyListeners();
  }
}
