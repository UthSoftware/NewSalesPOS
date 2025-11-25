import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/controller/dashboard/dashboard_controller.dart';
import 'package:soft_sales/screens/dashboard/chart%20_and_inventory_section.dart';
import 'package:soft_sales/screens/dashboard/overall_statistics_section.dart';
import 'package:soft_sales/screens/dashboard/top_product_section.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class DashboardContent extends StatefulWidget {
  final VoidCallback? onMenuPressed; // ✅ Add callback parameter

  const DashboardContent({super.key, this.onMenuPressed});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  StatsController controller = Get.put(StatsController());
  bool isUnitsSoldDescending = true;
  bool isSoldQtyDescending = true;
  String selectedItem = 'Dashboard';

  @override
  void initState() {
    controller.topSellingList.value = controller.buildTopSellingRows();
    controller.nonMovingList.value = controller.buildNonMovingRows();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 600;
    final bool isTablet = width >= 600 && width <= 1000;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: isMobile ? getProportionateScreenHeight(50) : getProportionateScreenHeight(60),
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(5),
                right: getProportionateScreenWidth(7),
              ),
              child: Row(
                children: [
                  // ✅ Show only on mobile & tablet with tap functionality
                  if (isMobile || isTablet)
                    InkWell(
                      onTap: () {
                        if (widget.onMenuPressed != null) {
                          widget.onMenuPressed!(); // 👈 FIXED
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
                        child: SvgPicture.asset(
                          'assets/sales_images/uthpos.svg',
                          width: getProportionateScreenWidth(30),
                          height: getProportionateScreenHeight(30),
                        ),
                      ),
                    ),

                  // ✅ Show only on desktop AND when selectedItem is NOT 'Dashboard'
                  if (!isMobile && !isTablet) ...[
                    SvgPicture.asset(
                      'assets/sales_images/dashboard.svg',
                      height: getProportionateScreenHeight(24),
                      color: const Color(0xff5A5A5A),
                    ),

                    SizedBox(width: getProportionateScreenWidth(2)),
                    Expanded(
                      child: Text(
                        selectedItem,
                        style: GoogleFonts.openSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff5A5A5A),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],

                  Spacer(),

                  // User Avatar (always visible)
                  Icon(
                    Icons.person,
                    color: Colors.pink,
                    size: isMobile
                        ? getProportionateScreenHeight(30)
                        : getProportionateScreenHeight(34),
                  ),
                ],
              ),
            ),
          ),

          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(color: Color(0xff000000).withOpacity(.1)),

                SizedBox(
                  height: isMobile
                      ? getProportionateScreenHeight(5)
                      : getProportionateScreenHeight(5),
                ),

                if (isMobile || isTablet)
                  Padding(
                    padding: EdgeInsets.only(left: getProportionateScreenWidth(7)),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/sales_images/dashboard.svg',
                          width: getProportionateScreenWidth(26),
                          height: getProportionateScreenHeight(26),
                          color: const Color(0xff5A5A5A),
                        ),
                        SizedBox(width: getProportionateScreenWidth(8)),
                        Text(
                          selectedItem,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff5A5A5A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: isMobile
                      ? getProportionateScreenHeight(5)
                      : getProportionateScreenHeight(5),
                ),

                OverallStatisticsSection(controller: controller, isMobile: isMobile, width: width),

                SizedBox(
                  height: isMobile
                      ? getProportionateScreenHeight(20)
                      : getProportionateScreenHeight(40),
                ),

                ChartAndInventorySection(controller: controller),
                SizedBox(height: getProportionateScreenHeight(40)),
                TopProductsSection(controller: controller),
                SizedBox(height: getProportionateScreenHeight(24)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
