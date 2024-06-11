import 'package:diary/main.dart';
import 'package:diary/more.dart';
import 'package:diary/newDiary.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class diary {
  final String date;
  final String title;
  final String diaryText;
  final int cnt;

  // final BuildContext context;
  diary(this.date, this.title, this.diaryText, this.cnt);
}

diary diaryMoreList = diary("", "", "", 0);

final List diaryModel = [
  // //test model
  // diary("2024/6/2", "test", "ttttest"),
  // diary("2024/6/5", "penguin", "penguin"),
  // diary("2024/6/2", "test", "ttttest"),
  // diary("2024/6/5", "penguin", "penguin"),
  // diary("2024/6/2", "test", "ttttest"),
  // diary("2024/6/5", "penguin", "penguin"),
  // diary("2024/6/2", "test", "ttttest"),
  // diary("2024/6/5", "penguin", "penguin"),
  // diary("2024/6/2", "test", "ttttest"),
  // diary("2024/6/5", "penguin", "penguin"),
  // diary("2024/6/2", "test", "ttttest"),
  // diary("2024/6/5", "penguin", "penguin"),
  // diary("2024/6/2", "test", "ttttest"),
]; //日記ウィジットをaddしていく

Widget modelToHomeDiaryWidget(diary diaryModel, BuildContext context) {
  //日記リストウィジェット

  final conDate = Container(
    child: Text(
      "${diaryModel.date}",
      style: TextStyle(
        color: Color(0xff4087a6),
      ),
    ),
  );

  final conDiaryTitle = Container(
    width: 250,
    alignment: Alignment.centerLeft,
    child: Text(
      "${diaryModel.title}",
      style: TextStyle(
        fontSize: 25,
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
    diaryMoreList = diary(diaryModel.date, diaryModel.title,
        diaryModel.diaryText, diaryModel.cnt);
    context.push("/more");
    debugPrint(diaryModel.title); //diaryModelを次のページに渡す
    debugPrint("more");
  }

  final moreButton = ElevatedButton(
    onPressed: () {
      moreDiary(context);
    }, //() => {moreDiary(context)},//context問題
    child: Text("さらに見る"),
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
    padding: EdgeInsets.all(10),
    child: rowHomeDiaryButtom,
  );

  final colHomeDiary = Column(
    children: [
      rowHomeDiaryTop,
      conRow,
    ],
  );

  final border = BoxDecoration(
    border: Border.all(width: 5, color: Color(0xff68cbc1)),
    borderRadius: BorderRadius.circular(30),
    color: Color(0xfffffff8),
  );

  final conHomeDiary = Container(
    // color: Colors.teal,
    padding: const EdgeInsets.all(5.0),
    width: double.infinity,
    decoration: border,

    // decoration: BoxDecoration(
    //   border: Border.all(color: Colors.teal),
    //   borderRadius: BorderRadius.circular(10),
    // ),
    child: Center(child: colHomeDiary),
  );

  return conHomeDiary;
}

class homeView extends StatelessWidget {
  homeView({super.key});

  moreDiary(BuildContext context) {
    context.push("/more");
  }

  @override
  Widget build(BuildContext context) {
    final listViewDiary = ListView.builder(
      itemCount: diaryModel.length,
      itemBuilder: (c, i) => modelToHomeDiaryWidget(diaryModel[i], context),
    );

    final conDiary = Container(
      height: 700,
      width: double.infinity,
      // color: Colors.black12,
      child: listViewDiary, //diaryList
    );

    void addDiary(BuildContext context) {
      context.push("/new");
      debugPrint("addDiary");
    }

    final conAddButton = Container(
        width: 80,
        height: 80,
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
