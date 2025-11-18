// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/constants/my_colour.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class OrderSummaryFooter extends StatefulWidget {
  const OrderSummaryFooter({super.key});

  @override
  State<OrderSummaryFooter> createState() => _OrderSummaryFooterState();
}

class _OrderSummaryFooterState extends State<OrderSummaryFooter> {
  DiscountType discountType = DiscountType.percentage;
  final double buttonRowFontSize = getProportionateScreenWidth(4.4);
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0, // ✅ Set to 0 to prevent side shadows
                blurRadius: 6,
                offset: const Offset(0, -3), // negative y offset for top shadow
              ),
            ],
          ),
          child: Column(
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: isExpanded
                    ? Column(
                        children: [
                          // Sub Total
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sub Total',
                                  style: GoogleFonts.openSans(color: Color(0XFF6A6A6A)),
                                ),
                                Text(
                                  '₹1340.00',
                                  style: GoogleFonts.openSans(color: Color(0XFF6A6A6A)),
                                ),
                              ],
                            ),
                          ),
                          // Discount Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Radio<DiscountType>(
                                        value: DiscountType.percentage,
                                        groupValue: discountType,
                                        onChanged: (value) {
                                          setState(() {
                                            discountType = value!;
                                          });
                                        },
                                        activeColor: Colors.redAccent,
                                      ),
                                      const Text('%'),
                                      Radio<DiscountType>(
                                        value: DiscountType.amount,
                                        groupValue: discountType,
                                        onChanged: (value) {
                                          setState(() {
                                            discountType = value!;
                                          });
                                        },
                                        activeColor: Colors.redAccent,
                                      ),
                                      const Text('₹'),
                                    ],
                                  ),
                                  SizedBox(width: getProportionateScreenWidth(5)),
                                  // Discount TextField
                                  SizedBox(
                                    width: getProportionateScreenWidth(35),
                                    child: SizedBox(
                                      height: 36,
                                      child: TextField(
                                        style: GoogleFonts.openSans(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Enter Discount',
                                          hintStyle: const TextStyle(color: Color(0XFFAAAAAA)),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 8,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                            borderSide: const BorderSide(
                                              color: Color(0XFFDDDDDD),
                                              width: 1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                            borderSide: const BorderSide(
                                              color: Color(0XFFDDDDDD),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Apply Button
                                  SizedBox(
                                    height: 36,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: MyColors.selectedBackgroundColor,
                                        foregroundColor: MyColors.selectedForegroundColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        'Apply',
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '(Discount Applied)',
                                style: GoogleFonts.openSans(color: Color(0XFF6A6A6A)),
                              ),
                              Text('₹80.00', style: GoogleFonts.openSans(color: Color(0XFF6A6A6A))),
                            ],
                          ),
                          // Tax
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tax', style: GoogleFonts.openSans(color: Color(0XFF6A6A6A))),
                              Text('₹40.00', style: GoogleFonts.openSans(color: Color(0XFF6A6A6A))),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),

              // Total
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(4.8),
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    Text(
                      '₹1300.00',
                      style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(4.8),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              // Buttons
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 0),
                child: Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.selectedBackgroundColor,
                          foregroundColor: MyColors.selectedForegroundColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Hold',
                          style: TextStyle(
                            fontSize: buttonRowFontSize,
                            fontWeight: FontWeight.w600,
                          ), // optional: smaller text
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.unSelectedBackgroundColor,
                          foregroundColor: MyColors.unSelectedForegroundColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            fontSize: buttonRowFontSize,
                            fontWeight: FontWeight.w600,
                          ), // optional: smaller text
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.selectedForegroundColor,
                            foregroundColor: MyColors.whiteColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Print Bill',
                            style: TextStyle(
                              fontSize: buttonRowFontSize,
                              fontWeight: FontWeight.w500,
                            ), // optional: smaller text
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(4), // optional, for spacing
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: AnimatedRotation(
                turns: isExpanded ? 0.5 : 0, // 0.5 turns = 180 degrees
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: Color(0XFF8A8A8A),
                  size: getProportionateScreenWidth(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum DiscountType { percentage, amount }
