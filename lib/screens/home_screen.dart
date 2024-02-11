import 'package:carselona_assignment/utils/common_scaffold.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
