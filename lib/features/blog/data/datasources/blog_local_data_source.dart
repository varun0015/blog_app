import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImpl(this.box);

  // @override
  // void uploadLocalBlogs({required List<BlogModel> blogs}) {
  //   box.clear();
  //   box.add(() {
  //     for (int i = 0; i < blogs.length; i++) {
  //       box.put(i.toString(), blogs[i].toJSON());
  //     }
  //   });
  // }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();
    for (int i = 0; i < blogs.length; i++) {
      box.put(i.toString(), blogs[i].toJSON());
    }
  }

  // @override
  // List<BlogModel> loadBlogs() {
  //   List<BlogModel> blogs = [];
  //   for (int i = 0; i < box.length; i++) {
  //     blogs.add(BlogModel.fromJSON(box.get(i.toString())));
  //   }
  //   return blogs;
  // }

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    for (int i = 0; i < box.length; i++) {
      final raw = box.get(i.toString());
      // Explicit cast here
      final Map<String, dynamic> json = Map<String, dynamic>.from(raw);
      blogs.add(BlogModel.fromJSON(json));
    }
    return blogs;
  }
}
