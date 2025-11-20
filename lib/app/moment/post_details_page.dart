import 'package:flutter/material.dart';
import 'package:wechat_moment_ui/app/moment/picture_page.dart';
import 'package:wechat_moment_ui/model/post.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;

  const PostDetailsPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Details',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white, size: 20),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User header section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        'assets/my_avator.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#*',
                        style: TextStyle(
                          color: Color.fromARGB(255, 125, 144, 169),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      // Post text content
                      if (post.text.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            post.text,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ),

                      // Post image
                      if (post.imageAsset.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PicturePage(post: post),
                              ),
                            ),
                            child: Image.asset(
                              post.imageAsset,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      // Timestamp and delete icon
                      Row(
                        children: [
                          Text(
                            post.formattedTimestamp,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.delete,
                            size: 16,
                            color: Color.fromARGB(255, 125, 144, 169),
                          ),
                          Expanded(
                            child: Container(),
                          ), // Push icons to the right
                          Container(
                            color: Color.from(
                              alpha: 255,
                              red: 25,
                              green: 25,
                              blue: 25,
                            ),
                            child: Icon(
                              Icons.more,
                              size: 16,
                              color: Color.fromARGB(255, 125, 144, 169),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              const SizedBox(height: 24),

              // Likes section (if there are likes)
              if (post.likes > 0)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.red, size: 18),
                      const SizedBox(width: 8),
                      // Show avatar placeholders for likes
                      ...List.generate(
                        post.likes > 2 ? 2 : post.likes,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey[700],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.asset(
                                'assets/avatars/avatar${index + 2}.jpg',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[700],
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      // Bottom navigation bar with comment, emoji and image buttons
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          border: Border(top: BorderSide(color: Colors.grey[900]!, width: 0.5)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Comment',
                      style: TextStyle(color: Colors.grey[600], fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.emoji_emotions_outlined,
                  color: Colors.grey[400],
                  size: 26,
                ),
                const SizedBox(width: 16),
                Icon(Icons.image_outlined, color: Colors.grey[400], size: 26),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
