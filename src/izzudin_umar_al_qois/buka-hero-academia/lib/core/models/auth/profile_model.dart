import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()

class ProfileModels {
  String email;
  String name;
  String profileImage;
  String phone;

  ProfileModels({
    String email,
    String name,
    String profileImage,
    String phone
  }) : 
  email = email ?? '',
  name = name ?? '',
  profileImage = profileImage ?? '',
  phone = phone ?? '';

  factory ProfileModels.fromJson(Map<String, dynamic>parsedJson) => _$ProfileModelsFromJson(parsedJson);

  Map<String, Object> toJson() => _$ProfileModelsToJson(this);
}