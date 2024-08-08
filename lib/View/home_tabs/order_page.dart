import 'package:flutter/material.dart';

import 'package:yuut_admin/View/orders/tabs/canceled_order.dart';
import 'package:yuut_admin/View/orders/tabs/completed_order.dart';
import 'package:yuut_admin/View/orders/tabs/new_order.dart';
import 'package:yuut_admin/utils/const/colors.dart';
import 'package:yuut_admin/utils/const/const.dart';
import 'package:yuut_admin/utils/widgets/appbar_home.dart';

class MyOrders extends StatelessWidget {
  MyOrders({super.key});
  List<Widget> tabs = [
    const NewOrder(),
    const CanceledOrder(),
    const CompletedOrder()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                  dividerColor: Colors.transparent,
                  indicatorColor: ColorResourse.white,
                  unselectedLabelStyle: appTextstyle(color: ColorResourse.grey),
                  labelStyle:
                      appTextstyle(fontWeight: FontWeight.bold, size: 15),
                  tabs:const [
                    Tab(
                      text: 'Pending Order',
                    ),
                    Tab(
                      text: 'Canceled Order',
                    ),
                    Tab(
                      text: 'Completed Order',
                    )
                  ]),
              Expanded(
                child: TabBarView(
                  children: tabs,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
