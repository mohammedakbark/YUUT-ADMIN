import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:yuut_admin/Model/product_model.dart';
import 'package:yuut_admin/utils/Const/const_string.dart';
import 'package:path/path.dart' as path;
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

  Future<void> updateProductDetail
    (ProductModel productModel) async {
      final doc = _db.collection(ConstString.productCollection).doc(productModel.productId);
      try {
        await doc.update(productModel.toJon(doc.id));
      } catch (e) {
        log(e.toString());
      }
  }

  Future <void> deleteProduct(String id)async{
  await  _db.collection(ConstString.productCollection).doc(id).delete();

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
}
