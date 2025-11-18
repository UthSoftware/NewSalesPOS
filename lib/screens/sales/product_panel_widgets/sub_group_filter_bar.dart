import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/constants/my_colour.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class SubGroupFilterBar extends StatefulWidget {
  const SubGroupFilterBar({super.key});

  @override
  State<SubGroupFilterBar> createState() => _SubGroupFilterBarState();
}

class _SubGroupFilterBarState extends State<SubGroupFilterBar> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double containerHeight = getProportionateScreenWidth(24.4);
    final double imageHeight = containerHeight - getProportionateScreenWidth(2);
    // final double containerWidth = getProportionateScreenWidth(48);
    final double itemContainerWidth = getProportionateScreenWidth(55);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   height: containerHeight,
          //   width: containerWidth,
          //   margin: EdgeInsets.only(right: getProportionateScreenWidth(4)),
          //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          //   decoration: BoxDecoration(
          //     color: MyColors.selectedBackgroundColor,
          //     borderRadius: BorderRadius.circular(50),
          //   ),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         'All Sub Group',
          //         style: GoogleFonts.openSans(
          //           color: MyColors.selectedForegroundColor,
          //           fontWeight: FontWeight.w600,
          //           fontSize: getProportionateScreenWidth(4),
          //         ),
          //       ),
          //     N  Text(
          //         '(جميع المجموعات)',
          //         style: GoogleFonts.openSans(
          //           color: MyColors.selectedForegroundColor,
          //           fontWeight: FontWeight.w500,
          //           fontSize: getProportionateScreenWidth(3.8),
          //         ),
          //       ),
          //       SizedBox(height: getProportionateScreenWidth(2)),
          //       Text(
          //         '(180 Items) (١٨٠ عنصرًا)',
          //         style: GoogleFonts.openSans(
          //           color: MyColors.unSelectedForegroundColor,
          //           fontSize: getProportionateScreenWidth(3.4),
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
                      width: itemContainerWidth,
                      margin: EdgeInsets.only(right: getProportionateScreenWidth(4)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: MyColors.borderColor),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/sub_group.png",
                                height: imageHeight,
                                width: imageHeight,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenWidth(2)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Special Cakes',
                                style: GoogleFonts.openSans(
                                  color: MyColors.unSelectedForegroundColor,
                                  fontSize: getProportionateScreenWidth(3.9),
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.right,
                                'كعكات خاصة',
                                style: GoogleFonts.openSans(
                                  color: MyColors.unSelectedForegroundColor,
                                  fontSize: getProportionateScreenWidth(3.7),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
