import 'dart:io';

import 'package:flutter/material.dart';
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
    return getAppBar(context, "Покращи свій датасет");
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
            text: "Додати фото",
            onClick: addPhotoHandler,
          ),
        )
      ],
    );
  }

  void addPhotoHandler() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    FirebaseVisionTextDetector detector = FirebaseVisionTextDetector.instance;

    var currentLabels = await detector.detectFromPath(image?.path);

    print(currentLabels);
  }
}
