import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:yuut_admin/Const/colors.dart';
import 'package:yuut_admin/Const/const.dart';
import 'package:yuut_admin/View%20Model/controller.dart';
import 'package:yuut_admin/View/utils/appbar_home.dart';
import 'package:yuut_admin/View/utils/snackbar.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({super.key});
  AnimationController? animationController;
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final higth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // List<File> pickedFile = [];
    return Scaffold(
        appBar: homeAppBar,
        body: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 2,
                  child: Builder(builder: (context) {
                    return InkWell(
                      onTap: () {
                        showBottomSheet(
                          transitionAnimationController: animationController,
                          enableDrag: true,
                          context: context,
                          builder: (context) {
                            return AspectRatio(
                                aspectRatio: 2,
                                child: SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 5,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              color: black,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(2))),
                                        ),
                                        Consumer<Controller>(builder:
                                            (context, controller, child) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              _customeButton(higth, width,
                                                  Icons.image, "GALLERY", () {
                                                controller
                                                    .pickImagesFormGallery();
                                                Navigator.of(context).pop();
                                              }),
                                              _customeButton(
                                                  higth,
                                                  width,
                                                  Icons.camera_alt,
                                                  "CAMERA", () {
                                                controller
                                                    .pickImageFromCamera();
                                                Navigator.of(context).pop();
                                              })
                                            ],
                                          );
                                        }),
                                        const SizedBox()
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        );
                        // Scaffold.of(context).showBottomSheet((context) {
                        //   return AspectRatio(
                        //     aspectRatio: 2,
                        //     child: Container(),
                        //   );
                        // });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration:
                            BoxDecoration(border: Border.all(color: white)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.system_update_alt_outlined,
                              color: white,
                              size: 30,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "UPLOAD IMAGE",
                              style: appTextstyle(),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Consumer<Controller>(
                      builder: (context, controller, child) {
                    return controller.imageList.isEmpty
                        ? const SizedBox()
                        : SizedBox(
                            height: 100,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 5,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.imageList.length,
                              itemBuilder: (context, index) {
                                // print(pickedFile[index].path);
                                return Image.file(controller.imageList[index]);
                              },
                            ),
                          );
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(right: width * .2),
                  child: _customeTextFied("NAME", nameController),
                ),
                _customeTextFied("DESCRIPTION", descriptionController,
                    maxLine: 3),
                Padding(
                  padding: EdgeInsets.only(right: width * .7),
                  child: _customeTextFied("PRIZE", priceController,
                      inputtype: TextInputType.number, prefix: "₹ "),
                ),
                SizedBox(
                  height: higth * .08,
                ),
                // Expanded(child: SizedBox()),
                Center(
                  child: SizedBox(
                    // height: 10,
                    width: width * .33,
                    child: Consumer<Controller>(
                        builder: (context, controller, child) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const ContinuousRectangleBorder(),
                          ),
                          onPressed: () {
                            showSuccessMessage("PRODUCT ADDED SUCCESSFUL");
                            // controller.dispiseImage();
                            // showSuccessMessage(
                            //     context, "PRODUCT ADDED SUCCESSFUL");
                            // Navigator.of(context).pop();

                            // Navigator.of(context).pushAndRemoveUntil(
                            //     createRoute(const ProductViewPageMobile()),
                            //     (route) => false);
                            // showLoadingIndiactor(context);
                          },
                          child: Text(
                            "UPLOAD NOW",
                            style: appTextstyle(
                                size: 17,
                                color: black,
                                fontWeight: FontWeight.bold),
                          ));
                    }),
                  ),
                ),
                SizedBox(
                  height: higth * .02,
                )
              ],
            ),
          ),
        ));
  }

  Widget _customeButton(
      higth, width, IconData icon, String text, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: higth * .12,
        width: width * .4,
        decoration: BoxDecoration(
          // color: black,
          border: Border.all(color: black, width: 4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: black,
              size: 50,
            ),
            Text(
              text,
              style: appTextstyle(
                fontWeight: FontWeight.bold,
                color: black,
                letterSpacing: 1,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _customeTextFied(String text, TextEditingController controller,
      {int? maxLine, TextInputType? inputtype, String? prefix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          text,
          style: appTextstyle(),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          keyboardType: inputtype,
          maxLines: maxLine ?? 1,
          controller: controller,
          cursorColor: white,
          style: appTextstyle(),
          // controller: ,
          decoration: InputDecoration(
              prefixText: prefix,
              prefixStyle: appTextstyle(size: 17),
              enabledBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: white)),
              focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: white))),
        )
      ],
    );
  }
}
