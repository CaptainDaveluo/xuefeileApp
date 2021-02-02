
import 'package:flutter/material.dart';
import 'package:flutter_datainn/pages/courses/CourseListPage.dart';
import 'package:flutter_datainn/pages/courses/ExplorePage.dart';
import 'package:flutter_datainn/pages/details/CourseDetailPage.dart';
import 'package:flutter_datainn/pages/home/HomePage.dart';
import 'package:flutter_datainn/pages/login/LoginPage.dart';
import 'package:flutter_datainn/pages/messages/MessagePage.dart';
import 'package:flutter_datainn/pages/mine/MinePage.dart';
import 'package:flutter_datainn/pages/Tabs.dart';

final routes = {
  '/tabs':(context)=>Tabs(),
  '/home':(context)=>HomePage(),
  '/explore':(context)=>ExplorePage(),
  '/mine':(context)=>MinePage(),
  '/message':(context)=>MessagePage(),
  '/courselist':(context)=>CourseListPage(),
  '/courseDetail':(context, {arguments})=>CourseDetailPage(course: arguments,),
  '/login':(context)=>LoginPage(),
};

//ignore: missing_return, top_level_function_literal_block
var onGenerateRoute=(RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if(pageContentBuilder !=null){

    if(settings.arguments !=null){
      final Route route = MaterialPageRoute(
          builder: (context) =>pageContentBuilder(context,arguments:settings.arguments)
      );
      return route;
    }else{
      final Route route = MaterialPageRoute(
          builder: (context)=>pageContentBuilder(context)
      );
      return route;
    }
  }
};