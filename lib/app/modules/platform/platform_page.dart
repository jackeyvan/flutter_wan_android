import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlatformPage extends GetView {
  @override
  Widget build(BuildContext context) {
    print("--------------> PlatformPage build");
    return Center(
      child: Text("公众号"),
    );
  }
}
