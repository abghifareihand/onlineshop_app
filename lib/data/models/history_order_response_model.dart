import 'dart:convert';

class HistoryOrderResponseModel {
    final int? code;
    final bool? success;
    final String? message;
    final List<HistoryOrder>? data;

    HistoryOrderResponseModel({
        this.code,
        this.success,
        this.message,
        this.data,
    });

    factory HistoryOrderResponseModel.fromJson(String str) => HistoryOrderResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory HistoryOrderResponseModel.fromMap(Map<String, dynamic> json) => HistoryOrderResponseModel(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<HistoryOrder>.from(json["data"]!.map((x) => HistoryOrder.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class HistoryOrder {
    final int? id;
    final int? userId;
    final int? addressId;
    final int? shippingCost;
    final int? totalCost;
    final int? subtotal;
    final String? status;
    final String? paymentMethod;
    final String? paymentVaName;
    final String? paymentVaNumber;
    final dynamic paymentEwallet;
    final String? shippingService;
    final String? shippingResi;
    final String? transactionNumber;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    HistoryOrder({
        this.id,
        this.userId,
        this.addressId,
        this.shippingCost,
        this.totalCost,
        this.subtotal,
        this.status,
        this.paymentMethod,
        this.paymentVaName,
        this.paymentVaNumber,
        this.paymentEwallet,
        this.shippingService,
        this.shippingResi,
        this.transactionNumber,
        this.createdAt,
        this.updatedAt,
    });

    factory HistoryOrder.fromJson(String str) => HistoryOrder.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory HistoryOrder.fromMap(Map<String, dynamic> json) => HistoryOrder(
        id: json["id"],
        userId: json["user_id"],
        addressId: json["address_id"],
        shippingCost: json["shipping_cost"],
        totalCost: json["total_cost"],
        subtotal: json["subtotal"],
        status: json["status"],
        paymentMethod: json["payment_method"],
        paymentVaName: json["payment_va_name"],
        paymentVaNumber: json["payment_va_number"],
        paymentEwallet: json["payment_ewallet"],
        shippingService: json["shipping_service"],
        shippingResi: json["shipping_resi"],
        transactionNumber: json["transaction_number"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "address_id": addressId,
        "shipping_cost": shippingCost,
        "total_cost": totalCost,
        "subtotal": subtotal,
        "status": status,
        "payment_method": paymentMethod,
        "payment_va_name": paymentVaName,
        "payment_va_number": paymentVaNumber,
        "payment_ewallet": paymentEwallet,
        "shipping_service": shippingService,
        "shipping_resi": shippingResi,
        "transaction_number": transactionNumber,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
