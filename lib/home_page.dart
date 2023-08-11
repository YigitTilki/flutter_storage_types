import 'package:flutter/material.dart';
import 'package:flutter_storage/shared_pref_usage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Flutter Storage Operations"),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SharedPreference(),
              ),
            );
          },
          child: const Text("Shared Preference / Secure Storage Usage"),
        ),
      ),
    );
  }
}
