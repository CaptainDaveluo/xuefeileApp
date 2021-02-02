
import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'Course.g.dart';

// flutter pub run build_runner build
// flutter pub run build_runner watch

@JsonSerializable()
class Course {
  final String courseId;
  final String courseCategoriesId;
  final String courseName;
  final String courseSummary;
  final String courseTeacher;
  final String showHomePage;
  final String coursePhotoUrl;
  int courseLike;
  double coursePrice;
  int createTime;
  int updateTime;

  Course(this.courseId, this.courseCategoriesId, this.courseName,
      this.courseSummary, this.courseTeacher, this.coursePhotoUrl, {this.showHomePage,
        this.createTime, this.updateTime});

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}