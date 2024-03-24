import 'dart:async';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class DonateController extends GetxController {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  var products = <ProductDetails>[].obs;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  @override
  void onInit() {
    super.onInit();
    _initializePurchase();
    _subscription =
        _inAppPurchase.purchaseStream.listen(_listenToPurchaseUpdated);
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  Future<void> _initializePurchase() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      // Hiển thị thông báo lỗi hoặc xử lý tình trạng này
      print('The store is not available');
      return;
    }
    const Set<String> productIds = {
      'donate_task_1',
      'donate_task_2',
      'donate_task_3',
      'donate_task_4',
      'donate_task_5'
    }; // IDs của các sản phẩm

    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(productIds);
    if (response.notFoundIDs.isNotEmpty) {
      // Xử lý các ID sản phẩm không tìm thấy
      print('The following products were not found: ${response.notFoundIDs}');
    }
    if (response.error != null) {
      // Xử lý lỗi khi truy vấn sản phẩm
      print('Error fetching product list: ${response.error}');
      return;
    }

    products.value =
        response.productDetails; // Lưu trữ thông tin sản phẩm để hiển thị
  }

  void buyProduct(ProductDetails prod) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // Handle pending state
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // Handle error
      } else if (purchaseDetails.status == PurchaseStatus.purchased) {
        if (purchaseDetails.pendingCompletePurchase) {
          _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }
}
