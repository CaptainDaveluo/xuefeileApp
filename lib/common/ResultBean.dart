

import 'package:json_annotation/json_annotation.dart';

part 'ResultBean.g.dart';

@JsonSerializable()
class ResultBean {
  final String status;
  final String msg;
  final List<dynamic> data;

  ResultBean(this.status,this.msg,{this.data});

  factory ResultBean.fromJson(Map<String, dynamic> json) => _$ResultBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ResultBeanToJson(this);

}