import 'package:get/get.dart';
import 'package:knovator_practical_by_chirag/src/view/post/post_controller.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostController());
  }
}
