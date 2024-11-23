import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/post_model.dart';
import '../../core/api_service/api_service.dart';

class PostController extends GetxController {
  var posts = <PostModel>[].obs; // Observable for UI updates
  late Future<void> futurePosts; // Future to control the loading state

  @override
  void onInit() {
    super.onInit();
    futurePosts = _initializePosts();
  }

  Future<void> _initializePosts() async {
    // Step 1: Load cached posts from local storage
    await _loadCachedPosts();

    // Step 2: Fetch posts from the API and sync local storage
    await _fetchAndSyncPosts();
  }

  Future<void> _loadCachedPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedPostsJson = prefs.getString('cached_posts');

    if (cachedPostsJson != null) {
      List<dynamic> cachedList = jsonDecode(cachedPostsJson);
      posts.value = cachedList.map((e) => PostModel.fromJson(e)).toList();
    }
  }

  Future<void> _fetchAndSyncPosts() async {
    try {
      List<PostModel> apiPosts = await ApiService().fetchPosts();

      // Update UI with fresh data
      posts.value = apiPosts;

      // Save fresh data to local storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(
        'cached_posts',
        jsonEncode(apiPosts.map((e) => e.toJson()).toList()),
      );
    } catch (e) {
      // Handle API errors gracefully
      Get.snackbar('Error', 'Failed to fetch posts: $e');
    }
  }
}
