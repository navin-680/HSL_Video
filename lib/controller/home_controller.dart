import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
 var jsonResult = [].obs;

  @override
  void onInit() {
    loadJson();
    super.onInit();
  }

  Future<void> loadJson() async {
  String data = await rootBundle.loadString('assets/data.json');
   jsonResult.value = json.decode(data);
}
    
}

