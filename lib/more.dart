import 'package:flutter/material.dart';
import 'home.dart';
import 'main.dart';
import 'package:go_router/go_router.dart';

class moreView extends StatelessWidget {
  moreView({super.key});

  @override
  Widget build(BuildContext context) {
    final dateMore = Text(
      "${diaryMoreList.date}",
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.teal,
        fontSize: 30,
      ),
    );

    final titleMore = Text(
      "\n${diaryMoreList.title}",
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.teal,
        fontSize: 40,
      ),
    );

    final mainMore = Text(
      "\n ${diaryMoreList.diaryText}",
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.teal,
        fontSize: 30,
      ),
    );

    final colMore = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        dateMore,
        titleMore,
        mainMore,
      ],
    );

    final conMainText = Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: colMore,
      ),
    );
//todo ダイアログを出して削除
    void delDiary() {
      diaryModel.removeAt(diaryMoreList.cnt);
      debugPrint(diaryMoreList.cnt.toString());
      debugPrint("del");
      context.pop();
    }

    final delButton = IconButton(onPressed: delDiary, icon: Icon(Icons.delete));

    final rowHead = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [Text(diaryMoreList.title), delButton],
    );
    final conHead = Container(
      child: rowHead,
    );

    final sca = Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        title: conHead,
      ),
      body: Center(
        child: conMainText,
      ),
    );

    final conSca = Container(
      child: sca,
    );

    return conSca;
  }
}
