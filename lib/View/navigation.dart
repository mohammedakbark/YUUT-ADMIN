import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuut_admin/View/home_tabs/mainpage.dart';
import 'package:yuut_admin/View/home_tabs/order_page.dart';
import 'package:yuut_admin/View/home_tabs/users_view.dart';
import 'package:yuut_admin/controller/controller.dart';
import 'package:yuut_admin/utils/const/colors.dart';

class NavigationPage extends StatelessWidget {
  NavigationPage({super.key});
  List<Widget> pages = [MainPage(), MyOrders(), UsersView()];
  @override
  Widget build(BuildContext context) {
    // final controller = Provider.of<Controller>(
    //   context,
    // );
    return Consumer<Controller>(builder: (context, controller, _) {
      return Scaffold(
        body: pages[controller.initialPageIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.initialPageIndex,
            onTap: (index) {
              controller.onChangePage(index);
            },
            selectedItemColor: ColorResourse.black,
            items: const [
              BottomNavigationBarItem(label: '', icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.list),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.people),
              )
            ]),
      );
    });
  }
}
