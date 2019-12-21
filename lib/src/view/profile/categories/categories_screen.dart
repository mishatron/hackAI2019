import 'package:flutter/material.dart';
import 'package:hackai/res/values/styles.dart';
import 'package:hackai/src/core/ui/base_statefull_screen.dart';
import 'package:hackai/src/core/ui/base_statefull_widget.dart';
import 'package:hackai/src/core/ui/ui_utils.dart';

class CategoriesScreen extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoriesScreenState();
  }
}

class CategoriesScreenState extends BaseStatefulScreen<CategoriesScreen> {
  @override
  Widget buildAppbar() {
    return getAppBar(context, "Категорії", leading: getBack());
  }

  Widget getItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text, style: getMidFont(),),
              ),
            ),
            Icon(Icons.chevron_right),
          ],),
        ),
      ),
    );
  }

  @override
  Widget buildBody() {
    return SingleChildScrollView(child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          getItem("Лікарні"),
          getItem("Школи"),
          getItem("Підприємства"),
          getItem("Смітники"),
        ],
      ),
    ));
  }
}
