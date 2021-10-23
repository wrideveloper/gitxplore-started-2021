// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressList _$AddressListFromJson(Map<String, dynamic> json) {
  return AddressList(
    addressModel: (json['addressModel'] as List)
        ?.map((e) =>
            e == null ? null : AddressModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AddressListToJson(AddressList instance) =>
    <String, dynamic>{
      'addressModel': instance.addressModel?.map((e) => e?.toJson())?.toList(),
    };

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return AddressModel(
    address_label: json['address_label'] as String,
    receiver_name: json['receiver_name'] as String,
    phone_number: json['phone_number'] as String,
    address_detail: json['address_detail'] as String,
  );
}

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'address_label': instance.address_label,
      'receiver_name': instance.receiver_name,
      'phone_number': instance.phone_number,
      'address_detail': instance.address_detail,
    };
