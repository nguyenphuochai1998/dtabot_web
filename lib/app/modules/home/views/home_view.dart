import 'dart:html';

import 'package:captone2_dta_bot/app/widgets/menubar.dart';
import 'package:captone2_dta_bot/app/widgets/newTag.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:get/get.dart';

import '../../../common/colors.dart';
import '../../../common/size.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
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
              stream:
                  FirebaseFirestore.instance.collection('Banner').snapshots(),
              builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                var items = snapshot.data?.docs ?? [];
                if (!snapshot.hasData) {
                  return const SizedBox(
                    height: 400,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 400,
                    aspectRatio: 16 / 9,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 1200),
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 150),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/top.PNG'),
                  SizedBox(
                    width: 40,
                  ),
                  Container(
                      width: 600,
                      height: 300,
                      child: Text(
                        '????o t???o, nghi??n c???u g???n li???n v???i khoa h???c v?? c??ng ngh??? nh???m t???o ra nh???ng sinh vi??n v?? h???c vi??n c?? l??ng y??u n?????c,\n'
                        'c?? ph???m ch???t nh??n v??n mang ?????m b???n s???c Vi???t Nam, c?? ?? th???c sinh ho???t ?????ng c???ng ?????ng, c?? s???c kh???e, c?? n??ng l???c v??\n'
                        'k??? n??ng to??n di???n,t??? tin, n??ng ?????ng, s??ng t???o v?? tr??? th??nh c??ng d??n kh???i nghi???p mang t??nh to??n c???u.',
                        style: TextStyle(fontSize: 25),
                      )),
                  SizedBox(
                    width: 40,
                  ),
                  Image.asset('assets/images/bottom.PNG'),
                ],
              ),
            ),
            Image.asset(
              'assets/images/adv_top_rankingQS1-89.png',
              fit: BoxFit.cover,
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  color: bacgroundAppColor,
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'TIN T???C',
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('News')
                            .snapshots(),
                        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                          var items = snapshot.data?.docs ?? [];
                          if (!snapshot.hasData) {
                            return const SizedBox(
                              height: 400,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return CarouselSlider(
                            options: CarouselOptions(
                              height: 400,
                              aspectRatio: 16 / 9,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 5),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 1200),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            ),
                            items: items.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return NewsTag(
                                      imageUrl: i['urlImage'],
                                      content: i['content']);
                                },
                              );
                            }).toList(),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: 200,
              width: double.infinity,
              color: Color(0xffeff0ef),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "BAN TUY???N SINH ?????I H???C DUY T??N\n",
                      style: const TextStyle(
                          fontSize: 14.0, color: Colors.black, height: 2),
                      children: <TextSpan>[
                        TextSpan(text: '254 Nguy???n V??n Linh - TP ???? N???ng\n'),
                        TextSpan(
                            text: 'Email:',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'tuyensinh@duytan.edu.vn\n'),
                        TextSpan(
                            text: '??i???n tho???i:',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '02363.650403 - 02363.653561\n'),
                        TextSpan(
                            text: 'Hotline:',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '0905.294.390 - 0905.294.391 - 1900.2252'),
                      ],
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      );
    });
  }
}
