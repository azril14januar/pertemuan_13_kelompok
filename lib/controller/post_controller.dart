import 'dart:convert';
import 'dart:developer';
import 'dart:html';
import 'package:http/http.dart' as http;

import '../models/post.dart';
import '../models/comment.dart';

import '../services/post_services.dart';

class PostController {
  Future<List<Post>> fetchAll() async {
    var res = await PostServices().fetch();
    if (res.statusCode == 200) {
      var jsonBody = jsonDecode(res.body);
      return List.generate(
        jsonBody.length,
        (index) => Post.fromMap(
          jsonBody[index],
        ),
      );
    } else {
      throw Exception();
    }
  }

  Future<List<Comment>> fetchComments(int id) async {
    var res = await PostServices().fetchComments(id);
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      return List.generate(
        jsonData.length,
        (index) => Comment.fromMap(jsonData[index]),
      );
    } else {
      throw Exception();
    }
  }

  Future<bool> delete(int id) async {
    var res = await PostServices().delete(id);
    inspect(res);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
