import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/const/app_color.dart';
import '../../model/post_model.dart';

class PostItemView extends StatefulWidget {
  const PostItemView({
    super.key,
    required this.post,
    required this.isRead,
    required this.onRead,
  });

  final PostModel post;
  final bool isRead;
  final VoidCallback onRead;

  @override
  _PostItemViewState createState() => _PostItemViewState();
}

class _PostItemViewState extends State<PostItemView> {
  late int timerDuration;
  late Timer _timer;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    final random = Random();
    timerDuration = [10, 20, 25][random.nextInt(3)]; // Random duration
  }

  void _startTimer() {
    if (_isVisible) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timerDuration > 0) {
          setState(() {
            timerDuration--;
          });
        } else {
          _timer.cancel(); // Stop timer when it reaches 0
        }
      });
    }
  }

  void _pauseTimer() {
    if (_timer.isActive) _timer.cancel();
  }

  @override
  void dispose() {
    _timer.cancel(); // Ensure timer is canceled
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.post.id.toString()),
      onVisibilityChanged: (visibilityInfo) {
        final visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 0 && !_isVisible) {
          _isVisible = true;
          _startTimer();
        } else if (visiblePercentage == 0 && _isVisible) {
          _isVisible = false;
          _pauseTimer();
        }
      },
      child: GestureDetector(
        onTap: () {
          widget.onRead();
          _pauseTimer(); // Pause timer on navigation
          Get.toNamed(
            '/postDetailRoute',
            arguments: {"post": widget.post},
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.isRead ? AppColor.whiteColor : AppColor.yellowLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.blackColor, width: 1),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Row(
            children: [
              // Post Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.title ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // Timer Icon with Duration
              Row(
                children: [
                  const Icon(
                    Icons.timer,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$timerDuration s',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
