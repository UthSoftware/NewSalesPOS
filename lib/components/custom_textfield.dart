import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String prefixImagePath;
  final bool? suffixImagePath;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String)? onSubmitted;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixImagePath,
    this.suffixImagePath,
    required this.controller,
    required this.focusNode,
    this.onSubmitted,
    this.errorText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.suffixImagePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius loginBorderRadius = BorderRadius.circular(4);
    final Color borderColor = const Color(0XFFDDDDDD);

    return TextField(
      cursorColor: const Color(0XFF1E1E1E),
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: _obscureText,
      obscuringCharacter: '*',
      onChanged: (value) {
        // Use Get.find to get the existing instance of LoginController
        // Get.find<LoginController>().updateFormValidity();
      },
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        errorText: widget.errorText,
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 12, 10),
          child: SvgPicture.asset(widget.prefixImagePath, height: 20, width: 20),
        ),
        suffixIcon:
            widget.suffixImagePath != null
                ? IconButton(
                  icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
                : null,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: loginBorderRadius,
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: loginBorderRadius,
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: loginBorderRadius,
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
      ),
    );
  }
}
