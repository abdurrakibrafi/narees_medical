// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../uitilies/app_colors.dart';

class SuccesfullyPageForAll extends StatefulWidget {
  final String title;
  final IconData? iconData;
  final Color? iconColor;
  final String subTitle;
  final VoidCallback onTap;
  const SuccesfullyPageForAll(
      {super.key,
        required this.title,
        required this.subTitle,
        required this.onTap,
        this.iconData,
        this.iconColor});

  @override
  _SuccesfullyPageForQuationState createState() =>
      _SuccesfullyPageForQuationState();
}

class _SuccesfullyPageForQuationState extends State<SuccesfullyPageForAll>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Use default icon if `iconData` is null
            ScaleTransition(
              scale: _scaleAnimation,
              child: Icon(
                widget.iconData ?? Icons.check_circle_outline, // Default icon
                color:
                widget.iconColor ?? AppColors.mainColor, // Default color
                size: 100.0,
              ),
            ),
            SizedBox(height: 30),

            Text(
              widget.title,
              style: GoogleFonts.kumbhSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            Text(
              widget.subTitle,
              style: GoogleFonts.kumbhSans(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),

            // Back to Home Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: widget.onTap,
                child: Text(
                  'Back to Home',
                  style: GoogleFonts.kumbhSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
