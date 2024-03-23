import 'dart:convert';

class AddressRequestModel {
    final String? name;
    final String? fullAddress;
    final String? phone;
    final String? provId;
    final String? cityId;
    final String? districtId;
    final String? postalCode;
    final bool? isDefault;

    AddressRequestModel({
        this.name,
        this.fullAddress,
        this.phone,
        this.provId,
        this.cityId,
        this.districtId,
        this.postalCode,
        this.isDefault,
    });

    factory AddressRequestModel.fromJson(String str) => AddressRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AddressRequestModel.fromMap(Map<String, dynamic> json) => AddressRequestModel(
        name: json["name"],
        fullAddress: json["full_address"],
        phone: json["phone"],
        provId: json["prov_id"],
        cityId: json["city_id"],
        districtId: json["district_id"],
        postalCode: json["postal_code"],
        isDefault: json["is_default"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "full_address": fullAddress,
        "phone": phone,
        "prov_id": provId,
        "city_id": cityId,
        "district_id": districtId,
        "postal_code": postalCode,
        "is_default": isDefault,
    };
}
