import 'package:get/get.dart';

import '../../model/post_model.dart';

class PostDetailController extends GetxController {
  Rxn<PostModel> post = Rxn();

  @override
  void onInit() {
    super.onInit();
    _getArguments();
  }

  void _getArguments() {
    final args = Get.arguments;
    if (args is Map) {
      if (args.containsKey("post")) {
        post.value = args["post"];
      }
    }
  }
}
