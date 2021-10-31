import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getSettings(String key) async {
    String _data = await _prefs.then((SharedPreferences prefs) {
      return prefs.getString(key) ?? '';
    });
    return _data;
  }

  void setSettings(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }
}
