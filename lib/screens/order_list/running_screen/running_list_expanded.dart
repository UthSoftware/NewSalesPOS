import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class RunningListExpanded extends StatelessWidget {
  const RunningListExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // LEFT SECTION
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(3),
                vertical: getProportionateScreenWidth(1),
              ),
              decoration: BoxDecoration(
                color: const Color(0xffF2F4F5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Text(
                    "Order #12568",
                    style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff1E1E1E),
                    ),
                  ),
                  SizedBox(width: getProportionateScreenWidth(2)),
                  Text(
                    "Waiter: Dhina",
                    style: GoogleFonts.openSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff4A4A4A),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: getProportionateScreenWidth(10)),

            // Status badge
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(3),
                vertical: getProportionateScreenWidth(1),
              ),
              decoration: BoxDecoration(
                color: const Color(0xffE7F1FF),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Running",
                style: GoogleFonts.openSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff2F80ED),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(3),
                vertical: getProportionateScreenWidth(1),
              ),
              decoration: BoxDecoration(
                color: const Color(0xffFFF1E5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "DINE - IN",
                style: GoogleFonts.openSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffF2994A),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: getProportionateScreenHeight(10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                SizedBox(width: getProportionateScreenWidth(2)),
                Text(
                  "24/11/2025 • 11:11 AM (10 min ago)",
                  style: GoogleFonts.openSans(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            Text(
              "Table - 3 | C - 1,2,3,4",
              style: GoogleFonts.openSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xff4A4A4A),
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(20), child: Divider()),

        Align(
          alignment: Alignment.centerLeft,

          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(3),
              vertical: getProportionateScreenWidth(1),
            ),
            decoration: BoxDecoration(
              color: const Color(0xffF2F4F5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              "Customer Details: ",
              style: GoogleFonts.openSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xff1E1E1E),
              ),
            ),
          ),
        ),

        SizedBox(height: getProportionateScreenHeight(10)),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.person_2_outlined, size: 16, color: Color(0xff6A6A6A)),
                Text(
                  'VijayaLakshmi',
                  style: GoogleFonts.openSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1E1E1E),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.phone_outlined, size: 16, color: Color(0xff6A6A6A)),
                Text(
                  '+91 7032177778',
                  style: GoogleFonts.openSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1E1E1E),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.history, size: 16, color: Color(0xff0480D0)),
                Text(
                  'Customer History',
                  style: GoogleFonts.openSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff0480D0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
