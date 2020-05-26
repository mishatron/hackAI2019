

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  final String _kFirstLaunch = "_kFirstLaunch";
  final String _historySettings = "_historySettings";
  final String _wifiSettings = "_wifiSettings";
  final String _giftExplained = "_giftExplained";

  static final PreferenceManager singleton = PreferenceManager._internal();

  PreferenceManager._internal();

  factory PreferenceManager() => singleton;

  Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  Future<bool> getIsFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kFirstLaunch) ?? true;
  }

  Future<bool> setFirstLaunch(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_kFirstLaunch, value);
  }

  Future<bool> setHistorySettings(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_historySettings, value);
  }

  Future<bool> getHistorySettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_historySettings) ?? true;
  }

  Future<bool> setNotificationsSettings(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_wifiSettings, value);
  }

  Future<bool> getNotificationsSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_wifiSettings) ?? true;
  }
  Future<bool> setGiftExplained(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_giftExplained, value);
  }

  Future<bool> getGiftExplained() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_giftExplained) ?? false;
  }
}
