// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

enum Gender { Female, Male, Other }

enum Colorian { YELLOW, RED, BLUE, GREEN, PINK }

class UserInformation {
  final String name;
  final Gender gender;
  final List<String> colorian;
  final bool isStudent;

  UserInformation(this.name, this.gender, this.colorian, this.isStudent);

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "gender": describeEnum(gender),
      "colorian": colorian,
      "isStudent": isStudent
    };
  }

  UserInformation.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        gender = Gender.values.firstWhere(
            (element) => describeEnum(element).toString() == json["gender"]),
        colorian = List<String>.from(json["colorian"]),
        isStudent = json["isStudent"];
}
