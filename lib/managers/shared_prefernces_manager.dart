import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  late SharedPreferences sharedPreferences;
  static SharedPreferencesManager? _instance;

  static SharedPreferencesManager get instance {
    _instance ??= SharedPreferencesManager();
    return _instance!;
  }

  SharedPreferencesManager() {
    initialize();
  }
  Future<void> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
