import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackai/res/values/colors.dart';
import 'package:hackai/src/core/localization/app_localizations.dart';
import 'package:hackai/src/core/ui/base_statefull_screen.dart';
import 'package:hackai/src/core/ui/base_statefull_widget.dart';
import 'package:hackai/src/view/custom/bottom_menu/fancy_bottom_navigation.dart';
import 'package:hackai/src/view/map/MapScreen.dart';
import 'package:hackai/src/view/profile/profile_screen.dart';
import 'package:hackai/src/view/upload/upload_screen.dart';

class MainScreen extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends BaseStatefulScreen<MainScreen> {
  ValueNotifier<int> _currentIndex = ValueNotifier(0);
  List<Widget> _children = [
    UploadScreen(),
    MapScreen(),
    ProfileScreen(),
  ];

  @override
  Widget getLayout() {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: buildAppbar(),
        body: buildBody(),
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: getBottomMenu(),
      ),
    );
  }

  Widget getBottomMenu() {
    return FancyBottomNavigation(
      circleColor: colorAccent,
      inactiveIconColor: colorAccent,
      tabs: [
        TabData(iconData: Icons.collections, title: "Screen1"),
        TabData(iconData: Icons.monetization_on, title: "Screen2"),
        TabData(iconData: Icons.search, title: "Screen3"),
      ],
      onTabChangedListener: (position) {
        _currentIndex.value = position;
      },
    );
  }

  @override
  Widget buildAppbar() {
    return null;
  }

  @override
  Widget buildBody() {
    return ValueListenableBuilder(
      valueListenable: _currentIndex,
      builder: (context, int value, child) {
        return _children[value];
      },
    );
  }
}
