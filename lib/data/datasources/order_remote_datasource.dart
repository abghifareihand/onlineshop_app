import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshop_app/data/datasources/auth_local_datasource.dart';
import 'package:onlineshop_app/data/datasources/request/order_request_model.dart';
import 'package:onlineshop_app/data/models/order_response_model.dart';

import '../../core/constants/variables.dart';

class OrderRemoteDatasource {
  Future<Either<String, OrderResponseModel>> order(
      OrderRequestModel orderRequest) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/order'),
      headers: headers,
      body: orderRequest.toJson(),
    );

    log('Request Order : ${orderRequest.toJson()}');
    log('Response Order : ${response.body}');

    if (response.statusCode == 200) {
      return Right(OrderResponseModel.fromJson(response.body));
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }
}
