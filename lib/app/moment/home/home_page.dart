import 'package:flutter/material.dart';
import 'package:wechat_moment_ui/app/moment/home/post_tile.dart';
import 'package:wechat_moment_ui/model/post.dart';

class MomentHomePage extends StatefulWidget {
  const MomentHomePage({super.key});

  @override
  State<MomentHomePage> createState() => _MomentHomePageState();
}

class _MomentHomePageState extends State<MomentHomePage> {
  late ScrollController _scrollController;

  // 1. 定义状态变量
  Color _appBarColor = Colors.transparent;
  double _titleOpacity = 0.0;
  double _appBarElevation = 0.0;

  // 2. 定义目标颜色和渐变范围
  final Color _targetColor = Color.fromRGBO(25, 25, 25, 1);
  final double _fadeStart = 200.0;
  final double _fadeEnd = 240.0; // 渐变范围 (200 -> 300)

  // 3. 定义 "Child 1" (你的头部) 的高度
  // 既然渐变在 310 结束，我们假设 Child 1 的高度就是 310
  final double _headerHeight = 310.0;

  IconData _cameraIcon = Icons.camera_alt;
  final double _iconChangeThreshold = 240.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateAppBar); // 添加监听器
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateAppBar);
    _scrollController.dispose();
    super.dispose();
  }

  // 4. 核心逻辑：监听滚动并计算渐变
  void _updateAppBar() {
    double offset = _scrollController.offset;
    double progress;

    if (offset < _fadeStart) {
      // 滚动在渐变区之前
      progress = 0.0;
    } else if (offset >= _fadeStart && offset <= _fadeEnd) {
      // 正在渐变区域
      // 计算 (0.0 到 1.0) 的进度
      progress = (offset - _fadeStart) / (_fadeEnd - _fadeStart);
    } else {
      // 滚动超过渐变区
      progress = 1.0;
    }

    // progress.clamp(0.0, 1.0) 确保值总是在 0 和 1 之间
    progress = progress.clamp(0.0, 1.0);

    // 5. 更新状态
    setState(() {
      IconData newCameraIcon;
      if (offset < _iconChangeThreshold) {
        newCameraIcon = Icons.camera_alt; // 300 以下是实心
      } else {
        newCameraIcon = Icons.camera_alt_outlined; // 300 及以上是空心
      }
      // Color.lerp 在两种颜色之间进行线性插值
      _appBarColor = Color.lerp(Colors.transparent, _targetColor, progress)!;
      _titleOpacity = progress;
      _appBarElevation = progress * 4.0; // 阴影也渐变

      _cameraIcon = newCameraIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 6. 让 body 延伸到 AppBar 后面
      extendBodyBehindAppBar: true,

      // 7. AppBar 的属性现在由状态变量控制
      appBar: AppBar(
        backgroundColor: _appBarColor,
        elevation: _appBarElevation,
        centerTitle: true,

        // 标题：使用 Opacity 来实现渐入渐出
        title: Opacity(
          opacity: _titleOpacity,
          child: Text(
            'Moments',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ), // 你的标题
        ),

        // 你的按钮（始终显示）
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(_cameraIcon, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),

      body: ListView(
        controller: _scrollController,
        padding: EdgeInsets.zero, // 移除顶部 padding
        children: [
          // ------------------------------------
          // "Child 1": 头像
          // ------------------------------------
          Container(
            height: _headerHeight, // 高度设为 310
            color: _targetColor,
            child: Stack(
              fit: StackFit.expand, // 让 Stack 填满 Container
              children: [
                // 背景图
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Image.asset('assets/moment_bg.png', fit: BoxFit.cover),
                ),
                // 你的头像
                Positioned(
                  bottom: 0,
                  right: 10,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Text(
                          "#*",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          'assets/my_avator.jpg',
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ------------------------------------
          // 列表的其余部分
          // ------------------------------------
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - _headerHeight,
            ),
            child: Container(
              color: _targetColor,
              child: Column(
                mainAxisSize: MainAxisSize.max,

                children: [
                  SizedBox(height: 20), // the padding at the top
                  PostTile(
                    post: Post(
                      time:
                          '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                      date: DateTime.now().day.toString(),
                      month: "Nov",
                      likes: 0,
                      text: "",
                      imageAsset: 'assets/new_post.png',
                    ),
                  ),
                  PostTile(
                    post: Post(
                      time: '22:12',
                      date: "10",
                      month: "Nov",
                      likes: 5,
                      text: "请我喝奶茶谢谢",
                      imageAsset: 'assets/post.jpg',
                    ),
                  ),
                  PostTile(
                    post: Post(
                      time: '22:12',
                      date: "29",
                      month: "Oct",
                      likes: 2,
                      text: "滑铁卢吃喝玩乐交友大派对hhhhhhhhhhhhhhhhhhh来玩来玩",
                      imageAsset: 'assets/test_post.jpg',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
