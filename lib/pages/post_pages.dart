import 'package:flutter/material.dart';
import 'package:pertemuan_11/controller/post_controller.dart';
import 'package:pertemuan_11/models/post.dart';
import 'package:pertemuan_11/models/comment.dart' as c;

class PostPage extends StatefulWidget {
  const PostPage({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostController postController = PostController();
  late Size size;

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  Future<void> fetchPost() async {
    try {
      await postController.fetchComments(widget.post.id);
    } catch (e) {
      // Handle the exception
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Post"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.post.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                width: size.width,
                child: Text(
                  widget.post.body,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                "Komentar",
              ),
              Expanded(
                child: FutureBuilder<List<c.Comment>>(
                  future: postController.fetchComments(widget.post.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error'),
                      );
                    } else if (snapshot.hasData) {
                      List<c.Comment> comments = snapshot.data!;
                      if (comments.isNotEmpty) {
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(comments[index].name),
                                subtitle: Text(comments[index].body),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: size.height * 0.0005,
                            );
                          },
                          itemCount: comments.length,
                        );
                      } else {
                        return const Center(
                          child: Text("Belum ada komentar"),
                        );
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: SizedBox(
                          width: size.width * 0.2,
                          height: size.width * 0.2,
                          child: const CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return const Text("Err");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
