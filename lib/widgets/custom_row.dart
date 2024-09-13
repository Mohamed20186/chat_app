import 'package:chat_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.callback,
  });
  final VoidCallback callback;
  final String firstText;
  final String secondText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: GoogleFonts.aldrich(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        GestureDetector(
          onTap: callback,
          child: Text(
            secondText,
            style: GoogleFonts.aldrich(
              color: kSecondlyColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
