import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:hackai/res/values/styles.dart';
import 'package:hackai/router/navigation_service.dart';
import 'package:hackai/router/route_paths.dart';
import 'package:hackai/src/core/localization/app_localizations.dart';
import 'package:hackai/src/core/ui/base_statefull_screen.dart';
import 'package:hackai/src/core/ui/base_statefull_widget.dart';
import 'package:hackai/src/di/dependency_injection.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hackai/src/view/login/AuthPresenter.dart';


class AuthScreen extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return  AuthScreenState();
  }
}

class AuthScreenState extends BaseStatefulScreen implements AuthContract {
  final FacebookLogin facebookSignIn = new FacebookLogin();
  AuthPresenter _presenter;
  bool _privacyState = false;

  AuthScreenState() {
    _presenter = new AuthPresenter(this);
  }

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Center(child: Image(image: AssetImage('assets/logo.png')))),
        Column(
          children: <Widget>[
            getAuthButton(
                Color(0xff4554a6),
                "assets/facebook.png",
                "",
                makeFacebookSign),
            getAuthButton(Color(0xffff3795), "assets/google.png",
                "", makeGoogleSign),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: CheckboxListTile(
                value: _privacyState,
                onChanged: _policyChanged,
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: new TextStyle(color: Colors.black),
                      ),
                      TextSpan(

                        style: TextStyle(color: Color(0xff5f38f9)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
//                          launchURL(privacyUrl);
                          },
                      ),
                    ],
                  ),
                ),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getAuthButton(
      Color color, String asset, String title, Function onClick) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 5, bottom: 5),
      child: SizedBox(
        height: 50,
        child: RaisedButton(
          color: color,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Stack(
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Image(image: AssetImage(asset)),
              ),
              Center(
                child: Text(
                  title,
                  style: getSmallFontWhite(),
                ),
              )
            ],
          ),
          onPressed: onClick,
        ),
      ),
    );
  }

  void _policyChanged(bool state) {
    setState(() {
      _privacyState = state;
    });
  }

  @override
  Widget getLayout() {
    return Scaffold(
      key: scaffoldKey,
      body: buildBody(),
    );
  }

  void makeFacebookSign() {
    facebookSignIn.loginBehavior = FacebookLoginBehavior.webViewOnly;
    if (_privacyState) {
      _presenter.handleFacebookSignIn();
    } else {
      //showMessage(Localization.of(context).getValue(policy_fail_msg));
    }
  }

  void makeGoogleSign() {
    if (_privacyState) {
      _presenter.makeGoogleLogin();
    } else {
    //  showMessage(Localization.of(context).getValue(policy_fail_msg));
    }
  }

  @override
  void onLogin() {
    injector<NavigationService>().pushNamedReplacement(mainRoute);
  }

  @override
  Widget buildAppbar() {
    return null;
  }

}
