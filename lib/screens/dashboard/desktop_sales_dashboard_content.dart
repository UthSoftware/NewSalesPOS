import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:soft_sales/controller/dashboard/dashboard_controller.dart';
import 'package:soft_sales/screens/dashboard/chart%20_and_inventory_section.dart';
import 'package:soft_sales/screens/dashboard/overall_statistics_section.dart';
import 'package:soft_sales/screens/dashboard/sales_widgets/sales_header.dart';
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
  bool isPriceDescending = true;
  final Map<String, String> _imageMap = {'Dashboard': 'assets/sales_images/dashboard.svg'};
  String selectedItem = 'Dashboard';

  @override
  void initState() {
    controller.topSellingList.value = controller.buildTopSellingRows();
    controller.nonMovingList.value = controller.buildNonMovingRows();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    SizeConfig().init(context);
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 600;
    final bool isTablet = width >= 600 && width <= 1000;

    return Column(
      children: [
        SalesHeader(
          selectedItem: selectedItem,
          imageMap: _imageMap,
          onMenuPressed: widget.onMenuPressed, // ✅ Pass callback to header
        ),

        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: isMobile
                    ? getProportionateScreenHeight(5)
                    : getProportionateScreenHeight(5),
              ),

              if (isMobile || isTablet)
                Padding(
                  padding: EdgeInsets.only(left: getProportionateScreenWidth(12)),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/sales_images/dashboard.svg',
                        width: 20,
                        height: 20,
                        color: const Color(0xff5A5A5A),
                      ),
                      const SizedBox(width: 8),
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

              SizedBox(height: isMobile ? 20 : 40),

              ChartAndInventorySection(controller: controller),
              const SizedBox(height: 40),
              TopProductsSection(controller: controller),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
