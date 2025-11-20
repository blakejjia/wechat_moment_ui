import 'package:flutter/material.dart';
import 'package:wechat_moment_ui/model/post.dart';
import '../picture_page.dart';
import '../post_details_page.dart';

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // 顶部对齐
        children: [
          // 1. 日期 (最左边)
          SizedBox(
            width: 60, // 给日期一个固定的宽度
            child: Row(
              spacing: 2,
              children: [
                Text(
                  post.date,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    post.month,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12), // 日期和图片之间的间距
          // 2. 正方形图片 (可点击跳转到图片页面)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PicturePage(post: post),
                ),
              );
            },
            child: Container(
              width: 80, // 正方形的宽高
              height: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(post.imageAsset),
                  fit: BoxFit.cover, // 确保图片填满正方形
                ),
              ),
            ),
          ),
          const SizedBox(width: 12), // 图片和文字之间的间距
          // 3. 文字 (右边，可点击跳转到帖子详情页)
          Expanded(
            // Expanded 会让文字自动填充剩余空间并换行
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailsPage(post: post),
                  ),
                );
              },
              child: Text(
                post.text,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
