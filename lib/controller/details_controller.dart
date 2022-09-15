import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsController extends GetxController {
  final RxInt _index = 0.obs;
  final RxInt _selectedSizeIndex = 1.obs;
  final pageController = PageController();
  final scrollNotifier = ValueNotifier(0.0);

  @override
  void onReady() {
    super.onReady();
    _index.value = 0;
    _selectedSizeIndex.value = 1;
    pageController.addListener(_listener);
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint("dsdds");
    pageController.removeListener(_listener);
    pageController.dispose();
  }

  void _listener() {
    scrollNotifier.value = pageController.page ?? 0;
  }

  updateIndex(int index) {
    _index.value = index;

    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInCubic);
  }

  updateSize(int size) {
    _selectedSizeIndex.value = size;
  }

  get index => _index.value;
  get sizeIndex => _selectedSizeIndex.value;
}
