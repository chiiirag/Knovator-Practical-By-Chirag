import 'package:dio/dio.dart';
import 'package:knovator_practical_by_chirag/src/model/post_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<PostModel>> fetchPosts() async {
    const url = 'https://jsonplaceholder.typicode.com/posts';

    try {
      // Make GET request
      final response = await _dio.get(url);

      // Check if response is successful
      if (response.statusCode == 200) {
        // Parse JSON into a List<Post>
        List<PostModel> posts = (response.data as List)
            .map((postJson) => PostModel.fromJson(postJson))
            .toList();
        return posts;
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } on DioError catch (e) {
      // Dio-specific error handling
      if (e.response != null) {
        throw Exception(
            'Request failed: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      } else {
        throw Exception('Connection error: ${e.message}');
      }
    } catch (e) {
      // General error handling
      throw Exception('Unexpected error: $e');
    }
  }
}
