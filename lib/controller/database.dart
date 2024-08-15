import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:yuut_admin/Model/product_model.dart';
import 'package:yuut_admin/utils/Const/const_string.dart';
import 'package:path/path.dart' as path;
import 'package:yuut_admin/utils/const/enum_order_status.dart';
import 'package:yuut_admin/utils/helper/snackbar.dart';

class FirebaseDataBase {
  final _db = FirebaseFirestore.instance;

  Future<void> addNewProduct(ProductModel productModel) async {
    final doc = _db.collection(ConstString.productCollection).doc();
    try {
      await doc.set(productModel.toJon(doc.id));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateProductDetail(ProductModel productModel) async {
    final doc = _db
        .collection(ConstString.productCollection)
        .doc(productModel.productId);
    try {
      await doc.update(productModel.toJon(doc.id));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteProduct(String id) async {
    await _db.collection(ConstString.productCollection).doc(id).delete();
  }

  QuerySnapshot<Map<String, dynamic>>? _snapshot;

  Future<QuerySnapshot<Map<String, dynamic>>> getAllProducts() async {
    try {
      _snapshot = await _db.collection(ConstString.productCollection).get();
    } catch (e) {
      log(e.toString());
    }

    return _snapshot!;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getSingleProductDetail(
      String id) async {
    return await _db.collection(ConstString.productCollection).doc(id).get();
  }

//----------------------------STORE IMAGE

  static Future<List<String>> storeImagetoCloud(List<File> imageList) async {
    SettableMetadata metaData = SettableMetadata(contentType: 'image/jpeg');
    final storage = FirebaseStorage.instance;
    List<String> downloadUrls = [];

    for (var image in imageList) {
      try {
        final now = DateTime.now();
        final date = '${now.day}-${now.month}-${now.year}';
        final fileName = path.basename(image.path);
        UploadTask uploadTask = storage
            .ref()
            .child('Products/$date/$fileName')
            .putFile(image, metaData);
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      } catch (e) {
        showWarningMessage('IMAGE UPLOADING FAILED !!');
      }
    }

    return downloadUrls;
  }

  //------------ORDER

  Stream<QuerySnapshot<Map<String, dynamic>>> getOrder(OrderStatus status) {
    return _db
        .collection(ConstString.oderCollection)
        .where('status', isEqualTo: convertOrderStatusToString(status))
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // actionToTheOrder(OrderStatus orderStatus, String orderId) {
  //   if (orderStatus == OrderStatus.processed) {}
  // }

  void _updateOrderStatus(OrderStatus orderStatus, String id) async {
    await _db
        .collection(ConstString.oderCollection)
        .doc(id)
        .update({'status': convertOrderStatusToString(orderStatus)});
  }

  void cancelOrder(OrderStatus orderStatus, String id) {
    _updateOrderStatus(orderStatus, id);
  }

  void proceedOrder(OrderStatus orderStatus, String id) {
    _updateOrderStatus(orderStatus, id);
  }

  void completeOrder(OrderStatus orderStatus, String id) {
    _updateOrderStatus(orderStatus, id);
  }

  // Future<bool> checkTheProductAvailibility(
  //     List<Map<String, dynamic>> listOFProduct) async {
  //   bool isProductAvailable = false;
  //   for (var product in listOFProduct) {
  //     final snapshot = await getSingleProductDetail(product['id']);

  //     if (snapshot.exists) {
  //       ProductModel model =
  //           ProductModel.fromJson(snapshot.data() as Map<String, dynamic>);
  //       if (product['qty'] <= model.quantity) {
  //         isProductAvailable = true;
  //         log('truem');
  //       } else {
  //         isProductAvailable = false;
  //         log('fals');
  //       }
  //     }
  //   }
  //   return isProductAvailable;
  // }

//  reduce product quantity -- if the proceed  the order
  void reduceTheProductQuantity(
      BuildContext context, num quantity, String productId) async {
    final snapshot = await getSingleProductDetail(productId);
    if (snapshot.exists) {
      ProductModel model =
          ProductModel.fromJson(snapshot.data() as Map<String, dynamic>);
      if (model.quantity >= quantity) {
        final updatedQuantity = model.quantity - quantity;

        await _db
            .collection(ConstString.productCollection)
            .doc(productId)
            .update({'quantity': updatedQuantity});
      } else {
        showErrorSnackBar(
            context, 'We dont have enough product to proceed this order');
      }
    }
  }
}
