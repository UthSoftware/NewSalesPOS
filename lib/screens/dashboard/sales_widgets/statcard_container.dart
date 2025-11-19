import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/controller/dashboard/dashboard_controller.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class StatCard extends StatelessWidget {
  final StatModel stat;
  const StatCard({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    SizeConfig().init(context);

    // ✅ Responsive sizes based on width breakpoints
    double labelSize;
    double valueSize;
    double trendSize;
    double iconSize;
    double horizontalPadding;
    double verticalPadding;
    double borderRadius;
    double spacingBetween;

    // 🖥️ DESKTOP LAYOUT (Image 2 - Spacious cards)
    if (width >= 1400) {
      labelSize = 16;
      valueSize = 30;
      trendSize = 13;
      iconSize = 14;
      horizontalPadding = 20;
      verticalPadding = 18;
      borderRadius = 10;
      spacingBetween = 6;
    } else if (width >= 1200) {
      borderRadius = 8;
      labelSize = 16;
      valueSize = 30;
      trendSize = 13;
      iconSize = 13;
      horizontalPadding = 18;
      verticalPadding = 16;
      spacingBetween = 5;
    }
    // 💻 WEB/TABLET LAYOUT (Image 3 - Compact 4 columns)
    else if (width >= 900) {
      labelSize = 13;
      valueSize = 24;
      trendSize = 10;
      iconSize = 10;
      horizontalPadding = 14;
      verticalPadding = 12;
      borderRadius = 8;
      spacingBetween = 5;
    } else if (width >= 768) {
      labelSize = 12;
      valueSize = 20;
      trendSize = 9;
      iconSize = 10;
      horizontalPadding = 12;
      verticalPadding = 10;
      borderRadius = 8;
      spacingBetween = 4;
    } else if (width >= 600) {
      labelSize = 10;
      valueSize = 18;
      trendSize = 8;
      iconSize = 9;
      horizontalPadding = 10;
      verticalPadding = 10;
      borderRadius = 8;
      spacingBetween = 4;
    }
    // 📱 MOBILE LAYOUT (Image 1 - 2x2 grid)
    else {
      labelSize = 10;
      valueSize = 22;
      trendSize = 11;
      iconSize = 12;
      horizontalPadding = 10;
      verticalPadding = 10;
      borderRadius = 8;
      spacingBetween = 8;
    }

    return Container(
      decoration: BoxDecoration(
        color: Color(stat.color).withOpacity(0.1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(
            stat.label,
            style: GoogleFonts.openSans(
              fontSize: labelSize,
              color: const Color(0xff5A5A5A),
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: spacingBetween),

          // Value - Auto-scaling
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                stat.value,
                style: GoogleFonts.openSans(
                  fontSize: valueSize,
                  fontWeight: FontWeight.w700,
                  color: Color(stat.color),
                  height: 1.0,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ),

          SizedBox(height: spacingBetween),

          // Trend Row
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  stat.isTrendUp ? Icons.trending_up : Icons.trending_down,
                  size: iconSize,
                  color: stat.isTrendUp ? const Color(0xff078747) : const Color(0xffD60F0F),
                ),
                const SizedBox(width: 4),
                Text(
                  "${stat.num}${stat.percent}",
                  style: GoogleFonts.openSans(
                    fontSize: trendSize,
                    fontWeight: FontWeight.w600,
                    color: stat.isTrendUp ? const Color(0xff078747) : const Color(0xffD60F0F),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  "than ${stat.trend}",
                  style: GoogleFonts.openSans(
                    fontSize: trendSize,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff5A5A5A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
