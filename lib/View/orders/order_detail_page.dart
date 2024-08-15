import 'dart:developer';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:yuut_admin/Model/address_model.dart';
import 'package:yuut_admin/Model/cart_model.dart';
import 'package:yuut_admin/Model/order_model.dart';
import 'package:yuut_admin/Model/product_model.dart';
import 'package:yuut_admin/controller/database.dart';
import 'package:yuut_admin/utils/Const/const.dart';
import 'package:yuut_admin/utils/const/colors.dart';
import 'package:yuut_admin/utils/const/enum_order_status.dart';
import 'package:yuut_admin/utils/helper/snackbar.dart';
import 'package:yuut_admin/utils/widgets/appbar_home.dart';
import 'package:yuut_admin/utils/widgets/custome_button.dart';
import 'package:yuut_admin/utils/widgets/loading_indicator.dart';

class OrderDetailPage extends StatelessWidget {
  bool showBottom;
  OrderModel order;
  OrderDetailPage({super.key, required this.order, required this.showBottom});

  List<Map<String, dynamic>> productData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _orderDeatil(context),
              const SizedBox(
                height: 20,
              ),
              _paymentDetails(context),
              const SizedBox(
                height: 20,
              ),
              _userAddress(context),
              const SizedBox(
                height: 20,
              ),
              _productDetail(context),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: showBottom
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * .1,
                width: MediaQuery.of(context).size.width,
                color: ColorResourse.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomeButton(
                        width: .5,
                        bgColor: ColorResourse.green,
                        onPressed: () {
                          showCustomeDiolog(
                              context, 'Confirm before Proceed this order',
                              onPressedCancel: () {
                            Navigator.pop(context);
                          }, onPressedProceed: () {
                            FirebaseDataBase().proceedOrder(
                                OrderStatus.processed, order.orderId!);
                            showSuccessSnackBar(context, 'Order proceed !!');
                          });
                        },
                        title: 'Proceed'),
                    CustomeButton(
                        width: .3,
                        bgColor: ColorResourse.red,
                        onPressed: () {
                          showCustomeDiolog(
                              context, 'Confirm before cancel this order',
                              onPressedCancel: () {
                            Navigator.pop(context);
                          }, onPressedProceed: () {
                            FirebaseDataBase().cancelOrder(
                                OrderStatus.cancelled, order.orderId!);
                            showErrorSnackBar(context, 'Order cancelled !!');

                            final pop = Navigator.of(context);
                            pop.pop();
                            pop.pop();
                          });
                        },
                        title: 'Cancel')
                  ],
                ),
              ),
            )
          : SizedBox(),
    );
  }

//   -------------------  address  ------------------------
  Widget _userAddress(BuildContext context) {
    AddressModel address = order.address;
    return Column(
      children: [
        Text(
          'Address',
          style: appTextstyle(size: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        _customeBorderContainer(context,
            child: Text(
              '${address.firstName} ${address.lastName}\n${address.streetAddress}\n${address.country},${address.city},${address.area}\nPin : ${address.postCode}\nPhone Number : ${address.phoneNumber}\nEmail : ${address.email} ',
              style: appTextstyle(),
            )),
      ],
    );
  }
//   -------------------  order detail  ------------------------

  Widget _orderDeatil(BuildContext context) {
    return Column(
      children: [
        Text(
          'Order Details',
          style: appTextstyle(size: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        _customeBorderContainer(
          context,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Date',
                    style: appTextstyle(),
                  ),
                  Text(
                    'Order Time',
                    style: appTextstyle(),
                  ),
                  Text(
                    'Order ID',
                    style: appTextstyle(),
                  ),
                  Text(
                    'User ID',
                    style: appTextstyle(),
                  ),
                  Text(
                    'Total Amount',
                    style: appTextstyle(size: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formateDate(order.timestamp!),
                    style: appTextstyle(),
                  ),
                  Text(
                    _formateTime(order.timestamp!),
                    style: appTextstyle(),
                  ),
                  Text(
                    order.orderId!,
                    style: appTextstyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    order.uid,
                    style: appTextstyle(),
                  ),
                  Text(
                    double.parse(order.totalAmout).toString(),
                    style: appTextstyle(size: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

//   -------------------  product detail  ------------------------

  Widget _productDetail(BuildContext context) {
    return Column(
      children: [
        Text(
          'Products',
          style: appTextstyle(size: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: order.products.length,
            itemBuilder: (context, index) {
              CartModel cart = order.products[index];

              return _customeBorderContainer(
                context,
                child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future:
                      FirebaseDataBase().getSingleProductDetail(cart.productId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingAnimatedLogo();
                    }

                    ProductModel product =
                        ProductModel.fromJson(snapshot.data!.data()!);
                    // productData.add(
                    //     {'id': product.productId, 'qty': product.quantity});
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                            height: 100,
                            width: 100,
                            imageUrl: product.image[0]),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                product.name,
                                style: appTextstyle(
                                    size: 20, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Text(
                              cart.productId,
                              style: appTextstyle(
                                  color: ColorResourse.grey,
                                  size: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Quantity: ${cart.quantity.toString()}',
                                    style: appTextstyle(
                                        size: 20, fontWeight: FontWeight.w700),
                                  ),
                                  // Text(
                                  //   '( Available: ${product.quantity.toString()} )',
                                  //   style: appTextstyle(
                                  //       color: product.quantity == 0
                                  //           ? ColorResourse.red
                                  //           : null,
                                  //       size: 10,
                                  //       fontWeight: FontWeight.w500),
                                  // ),
                                ],
                              ),
                            ),
                            Text(
                              'Price: ${product.prize.toString()}',
                              style: appTextstyle(
                                  size: 20, fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              );
            }

            // scrollDirection: Axis.horizontal,
            )
      ],
    );
  }
  //                           payment detail

  Widget _paymentDetails(BuildContext context) {
    SuccessRespose response = order.response;

    return Column(
      children: [
        Text(
          'Payment Details',
          style: appTextstyle(size: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        _customeBorderContainer(
          context,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rezorpay Order ID',
                    style: appTextstyle(),
                  ),
                  Text(
                    'Rezorpay Payement ID',
                    style: appTextstyle(),
                  ),
                  Text(
                    'Rezorpay Signature',
                    style: appTextstyle(),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    response.rezorpayOrderId.isEmpty
                        ? 'N/A'
                        : response.rezorpayOrderId,
                    style: appTextstyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    response.rezorpayPayementId.isEmpty
                        ? 'N/A'
                        : response.rezorpayPayementId,
                    style: appTextstyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    response.rezorpaySignature.isEmpty
                        ? 'N/A'
                        : response.rezorpaySignature,
                    style: appTextstyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  String _formateDate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    return formattedDate;
  }

  String _formateTime(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    String formattedDate = DateFormat('hh:mm a').format(date);
    return formattedDate;
  }

  Widget _customeBorderContainer(BuildContext context,
      {required Widget child}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(border: Border.all(color: ColorResourse.white)),
      child: child,
    );
  }

  showCustomeDiolog(BuildContext context, String message,
      {required void Function()? onPressedCancel,
      required void Function()? onPressedProceed}) {
    final size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const ContinuousRectangleBorder(),
              shadowColor: Colors.transparent,
              backgroundColor: ColorResourse.white,
              title: Text(
                message,
                style: appTextstyle(color: ColorResourse.black),
              ),
              actions: [
                CustomeButton(
                    width: size.width * .4,
                    bgColor: ColorResourse.white,
                    onPressed: onPressedCancel,
                    textColor: ColorResourse.black,
                    title: 'Cancel'),
                CustomeButton(
                    width: size.width * .4,
                    bgColor: ColorResourse.black,
                    onPressed: onPressedProceed,
                    title: 'Confirm')
              ],
            ));
  }
}
