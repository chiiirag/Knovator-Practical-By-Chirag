import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/post_model.dart';
import 'post_controller.dart';
import 'post_item_view.dart';
import '../../core/const/app_string.dart';

class PostView extends GetView<PostController> {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.posts),
      ),
      body: FutureBuilder<void>(
        future: controller.futurePosts, // Observe initialization process
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              controller.posts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                '${AppString.error}: ${snapshot.error}',
              ),
            );
          } else if (controller.posts.isEmpty) {
            return const Center(
              child: Text(AppString.noPostsFound),
            );
          } else {
            return Obx(
                  () => ListView.separated(
                itemCount: controller.posts.length,
                itemBuilder: (context, index) {
                  final post = controller.posts[index];
                  return PostItemView(
                    post: post,
                    isRead: false, // Example: Track read status dynamically
                    onRead: () {},  // Implement read marking logic
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
