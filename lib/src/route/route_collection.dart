import 'package:get/get.dart';
import 'package:knovator_practical_by_chirag/src/view/post/post_view.dart';
import 'package:knovator_practical_by_chirag/src/view/post_detail/post_detail_binding.dart';
import 'package:knovator_practical_by_chirag/src/view/post_detail/post_detail_view.dart';

import '../view/post/post_binding.dart';
import 'route_name.dart';

class RouteCollection {
  static final routePage = [
    GetPage(
      name: RouteName.postRoute,
      page: () => const PostView(),
      binding: PostBinding(),
    ),
    GetPage(
      name: RouteName.postDetailRoute,
      page: () => const PostDetailView(),
      binding: PostDetailBinding(),
    ),
  ];
}
