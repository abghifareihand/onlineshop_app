import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshop_app/data/datasources/auth_local_datasource.dart';
import 'package:onlineshop_app/data/datasources/request/order_request_model.dart';
import 'package:onlineshop_app/data/models/history_order_response_model.dart';
import 'package:onlineshop_app/data/models/order_detail_response_model.dart';
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

  Future<Either<String, String>> checkPaymentStatus(int orderId) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/order/status/$orderId'),
      headers: headers,
    );

    log('Response Status Order : ${response.body}');

    if (response.statusCode == 200) {
      final success = jsonDecode(response.body)['status'];
      return Right(success);
    } else {
      return const Left('Error');
    }
  }

  Future<Either<String, HistoryOrderResponseModel>> getOrders() async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/order'),
      headers: headers,
    );

    log('Response History Order : ${response.body}');

    if (response.statusCode == 200) {
      return Right(HistoryOrderResponseModel.fromJson(response.body));
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }

  Future<Either<String, OrderDetailResponseModel>> getOrderById(int orderId) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/order/$orderId'),
      headers: headers,
    );

    log('Response Order Detail : ${response.body}');

    if (response.statusCode == 200) {
      return Right(OrderDetailResponseModel.fromJson(response.body));
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }
}
