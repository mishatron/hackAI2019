import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackai/res/values/styles.dart';
import 'package:hackai/src/core/ui/base_statefull_screen.dart';
import 'package:hackai/src/core/ui/base_statefull_widget.dart';
import 'package:hackai/src/core/ui/ui_utils.dart';

class MapScreen extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MapScreenState();
  }

}

class MapScreenState extends BaseStatefulScreen<MapScreen>{

  var markers = Set<Marker>();
  Completer<GoogleMapController> controllerCompleter = Completer();

  @override
  Widget buildAppbar() {
    return getAppBar(context,  "Знайди, що треба");
  }

  @override
  Widget buildBody() {
    return GoogleMap(
      markers: markers,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target:LatLng(48.535, 29.323),
        zoom: 5,
      ),
      onMapCreated: (GoogleMapController controller) {
        controllerCompleter.complete(controller);
      },
    );
  }
}