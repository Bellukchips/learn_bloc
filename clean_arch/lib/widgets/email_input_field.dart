import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailInputField extends StatefulWidget {
  final TextEditingController controller;

  const EmailInputField({Key key, this.controller}) : super(key: key);

  @override
  _EmailInputFieldState createState() => _EmailInputFieldState();
}

class _EmailInputFieldState extends State<EmailInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
          labelText: "Enter Email"),
      controller: widget.controller,
    );
  }
}
