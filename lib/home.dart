import 'package:flutter/material.dart';

class diary {
  final String date;
  final String title;
  final String diaryText;

  diary(this.date, this.title, this.diaryText);
}

final List diaryModel = [
  //test model
  diary("2024/6/2", "test", "ttttest"),
  diary("2024/6/5", "penguin", "penguin"),
  diary("2024/6/2", "test", "ttttest"),
  diary("2024/6/5", "penguin", "penguin"),
  diary("2024/6/2", "test", "ttttest"),
  diary("2024/6/5", "penguin", "penguin"),
  diary("2024/6/2", "test", "ttttest"),
  diary("2024/6/5", "penguin", "penguin"),
  diary("2024/6/2", "test", "ttttest"),
  diary("2024/6/5", "penguin", "penguin"),
  diary("2024/6/2", "test", "ttttest"),
  diary("2024/6/5", "penguin", "penguin"),
  diary("2024/6/2", "test", "ttttest"),
  diary("2024/6/5", "penguin", "penguin"),
  diary("2024/6/2", "test", "ttttest"),
  diary("2024/6/5", "penguin", "penguin"),
  diary("2024/6/2", "test", "ttttest"),
  diary("2024/6/5", "penguin", "penguin"),
  diary("2024/6/2", "test", "ttttest"),
  diary("2024/6/5", "penguin", "penguin"),
  diary("2024/6/2", "test", "ttttest"),
  diary("2024/6/5", "penguin", "penguin"),
  diary("2024/6/2", "test", "ttttest"),
  diary("2024/6/5", "penguin", "penguin"),
  diary("2024/6/2", "test", "ttttest"),
  diary("2024/6/5", "penguin", "penguin"),
]; //日記ウィジットをaddしていく

Widget modelToHomeDiaryWidget(diary diaryModel) {
  //日記リストウィジェット
  final conDate = Container(
    child: Text("${diaryModel.date}"),
  );

  final conDiaryTitle = Container(
    width: 250,
    alignment: Alignment.centerLeft,
    child: Text(
      "${diaryModel.title}",
      style: TextStyle(
        fontSize: 25,
        color: Colors.white,
      ),
    ),
  );

  final rowHomeDiaryTop = Row(
    children: [
      conDate,
    ],
  );

  void moreDiary() {
    debugPrint(diaryModel.title); //diaryModelを次のページに渡す
    debugPrint("more");
  }

  final moreButton = ElevatedButton(
    onPressed: moreDiary,
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

  final conHomeDiary = Container(
    color: Colors.cyan.shade300,
    child: colHomeDiary,
  );

  return conHomeDiary;
}

class homeView extends StatelessWidget {
  const homeView({super.key});

  @override
  Widget build(BuildContext context) {
    final listViewDiary = ListView.builder(
      itemCount: diaryModel.length,
      itemBuilder: (c, i) => modelToHomeDiaryWidget(diaryModel[i]),
    );

    final conDiary = Container(
      height: 700,
      width: double.infinity,
      color: Colors.black12,
      child: listViewDiary, //diaryList
    );

    void addDiary() {
      debugPrint("addDiary");
    }

    final conAddButton = Container(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () {
            addDiary();
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
