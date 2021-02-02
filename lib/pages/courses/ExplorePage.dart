import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_datainn/pages/home/models/Course.dart';
import 'package:flutter_datainn/utils/Constant.dart';
import 'package:flutter_datainn/utils/HttpClient.dart';
import 'package:flutter_datainn/widgets/ClassCardItem.dart';

class ExplorePage extends StatefulWidget {
  ExplorePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExplorePageState();
  }
}

class _ExplorePageState extends State<ExplorePage>{
  final controller = TextEditingController();

  int _selectIndex = 0;

  var menuStr = ["语言学习", "移动通信", "操作系统", "软件编程", "考证考试"];
  var categoriesIds = ["0230ddbe4fb80b23f4c1364ac52d4265","35263affb5b950163dfbc1d289446cad","4bcaf4f80ed69f34ab67e16e56ea0fd2","4e5eb9cfaf2d3f3f07e3e5c548ce0a12","8a1e095d317af1467b6748291a83e2e6"];

  Map<String, List<Widget>> courseMap = {};

  List<Widget> currentCourseItems = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    var param = {
      "categoriesIds": "0230ddbe4fb80b23f4c1364ac52d4265,35263affb5b950163dfbc1d289446cad,4bcaf4f80ed69f34ab67e16e56ea0fd2,4e5eb9cfaf2d3f3f07e3e5c548ce0a12,8a1e095d317af1467b6748291a83e2e6"
    };
    currentCourseItems = [];
    HttpController.post(Constant.baseUrl + "/app/course/categories",(data){
      var jsonData = jsonDecode(data);
      if (jsonData["status"] == "200") {
        Map<String, dynamic> catogoriesList = jsonData["data"];
        catogoriesList.forEach((key, value) {
          List<ClassCardItem> courseCardItems = [];
          for (var course in value) {
            Course c = Course.fromJson(course);
            ClassCardItem courseCardItem = ClassCardItem(title:course["courseName"],imageStr: "http://"+course["coursePhotoUrl"],description: "共110节",course: c,);
            setState(() {
              courseCardItems.add(courseCardItem);
            });
          }
          courseMap[key] = courseCardItems;
        });
        setState(() {
          currentCourseItems = courseMap["0230ddbe4fb80b23f4c1364ac52d4265"];
        });
      }
    },params: param, errorCallback: (err) {

    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQueryData.fromWindow(window).padding.top,
            ),
            child: Container(
              height: 65.0,
              child: new Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: new Card(
                      child: new Container(
                    color: Color.fromRGBO(240, 241, 242, 1),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: TextField(
                              controller: controller,
                              decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 0.0),
                                  filled: true,
                                  fillColor: Color.fromRGBO(240, 241, 242, 1),
                                  hintText: '搜索课程和文章',
                                  hintStyle: TextStyle(fontSize: 14),
                                  border: InputBorder.none),
                              // onChanged: onSearchTextChanged,
                            ),
                          ),
                        ),
                        new IconButton(
                          icon: new Icon(Icons.cancel),
                          color: Colors.grey,
                          iconSize: 18.0,
                          onPressed: () {
                            controller.clear();
                          },
                        ),
                      ],
                    ),
                  ))),
            ),
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 80,
                  color: Color.fromRGBO(244, 244, 244, 1),
                  height: MediaQuery.of(context).size.height - 165,
                  child: ListView.builder(
                      itemCount: menuStr.length,
                      itemBuilder: (context, index) {
                        String str = menuStr[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectIndex = index;
                              var cid = categoriesIds[_selectIndex];
                              setState(() {
                                currentCourseItems = courseMap[cid];
                              });
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 80,
                                color: _selectIndex == index
                                    ? Colors.white
                                    : Color.fromRGBO(244, 244, 244, 1),
                                child: Text(str),
                              )
                            ],
                          ),
                        );
                      })),
              Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width - 80,
                        child: Center(
                            child: Stack(
                              children: [
                                Align(
                                  child: Container(
                                    child: Image.asset(
                                      "images/class_banner.png",
                                      width:
                                          MediaQuery.of(context).size.width - 120,
                                    ),
                                  ),
                                ),
                                Align(
                                  child: Text(
                                    "精品课程助力技能进阶",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                )
                              ],
                        )),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "语言学习",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                    textAlign: TextAlign.left,
                                  ),
                                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: currentCourseItems,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
