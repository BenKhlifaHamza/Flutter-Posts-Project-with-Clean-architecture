import 'dart:convert';

import 'package:clean_architecture_project/core/exceptions/exceptions.dart';
import 'package:clean_architecture_project/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> saveLocalPosts(List<PostModel> listPostModel);
}

const cachedPosts = "CACHED_POSTS";

class PostLocalDataSourceImp extends PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(cachedPosts);

    if (jsonString != null) {
      List jsonDecoded = json.decode(jsonString);

      List<PostModel> jsonToPostModel = jsonDecoded
          .map((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModel);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> saveLocalPosts(List<PostModel> listPostModel) {
    List<Map<String, dynamic>> postModelToJson = listPostModel
        .map<Map<String, dynamic>>((PostModel postModel) => postModel.toJson())
        .toList();

    sharedPreferences.setString(cachedPosts, json.encode(postModelToJson));

    return Future.value(unit);
  }
}
