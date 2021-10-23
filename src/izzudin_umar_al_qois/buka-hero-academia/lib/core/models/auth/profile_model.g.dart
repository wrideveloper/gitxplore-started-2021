// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModels _$ProfileModelsFromJson(Map<String, dynamic> json) {
  return ProfileModels(
    email: json['email'] as String,
    name: json['name'] as String,
    profileImage: json['profileImage'] as String,
    phone: json['phone'] as String,
  );
}

Map<String, dynamic> _$ProfileModelsToJson(ProfileModels instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'profileImage': instance.profileImage,
      'phone': instance.phone,
    };
