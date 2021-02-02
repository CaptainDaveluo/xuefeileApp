// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) {
  return Course(
    json['courseId'] as String,
    json['courseCategoriesId'] as String,
    json['courseName'] as String,
    json['courseSummary'] as String,
    json['courseTeacher'] as String,
    json['coursePhotoUrl'] as String,
    showHomePage: json['showHomePage'] as String,
    createTime: json['createTime'] as int,
    updateTime: json['updateTime'] as int,
  )
    ..courseLike = json['courseLike'] as int
    ..coursePrice = (json['coursePrice'] as num)?.toDouble();
}

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'courseId': instance.courseId,
      'courseCategoriesId': instance.courseCategoriesId,
      'courseName': instance.courseName,
      'courseSummary': instance.courseSummary,
      'courseTeacher': instance.courseTeacher,
      'showHomePage': instance.showHomePage,
      'coursePhotoUrl': instance.coursePhotoUrl,
      'courseLike': instance.courseLike,
      'coursePrice': instance.coursePrice,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
    };
