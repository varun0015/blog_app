import 'package:blog_app/core/utilies/calculate_reading_time.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/blog.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    final readingTime = calculateReadingTime(blog.content);
    return GestureDetector(
      onTap: () => Navigator.push(context, BlogViewerPage.route(blog),),
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 8.0, // Horizontal spacing between chips
                // runSpacing: 4.0, // Vertical spacing between lines of chips
                children: blog.topics.map((e) => Chip(label: Text(e))).toList(),
              ),
            ),
            Text(
              blog.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              readingTime < 1
                  ? '${(readingTime * 60).ceil()} seconds'
                  : '$readingTime min',
            ),
          ],
        ),
      ),
    );
  }
}
