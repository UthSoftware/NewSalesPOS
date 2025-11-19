import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/constants/my_colour.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class GroupFilterBar extends StatefulWidget {
  const GroupFilterBar({super.key});

  @override
  State<GroupFilterBar> createState() => _GroupFilterBarState();
}

class _GroupFilterBarState extends State<GroupFilterBar> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double containerHeight = getProportionateScreenWidth(27.8);
    final double containerWidth = getProportionateScreenWidth(35);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   height: containerHeight,
        //   width: containerWidth,
        //   margin: EdgeInsets.only(right: getProportionateScreenWidth(4)),
        //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        //   decoration: BoxDecoration(
        //     color: MyColors.selectedBackgroundColor,
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         'All Group',
        //         style: GoogleFonts.openSans(
        //           color: MyColors.selectedForegroundColor,
        //           fontWeight: FontWeight.w600,
        //           fontSize: getProportionateScreenWidth(4.2),
        //         ),
        //       ),
        //       Text(
        //         '(جميع المجموعات)',
        //         style: GoogleFonts.openSans(
        //           color: MyColors.selectedForegroundColor,
        //           fontWeight: FontWeight.w500,
        //           fontSize: getProportionateScreenWidth(4),
        //         ),
        //       ),
        //       SizedBox(height: getProportionateScreenWidth(2)),
        //       Text(
        //         '(540 Items)',
        //         style: GoogleFonts.openSans(
        //           color: MyColors.unSelectedForegroundColor,
        //           fontSize: getProportionateScreenWidth(3.9),
        //         ),
        //       ),
        //       Text(
        //         '(٥٤٠ عنصرًا)',
        //         style: GoogleFonts.openSans(
        //           color: MyColors.unSelectedForegroundColor,
        //           fontSize: getProportionateScreenWidth(3.7),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Expanded(
          child: SizedBox(
            height: containerHeight, // height for the horizontal list
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
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    height: containerHeight,
                    width: containerWidth,
                    margin: EdgeInsets.only(right: getProportionateScreenWidth(4)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: MyColors.borderColor),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.asset(
                            "assets/sub_filter_icon.jpg",
                            height: containerHeight * 0.56,
                            width: containerWidth,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenWidth(0.9)),
                        Text(
                          'Desserts',
                          style: GoogleFonts.openSans(
                            color: MyColors.unSelectedForegroundColor,
                            fontSize: getProportionateScreenWidth(3.7),
                          ),
                        ),
                        Text(
                          '(حلويات)',
                          style: GoogleFonts.openSans(
                            color: MyColors.unSelectedForegroundColor,
                            fontSize: getProportionateScreenWidth(3.5),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
