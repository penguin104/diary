import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class firstViewWidget extends StatelessWidget {
  const firstViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final conName = Container(
      width: 300,
      child: TextField(
        controller: TextEditingController(),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: "ユーザ名を入力",
        ),
      ),
    );

    void onpressed() {
      debugPrint("start diary");
    }

    final conButton = Container(
      alignment: Alignment(0.7, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal, // background
            foregroundColor: Colors.white //forgraund
            ),
        onPressed: onpressed,
        child: Text("さぁ、始めよう!!"),
      ),
    );

    final col = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Welcome Diary!", style: TextStyle(fontSize: 40)),
        conName,
        conButton,
      ],
    );

    final v = Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Please Initial Registration",
          style: TextStyle(
            color: Colors.white,
          ),
        ), //タイトル
      ),
      body: Center(
        child: col,
      ),
    );
    return v;
  }
}
