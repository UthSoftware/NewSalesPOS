// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/constants/my_colour.dart';
import 'package:soft_sales/screens/sales/product_panel_widgets/filter_header_widget.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class SubFilterTabBar extends StatefulWidget {
  const SubFilterTabBar({super.key});

  @override
  State<SubFilterTabBar> createState() => _SubFilterTabBarState();
}

class _SubFilterTabBarState extends State<SubFilterTabBar> {
  int selectedFilter = 0;
  final ScrollController _scrollController = ScrollController();

  final filterHeaderList = [
    FilterHeader(nameEn: "Freaky Fry", nameReg: "فریکی فرای", thamnailChar: 'FF'),
    FilterHeader(nameEn: "KFC", nameReg: "کی ایف سی", thamnailChar: 'K'),
    FilterHeader(nameEn: "Madurai Special", nameReg: "مدورای اسپیشل", thamnailChar: 'MS'),
    FilterHeader(nameEn: "Thalapakatti", nameReg: "تھالاپاکٹی", thamnailChar: 'T'),
    FilterHeader(nameEn: "McDonalds", nameReg: "میکڈونلڈز", thamnailChar: 'MD'),
    FilterHeader(nameEn: "Madurai Special", nameReg: "مدورای اسپیشل", thamnailChar: 'MS'),
    FilterHeader(nameEn: "Thalapakatti", nameReg: "تھالاپاکٹی", thamnailChar: 'T'),
    FilterHeader(nameEn: "Madurai Special", nameReg: "مدورای اسپیشل", thamnailChar: 'MS'),
    FilterHeader(nameEn: "Freaky Fry", nameReg: "فریکی فرای", thamnailChar: 'FF'),
    FilterHeader(nameEn: "KFC", nameReg: "کی ایف سی", thamnailChar: 'K'),
    FilterHeader(nameEn: "Madurai Special", nameReg: "مدورای اسپیشل", thamnailChar: 'MS'),
    FilterHeader(nameEn: "Thalapakatti", nameReg: "تھالاپاکٹی", thamnailChar: 'T'),
    FilterHeader(nameEn: "McDonalds", nameReg: "میکڈونلڈز", thamnailChar: 'MD'),
    FilterHeader(nameEn: "Madurai Special", nameReg: "مدورای اسپیشل", thamnailChar: 'MS'),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenWidth(26),
          child: Listener(
            onPointerSignal: (pointerSignal) {
              if (pointerSignal is PointerScrollEvent) {
                // Smooth scroll horizontally when mouse wheel is used
                final newOffset = _scrollController.offset + pointerSignal.scrollDelta.dy;
                _scrollController.animateTo(
                  newOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                );
              }
            },
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(), // Smooth bouncing effect
              itemCount: filterHeaderList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        selectedFilter = index;
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          transform: Matrix4.identity()
                            ..scale(selectedFilter == index ? 1.05 : 1.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              "assets/section_img.png",

                              width: getProportionateScreenWidth(12),
                              height: getProportionateScreenWidth(12),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // -------------- Title First Letter ------------------ //
                        // AnimatedContainer(
                        //   duration: const Duration(milliseconds: 200),
                        //   curve: Curves.easeInOut,
                        //   transform: Matrix4.identity()
                        //     ..scale(selectedFilter == index ? 1.05 : 1.0),
                        //   child: CircleAvatar(
                        //     radius: 23,
                        //     backgroundColor: MyColors.selectedBackgroundColor,
                        //     child: Text(
                        //       filterHeaderList[index].thamnailChar.toString(),
                        //       style: GoogleFonts.openSans(
                        //         color: MyColors.selectedForegroundColor,
                        //         fontWeight: FontWeight.w500,
                        //         fontSize: getProportionateScreenWidth(5.5),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: getProportionateScreenHeight(4)),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          style: GoogleFonts.openSans(
                            color: (selectedFilter == index)
                                ? MyColors.selectedForegroundColor
                                : MyColors.unSelectedForegroundColor,
                            fontWeight: (selectedFilter == index)
                                ? FontWeight.w500
                                : FontWeight.w400,
                            fontSize: getProportionateScreenWidth(3.4),
                          ),
                          child: Text(filterHeaderList[index].nameEn),
                        ),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          style: GoogleFonts.openSans(
                            color: (selectedFilter == index)
                                ? MyColors.selectedForegroundColor
                                : MyColors.unSelectedForegroundColor,
                            fontWeight: (selectedFilter == index)
                                ? FontWeight.w500
                                : FontWeight.w400,
                            fontSize: getProportionateScreenWidth(3),
                          ),
                          child: Text(filterHeaderList[index].nameReg),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenHeight(2)),
        Divider(color: MyColors.borderColor, height: 2),
        SizedBox(height: getProportionateScreenHeight(14)),
      ],
    );
  }
}
