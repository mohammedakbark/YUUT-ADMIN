import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yuut_admin/Model/order_model.dart';
import 'package:yuut_admin/View/orders/order_detail_page.dart';
import 'package:yuut_admin/utils/const/colors.dart';
import 'package:yuut_admin/utils/const/const.dart';

class SingleOrderTile extends StatelessWidget {
  bool showBottom;
  OrderModel order;
  SingleOrderTile({super.key, required this.order,required this.showBottom});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(createRoute(OrderDetailPage(
          showBottom: showBottom,
          order: order,
        )));
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: ColorResourse.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formateDate(order.timestamp!),
                  style: appTextstyle(color: ColorResourse.grey),
                ),
                Text(
                  _formateTime(order.timestamp!),
                  style: appTextstyle(color: ColorResourse.grey),
                ),
              ],
            ),
            Text(
              'Order ID : ${order.orderId!}',
              style: appTextstyle(color: ColorResourse.black, size: 18),
            ),
          ],
        ),
      ),
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
}
