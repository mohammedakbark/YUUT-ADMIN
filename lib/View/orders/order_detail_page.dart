import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuut_admin/Model/order_model.dart';
import 'package:yuut_admin/utils/widgets/appbar_home.dart';

class OrderDetailPage extends StatelessWidget {
  OrderModel order;
   OrderDetailPage({super.key,required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar,
    );
  }
}
