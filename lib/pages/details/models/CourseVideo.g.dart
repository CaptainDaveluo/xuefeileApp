// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CourseVideo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseVideo _$CourseVideoFromJson(Map<String, dynamic> json) {
  return CourseVideo(
    json['courseVideoId'] as String,
    json['courseVideoName'] as String,
    json['courseVideoUrl'] as String,
    json['courseId'] as String,
    videoLength: json['videoLength'] as String,
    createTime: json['createTime'] as int,
    updateTime: json['updateTime'] as int,
  );
}

Map<String, dynamic> _$CourseVideoToJson(CourseVideo instance) =>
    <String, dynamic>{
      'courseVideoId': instance.courseVideoId,
      'courseVideoName': instance.courseVideoName,
      'courseVideoUrl': instance.courseVideoUrl,
      'courseId': instance.courseId,
      'videoLength': instance.videoLength,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
    };
