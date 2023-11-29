import 'dart:convert';

import '../../../../core/exceptions/exceptions.dart';
import '../models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

const baseUrl = "https://jsonplaceholder.typicode.com";
const myHeaders = {"Content-type": "application/json"};

class PostRemoteDataSourceImp extends PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImp({required this.client});

//////////////////////GET ALL POSTS////////////////////////
  @override
  Future<List<PostModel>> getAllPosts() async {
    final response =
        await client.get(Uri.parse("$baseUrl/posts"), headers: myHeaders);

    if (response.statusCode == 200) {
      //final List<Map<String, dynamic>> decodedJson = json.decode(response.body);
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postsModel = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postsModel;
    } else {
      throw ServerException();
    }
  }

//////////////////////Add POST////////////////////////
  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };
    final response = await client.post(Uri.parse("$baseUrl/posts"), body: body);
    if (response.statusCode == 201) {
      return unit;
    } else {
      throw ServerException();
    }
  }

//////////////////////DELETE POST////////////////////////
  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(Uri.parse("$baseUrl/posts/$postId"),
        headers: myHeaders);

    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }

//////////////////////UPDATE POST////////////////////////
  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };
    final response =
        await client.patch(Uri.parse("$baseUrl/posts/$postId"), body: body);

    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }
}
