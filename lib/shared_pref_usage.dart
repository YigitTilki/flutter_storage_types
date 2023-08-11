import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storage/main.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/services/local_storage_service.dart';

class SharedPreference extends StatefulWidget {
  const SharedPreference({super.key});

  @override
  State<SharedPreference> createState() => _SharedPreferenceState();
}

class _SharedPreferenceState extends State<SharedPreference> {
  var _selectedGender = Gender.Female;
  var _selectedColors = <String>[];
  var _isStudent = false;
  final TextEditingController _nameController = TextEditingController();
  final LocalStorageService _preferenceService = locator<LocalStorageService>();
  /*final LocalStorageService _preferenceService2 = SharedPrefService();
  final LocalStorageService _preferenceService3 = FileStorageService();*/

  @override
  void initState() {
    super.initState();
    _readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SharedPreference Usage"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Enter Your Name"),
            ),
          ),
          for (var item in Gender.values)
            _buildRadioListTile(describeEnum(item), item),
          for (var item in Colorian.values) _buildCheckedBoxListTile(item),
          SwitchListTile(
            title: const Text("Are you a student"),
            value: _isStudent,
            onChanged: (bool isStudent) {
              setState(
                () {
                  _isStudent = isStudent;
                },
              );
            },
          ),
          TextButton(
            onPressed: () {
              var userInformation = UserInformation(_nameController.text,
                  _selectedGender, _selectedColors, _isStudent);
              _preferenceService.saveData(userInformation);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioListTile(String title, Gender gender) {
    return RadioListTile(
      title: Text(title),
      value: gender,
      groupValue: _selectedGender,
      toggleable: true,
      onChanged: (Gender? selectedGender) {
        setState(
          () {
            _selectedGender = selectedGender!;
          },
        );
      },
    );
  }

  Widget _buildCheckedBoxListTile(Colorian colorian) {
    return CheckboxListTile(
      title: Text(
        describeEnum(colorian),
      ),
      value: _selectedColors.contains(
        describeEnum(colorian),
      ),
      onChanged: (bool? value) {
        if (value == false) {
          _selectedColors.remove(
            describeEnum(colorian),
          );
        } else {
          _selectedColors.add(
            describeEnum(colorian),
          );
        }
        setState(() {});
      },
    );
  }

  void _readData() async {
    var info = await _preferenceService.readData();
    _nameController.text = info.name;
    _selectedGender = info.gender;
    _selectedColors = info.colorian;
    _isStudent = info.isStudent;
    setState(() {});
  }
}
