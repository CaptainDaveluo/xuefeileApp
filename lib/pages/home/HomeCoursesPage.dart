import 'package:flutter/material.dart';
import 'package:flutter_datainn/common/ResultBean.dart';
import 'package:flutter_datainn/pages/home/models/Course.dart';
import 'package:flutter_datainn/utils/Constant.dart';
import 'package:flutter_datainn/utils/HttpClient.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../courses/CourseListPage.dart';
import 'dart:convert';

class HomeCoursesPage extends StatefulWidget {
  HomeCoursesPage({Key key}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeCoursesPageState();
  }
}

class HomeCoursesPageState extends State<HomeCoursesPage> {
  final controller = TextEditingController();

  List<Widget> courseList;

  @override
  void initState() {
    // TODO: implement initState


    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    // Course course = Course("123123","adasda","测试","adasdasda","李白","http://i5xuexi.oss-cn-beijing.aliyuncs.com/program/2020-12-10/5ac30262e090472d98b97fce897fceec-20201210015833.png");
    this.courseList = [];
    HttpController.post(Constant.baseUrl + "/app/homepage", (data){
      Map<String, dynamic> jsonData = jsonDecode(data);
      ResultBean result = ResultBean.fromJson(jsonData);
      List dataList = result.data;
      for (var courseData in dataList) {
        Course course = Course.fromJson(courseData);
        Widget widget = _homeCourseWidget(course);
        setState(() {
          this.courseList.add(widget);
        });
      }
    },errorCallback: (err) {

    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return SingleChildScrollView(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [

              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                  ),
                  child: Container(
                    height: 50.0,
                    child: new Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: new Card(
                            color: Color.fromRGBO(240, 241, 242, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(25.0))),
                            child: new Container(
                              // color: Color.fromRGBO(240, 241, 242, 1),
                              width: MediaQuery.of(context).size.width - 30,
                              child: new Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      // alignment: Alignment.center,
                                      child: TextField(
                                        controller: controller,
                                        textAlignVertical:
                                        TextAlignVertical.top,
                                        decoration: new InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          filled: true,
                                          fillColor: Color.fromRGBO(
                                              240, 241, 242, 1),
                                          hintText: '搜索课程和文章',
                                          hintStyle:
                                          TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                        // onChanged: onSearchTextChanged,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ))),
                  ),
                ),
              ),
              Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(25.0))),
                  ),
                  child: Swiper(
                    itemBuilder: _swiperBuilder,
                    itemCount: 3,
                    pagination: SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                            size: 5,
                            activeSize: 6,
                            color: Colors.black54,
                            activeColor: Colors.white)),
                    scrollDirection: Axis.horizontal,
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _homeButton("images/home_language.png", "语言学习"),
                    _homeButton("images/home_job.png", "职场学习"),
                    _homeButton("images/home_test.png", "考试考证"),
                    _homeButton("images/home_designskill.png", "设计技能"),
                    _homeButton("images/home_interest.png", "兴趣生活"),
                  ],
                ),
              ),
              Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      iconSize: 165,
                      icon: Image.asset("images/home_hotclass.png"),
                    ),
                    IconButton(
                      iconSize: 165,
                      icon: Image.asset("images/home_discount.png"),
                    )
                  ],
                ),
              ),
              _moreTitleItem(),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: this.courseList,
                ),
              )
            ],
          )
      ),
    );
  }

  Widget _moreTitleItem() {
    return Container(
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
            "今日推荐",
            style: TextStyle(fontSize: 18),
          ),
          Expanded(
            child: Container(
              child: null,
            ),
          ),
          SizedBox(
            width: 40,
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder:(_) {
                      return CourseListPage(keyword: "home",);
                    })
                );
              },
              child: Text(
                "更多",
                style: TextStyle(color: Color.fromRGBO(102, 102, 102, 1)),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          SizedBox(
              width: 20,
              child: IconButton(
                iconSize: 17,
                padding: EdgeInsets.zero,
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey,),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder:(_) {
                        return CourseListPage(keyword: "home",);
                      })
                  );
                },
              )),
          SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.asset(
      "images/home_banner.png",
      fit: BoxFit.fill,
    ));
  }

  Widget _homeButton(String imgSrc, String title) {
    return Column(
      children: [
        IconButton(
          icon: Image.asset(imgSrc),
        ),
        Text(title, style: TextStyle(fontSize: 13))
      ],
    );
  }

  Widget _homeCourseWidget(Course course) {
    return FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, "/courseDetail", arguments: course);
          // Navigator.of(context).pushNamed("/courseDetail", arguments: { "course": course});
        },
        padding: EdgeInsets.zero,
        child: Container(
          width: (MediaQuery.of(context).size.width - 60) / 2,
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Image.network("http://"+course.coursePhotoUrl,width:
                (MediaQuery.of(context).size.width - 60) /
                    2,height: 0.6 * (MediaQuery.of(context).size.width - 60)/2),
              ),

              SizedBox(
                height: 5,
              ),
              Text(
                course.courseName,
                style: TextStyle(
                    color: Colors.black87,fontSize: 13
                ),
              )
            ],
          ),
        )
    );
  }
}