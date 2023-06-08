import 'dart:convert';
import 'dart:developer';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:pertemuan_11/services/post_services.dart';

import '../models/post.dart';

class PostController {
  Future<List<Post>> fetchAll() async {
    return await PostServices().fetch().then((res) {
      if (res.statusCode == HttpStatus.ok) {
        var jsonBody = jsonDecode(res.body);
        return List.generate(
          jsonBody.Length,
          (index) => Post.fromMap(
            jsonBody[index],
          ),
        );
      } else {
        throw Exception();
      }
    });
  }

  Future<bool> delete(int id) async {
    return await PostServices().delete(id).then((res) {
      inspect(res);
      if (res.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    });
  }
}
