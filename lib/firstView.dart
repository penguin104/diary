import 'package:flutter/material.dart';

class firstViewWidget extends StatelessWidget {
  const firstViewWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final v = Scaffold(
      body: Center(
        child: Text("diary"),
      ),
    );
    return v;
  }
}
