// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/constants/my_colour.dart';
import 'package:soft_sales/models/sales/order_type.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

// ignore: must_be_immutable
class SalesOrderSummaryHeader extends StatelessWidget with MyColors {
  SalesOrderSummaryHeader({super.key});
  final orderTypes = [
    OrderType(nameEn: "Counter Sale", nameReg: "مبيعات الكاونتر"),
    OrderType(nameEn: "Take Away", nameReg: "سفري"),
    OrderType(nameEn: "Dine In", nameReg: "تناول الطعا..."),
    OrderType(nameEn: "Delivery", nameReg: "توصيل"),
  ];

  RxInt selectedOrderTypes = (0).obs;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: (60), // height of the horizontal list
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // make it horizontal
                itemCount: orderTypes.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedOrderTypes.value == index;
                  return GestureDetector(
                    onTap: () {
                      selectedOrderTypes.value = index; // update selection
                      debugPrint('Selected : ${selectedOrderTypes.value}');
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 4), // spacing between items
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? MyColors.selectedBackgroundColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            orderTypes[index].nameEn,
                            style: GoogleFonts.openSans(
                              color: isSelected
                                  ? MyColors.selectedForegroundColor
                                  : MyColors.unSelectedForegroundColor,
                              fontSize: (13),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            orderTypes[index].nameReg,
                            style: GoogleFonts.openSans(
                              color: isSelected
                                  ? MyColors.selectedForegroundColor
                                  : MyColors.unSelectedForegroundColor,
                              fontSize: (13),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Row(
            children: [
              SvgPicture.asset(
                "assets/printer_icon.svg",
                height: getProportionateScreenHeight(35),
                width: getProportionateScreenHeight(35),
              ),
              SizedBox(width: getProportionateScreenWidth(5)),
              SvgPicture.asset(
                "user_icon.svg",
                height: getProportionateScreenHeight(30),
                width: getProportionateScreenHeight(30),
              ),
              SizedBox(width: getProportionateScreenWidth(4)),
            ],
          ),
        ],
      ),
    );
  }
}
