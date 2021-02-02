import 'dart:convert';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datainn/common/ResultBean.dart';
import 'package:flutter_datainn/pages/details/models/CourseVideo.dart';
import 'package:flutter_datainn/pages/home/models/Course.dart';
import 'package:flutter_datainn/utils/Constant.dart';
import 'package:flutter_datainn/utils/HttpClient.dart';
import 'package:video_player/video_player.dart';

class CoursePlayer extends StatefulWidget {
  CoursePlayer({Key key, this.course}):super(key:key);

  final course;

  final String url = 'https://nico-android-apk.oss-cn-beijing.aliyuncs.com/landscape.mp4';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CoursePlayerState(this.course);
  }
}

class _CoursePlayerState extends State<CoursePlayer> {

  List<Widget> videoList;

  Course course;

  String videoUrl;

  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  _CoursePlayerState(Course course) {
    this.course = course;
    this.videoList = [];
    HttpController.post(Constant.baseUrl + "/app/video/list", (data){
      Map<String, dynamic> jsonData = jsonDecode(data);
      ResultBean result = ResultBean.fromJson(jsonData);
      List dataList = result.data;
      var i = 0;
      for (var courseData in dataList) {
        CourseVideo course = CourseVideo.fromJson(courseData);
        Widget widget = _chapterVideoTile(course);
        if (i==0) {
          setState(() {
            videoUrl = "http://"+course.courseVideoUrl;
          });
        }
        setState(() {
          this.videoList.add(widget);
        });
        i++;
      }
    } , params:{"courseId":this.course.courseId} ,errorCallback: (err) {

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    videoPlayerController = VideoPlayerController.network(this.videoUrl);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController, //播放的视频地址写在这里
      aspectRatio: 5/3, //屏幕高宽比
      autoPlay: (this.videoUrl==null)?false:true, //是否自动播放
      looping: false, //是否循环播放

      //fullScreenByDefault:false, //默认情况下全屏
      // isLive:false, //视频长度替换成live字样
    );
    chewieController.addListener(() {
      final bool isFullScreen = chewieController.isFullScreen;
      if (isFullScreen) {
        AutoOrientation.landscapeAutoMode();
        SystemChrome.setEnabledSystemUIOverlays([]);
      } else {

        AutoOrientation.portraitAutoMode();
        SystemChrome.setEnabledSystemUIOverlays(
            [SystemUiOverlay.top, SystemUiOverlay.bottom]);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("第一章"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              viDeoPlayer(),
              Container(
                color: Colors.grey[200],
                child: courseTimeList(),
              )
            ],
          ),
        ),
      )
    );
  }

  Widget viDeoPlayer() {

    //视频播放控件设置
    Widget playerWidget = Chewie(
      controller: chewieController
    );
    return playerWidget; //返回
  }
  
  Widget courseTimeList() {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 15, 0, 15),
                  child: Text(
                    "课程表",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                )
              ),
              SizedBox(height: 1,),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Column(
                    children: this.videoList,
                  ),
                )
              )
            ],
          ),
        ),
    );
  }

  Widget _chapterVideoTile(CourseVideo video) {
    return Column(
      children: [
        ListTile(
          title: Text(video.courseVideoName),
          subtitle: Text("时长 10:20"),
          onTap: (){
            videoPlayerController.pause();
            chewieController.dispose();
            if (mounted) {
              setState(() {
                this.videoUrl = "http://"+video.courseVideoUrl;
              });
            }
          },
        ),
        Divider()
      ],
    );
  }
}