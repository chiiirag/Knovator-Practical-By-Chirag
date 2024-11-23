import 'package:get/get.dart';
import 'package:knovator_practical_by_chirag/src/view/post_detail/post_detail_controller.dart';

class PostDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostDetailController());
  }
}
