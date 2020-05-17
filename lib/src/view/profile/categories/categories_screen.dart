import 'package:flutter/material.dart';
import 'package:hackai/res/values/styles.dart';
import 'package:hackai/router/navigation_service.dart';
import 'package:hackai/router/route_paths.dart';
import 'package:hackai/src/core/bundle.dart';
import 'package:hackai/src/core/ui/base_statefull_screen.dart';
import 'package:hackai/src/core/ui/base_statefull_widget.dart';
import 'package:hackai/src/core/ui/ui_utils.dart';
import 'package:hackai/src/di/dependency_injection.dart';
import 'package:hackai/src/view/custom/BaseButton.dart';

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
      child: InkWell(
        onTap: () {
          var bundle = Bundle();
          bundle.putString("category", text);
          injector<NavigationService>()
              .pushNamed(downloadRoute, arguments: bundle);
        },
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      style: getMidFont(),
                    ),
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                getItem("Пожежі"),
                getItem("Рослини"),
                getItem("Авто"),
                getItem("ДТП"),
              ],
            ),
          )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: BaseButton(
            text: "Стежити за категорією",
            onClick: () {},
          ),
        )
      ],
    );
  }
}
