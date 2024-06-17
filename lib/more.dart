import 'package:flutter/material.dart';
import 'home.dart';
import 'main.dart';
import 'package:go_router/go_router.dart';
import 'saveFunction.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            // debugPrint(diaryMoreList.cnt.toString());
            // for (int i = 0; i < diaryModel.length; i++) {
            //   if (diaryModel[i].cnt == diaryMoreList.cnt) {
            //     debugPrint("一致");
            //     // diaryMoreList.cnt = i;
            //     diaryModel.removeAt(diaryModel[i].cnt);
            //     delData(diaryModel[i]);
            //   } else {
            //     diaryModel[i].cnt = i;
            //
            //     updateData(diaryModel[i]);
            //   }
            //   // debugPrint("cnt start");
            //   // debugPrint(diaryModel[i].toString());
            // }
            // int j;
            // diaryModelの削除と詰める処理

            var j = 0;
            for (int i = 0; i < diaryModel.length; i++) {
              if (diaryMoreList.cnt == diaryModel[i].cnt) {
                diaryModel.removeAt(i);
                delData(diaryMoreList);
                debugPrint("del data!");
                if (diaryModel.length > 1) {
                  for (j = i; j < diaryModel.length - 1; j++) {
                    diaryModel[j] = diaryModel[j + 1]; //詰める
                    print("shift!");
                  }
                }
              }
              // else {
              //   diaryModel[i].cnt = i;
              // }
            }

            if (diaryModel.isNotEmpty) {
              for (int i = 0; i < diaryModel.length; i++) {
                updateData(diaryModel[i]);
              }
            }

            if (diaryModel.length > 1) {
              //todo 長さで判断したら最後のやつ消したときにエラー出る

              delData(diaryModel[j]);
              diaryModel.removeAt(j);
            }
            loadData();
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
        fontSize: 30.sp,
      ),
    );

    final titleMore = Text(
      "\n${diaryMoreList.title}",
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.teal,
        fontSize: 40.sp,
      ),
    );

    final mainMore = Text(
      "\n ${diaryMoreList.diaryText}",
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.teal,
        fontSize: 30.sp,
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
      padding: EdgeInsets.all(20.sp),
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
      children: [delButton, Text(diaryMoreList.title)],
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
