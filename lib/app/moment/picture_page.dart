import 'package:flutter/material.dart';
import 'package:wechat_moment_ui/app/moment/post_details_page.dart';
import 'package:wechat_moment_ui/model/post.dart';

class PicturePage extends StatefulWidget {
  final Post post;

  const PicturePage({super.key, required this.post});

  @override
  State<PicturePage> createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  bool isLiked = false;
  late int currentLikeCount;

  @override
  void initState() {
    super.initState();
    currentLikeCount = widget.post.likes;
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      currentLikeCount += isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main image
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image
                Image.asset(widget.post.imageAsset, fit: BoxFit.contain),
              ],
            ),
          ),

          // Top navigation bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        widget.post.formattedTimestamp,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz, color: Colors.white),
                      onPressed: () {
                        // Show more options
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom action bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.post.text,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                ),
                // Action buttons
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 8, 16),
                  child: SafeArea(
                    child: Row(
                      children: [
                        // Like button
                        GestureDetector(
                          onTap: _toggleLike,
                          child: Row(
                            children: [
                              Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isLiked ? Colors.red : Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                currentLikeCount > 0
                                    ? '${8 + currentLikeCount}'
                                    : '8',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),

                        // Comment button
                        GestureDetector(
                          onTap: () {
                            // Open comment section
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Comment',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        // Details button
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PostDetailsPage(post: widget.post),
                              ),
                            );
                          },
                          child: const Row(
                            children: [
                              Text(
                                'Details',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
