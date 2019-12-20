import 'package:flutter/material.dart';

/// TabBar with customizable background color
class ColoredTabBar extends Container implements PreferredSizeWidget {
  ///Constructor
  ///[color] and [tabBar] is required
  ColoredTabBar(this.color, this.tabBar);

  final Color color;
  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
        color: color,
        child: tabBar,
      );
}
