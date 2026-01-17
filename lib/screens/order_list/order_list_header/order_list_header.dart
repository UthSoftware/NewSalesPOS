import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderListHeader extends StatelessWidget {
  const OrderListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Text(
            "Order list",
            style: GoogleFonts.openSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xff1E1E1E),
            ),
          ),
        ],
      ),
    );
  }
}
