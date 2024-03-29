import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshop_app/data/datasources/cost_response_model.dart';
import 'package:onlineshop_app/data/models/city_response_model.dart';
import 'package:onlineshop_app/data/models/province_response_model.dart';
import 'package:onlineshop_app/data/models/subdistrict_response_model.dart';
import 'package:onlineshop_app/data/models/tracking_response_model.dart';

import '../../core/constants/variables.dart';

class RajaongkirRemoteDatasource {
  Future<Either<String, ProvinceResponseModel>> getProvince() async {
    final headers = {
      'key': Variables.rajaongkirApiKey,
    };
    final response = await http.get(
      Uri.parse('https://pro.rajaongkir.com/api/province'),
      headers: headers,
    );

    log('Response Province : ${response.body}');

    if (response.statusCode == 200) {
      return Right(ProvinceResponseModel.fromJson(response.body));
    } else {
      final errorMessage =
          jsonDecode(response.body)['rajaongkir']['status']['description'];
      return Left(errorMessage);
    }
  }

  Future<Either<String, CityResponseModel>> getCity(String provinceId) async {
    final headers = {
      'key': Variables.rajaongkirApiKey,
    };
    final response = await http.get(
      Uri.parse('https://pro.rajaongkir.com/api/city?province=$provinceId'),
      headers: headers,
    );

    log('Response City : ${response.body}');

    if (response.statusCode == 200) {
      return Right(CityResponseModel.fromJson(response.body));
    } else {
      final errorMessage =
          jsonDecode(response.body)['rajaongkir']['status']['description'];
      return Left(errorMessage);
    }
  }

  Future<Either<String, SubdistrictResponseModel>> getSubdistrict(
      String cityId) async {
    final headers = {
      'key': Variables.rajaongkirApiKey,
    };
    final response = await http.get(
      Uri.parse('https://pro.rajaongkir.com/api/subdistrict?city=$cityId'),
      headers: headers,
    );

    log('Response Subdistrict : ${response.body}');

    if (response.statusCode == 200) {
      return Right(SubdistrictResponseModel.fromJson(response.body));
    } else {
      final errorMessage =
          jsonDecode(response.body)['rajaongkir']['status']['description'];
      return Left(errorMessage);
    }
  }

  Future<Either<String, CostResponseModel>> getCost(
      String origin, String destination, String courier) async {
    final headers = {
      'key': Variables.rajaongkirApiKey,
    };
    final response = await http.post(
        Uri.parse('https://pro.rajaongkir.com/api/cost'),
        headers: headers,
        body: {
          'origin': origin,
          'originType': 'subdistrict',
          'destination': destination,
          'destinationType': 'subdistrict',
          'weight': '1000',
          'courier': courier,
        });

    log('Response Get Cost : ${response.body}');

    if (response.statusCode == 200) {
      return Right(CostResponseModel.fromJson(response.body));
    } else {
      final errorMessage =
          jsonDecode(response.body)['rajaongkir']['status']['description'];
      return Left(errorMessage);
    }
  }

  Future<Either<String, TrackingResponseModel>> getWaybill(
      String waybill, String courier) async {
    final headers = {
      'key': Variables.rajaongkirApiKey,
    };
    final response = await http.post(
        Uri.parse('https://pro.rajaongkir.com/api/waybill'),
        headers: headers,
        body: {
          'waybill': waybill,
          'courier': courier,
        });

    log('Response Get Cost : ${response.body}');

    if (response.statusCode == 200) {
      return Right(TrackingResponseModel.fromJson(response.body));
    } else {
      final errorMessage =
          jsonDecode(response.body)['rajaongkir']['status']['description'];
      return Left(errorMessage);
    }
  }
}
