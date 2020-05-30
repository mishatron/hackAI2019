import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackai/src/core/provider/vm_provider.dart';
import 'package:hackai/src/core/ui/base_statefull_screen.dart';
import 'package:hackai/src/core/ui/base_statefull_widget.dart';
import 'package:hackai/src/core/ui/ui_utils.dart';
import 'package:hackai/src/view/map/map_view_model.dart';

class MapScreen extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MapScreenState();
  }
}

class MapScreenState extends BaseStatefulScreen<MapScreen> {
  final MapViewModel _viewModel = MapViewModel();

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
    return VMProvider.withConsumer(
        viewModel: _viewModel,
        builder: (context, model, child) {
          return GoogleMap(
            markers: _viewModel.markers,
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _viewModel.initialCameraPOs,
              zoom: 11,
            ),
          );
        });
  }
}
