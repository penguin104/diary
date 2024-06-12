import 'package:flutter/material.dart';
import 'home.dart';
import 'main.dart';
import 'package:go_router/go_router.dart';

class delDialog extends StatelessWidget {
  const delDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final dialog = AlertDialog(
      title: Text(
        "日記を消してしまいますか?",
      ),
      actions: [
        GestureDetector(
          child: Text("いいえ"),
          onTap: () {
            context.pop();
          },
        ),
        GestureDetector(
          child: Text("はい"),
          onTap: () {
            // for (int i = 0; i < diaryModel.length; i++) {
            //   diaryModel[i].cnt = i;
            //   debugPrint("cnt start");
            //   debugPrint(diaryModel[i].cnt.toString());
            // }

            // debugPrint(diaryMoreList.cnt.toString());
            diaryModel.removeAt(diaryMoreList.cnt);
            // debugPrint(diaryMoreList.cnt.toString());
            for (int i = 0; i < diaryModel.length; i++) {
              diaryModel[i].cnt = i;
              debugPrint("cnt start");
              debugPrint(diaryModel[i].cnt.toString());
            }
            context.go("/home");
          },
        )
      ],
    );
    return dialog;
  }
}

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

    final delButton = IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return delDialog();
              });
        },
        icon: Icon(Icons.delete));

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
