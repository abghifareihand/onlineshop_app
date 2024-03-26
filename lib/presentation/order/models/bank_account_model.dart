

import 'package:onlineshop_app/core/constants/images.dart';

class BankAccountModel {
  String code;
  final String name;
  final String image;

  BankAccountModel({
    required this.code,
    required this.name,
    required this.image,
  });
}

final banks = [
  BankAccountModel(
    code: 'bri',
    name: 'BRI Virtual Account',
    image: Images.logoBri,
  ),
  BankAccountModel(
    code: 'bca',
    name: 'BCA Virtual Account',
    image: Images.logoBca,
  ),
  BankAccountModel(
    code: 'bni',
    name: 'BNI Virtual Account',
   image: Images.logoBni,
  ),
];

// class BankAccountModel {
//   final int code;
//   final String name;
//   final String image;

//   BankAccountModel({
//     required this.code,
//     required this.name,
//     required this.image,
//   });
// }