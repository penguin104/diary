import 'package:diary/main.dart';
import 'package:diary/more.dart';
import 'package:diary/newDiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'saveFunction.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod/riverpod.dart';

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

class homeView extends ConsumerStatefulWidget {
  const homeView({Key? key}) : super(key: key);

  @override
  homeState createState() => homeState();
}

class homeState extends ConsumerState<homeView> {
  @override
  void initState() {
    // implement initState
    super.initState();
    print("homeView");
    // Future.delayed(Duration.zero, () {
    //   loadData(ref);
    //   // ref.refresh(diaryModelState);
    // });
  }

  void moreDiary(BuildContext context) {
    context.push("/more");
  }

  @override
  Widget build(BuildContext context) {
    late List<diary> diaryModelSt = ref.watch(diaryModelState);
    var notifire = ref.watch(diaryModelState.notifier);

    final listViewDiary = ListView.builder(
        itemCount: diaryModelSt.length,
        itemBuilder: (c, i) {
          print("listvew$i");
          return modelToHomeDiaryWidget(notifire.state[i], context);
        });

    final conDiary = Container(
      height: 700.sp,
      width: double.infinity,
      child: listViewDiary, //diaryList
    );

    void addDiary(BuildContext context) {
      loadData(ref);
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

    // final col = Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     conDiary,
    //   ],
    // );

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
        child: conDiary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: conAddButton,
    );

    return homeViewWidget;
  }
}
