import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable(explicitToJson: true)

class AddressList {
  List<AddressModel> addressModel;

  AddressList({
    this.addressModel
  });

  factory AddressList.fromJson(List<dynamic> parsedJson) {
    List<AddressModel> addressModel = List<AddressModel>();
    addressModel = parsedJson.map((e) => _$AddressModelFromJson(e)).toList();

    return AddressList(
      addressModel: addressModel
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AddressModel {
  String address_label;
  String receiver_name;
  String phone_number;
  String address_detail;

  AddressModel({
    String address_label,
    String receiver_name,
    String phone_number,
    String address_detail
  }) : 
  address_label = address_label ?? '',
  receiver_name = receiver_name ?? '',
  phone_number = phone_number ?? '',
  address_detail = address_detail ?? '';

  factory AddressModel.fromJson(Map<String, dynamic>parsedJson) => _$AddressModelFromJson(parsedJson);

  Map<String, Object> toJson() => _$AddressModelToJson(this);
}