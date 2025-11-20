// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/constants/my_colour.dart';

class CustomDropdown extends StatefulWidget {
  final String selectedValue;
  final String imagePath;
  final List<DropdownMenuEntry<String>> dropdownItems;
  final List<String> branchList;
  final ValueChanged<String?> onSelected;
  final double? height;
  final double? fontSize;
  final double? width;
  final double? imageHeight;

  const CustomDropdown({
    super.key,
    required this.selectedValue,
    required this.imagePath,
    required this.dropdownItems,
    required this.branchList,
    required this.onSelected,
    this.fontSize,
    this.height,
    this.width,
    this.imageHeight,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final GlobalKey _menuKey = GlobalKey();
  double _fieldWidth = 200;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _menuKey.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        _fieldWidth = renderBox.size.width;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return Container(
      key: _menuKey,
      height: widget.height ?? 55,
      width: widget.width ?? double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: widget.dropdownItems.length > 1 ? Colors.white : const Color(0XFFF5F5F5),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(width: 1.3, color: const Color(0XFFF5F5F5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 8),
          SvgPicture.asset(widget.imagePath, height: 25),
          const SizedBox(width: 8),
          Expanded(
            child: PopupMenuButton<int>(
              color: Colors.white,
              initialValue: widget.branchList.indexOf(widget.selectedValue),
              onSelected: (int index) {
                widget.onSelected(widget.branchList[index]);
              },
              itemBuilder: (BuildContext context) {
                return widget.branchList.asMap().entries.map((entry) {
                  final index = entry.key;
                  final branchName = entry.value;
                  return PopupMenuItem<int>(
                    value: index,
                    child: SizedBox(width: _fieldWidth - 20, child: Text(branchName)),
                  );
                }).toList();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.selectedValue,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: widget.fontSize ?? (mediaQuery >= 800 ? 16 : 14),
                      ),
                    ),
                    SizedBox(width: mediaQuery >= 800 ? 4 : 0),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xff888888),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  ***************** SECOND CUSTOM DROPDOWN ***************** //

class Custom2Dropdown extends StatefulWidget {
  const Custom2Dropdown({super.key});

  @override
  _Custom2DropdownState createState() => _Custom2DropdownState();
}

class _Custom2DropdownState extends State<Custom2Dropdown> {
  final ValueNotifier<int> indexOfBranchList = ValueNotifier<int>(0);

  List<String> branchList = ['English', 'Tamil', 'Arabic', 'Hindi'];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: indexOfBranchList,
      builder: (context, value, child) {
        return PopupMenuButton<int>(
          color: Colors.white,
          initialValue: value,
          onSelected: (int newValue) {
            indexOfBranchList.value = newValue;
          },
          itemBuilder: (BuildContext context) {
            return branchList.asMap().entries.map((entry) {
              int index = entry.key;
              String branchName = entry.value;
              return PopupMenuItem<int>(value: index, child: Text(branchName));
            }).toList();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Spacing
            decoration: BoxDecoration(
              color: Colors.transparent, // No fixed width, keeps natural size
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Adjusts size to content
              children: [
                Text(
                  branchList[value], // Selected language
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: MyColors.selectedForegroundColor, // Use your theme color
                  ),
                ),
                SizedBox(width: 6), // Small spacing
                Icon(Icons.keyboard_arrow_down_rounded, color: const Color(0xff888888), size: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

//  ***************** SECOND CUSTOM DROPDOWN ***************** //

class Custom3Dropdown extends StatefulWidget {
  const Custom3Dropdown({super.key});

  @override
  _Custom3DropdownState createState() => _Custom3DropdownState();
}

class _Custom3DropdownState extends State<Custom3Dropdown> {
  final ValueNotifier<int> indexOfBranchList = ValueNotifier<int>(0);

  List<String> branchList = ['English', 'Tamil', 'Arabic', 'Hindi'];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: indexOfBranchList,
      builder: (context, value, child) {
        return PopupMenuButton<int>(
          color: Colors.white,
          initialValue: value,
          onSelected: (int newValue) {
            indexOfBranchList.value = newValue;
          },
          itemBuilder: (BuildContext context) {
            return branchList.asMap().entries.map((entry) {
              int index = entry.key;
              String branchName = entry.value;
              return PopupMenuItem<int>(value: index, child: Text(branchName));
            }).toList();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Spacing
            decoration: BoxDecoration(
              color: Colors.transparent, // No fixed width, keeps natural size
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Adjusts size to content
              children: [
                Text(
                  branchList[value], // Selected language
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: const Color(0xffFFFFFF), // Use your theme color
                  ),
                ),
                SizedBox(width: 6), // Small spacing
                Icon(Icons.keyboard_arrow_down_rounded, color: const Color(0xffFFFFFF), size: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
