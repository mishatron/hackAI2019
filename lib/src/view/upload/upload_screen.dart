import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackai/res/values/styles.dart';
import 'package:hackai/src/core/ui/base_statefull_screen.dart';
import 'package:hackai/src/core/ui/base_statefull_widget.dart';
import 'package:hackai/src/core/ui/ui_utils.dart';
import 'package:hackai/src/libs/flutter_mlkit-master/lib/mlkit.dart';
import 'package:hackai/src/view/custom/BaseButton.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UploadScreenState();
  }
}

class _UploadScreenState extends BaseStatefulScreen<UploadScreen> {
  @override
  Widget buildAppbar() {
    return getAppBar(context, "Покращи світовий датасет");
  }

  @override
  Widget buildBody() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(64.0),
          child: Image.asset("assets/add_photo.png"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: BaseButton(
            text: "Перевірити об'єкт",
            onClick: addPhotoHandler,
          ),
        )
      ],
    );
  }

  void addPhotoHandler() async {
//    var currentLabels = ["ДТП", "Авто", "Будівля", "Дощ"];
//
//    showDialog(
//        context: context,
//        builder: (context) {
//          return Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              AlertDialog(
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(10)),
//                title: Text("Результати"),
//                content: Row(
//                  children: <Widget>[
//                    Expanded(
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: currentLabels.map((it) {
//                          return Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Text(
//                              it,
//                              style: getBigFont(),
//                            ),
//                          );
//                        }).toList(),
//                      ),
//                    ),
//                    Expanded(
//                      child: Image.asset(
//                        "assets/join_pool_back.png",
//                        fit: BoxFit.cover,
//                      ),
//                    )
//                  ],
//                ),
//              ),
//              Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                  child: BaseButton(
//                    radius: 10,
//                    text: "OK",
//                    onClick: () {
//                      Navigator.of(context).maybePop();
//                    },
//                  ))
//            ],
//          );
//        });

    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    FirebaseVisionLabelDetector detector = FirebaseVisionLabelDetector.instance;
    showProgress();
    List<VisionLabel> currentLabels =
        await detector.detectFromPath(image?.path);
    hideProgress();

    showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text("Результати"),
                content: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: currentLabels.map((it) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            it.label,
                            style: getBigFont(),
                          ),
                        );
                      }).toList(),
                    ),
                    Expanded(
                      child: Image.asset(
                        "assets/join_pool_back.png",
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: BaseButton(
                    radius: 10,
                    text: "OK",
                    onClick: () {
                      Navigator.of(context).maybePop();
                    },
                  ))
            ],
          );
        });

    for (var i in currentLabels) {
      print(i.label);
      print(i.confidence);
      print(i.entityID);
    }
  }
}
