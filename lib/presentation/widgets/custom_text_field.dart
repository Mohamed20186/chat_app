import 'package:chat_app/core/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    required this.labelName,
    required this.hintName,
    required this.icon,
    this.onChange,
    required this.isPassword,
  }) : super(key: key);

  final String labelName;
  final String hintName;
  final Icon icon;
  final Function(String)? onChange;
  final bool isPassword;

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        validator: (data) {
          if (data!.isEmpty) {
            return 'required feild';
          }
        },
        obscureText: widget.isPassword ? !_isPasswordVisible : false,
        onChanged: widget.onChange,
        style: GoogleFonts.aldrich(
          color: kSecondlyColor,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: widget.labelName,
          labelStyle: const TextStyle(
            color: kSecondlyColor,
          ),
          prefixIcon: widget.icon,
          prefixIconColor: kSecondlyColor,
          hintText: widget.hintName,
          hintStyle: GoogleFonts.aldrich(
            color: kSecondlyColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 15, 74, 236),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: kSecondlyColor,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: kSecondlyColor,
            ),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: kSecondlyColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
