
import 'package:json_annotation/json_annotation.dart';

part 'CourseVideo.g.dart';

@JsonSerializable()
class CourseVideo {
  final String courseVideoId;

  final String courseVideoName;

  final String courseVideoUrl;

  final String courseId;

  final String videoLength;

  int createTime;

  int updateTime;

  CourseVideo(this.courseVideoId, this.courseVideoName, this.courseVideoUrl,
      this.courseId, {this.videoLength, this.createTime, this.updateTime});

  factory CourseVideo.fromJson(Map<String, dynamic> json) =>_$CourseVideoFromJson(json);

  Map<String, dynamic> toJson()=>_$CourseVideoToJson(this);
}