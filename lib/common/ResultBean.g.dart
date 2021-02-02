// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResultBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultBean _$ResultBeanFromJson(Map<String, dynamic> json) {
  return ResultBean(
    json['status'] as String,
    json['msg'] as String,
    data: json['data'] as List,
  );
}

Map<String, dynamic> _$ResultBeanToJson(ResultBean instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'data': instance.data,
    };
