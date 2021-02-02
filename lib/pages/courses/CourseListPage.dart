import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datainn/common/ResultBean.dart';
import 'package:flutter_datainn/pages/home/models/Course.dart';
import 'package:flutter_datainn/utils/Constant.dart';
import 'package:flutter_datainn/utils/HttpClient.dart';
import 'package:flutter_datainn/utils/LocalStorage.dart';

class CourseListPage extends StatefulWidget{
  final String keyword;

  CourseListPage({Key key, this.keyword}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CourseListPageState();
  }
}

class _CourseListPageState extends State<CourseListPage> {
  List<Widget> courseList;

  var titleText = "";

  var totalCourses = "共0个课程";

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    this.courseList = [];
    if (widget.keyword == "home") {
      setState(() {
        titleText = "今日推荐";
      });
      HttpController.post(Constant.baseUrl + "/app/homepage", (data){
        parseCourseData(data);
      },errorCallback: (err) {

      });
    } else if(widget.keyword == "star"){
      setState(() {
        titleText = "我的关注";
      });
      var userId = await LocalStorage.getStringItem("userId");
      var param = {
        "userId": ""+userId
      };
      HttpController.post(Constant.baseUrl + "/app/star/list",(data){
        parseCourseData(data);
      },params: param, errorCallback: (err) {

      });
    } else {
      setState(() {
        titleText = "我的课程";
      });
      List<String> myCourses = await LocalStorage.getStringListItem("myCourses");
      String myCoursesIds = "";
      for (String courseId in myCourses) {
        myCoursesIds = myCoursesIds + courseId + ",";
      }
      myCoursesIds = myCoursesIds.substring(0,myCoursesIds.length-1);
      var param = {
        "courseIds": myCoursesIds
      };
      HttpController.post(Constant.baseUrl + "/app/course/courseIds",(data){
        parseCourseData(data);
      },params: param, errorCallback: (err) {

      });
    }
    super.didChangeDependencies();
  }

  void parseCourseData(data) {
    Map<String, dynamic> jsonData = jsonDecode(data);
    ResultBean result = ResultBean.fromJson(jsonData);
    List dataList = result.data;
    var length = dataList.length;
    setState(() {
      totalCourses = "共"+length.toString()+"个课程";
    });
    for (var courseData in dataList) {
      Course course = Course.fromJson(courseData);
      Widget widget = _courseCard(context,course, 100, 58, "10:20", 100);
      setState(() {
        this.courseList.add(widget);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleText,
          style: TextStyle(
            color: Colors.black
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromRGBO(244, 244, 244, 1),
          // height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                color: Color.fromRGBO(244, 244, 244, 1),
                child: Row(
                  children: [
                    SizedBox(width: 15,),
                    Text(
                      totalCourses,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: null,
                      ),
                    ),
                    Text(
                      "最新",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.keyboard_arrow_down),
                          onPressed: null
                      ),
                    ),
                    Text(
                      "筛选",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Image.asset("images/list_filter.png", width: 12,),
                          onPressed: null
                      ),
                    ),
                    SizedBox(width: 10,)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: this.courseList,
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

Widget _courseCard(BuildContext context, Course course, int stars, int comments, String timeLength, int watchNum) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/courseDetail", arguments: course);
      },
      child: Container(
        // color: Colors.white,
        width: MediaQuery.of(context).size.width - 40,
        child: Column(
          children: [
            SizedBox(height: 10,),
            Text(
              course.courseName,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Image.network("http://"+course.coursePhotoUrl),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(width: 10,),
                Text("视频时长: "+ timeLength +"  "+ watchNum.toString() +"人观看", style:TextStyle(fontSize: 12, color: Colors.grey)),
                Expanded(child: Container(child: null,)),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child:Image.asset("images/list_star.png" ,width: 15,),
                ),
                Text(stars.toString(), style:TextStyle(fontSize: 12, color: Colors.grey)),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child:Image.asset("images/list_comment.png" ,width: 15,),
                ),
                Text(comments.toString(), style:TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(width: 15,)
              ],
            ),
            SizedBox(height: 15,),
          ],
        ),
      ),
    )
  );
}