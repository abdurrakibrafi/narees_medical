// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.grey,
            endIndent: 10,
          ),
        ),
        Text(
          text,
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.grey,
            indent: 10,
          ),
        ),
      ],
    );
  }
}
