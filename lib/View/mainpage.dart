import 'package:flutter/material.dart';
import 'package:yuut_admin/Const/colors.dart';
import 'package:yuut_admin/Const/const.dart';
import 'package:yuut_admin/View/add_product_page.dart';
import 'package:yuut_admin/View/utils/appbar_home.dart';
import 'package:yuut_admin/View/utils/drawer.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar,
      drawer: myDrawer,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 2,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1.5,
                  child: Container(
                    color: white,
                  ),
                ),
                Text(
                  "YUUT EBROK",
                  style: appTextstyle(),
                ),
                Text(
                  "₹ 100.00",
                  style: appTextstyle(),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: white,
        onPressed: () {
          Navigator.of(context).push(createRoute( AddProductPage()));
        },
        child: Icon(
          Icons.file_upload_outlined,
          color: black,
          size: 28,
        ),
      ),
    );
  }
}
