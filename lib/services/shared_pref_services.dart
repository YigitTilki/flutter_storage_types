import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService implements LocalStorageService {
  late final SharedPreferences preferences;
  SharedPrefService() {
    init();
  }

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> saveData(UserInformation userInformation) async {
    final name = userInformation.name;
    final preferences = await SharedPreferences.getInstance();

    preferences.setString("Name", name);
    preferences.setBool("Student", userInformation.isStudent);
    preferences.setInt("Gender", userInformation.gender.index);
    preferences.setStringList("Colorian", userInformation.colorian);
  }

  @override
  Future<UserInformation> readData() async {
    var name = preferences.getString("Name") ?? "";
    var student = preferences.getBool("Student") ?? false;
    var gender = Gender.values[preferences.getInt("Gender") ?? 0];
    var colors = preferences.getStringList("Colorian") ?? <String>[];

    return UserInformation(name, gender, colors, student);
  }
}
