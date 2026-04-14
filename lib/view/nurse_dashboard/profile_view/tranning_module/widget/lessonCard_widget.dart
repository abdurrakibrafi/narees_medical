// ignore_for_file: prefer_const_constructors

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:video_player/video_player.dart';
import '../model/modules_model.dart';

class LessonCard extends StatelessWidget {
  final Module module;
  final bool isExpanded;
  final bool isUnlocked;
  final VoidCallback onTap;
  final VoidCallback? onComplete;
  final VoidCallback? markOnTap;

  const LessonCard({
    super.key,
    required this.module,
    required this.isExpanded,
    required this.isUnlocked,
    required this.onTap,
    this.onComplete,
    this.markOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isExpanded
              ? const Color(0xFF185FA5).withOpacity(0.4)
              : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Tile ──
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  // Status circle
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: isExpanded
                          ? Colors.black
                          : const Color(0xFF185FA5).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: !isUnlocked
                          ? Icon(Icons.lock_outline_rounded,
                              size: 16, color: Colors.grey.shade400)
                          : Text(
                              '${module.serial}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isExpanded
                                    ? Colors.white
                                    : const Color(0xFF185FA5),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Title + description
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          module.name ?? '',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isUnlocked
                                ? Colors.black87
                                : Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          module.description ?? '',
                          maxLines: isExpanded ? 10 : 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade500,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  if (isUnlocked)
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 250),
                      child: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFF185FA5),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // ── Video + Complete ──
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: isExpanded &&
                    module.videoUrl != null &&
                    module.videoUrl!.isNotEmpty
                ? Column(
                    children: [
                      Divider(height: 1, color: Colors.grey.shade100),

                      // 🎥 Video
                      _VideoPlayerWidget(videoUrl: module.videoUrl!),
                      SizedBox(height: 10),








                      CustomButtonWidget(
                          btnTextSize: 14.0,
                          btnColor: AppColors.mainColor,
                          btnText: "Mark as Complete",
                          onTap: markOnTap!,
                          iconWant: false)
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  const _VideoPlayerWidget({required this.videoUrl});

  @override
  State<_VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<_VideoPlayerWidget> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    try {
      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );

      await _videoController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: false,
        looping: false,
        aspectRatio: 16 / 9,
      );

      if (mounted) setState(() => _isLoading = false);
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        height: 200,
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_hasError) {
      return Container(
        height: 200,
        color: Colors.black,
        child: const Center(
          child: Text(
            "Video load failed",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Chewie(controller: _chewieController!),
    );
  }
}
