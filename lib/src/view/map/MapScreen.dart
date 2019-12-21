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

class MapScreenState extends BaseStatefulScreen<MapScreen> {
  var markers = Set<Marker>();
  Completer<GoogleMapController> controllerCompleter = Completer();

  @override
  void initState() {
    super.initState();
    markers.add(Marker(
        markerId: MarkerId("1"),
        onTap: () {},
        position: LatLng(49.236890, 28.449536)));
    markers.add(Marker(
        markerId: MarkerId("2"),
        onTap: () {},
        position: LatLng(49.234326, 28.449364)));
    markers.add(Marker(
        markerId: MarkerId("3"),
        onTap: () {},
        position: LatLng(49.234835, 28.429768)));
    markers.add(Marker(
        markerId: MarkerId("4"),
        onTap: () {},
        position: LatLng(49.214802, 28.434888)));
  }

  @override
  Widget buildAppbar() {
    return getAppBar(context, "Знайди, що треба", actions: [
      IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        onPressed: () {},
      )
    ]);
  }

  @override
  Widget buildBody() {
    return GoogleMap(
      markers: markers,
      mapType: MapType.normal,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(49.234326, 28.449364),
        zoom: 11,
      ),
      onMapCreated: (GoogleMapController controller) {
        controllerCompleter.complete(controller);
      },
    );
  }
}
