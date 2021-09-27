import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordInputField({Key key, this.controller}) : super(key: key);

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            fillColor: Colors.blue.shade100,
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(vertical: 30.w, horizontal: 30.w),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20.w,
              ),
              borderSide: const BorderSide(width: 0, color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.w),
              borderSide: const BorderSide(width: 0, color: Colors.transparent),
            ),
            labelText: "Enter Password"),
        controller: widget.controller,
      ),
    );
  }
}
