import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';

import '../controllers/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          body: Column(
        children: [
          const Text('Admin Page'),
          Container(
            color: Colors.black12,
            child: Column(
              children: [
                const Text('Quản lý file data về các ngành học của chatbot'),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('Data')
                      .doc('dataExel')
                      .get(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.hasError.toString()),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return Row(
                      children: [
                        Text(
                          "File data về ngành học của DTAbot[nếu muốn update bạn nên tải file này về và chỉnh sửa]: ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${snapshot.data?['name']}  ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        GFButton(
                          onPressed: () {
                            controller.launchDownload(snapshot.data?['url']);
                          },
                          text: "Tải Xuống",
                          icon: Icon(
                            Icons.download,
                            color: Colors.lightGreen,
                          ),
                          color: Colors.lightGreen,
                          type: GFButtonType.outline,
                        ),
                      ],
                    );
                  },
                ),
                Row(
                  children: [
                    const Text(
                      "Tải file lên và tự động update :",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    !controller.isLoading.value
                        ? GFButton(
                            onPressed: () {
                              controller.onUploadExel();
                            },
                            text: "Tải file lên",
                            icon: Icon(
                              Icons.upload_outlined,
                              color: Colors.redAccent,
                            ),
                            color: Colors.redAccent,
                            type: GFButtonType.outline,
                          )
                        : SizedBox(),
                    SizedBox(
                      width: 10,
                    ),
                    controller.isLoading.value
                        ? Row(
                            children: const [
                              SizedBox(
                                child: CircularProgressIndicator(
                                  color: Colors.redAccent,
                                ),
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Đang xử lý và upload file')
                            ],
                          )
                        : SizedBox(),
                  ],
                )
              ],
            ),
          )
        ],
      ));
    });
  }
}
