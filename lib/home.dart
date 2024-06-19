import 'package:diary/main.dart';
import 'package:diary/more.dart';
import 'package:diary/newDiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'saveFunction.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod/riverpod.dart';

class diary {
  final String date;
  final String title;
  final String diaryText;
  int cnt;

  Map<String, Object> toMap() {
    return {
      "id": cnt,
      "date": date,
      "title": title,
      "diaryText": diaryText,
      "cnt": cnt,
    };
  }

  // final BuildContext context;
  diary(this.date, this.title, this.diaryText, this.cnt);
}

diary diaryMoreList = diary("", "", "", 0);

// final List<diary> diaryModel = [];

Widget modelToHomeDiaryWidget(diary diaryModelWidget, BuildContext context) {
  //日記リストウィジェット

  final conDate = Container(
    child: Text(
      "${diaryModelWidget.date}",
      style: TextStyle(
        color: Color(0xff4087a6),
      ),
    ),
  );

  final conDiaryTitle = Container(
    width: 250.sp,
    alignment: Alignment.centerLeft,
    child: Text(
      "${diaryModelWidget.title}",
      style: TextStyle(
        fontSize: 25.sp,
        color: Color(0xff87A6FF),
      ),
    ),
  );

  final rowHomeDiaryTop = Row(
    children: [
      conDate,
    ],
  );

  void moreDiary(BuildContext context) {
    diaryMoreList = diary(diaryModelWidget.date, diaryModelWidget.title,
        diaryModelWidget.diaryText, diaryModelWidget.cnt);
    context.push("/more");
    debugPrint(diaryModelWidget.title); //diaryModelを次のページに渡す
    debugPrint("more");
  }

  final moreButton = ElevatedButton(
    onPressed: () {
      moreDiary(context);
    }, //() => {moreDiary(context)},//context問題
    child: Text("more"),
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.cyan, foregroundColor: Colors.white),
  );

  final rowHomeDiaryButtom = Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      conDiaryTitle,
      moreButton,
    ],
  );

  final conRow = Container(
    padding: EdgeInsets.all(10.sp),
    child: rowHomeDiaryButtom,
  );

  final colHomeDiary = Column(
    children: [
      rowHomeDiaryTop,
      conRow,
    ],
  );

  final border = BoxDecoration(
    border: Border.all(width: 5.sp, color: Color(0xff68cbc1)),
    borderRadius: BorderRadius.circular(30.sp),
    color: Color(0xfffffff8),
  );

  final conHomeDiary = Container(
    // color: Colors.teal,
    padding: const EdgeInsets.all(5.0),
    width: double.infinity.sp,
    decoration: border,

    // decoration: BoxDecoration(
    //   border: Border.all(color: Colors.teal),
    //   borderRadius: BorderRadius.circular(10),
    // ),
    child: Center(child: colHomeDiary),
  );

  return conHomeDiary;
}

final diaryModelState = StateProvider<List<diary>>((ref) {
  final List<diary> diaryModel = [];
  return diaryModel;
});

class homeView extends ConsumerWidget {
  homeView({super.key});

  moreDiary(BuildContext context) {
    context.push("/more");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diaryModelSt = ref.watch(diaryModelState); //todo riverpod勉強

    final listViewDiary = ListView.builder(
        itemCount: diaryModelSt.length,
        itemBuilder: (c, i) =>
            modelToHomeDiaryWidget(diaryModelSt[i], context));

    final conDiary = Container(
      height: 700.sp,
      width: double.infinity,
      // color: Colors.black12,
      child: listViewDiary, //diaryList
    );

    void addDiary(BuildContext context) {
      context.push("/new");
      debugPrint("addDiary");
    }

    final conAddButton = Container(
        width: 80.sp,
        height: 80.sp,
        child: FloatingActionButton(
          onPressed: () {
            addDiary(context);
          },
          foregroundColor: Colors.white,
          backgroundColor: Colors.teal,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ));

    final col = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        conDiary,
      ],
    );

    final homeViewWidget = Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: col,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: conAddButton,
    );

    return homeViewWidget;
  }
}
