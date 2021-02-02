import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datainn/pages/details/CoursePlayer.dart';
import 'package:flutter_datainn/pages/home/models/Course.dart';
import 'package:flutter_datainn/utils/Constant.dart';
import 'package:flutter_datainn/utils/HttpClient.dart';
import 'package:flutter_datainn/utils/LocalStorage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CourseDetailPage extends StatefulWidget{
  final course;
  CourseDetailPage({this.course});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CourseDetailPageState(course);
  }
}

class _CourseDetailPageState extends State<CourseDetailPage> with SingleTickerProviderStateMixin{
  TabController _detailTabController;

  Course course;

  String favoriteImage = "";
  final unStarImageSrc = "images/detail_favorites.png";
  final starImageSrc = "images/detail_favorited.png";

  String addToMyCourseImage = "";
  final notAddImageSrc = "images/detail_add.png";
  final addedImageSrc = "images/detail_added.png";

  _CourseDetailPageState(Course course) {
    this.course = course;
  }

  @override
  void initState() {
    super.initState();
    favoriteImage = unStarImageSrc;
    addToMyCourseImage = notAddImageSrc;
    _detailTabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _detailTabController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    var userId = await LocalStorage.getStringItem("userId");
    if (userId != "") {
      var param = {
        "userId": ""+userId,
        "courseId": this.course.courseId
      };
      HttpController.post(Constant.baseUrl + "/app/star/exist", (data) {
        final jsonData = jsonDecode(data);
        if (jsonData["msg"] == "success") {
          if (jsonData["data"] == "true") {
            setState(() {
              favoriteImage = starImageSrc;
            });
          } else {
            setState(() {
              favoriteImage = unStarImageSrc;
            });
          }
        } else {
          Fluttertoast.showToast(msg: jsonData["data"], toastLength: Toast.LENGTH_LONG);
        }
      }, params:param);
      super.didChangeDependencies();
    }
    var myCourses = await LocalStorage.getStringListItem("myCourses");
    var added = false;
    if (myCourses!=null) {
      for (var course in myCourses) {
        if (course == this.course.courseId) {
          added = true;
        }
      }
      if (added) {
        setState(() {
          addToMyCourseImage = addedImageSrc;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromRGBO(244, 244, 244, 1),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top,),
              Stack(
                children: [
                  Image.network("http://"+this.course.coursePhotoUrl, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.width*0.6,),
                  // Image.asset("images/detail_cover.png", width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.width*0.6,),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child:  IconButton(
                            icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white,),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                      )
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top:50),
                      child: IconButton(
                          iconSize: 60,
                          icon: Image.asset("images/video_play_btn.png",),
                          onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_){
                                return CoursePlayer(course: this.course,);
                              }));
                          },
                      ),
                    )
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.6 - 50,),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15),bottomLeft: Radius.zero,bottomRight: Radius.zero)),
                          margin: EdgeInsets.all(0),
                          elevation: 0,
                          child: Container(
                            height: 220,
                            alignment: Alignment.topLeft,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                                  child: Text(
                                    this.course.courseName,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: Text(
                                    "5300人学过 | 难度等级: 中级｜时长：11:36",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  children: [
                                    Padding(padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                      child: Text(
                                        "价格:",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color.fromRGBO(102, 133, 252, 1),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "免费",
                                      // this.course.coursePrice==null?"0.0":this.course.coursePrice.toString(),
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Color.fromRGBO(102, 133, 252, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                _videoToolBar()
                              ],
                            ),
                          ),
                        ),
                      )
                  )
                ],
              ),
              SizedBox(height: 8,),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                height: 50,
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      child: TabBar(
                        labelColor: Colors.black,
                        labelStyle: TextStyle(fontSize: 16),
                        indicatorPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Color.fromRGBO(102, 133, 252, 1),
                        indicatorWeight: 3,
                        tabs: [
                          Tab(
                            text: "详情",
                          ),
                          Tab(text: "评论"),
                        ],
                        controller: _detailTabController,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 3,),
              Container(
                  height: 100,
                  child: TabBarView(
                    controller: _detailTabController,
                    children: [
                      _holderDetail(),
                      _commentsView()
                    ],
                  )
              ),
              SizedBox(height: 8,),
              _moreTitleItem(),
              _recommandCourse()
            ],
          ),
        ),
      ),
    );
  }

  Widget _holderDetail(){
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Image.asset("images/head_icon.png", width: 65, height: 65,),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("赵某某",style: TextStyle(fontSize: 18,),),
              Text("关注人数：800",style: TextStyle(fontSize: 13,color: Colors.grey),),
            ],
          ),
          Expanded(
              child: Container(
                child: null,
              )
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: ButtonTheme(
                minWidth: 80,
                height: 30,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Color.fromRGBO(102, 133, 252, 1))
                  ),
                  color: Colors.white,
                  elevation:0,
                  highlightElevation:0,
                  disabledElevation:0,
                  onPressed: (){},
                  child: Text(
                    '关注',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(102, 133, 252, 1)
                    ),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget _commentsView() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: ClipOval(
              child: Image.asset("images/user_head.jpeg", width: 65, height: 65,),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("鸭蛋儿  ⭐️⭐️⭐️⭐️⭐️",style: TextStyle(fontSize: 18,),),
              SizedBox(height: 10,),
              Text("讲解得很细致，配合练习题效果很好",style: TextStyle(fontSize: 14),overflow: TextOverflow.clip,),
            ],
          ),
        ],
      ),
    );
  }

  Widget _videoToolBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            IconButton(
                icon: Image.asset("images/detail_share.png", height: 25,),
                onPressed: () {
                  Fluttertoast.showToast(msg: "您的设备未安装QQ或微信");
                }
            ),
            Text(
              "分享",
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey
              ),
            )
          ],
        ),
        Column(
          children: [
            IconButton(
                icon: Image.asset(addToMyCourseImage, height: 25,),
                onPressed: () async {
                  if (addToMyCourseImage == notAddImageSrc) {
                    List<String> myCourses = await LocalStorage
                        .getStringListItem("myCourses");
                    if (myCourses==null) {
                      myCourses = new List<String>();
                    }
                    myCourses.add(this.course.courseId);
                    LocalStorage.setStringListItem("myCourses", myCourses);
                    Fluttertoast.showToast(msg: "已添加到我的课程");
                    setState(() {
                      addToMyCourseImage = addedImageSrc;
                    });
                  } else {
                    Fluttertoast.showToast(msg: "课程已经在您的列表中，点击我的课程可查看");
                  }
                }
            ),
            Text(
              addToMyCourseImage==notAddImageSrc?"添加":"已添加",
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey
              ),
            )
          ],
        ),
        Column(
          children: [
            IconButton(
                icon: Image.asset(favoriteImage, height: 25,),
                onPressed: _onStarPressed,
            ),
            Text(
              "收藏",
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey
              ),
            )
          ],
        ),
        Column(
          children: [
            IconButton(
                icon: Image.asset("images/detail_download.png", height: 40,),
                onPressed: () {
                  Fluttertoast.showToast(msg: "您还不是会员，无法下载视频");
                }
            ),
            Text(
              "下载",
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _moreTitleItem() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
              child: Image.asset(
                "images/home_indicator.png",
                height: 20,
              ),
            ),
            Text(
              "推荐课程",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      )
    );
  }

  void _onStarPressed() async {
    var isLogin = await LocalStorage.getBoolItem("isLogin");
    if (isLogin==null || isLogin==false) {
      Fluttertoast.showToast(msg: "您当前未登陆，请先登录!");
      return;
    }
    var userId = await LocalStorage.getStringItem("userId");
    if (favoriteImage == unStarImageSrc) {
      var param = {
        "userId": ""+userId,
        "courseId": this.course.courseId,
      };
      HttpController.post(Constant.baseUrl + "/app/star/save", (data) {
        print(data);
        final jsonData = jsonDecode(data);
        if (jsonData["msg"] == "success") {
          setState(() {
            favoriteImage = starImageSrc;
          });
        } else {
          Fluttertoast.showToast(msg: jsonData["data"], toastLength: Toast.LENGTH_LONG);
        }
      }, params: param);
    } else {
      var param = {
        "userId": ""+userId,
        "courseId": this.course.courseId,
      };
      HttpController.post(Constant.baseUrl + "/app/star/remove", (data) {
        print(data);
        final jsonData = jsonDecode(data);
        if (jsonData["msg"] == "success") {
          setState(() {
            favoriteImage = unStarImageSrc;
          });
        } else {
          Fluttertoast.showToast(msg: jsonData["data"], toastLength: Toast.LENGTH_LONG);
        }
      }, params: param);
    }
  }

  Widget _recommandCourse() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: [
              FlatButton(
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (_) {
                    //   return new CourseDetailPage();
                    // }));
                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                    width:
                    (MediaQuery.of(context).size.width - 60) / 2,
                    child: Column(
                      children: [
                        Image.asset(
                          "images/home_adv1.png",
                          width: (MediaQuery.of(context).size.width -
                              60) /
                              2,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("XD-导航类APP专题UI设计",
                            style: TextStyle(
                                color: Colors.black87, fontSize: 13))
                      ],
                    ),
                  )),
              FlatButton(
                  onPressed: null,
                  padding: EdgeInsets.zero,
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 60) / 2,
                    child: Column(
                      children: [
                        Image.asset(
                          "images/home_adv2.png",
                          width:
                          (MediaQuery.of(context).size.width - 60) /
                              2,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "XD-内容推荐文章页设计与商品详情设计",
                          style: TextStyle(
                              color: Colors.black87,fontSize: 13
                          ),
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}