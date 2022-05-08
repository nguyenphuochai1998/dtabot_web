import 'dart:html';

import 'package:captone2_dta_bot/app/widgets/menubar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/size.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: marginWebApp,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Image.asset(
                      'assets/images/logo-dtu.png',
                      fit: BoxFit.fitWidth,
                    ),
                    const Spacer(),
                    MenuBar((index) {
                      controller.onChangeMenu(index);
                    },
                        listTitle: controller.menuBarTitle,
                        index: controller.index.value),
                    const Spacer()
                  ],
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Banner')
                      .snapshots(),
                  builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                    var items = snapshot.data?.docs ?? [];
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return CarouselSlider(
                      options: CarouselOptions(
                        height: 400,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: items.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(i['url']));
                          },
                        );
                      }).toList(),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
