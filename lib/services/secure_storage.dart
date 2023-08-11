import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/services/local_storage_service.dart';

class SecureStorageService implements LocalStorageService {
  late final FlutterSecureStorage preferences;
  SecureStorageService() {
    preferences = const FlutterSecureStorage();
  }
  @override
  Future<void> saveData(UserInformation userInformation) async {
    final name = userInformation.name;

    await preferences.write(key: "Name", value: name);
    await preferences.write(
        key: "Student", value: userInformation.isStudent.toString());
    await preferences.write(
        key: "Gender", value: userInformation.gender.index.toString());
    await preferences.write(
        key: "Colorian", value: jsonEncode(userInformation.colorian));
  }

  @override
  Future<UserInformation> readData() async {
    var name = await preferences.read(key: "Name") ?? "";

    var studentString = await preferences.read(key: "Student") ?? "false";
    var student = studentString.toLowerCase() == "true" ? true : false;

    var genderString = await preferences.read(key: "Gender") ?? "0";
    var gender = Gender.values[int.parse(genderString)];

    var colorianString = await preferences.read(key: "Colorian");
    var colorian = colorianString == null
        ? <String>[]
        : List<String>.from(jsonDecode(colorianString));

    return UserInformation(name, gender, colorian, student);
  }
}
