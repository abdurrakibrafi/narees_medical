// lesson_card_widget.dart

// ignore_for_file: prefer_const_constructors

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../model/modules_model.dart';

class LessonCard extends StatelessWidget {
  final Module module;
  final bool isExpanded;
  final bool isUnlocked;
  final bool isCompleted;
  final VoidCallback onTap;

  const LessonCard({
    super.key,
    required this.module,
    required this.isExpanded,
    required this.isUnlocked,
    required this.isCompleted,
    required this.onTap,
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
                  // Serial / status badge
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? Colors.green.shade50
                          : isExpanded
                          ? const Color(0xFF185FA5)
                          : const Color(0xFF185FA5).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: isCompleted
                          ? Icon(Icons.check_rounded,
                          size: 18, color: Colors.green.shade600)
                          : !isUnlocked
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

                  // Expand arrow (only if unlocked)
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

          // ── Video ──
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: isExpanded && module.videoUrl != null
                ? Column(
              children: [
                Divider(height: 1, color: Colors.grey.shade100),
                _VideoPlayerWidget(videoUrl: module.videoUrl!),
              ],
            )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

// ─── Video Player ─────────────────────────────────────────
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
        httpHeaders: {'Accept': '*/*'},
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      await _videoController.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: false,
        looping: false,
        aspectRatio: 16 / 9,
        placeholder: Container(color: Colors.black),
        materialProgressColors: ChewieProgressColors(
          playedColor: const Color(0xFF185FA5),
          handleColor: const Color(0xFF185FA5),
          bufferedColor: Colors.white38,
          backgroundColor: Colors.white24,
        ),
      );
      if (mounted) setState(() => _isLoading = false);
    } catch (e) {
      if (mounted) setState(() {
        _isLoading = false;
        _hasError = true;
      });
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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(14),
        bottomRight: Radius.circular(14),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: _isLoading
            ? Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(color: Color(0xFF185FA5)),
          ),
        )
            : _hasError
            ? Container(
          color: Colors.black,
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline,
                    color: Colors.white54, size: 36),
                SizedBox(height: 8),
                Text(
                  'Video could not be loaded',
                  style: TextStyle(
                      color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
        )
            : Chewie(controller: _chewieController!),
      ),
    );
  }
}