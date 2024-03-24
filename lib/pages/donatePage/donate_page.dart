import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../manage/controller/donate_controller.dart';

class DonatePage extends StatelessWidget {
  DonatePage({Key? key}) : super(key: key);

  final DonateController controller = Get.put(DonateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Obx(() {
            return Column(
              children:
                  controller.products.map((ProductDetails productDetails) {
                return ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.amber.shade300),
                  ),
                  onPressed: () => controller.buyProduct(productDetails),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        productDetails.title,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 10),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
        ),
      ),
    );
  }
}
