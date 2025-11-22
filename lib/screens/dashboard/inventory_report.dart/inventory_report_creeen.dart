import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InventoryReportCreeen extends StatefulWidget {
  final VoidCallback? onMenuPressed; // ✅ ADD THIS

  const InventoryReportCreeen({super.key, this.onMenuPressed}); // ✅ ADD onMenuPressed

  @override
  State<InventoryReportCreeen> createState() => _InventoryReportCreeenState();
}

class _InventoryReportCreeenState extends State<InventoryReportCreeen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width <= 1000;

    return SingleChildScrollView(
      child: Column(
        children: [
          // ✅ ADD HEADER WITH MENU BUTTON
          Container(
            height: isMobile ? 50 : 60,
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // Menu button for mobile/tablet
                  if (isMobile || isTablet)
                    InkWell(
                      onTap: () {
                        if (widget.onMenuPressed != null) {
                          widget.onMenuPressed!();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SvgPicture.asset(
                          'assets/sales_images/uthpos.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),

                  // Desktop title
                  if (!isMobile && !isTablet) ...[
                    SvgPicture.asset(
                      'assets/sales_images/reports.svg',
                      height: 24,
                      color: const Color(0xff5A5A5A),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Inventory Report',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff5A5A5A),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],

                  Spacer(),

                  // User Avatar
                  Icon(Icons.person, color: Colors.pink, size: isMobile ? 20 : 24),
                ],
              ),
            ),
          ),

          // ✅ YOUR EXISTING INVENTORY REPORT CONTENT GOES HERE
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Divider(color: Color(0xff000000).withOpacity(.1)),

                SizedBox(height: 10),

                // Add mobile/tablet title
                if (isMobile || isTablet)
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/sales_images/reports.svg',
                          width: 20,
                          height: 20,
                          color: const Color(0xff5A5A5A),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Inventory Report',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff5A5A5A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 20),

                // YOUR INVENTORY REPORT WIDGETS HERE
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Inventory Report Content', style: TextStyle(fontSize: 18)),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
