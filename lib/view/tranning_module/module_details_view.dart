// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/view/tranning_module/widget/module_description_widget.dart';
import 'package:restaurent_discount_app/view/tranning_module/widget/pdf_widget.dart';
import 'package:video_player/video_player.dart';

class TrainingModuleDetailScreen extends StatefulWidget {
  const TrainingModuleDetailScreen({super.key});

  @override
  State<TrainingModuleDetailScreen> createState() =>
      _TrainingModuleDetailScreenState();
}

class _TrainingModuleDetailScreenState
    extends State<TrainingModuleDetailScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
    )..initialize().then((_) {
        setState(() {});
      });
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Video Module"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVideoSection(),
            _buildTitleBar(),
            ModuleDescriptionWidget(),
            PdfWidget(),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget _buildVideoSection() {
    return Stack(
      children: [
        _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              ),
        if (_controller.value.isInitialized)
          Positioned(
            bottom: 10,
            left: 16,
            right: 16,
            child: Column(
              children: [
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Colors.red,
                    backgroundColor: Colors.white60,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatDuration(_controller.value.position),
                        style: const TextStyle(color: Colors.white)),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(_formatDuration(_controller.value.duration),
                        style: const TextStyle(color: Colors.white)),
                  ],
                )
              ],
            ),
          ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  Widget _buildTitleBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: CustomText(
          text: 'Importance of Hand Hygiene',
          color: Colors.white,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.bold,
          fontSize: 18.h),
    );
  }
}
