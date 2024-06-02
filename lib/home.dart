import 'package:flutter/material.dart';

class diary{
  final String date;
  final String title;
  final String diaryText;

  diary(this.date,this.title,this.diaryText);
}

final List diaryModel = [diary("2024/6/2", "test", "ttttest")];//日記ウィジットをaddしていく

Widget modelToHomeDiaryWidget(diary diaryModel){
  final conDate = Container(
    child: Text("${diaryModel.date}"),
  );

  final conDiaryTitle = Container(
    child: Text("${diaryModel.title}"),
  );


  final rowHomeDiaryTop = Row(
    children: [
      conDate,
    ],
  );

  void moreDiary(){
    debugPrint("more");
  }

  final moreButton = ElevatedButton(
    onPressed: moreDiary,
    child: Text("さらに見る"),
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.black12
    ),
  );

  final rowHomeDiaryButtom = Row(
    children: [
      conDiaryTitle,
      moreButton,
    ],
  );

  final colHomeDiary = Column(
    children: [
      rowHomeDiaryTop,
      rowHomeDiaryButtom,
    ],
  );

  return colHomeDiary;
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
      height: 500,
      width: double.infinity,
      color: Colors.black12,
      child: listViewDiary,//diaryList
    );



    void onPressed(){
      debugPrint("addDiary");
    }

    final addDiaryButton = IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      iconSize: 50,
      icon: Icon(
        Icons.add,
      ),
    );

    final conAddButton = Container(
      height: 100,
      alignment: Alignment(0.8,1),
      child: addDiaryButton,
    );


    final col = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        conDiary,
        conAddButton,
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
      body : Center(
        child: col,
      ),
    );
    return homeViewWidget;
  }
}
