// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semaphoreci_flutter_demo/features/detail/detail_page.dart';
import 'package:semaphoreci_flutter_demo/features/home/home_viewmodel.dart';

// ignore: use_key_in_widget_constructors
class MoodSpotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoodSpotPageState();
  }
}

class _MoodSpotPageState extends State<MoodSpotPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: fromHex('#ffffff'),
            body: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: getHorizontalSize(375.00),
                      decoration: AppDecoration.fillWhiteA700,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: getPadding(
                                        left: 20,
                                        top: 10,
                                        right: 20,
                                        bottom: 10),
                                    child: Text("lbl_app_navigation".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: AppStyle.txtRobotoRegular20))),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: getPadding(left: 20),
                                    child: Text("msg_check_your_app".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: AppStyle.txtRobotoRegular16))),
                            Container(
                                height: getVerticalSize(1.00),
                                width: getHorizontalSize(375.00),
                                margin: getMargin(top: 5),
                                decoration: BoxDecoration(
                                    color: ColorConstant.black900))
                          ])),
                  Expanded(
                      child: Align(
                          alignment: Alignment.center,
                          child: SingleChildScrollView(
                              child: Container(
                                  decoration: AppDecoration.fillWhiteA700,
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              onTapIPhone13ProMaxOne();
                                            },
                                            child: Container(
                                                width:
                                                getHorizontalSize(375.00),
                                                decoration:
                                                AppDecoration.fillWhiteA700,
                                                child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Padding(
                                                              padding:
                                                              getPadding(
                                                                  left: 20,
                                                                  top: 10,
                                                                  right: 20,
                                                                  bottom:
                                                                  10),
                                                              child: Text(
                                                                  "msg_iphone_13_pro_m"
                                                                      .tr,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style: AppStyle
                                                                      .txtRobotoRegular20Black900))),
                                                      Container(
                                                          height:
                                                          getVerticalSize(
                                                              1.00),
                                                          width:
                                                          getHorizontalSize(
                                                              375.00),
                                                          margin:
                                                          getMargin(top: 5),
                                                          decoration: BoxDecoration(
                                                              color: ColorConstant
                                                                  .bluegray400))
                                                    ]))),
                                        GestureDetector(
                                            onTap: () {
                                              onTapIPhone13ProMaxTwo();
                                            },
                                            child: Container(
                                                width:
                                                getHorizontalSize(375.00),
                                                decoration:
                                                AppDecoration.fillWhiteA700,
                                                child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Padding(
                                                              padding:
                                                              getPadding(
                                                                  left: 20,
                                                                  top: 10,
                                                                  right: 20,
                                                                  bottom:
                                                                  10),
                                                              child: Text(
                                                                  "msg_iphone_13_pro_m2"
                                                                      .tr,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style: AppStyle
                                                                      .txtRobotoRegular20Black9001))),
                                                      Container(
                                                          height:
                                                          getVerticalSize(
                                                              1.00),
                                                          width:
                                                          getHorizontalSize(
                                                              375.00),
                                                          margin:
                                                          getMargin(top: 5),
                                                          decoration: BoxDecoration(
                                                              color: ColorConstant
                                                                  .bluegray400))
                                                    ])))
                                      ])))))
                ])));
  }

  onTapIPhone13ProMaxOne() {
    Get.toNamed(AppRoutes.iphone13ProMaxOneScreen);
  }

  onTapIPhone13ProMaxTwo() {
    Get.toNamed(AppRoutes.iphone13ProMaxTwoScreen);
  };
}
