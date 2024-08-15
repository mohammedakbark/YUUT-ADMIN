import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:yuut_admin/Model/product_model.dart';
import 'package:yuut_admin/controller/database.dart';
import 'package:yuut_admin/utils/const/colors.dart';
import 'package:yuut_admin/utils/const/const.dart';
import 'package:yuut_admin/controller/controller.dart';
import 'package:yuut_admin/utils/widgets/appbar_home.dart';
import 'package:yuut_admin/utils/widgets/loading_indicator.dart';
import 'package:yuut_admin/utils/helper/snackbar.dart';

class EditProduct extends StatefulWidget {
  final ProductModel productModel;
  EditProduct({super.key, required this.productModel});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  AnimationController? animationController;

  late TextEditingController nameController;

  late TextEditingController detailController;

  late TextEditingController dimensionController;

  late TextEditingController deliveryAndReturnController;

  late TextEditingController quantityController;

  late TextEditingController priceController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController(text: widget.productModel.name);

    detailController =
        TextEditingController(text: widget.productModel.productDetails);

    dimensionController =
        TextEditingController(text: widget.productModel.productDimensions);

    deliveryAndReturnController =
        TextEditingController(text: widget.productModel.deliveryAndRetturn);

    quantityController =
        TextEditingController(text: widget.productModel.quantity.toString());

    priceController =
        TextEditingController(text: widget.productModel.prize.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final higth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: homeAppBar,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                  return Image.file(
                                      controller.imageList[index]);
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
                    child: _customeTextFied(validator: (value) {
                      if (value!.isEmpty) {
                        return 'The field must not be empty';
                      } else {
                        return null;
                      }
                    }, "NAME", nameController,
                        textInputAction: TextInputAction.done),
                  ),
                  _customeTextFied(
                    "PRODUCT DETAILS",
                    detailController,
                    maxLine: 4,
                    textInputAction: TextInputAction.newline,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'The field must not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  _customeTextFied(
                    "PRODUCT DIMENSIONS",
                    dimensionController,
                    maxLine: 4,
                    textInputAction: TextInputAction.newline,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'The field must not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  _customeTextFied(
                    "DELIVERY & RETURN",
                    deliveryAndReturnController,
                    maxLine: 4,
                    textInputAction: TextInputAction.newline,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'The field must not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    width: width,
                    height: higth * .08,
                    child:
                        Consumer<Controller>(builder: (context, controller, _) {
                      return ListView.builder(
                        itemCount: widget.productModel.sizes.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Center(
                          child: Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: ColorResourse.white,
                                border: Border.all(color: ColorResourse.white)),
                            child: Text(
                              widget.productModel.sizes[index],
                              style: appTextstyle(color: ColorResourse.black),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    width: width,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: _customeTextFied(
                            "PRIZE",
                            priceController,
                            inputtype: TextInputType.number,
                            prefix: "₹ ",
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'The field must not be empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: _customeTextFied(
                            "QUANTITY",
                            quantityController,
                            inputtype: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'The field must not be empty';
                              } else if (int.parse(value) >= 100) {
                                return 'Enter quantity between 1-99';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: higth * .08,
                  ),
                  Center(
                    child: SizedBox(
                      // height: 10,
                      width: width * .33,
                      child: Consumer<Controller>(
                          builder: (context, controller, child) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorResourse.drawerColor,
                              shape: const ContinuousRectangleBorder(),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                showLoadingIndiactor(context);
                                await FirebaseDataBase()
                                    .updateProductDetail(ProductModel(
                                  sizes: [],
                                  productId: widget.productModel.productId,
                                  deliveryAndRetturn:
                                      deliveryAndReturnController.text,
                                  productDetails: detailController.text,
                                  productDimensions: dimensionController.text,
                                  quantity: int.parse(quantityController.text),
                                  image: widget.productModel.image,
                                  name: nameController.text,
                                  prize: double.parse(priceController.text),
                                ));

                                showSuccessMessage("UPDATED SUCCESSFUL");
                                final pop = Navigator.of(context);
                                pop.pop();
                                pop.pop();
                              }
                            },
                            child: Text(
                              "UPDATE NOW",
                              style: appTextstyle(
                                  size: 17,
                                  color: ColorResourse.black,
                                  fontWeight: FontWeight.bold),
                            ));
                      }),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      // height: 10,
                      width: width * .33,
                      child: Consumer<Controller>(
                          builder: (context, controller, child) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorResourse.red,
                              shape: const ContinuousRectangleBorder(),
                            ),
                            onPressed: () async {
                              showLoadingIndiactor(context);
                              await FirebaseDataBase().deleteProduct(
                                  widget.productModel.productId!);
                              showWarningMessage("DELETED !!");
                              final pop = Navigator.of(context);

                              pop.pop();
                              pop.pop();
                            },
                            child: Text(
                              "REMOVE",
                              style: appTextstyle(
                                  size: 17,
                                  color: ColorResourse.white,
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
          border: Border.all(color: ColorResourse.black, width: 4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: ColorResourse.black,
              size: 50,
            ),
            Text(
              text,
              style: appTextstyle(
                fontWeight: FontWeight.bold,
                color: ColorResourse.black,
                letterSpacing: 1,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _customeTextFied(String text, TextEditingController controller,
      {int? maxLine,
      TextInputType? inputtype,
      String? prefix,
      TextInputAction? textInputAction,
      String? Function(String?)? validator}) {
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: inputtype,
          maxLines: maxLine ?? 1,
          controller: controller,
          cursorColor: ColorResourse.white,
          style: appTextstyle(),
          textInputAction: textInputAction,
          // controller: ,
          decoration: InputDecoration(
              prefixText: prefix,
              prefixStyle: appTextstyle(size: 17),
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorResourse.white)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorResourse.white))),
        )
      ],
    );
  }
}
