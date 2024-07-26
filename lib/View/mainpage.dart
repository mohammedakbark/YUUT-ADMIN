import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuut_admin/View/edit_product.dart';
import 'package:yuut_admin/controller/database.dart';
import 'package:yuut_admin/Model/product_model.dart';
import 'package:yuut_admin/utils/const/colors.dart';
import 'package:yuut_admin/utils/const/const.dart';
import 'package:yuut_admin/View/add_product_page.dart';
import 'package:yuut_admin/utils/widgets/appbar_home.dart';
import 'package:yuut_admin/utils/widgets/drawer.dart';
import 'package:yuut_admin/utils/widgets/loading_indicator.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar,
      drawer: myDrawer,
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          print('--------refresh ----');
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: FirebaseDataBase().getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingAnimatedLogo();
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: appTextstyle(),
                    ),
                  );
                }

                List<ProductModel> listOfProducts = snapshot.data!.docs
                    .map((e) => ProductModel.fromJson(e.data()))
                    .toList();
                return listOfProducts.isEmpty
                    ? Center(
                        child: Text(
                          "No Products",
                          style: appTextstyle(),
                        ),
                      )
                    : GridView.builder(
                        itemCount: listOfProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1 / 2,
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          final product = listOfProducts[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                  aspectRatio: 1 / 1.5,
                                  child: Container(
                                    color: ColorResourse.white,
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        width: 5,
                                      ),
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: product.image.length,
                                      itemBuilder: (context, imageIndex) =>
                                          AspectRatio(
                                        aspectRatio: 1 / 1.5,
                                        child: CachedNetworkImage(
                                            imageUrl:
                                                product.image[imageIndex]),
                                      ),
                                    ),
                                  )),
                              Text(
                                product.name.toUpperCase(),
                                style: appTextstyle(),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "₹ ${product.prize.roundToDouble()}",
                                    style: appTextstyle(),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(createRoute(
                                         EditProduct(productModel: product)));
                                    },
                                    child: Text("EDIT",
                                        style: TextStyle(
                                            color: ColorResourse.white,
                                            decorationColor:
                                                ColorResourse.white,
                                            decoration:
                                                TextDecoration.underline)),
                                  )
                                ],
                              )
                            ],
                          );
                        },
                      );
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorResourse.white,
        onPressed: () {
          Navigator.of(context).push(createRoute(AddProductPage()));
        },
        child: const Icon(
          Icons.file_upload_outlined,
          color: ColorResourse.black,
          size: 28,
        ),
      ),
    );
  }
}
