import 'package:flutter/material.dart';
import 'home.dart';
import 'main.dart';
import 'package:go_router/go_router.dart';
import 'saveFunction.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class newDiary extends StatelessWidget {
  newDiary({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final titleText = TextField(
      controller: titleController,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: "タイトル",
      ),
    );

    final conTitle = Container(
      alignment: Alignment.center,
      width: 300.sp,
      child: titleText,
    );

    final textMain = TextEditingController();
    final mainDiary = TextField(
      controller: textMain,
      maxLines: null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 1.sp),
        border: OutlineInputBorder(),
        labelText: "本文を入力",
      ),
    );
    final conMain = Container(
      width: 400.sp,
      height: 200.sp,
      child: mainDiary,
      alignment: Alignment.center,
    );
    final now = DateTime.now();
    final date =
        DateTime(now.year, now.month, now.day, now.hour, now.minute).toString();
    final dateStringLen = date.length;
    final dateDel = date.substring(16, dateStringLen);
    final dateNow = date.replaceAll(dateDel, "");

    void upLoad(BuildContext context) {
      // diary addDiaryM = diary(dateNow.toString(), titleController.text,
      //     textMain.text, diaryModel.length + 1);
      //
      // diaryModel[addDiaryM.cnt]["cnt"] = addDiaryM.cnt;
      // diaryModel[addDiaryM.cnt]["date"] = addDiaryM.date;
      // diaryModel[addDiaryM.cnt]["title"] = addDiaryM.title;
      // diaryModel[addDiaryM.cnt]["diaryText"] = addDiaryM.diaryText;
      Map add = {
        "cnt": diaryModel.length,
        "date": dateNow.toString(),
        "title": titleController.text,
        "diaryText": textMain.text
      };
      diaryModel.add(add);
      debugPrint(diaryModel.toString());
      textMain.text = ""; //空白にする
      debugPrint(diaryModel.length.toString());
      debugPrint("upload");
      debugPrint(diaryMoreList.toString());

      //上書き保存処理を書く
      // innerDiary();
      // print(diaryModel);

      context.pop(); //go_route to /home
    }

    final newDiaryUp = ElevatedButton(
        onPressed: () {
          upLoad(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
        ),
        child: Text(
          "日記を書き込む",
          style: TextStyle(
            color: Colors.white,
          ),
        ));

    final conButtonNew = Container(
      width: 500.sp,
      child: newDiaryUp,
    );

    final col = Column(
      children: [conTitle, conMain, conButtonNew],
      mainAxisAlignment: MainAxisAlignment.center,
    );
    final conNewDiaryView = Container(
      width: 500.sp,
      child: col,
    );

    final newDiaryScafold = Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        title: Text(
          "New Diary",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: conNewDiaryView,
      ),
    );

    return newDiaryScafold;
  }
}
// 本文のところの大きさなんとか白
