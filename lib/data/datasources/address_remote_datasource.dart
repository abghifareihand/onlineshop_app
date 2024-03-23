import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshop_app/data/datasources/auth_local_datasource.dart';
import 'package:onlineshop_app/data/datasources/request/address_request_model.dart';
import 'package:onlineshop_app/data/models/address_response_model.dart';

import '../../core/constants/variables.dart';

class AddressRemoteDatasource {
  Future<Either<String, AddressResponseModel>> getAddress() async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/address'),
      headers: headers,
    );

    log('Response Get Address : ${response.body}');

    if (response.statusCode == 200) {
      return Right(AddressResponseModel.fromJson(response.body));
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }

  Future<Either<String, String>> addAddress(
      AddressRequestModel addressRequest) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/address'),
        headers: headers,
        body: addressRequest.toJson());

    log('Response Add Address : ${response.body}');

    if (response.statusCode == 201) {
      final successMessage = jsonDecode(response.body)['message'];
      return Right(successMessage);
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }
}
