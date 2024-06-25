import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main.dart';
import 'package:go_router/go_router.dart';
import 'saveFunction.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod/riverpod.dart';

class delDialog extends ConsumerWidget {
  const delDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diaryModelSt = ref.watch(diaryModelState);
    final notifier = ref.watch(diaryModelState.notifier);

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
                var j = 0;
                for (int i = 0; i < diaryModelSt.length; i++) {
                  if (diaryMoreList.cnt == diaryModelSt[i].cnt &&
                      diaryMoreList.date == diaryModelSt[i].date) {
                    notifier.state.removeAt(i);
                    delData(diaryMoreList);

                    debugPrint("del data!");
                    if (diaryModelSt.isNotEmpty) {
                      for (j = i; j < diaryModelSt.length - 1; j++) {
                        notifier.state[j] = diaryModelSt[j + 1]; //詰める
                        print("shift!");
                      }
                      if (diaryModelSt.length > 1 &&
                          diaryModelSt[diaryModelSt.length - 1].cnt ==
                              diaryModelSt[diaryModelSt.length - 2].cnt &&
                          diaryModelSt[diaryModelSt.length - 1].title ==
                              diaryModelSt[diaryModelSt.length - 2].title) {
                        diaryModelSt
                            .remove(diaryModelSt[diaryModelSt.length - 1]);
                      }
                    }
                  }
                }

                loadData(ref);
                context.go("/home");
              }),
        ]);
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
