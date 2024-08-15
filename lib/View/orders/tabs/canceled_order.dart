import 'package:flutter/material.dart';
import 'package:yuut_admin/Model/order_model.dart';
import 'package:yuut_admin/View/orders/order_detail_page.dart';
import 'package:yuut_admin/View/orders/tabs/widget/single_order_tile.dart';
import 'package:yuut_admin/controller/database.dart';
import 'package:yuut_admin/utils/const/colors.dart';
import 'package:yuut_admin/utils/const/const.dart';
import 'package:yuut_admin/utils/const/enum_order_status.dart';
import 'package:yuut_admin/utils/widgets/loading_indicator.dart';

class CanceledOrder extends StatelessWidget {
  const CanceledOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseDataBase().getOrder(OrderStatus.cancelled),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingAnimatedLogo();
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'No Data',
                style: appTextstyle(),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: appTextstyle(),
              ),
            );
          }
          List<OrderModel> orders = snapshot.data!.docs
              .map((e) => OrderModel.fromJson(e.data()))
              .toList();
          return orders.isEmpty
              ? Center(
                  child: Text(
                    'No Orders',
                    style: appTextstyle(),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    OrderModel order = orders[index];
                    return SingleOrderTile(order: order, showBottom: false);
                  },
                );
        });
  }
}
