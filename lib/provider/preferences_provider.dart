import 'package:dicoding_restaurant_app/utils/preferences_helper.dart';
import 'package:flutter/material.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  bool _isDailyNotificationActive = false;
  bool get isDailyNotificationActive => _isDailyNotificationActive;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyNotificationPreferences();
  }

  void enableDailyNotification(bool value) {
    preferencesHelper.setDailyNotification(value);
    _getDailyNotificationPreferences();
  }

  void _getDailyNotificationPreferences() async {
    _isDailyNotificationActive =
        await preferencesHelper.isDailyNotificationActive;
    notifyListeners();
  }
}
