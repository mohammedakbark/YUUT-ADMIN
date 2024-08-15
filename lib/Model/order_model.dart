import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:yuut_admin/Model/address_model.dart';
import 'package:yuut_admin/Model/cart_model.dart';

class OrderModel {
  String uid;
  AddressModel address;
  String? orderId;
  SuccessRespose response;
  List<CartModel> products;
  String status;
  String totalAmout;
  Timestamp ?timestamp;
  OrderModel(
      {this.orderId,
      this.timestamp,
      required this.uid,
      required this.address,
      required this.products,
      required this.response,
      required this.status,
      required this.totalAmout});

  Map<String, dynamic> toJson(id) => {
        'orderId': id,
        'timestamp':Timestamp.now(),
        'uid': uid,
        'address': address.toJson(),
        'response': response.toJson(),
        'status': status,
        'totalAmout': totalAmout,
        'products': products.map((e) => e.toJson()).toList()
      };

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
      orderId: json['orderId'],
      timestamp:json['timestamp'],
      address: AddressModel.fromJson(json['address']),
      uid: json['uid'],
      products: List<CartModel>.from(
          json['products'].map((x) => CartModel.fromJson(x))),
      response: SuccessRespose.fromJson(json['response']),
      status: json['status'],
      totalAmout: json['totalAmout']);
}

class SuccessRespose {
  String rezorpaySignature;
  String rezorpayOrderId;
  String rezorpayPayementId;

  SuccessRespose(
      {required this.rezorpaySignature,
      required this.rezorpayOrderId,
      required this.rezorpayPayementId});

  Map<String, dynamic> toJson() => {
        'rezorpaySignature': rezorpaySignature,
        'rezorpayOrderId': rezorpayOrderId,
        'rezorpayPayementId': rezorpayPayementId
      };

  factory SuccessRespose.fromJson(Map<String, dynamic> json) => SuccessRespose(
      rezorpaySignature: json['rezorpaySignature'],
      rezorpayOrderId: json['rezorpayOrderId'],
      rezorpayPayementId: json['rezorpayPayementId']);
}

// razorpay_signature: null, razorpay_order_id: null, razorpay_payment_id: pay_OhYZmsZgDapvfG