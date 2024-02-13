import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CommonGradient(
          child: child,
        ),
      ),
    );
  }
}

class CommonGradient extends StatelessWidget {
  const CommonGradient({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Colors.black,
            Colors.black.withOpacity(0.7),
            Colors.grey.withOpacity(0.7),
          ],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
