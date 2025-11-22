// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/controller/dashboard/dashboard_controller.dart';
import 'package:soft_sales/screens/dashboard/sales_widgets/date_picker.dart';
import 'package:soft_sales/screens/dashboard/sales_widgets/sales_custom_table.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class TopProductsSection extends StatefulWidget {
  final StatsController controller;

  const TopProductsSection({super.key, required this.controller});

  @override
  State<TopProductsSection> createState() => _TopProductsSectionState();
}

class _TopProductsSectionState extends State<TopProductsSection> {
  bool isUnitsSoldDescending = true;
  bool isSoldQtyDescending = true;
  StatsController controller = Get.put(StatsController());
  DateTime? fromDate;
  DateTime? toDate;

  void _showCustomDateRangePicker(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return CustomDateRangePicker(
          onDateRangeSelected: (start, end) {
            setState(() {
              fromDate = start;
              toDate = end;
            });
            // Navigator.pop is already called inside the CustomDateRangePicker
          },
          initialStartDate: fromDate,
          initialEndDate: toDate,
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width <= 1000;

    if (isMobile || isTablet) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 15 : 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildTopSellingTable(), const SizedBox(height: 20), _buildNonMovingTable()],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildTopSellingTable()),
            const SizedBox(width: 30),
            Expanded(child: _buildNonMovingTable()),
          ],
        ),
      );
    }
  }

  // 🔹 Top Selling Products Table
  Widget _buildTopSellingTable() {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;

    final bool isTablet = width >= 600 && width <= 1000;

    return Padding(
      padding: EdgeInsets.only(
        left: isTablet ? getProportionateScreenWidth(7) : getProportionateScreenWidth(0),
        right: isTablet ? getProportionateScreenWidth(7) : getProportionateScreenWidth(0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Top 10 Selling Products",
                  style: GoogleFonts.openSans(
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              if (isTablet) ...[
                InkWell(
                  onTap: () {
                    _showCustomDateRangePicker(context);
                  },
                  child: Container(
                    height: 35,
                    width: 190,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              fromDate == null || toDate == null
                                  ? "dd/MM/yyyy - DD/MM/YYYY"
                                  : "${_formatDate(fromDate!)} - ${_formatDate(toDate!)}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: fromDate == null ? Colors.grey.shade600 : Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
                        ],
                      ),
                    ),
                  ),
                ),
              ] else if (isMobile) ...[
                const SizedBox(width: 12),
                Row(
                  children: [
                    const SizedBox(width: 12),
                    // Filter container
                    Container(
                      height: 40, // adjust size as needed
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset('assets/sales_images/filter.png', width: 15, height: 15),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Calendar container
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/sales_images/calender.png',
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          SizedBox(height: isMobile ? 12 : 18),
          CustomTableWidget(
            headers: [
              Headers(title: "Rank"),
              Headers(title: 'Product Name'),
              Headers(
                title: 'Units Sold',
                isSortable: isUnitsSoldDescending,
                function: () {
                  setState(() {
                    // Sort based on the toggle flag
                    if (isUnitsSoldDescending) {
                      widget.controller.topSelling.sort(
                        (a, b) => b.unitsSold.compareTo(a.unitsSold),
                      );
                    } else {
                      widget.controller.topSelling.sort(
                        (a, b) => a.unitsSold.compareTo(b.unitsSold),
                      );
                    }
                    isUnitsSoldDescending = !isUnitsSoldDescending;

                    // Refresh data
                    widget.controller.topSellingList.value = widget.controller
                        .buildTopSellingRows();
                  });
                },
              ),
              Headers(title: 'Price (₹)'),
              Headers(title: 'Revenue (₹)'),
            ],
            data: widget.controller.topSellingList,
            headerColor: const Color(0xffEBFFF8),
            headerTextColor: const Color(0xff00885B),
          ),
        ],
      ),
    );
  }

  // 🔹 Non-Moving Products Table
  Widget _buildNonMovingTable() {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width <= 1000;

    return Padding(
      padding: EdgeInsets.only(
        left: isTablet ? getProportionateScreenWidth(7) : getProportionateScreenWidth(0),
        right: isTablet ? getProportionateScreenWidth(7) : getProportionateScreenWidth(0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Top 10 Non Moving Products',
                  style: GoogleFonts.openSans(
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              if (isMobile) ...[
                const SizedBox(width: 12),
                Row(
                  children: [
                    const SizedBox(width: 12),
                    // Filter container
                    Container(
                      height: 40, // adjust size as needed
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset('assets/sales_images/filter.png', width: 15, height: 15),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Calendar container
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/sales_images/calender.png',
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ] else if (isTablet) ...[
                SizedBox.shrink(),
              ] else ...[
                InkWell(
                  onTap: () {
                    _showCustomDateRangePicker(context);
                  },
                  child: Container(
                    height: 35,
                    width: 190,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              fromDate == null || toDate == null
                                  ? "dd/MM/yyyy - DD/MM/YYYY"
                                  : "${_formatDate(fromDate!)} - ${_formatDate(toDate!)}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: fromDate == null ? Colors.grey.shade600 : Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: isMobile ? 12 : 15),
          CustomTableWidget(
            headers: [
              Headers(title: "Rank"),
              Headers(title: 'Product Name'),
              Headers(
                title: 'Sold Qty',
                isSortable: isSoldQtyDescending,
                function: () {
                  setState(() {
                    if (isSoldQtyDescending) {
                      widget.controller.nonMoving.sort((a, b) => b.soldQty.compareTo(a.soldQty));
                    } else {
                      widget.controller.nonMoving.sort((a, b) => a.soldQty.compareTo(b.soldQty));
                    }

                    isSoldQtyDescending = !isSoldQtyDescending;
                    widget.controller.nonMovingList.value = widget.controller.buildNonMovingRows();
                  });
                },
              ),
              Headers(title: 'Age'),
              Headers(title: 'UnSold Stock'),
            ],
            data: widget.controller.nonMovingList,
            headerColor: const Color(0xffFFEEEE),
            headerTextColor: const Color(0xffD70000),
          ),
        ],
      ),
    );
  }

  // void _showDateRangePicker(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext dialogContext) {
  //       return Dialog(
  //         backgroundColor: Colors.white,
  //         child: SizedBox(
  //           width: 400,
  //           height: 580,
  //           child: CustomDateRangePicker(
  //             minimumDate: DateTime.now().subtract(const Duration(days: 365)),
  //             maximumDate: DateTime.now().add(const Duration(days: 365)),
  //             initialEndDate: endDate,
  //             initialStartDate: startDate,

  //             backgroundColor: Colors.white,
  //             primaryColor: Color(0xffD2303F),

  //             onApplyClick: (start, end) {
  //               setState(() {
  //                 startDate = start;
  //                 endDate = end;
  //               });
  //             },
  //             onCancelClick: () {},
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
