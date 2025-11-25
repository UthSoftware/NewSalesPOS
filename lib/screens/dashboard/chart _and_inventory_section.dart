import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/controller/dashboard/dashboard_controller.dart';
import 'package:soft_sales/screens/dashboard/inventory_stock.dart';
import 'package:soft_sales/screens/dashboard/sales_widgets/date_picker.dart';
import 'package:soft_sales/screens/dashboard/sales_widgets/sales_custom_dropdown.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class ChartAndInventorySection extends StatefulWidget {
  final StatsController controller;
  const ChartAndInventorySection({super.key, required this.controller});

  @override
  State<ChartAndInventorySection> createState() => _ChartAndInventorySectionState();
}

class _ChartAndInventorySectionState extends State<ChartAndInventorySection> {
  DateTime? fromDate;
  DateTime? toDate;
  String selectedSort = 'Revenue';
  String selectedDays = 'Last 7 Days';
  // Add this method at the class level:
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
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width <= 1000;
    final bool isDesktop = width > 1000;

    if (isMobile) {
      // Mobile layout - stacked vertically
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildChart(context),
          const SizedBox(height: 20),
          Padding(padding: EdgeInsets.only(left: 15, right: 15), child: InventoryStockAlertCard()),
        ],
      );
    } else if (isTablet) {
      // Tablet layout - stacked vertically with expanded inventory
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildChart(context),
          const SizedBox(height: 20),
          Padding(padding: EdgeInsets.only(left: 18, right: 18), child: InventoryStockAlertCard()),
        ],
      );
    } else if (isDesktop) {
      // Desktop layout - side by side
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 65, child: _buildChart(context)),
            const SizedBox(width: 15),
            Expanded(
              flex: 35,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InventoryStockAlertCard(),
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  void _showFilterBottomSheet() {
    String tempSort = selectedSort;
    String tempDays = selectedDays;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 8),
                      width: 35,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Sort',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),

                  // Content
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Revenue dropdown
                        const Text(
                          'Revenue',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonFormField<String>(
                            initialValue: tempSort,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              border: InputBorder.none,
                            ),
                            items: ['Revenue', 'Profit', 'Orders', 'Customers'].map((String value) {
                              return DropdownMenuItem<String>(value: value, child: Text(value));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setModalState(() {
                                tempSort = newValue!;
                              });
                            },
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Days dropdown
                        const Text(
                          'Days',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonFormField<String>(
                            initialValue: tempDays,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              border: InputBorder.none,
                            ),
                            items: ['Last 7 Days', 'Last 14 Days', 'Last 30 Days', 'Last 90 Days']
                                .map((String value) {
                                  return DropdownMenuItem<String>(value: value, child: Text(value));
                                })
                                .toList(),
                            onChanged: (String? newValue) {
                              setModalState(() {
                                tempDays = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Buttons
                  Container(
                    padding: const EdgeInsets.all(24),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 100,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          height: 40,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedSort = tempSort;
                                selectedDays = tempDays;
                              });
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Apply'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildChart(BuildContext context) {
    SizeConfig().init(context);
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width <= 1000;
    final bool isDesktop = width > 1000;

    // Responsive sizing
    double chartHeight;
    double headerFontSize;
    double legendFontSize;
    double axisFontSize;

    if (isDesktop) {
      chartHeight = 300;
      headerFontSize = 16;
      legendFontSize = 12;
      axisFontSize = 10;
    } else if (isTablet) {
      chartHeight = 260;
      headerFontSize = 15;
      legendFontSize = 11;
      axisFontSize = 10;
    } else {
      chartHeight = 220;
      headerFontSize = 14;
      legendFontSize = 11;
      axisFontSize = 9;
    }

    return Obx(() {
      final data = widget.controller.salesList;

      // Calculate totals for legend
      double totalRevenue = data.fold(0.0, (sum, item) => sum + item.revenue);
      double totalSales = data.fold(0.0, (sum, item) => sum + item.sales);
      double totalOrders = data.fold(0.0, (sum, item) => sum + item.orders);

      return Padding(
        padding: EdgeInsets.only(
          left: isMobile ? 15 : 20,
          right: isMobile
              ? 15
              : isTablet
              ? 20
              : 5,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xffE8E8E8), width: 1),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile
                  ? 12
                  : isTablet
                  ? 15
                  : 16,
              vertical: isMobile
                  ? 12
                  : isTablet
                  ? 15
                  : 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Chart Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: getProportionateScreenWidth(10)),
                        child: Text(
                          'Overall Sales Chart',
                          style: GoogleFonts.inter(
                            fontSize: headerFontSize,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff1A1A1A),
                          ),
                        ),
                      ),
                    ),
                    if (isMobile) ...[
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          _showFilterBottomSheet();
                          // Show filter bottom sheet for mobile
                        },
                        child: Image.asset('assets/sales_images/filter.png', width: 20, height: 20),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          'assets/sales_images/calender.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ] else ...[
                      const SizedBox(width: 12),
                      Row(
                        children: [
                          Obx(
                            () => CustomDropdownButton(
                              items: widget.controller.salesTypes,
                              selectedValue: widget.controller.selectedSales.value,
                              onChanged: (value) {
                                widget.controller.selectedSales.value = value!;
                              },
                              width: 130,
                              borderColor: const Color(0xffDDDDDD),
                              backgroundColor: Colors.white,
                              textColor: const Color(0xff5A5A5A),
                              iconColor: const Color(0xff5A5A5A),
                              borderRadius: 4,
                            ),
                          ),
                          const SizedBox(width: 8),
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
                                          color: fromDate == null
                                              ? Colors.grey.shade600
                                              : Colors.black87,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: Colors.grey.shade600,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),

                SizedBox(height: isMobile ? 12 : 10),

                // Legend
                Padding(
                  padding: EdgeInsets.only(left: getProportionateScreenWidth(18)),
                  child: Wrap(
                    spacing: isMobile ? 12 : 20,
                    runSpacing: 8,
                    children: [
                      _buildLegendItem(
                        'Revenue',
                        isMobile ? '' : '- ₹${(totalRevenue / 100000).toStringAsFixed(3)}L',
                        const Color(0xff2DD4BF),
                        legendFontSize,
                      ),
                      _buildLegendItem(
                        'Sales',
                        isMobile ? '' : '- ₹${(totalSales / 1000).toStringAsFixed(2)}',
                        const Color(0xff60A5FA),
                        legendFontSize,
                      ),
                      _buildLegendItem(
                        'Orders',
                        isMobile ? '' : "- ${totalOrders.toStringAsFixed(0)}",
                        const Color(0xffFBBF24),
                        legendFontSize,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isMobile ? 12 : 10),

                // Chart
                SizedBox(
                  height: chartHeight,
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: 30,
                      minY: 0,

                      // Replace the lineTouchData section in your LineChart with this:
                      lineTouchData: LineTouchData(
                        enabled: true,

                        // Configure the vertical line and dots shown on touch
                        getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                          return spotIndexes.map((index) {
                            return TouchedSpotIndicatorData(
                              // Vertical dashed line
                              FlLine(
                                color: Colors.grey.withOpacity(0.5),
                                strokeWidth: 1.5,
                                dashArray: [5, 5],
                              ),
                              // Show dot on the touched point
                              FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 5,
                                    color: barData.color ?? Colors.white,
                                    strokeWidth: 2,
                                    strokeColor: Colors.white,
                                  );
                                },
                              ),
                            );
                          }).toList();
                        },

                        touchTooltipData: LineTouchTooltipData(
                          // Tooltip styling
                          tooltipBgColor: Colors.white,
                          tooltipBorder: BorderSide(color: Colors.grey.shade300, width: 1.5),
                          tooltipRoundedRadius: 8,
                          tooltipPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          fitInsideHorizontally: true,
                          fitInsideVertically: true,

                          // Custom tooltip showing all three values in one box
                          getTooltipItems: (List<LineBarSpot> touchedSpots) {
                            if (touchedSpots.isEmpty) return [];

                            // Get the day from the first spot
                            final day = touchedSpots[0].x.toInt();

                            // Find the actual data for this day
                            final dayData = data.firstWhere(
                              (item) => item.day == day,
                              orElse: () => data.first,
                            );

                            // Return only ONE tooltip item for the first line
                            return touchedSpots.asMap().entries.map((entry) {
                              final index = entry.key;

                              if (index == 0) {
                                // Show combined tooltip with all values
                                return LineTooltipItem(
                                  'Day $day',
                                  const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    height: 1.3,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '\n● Revenue: ₹${(dayData.revenue / 100000).toStringAsFixed(2)}L',
                                      style: GoogleFonts.openSans(
                                        color: Colors.black.withOpacity(.7),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                        height: 1.4,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '\n● Sales: ₹${(dayData.sales / 1000).toStringAsFixed(2)}K',
                                      style: GoogleFonts.openSans(
                                        color: Colors.black.withOpacity(.7),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                        height: 1.4,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '\n● Orders: ${dayData.orders.toStringAsFixed(0)}',
                                      style: GoogleFonts.openSans(
                                        color: Colors.black.withOpacity(.7),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                  textAlign: TextAlign.left,
                                );
                              }

                              // Return null for other lines to avoid multiple tooltips
                              return null;
                            }).toList();
                          },
                        ),

                        handleBuiltInTouches: true,
                      ),

                      maxY: 10,
                      gridData: FlGridData(
                        show: false,
                        drawVerticalLine: false,
                        drawHorizontalLine: false,
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          axisNameWidget: Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Text(
                              'Days',
                              style: GoogleFonts.inter(
                                fontSize: axisFontSize + 1,
                                color: const Color(0xff666666),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 22,
                            interval: isMobile ? 5 : 1,
                            getTitlesWidget: (value, meta) {
                              if (value == 0 || value > 30) return const SizedBox.shrink();
                              return Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  value.toInt().toString(),
                                  style: GoogleFonts.inter(
                                    fontSize: axisFontSize,
                                    color: const Color(0xff999999),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          axisNameWidget: Padding(
                            padding: const EdgeInsets.only(right: 6, bottom: 2),
                            child: Text(
                              'Amount (₹)',
                              style: GoogleFonts.inter(
                                fontSize: axisFontSize + 1,
                                color: const Color(0xff666666),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 34,
                            interval: 2,
                            getTitlesWidget: (value, meta) {
                              if (value == 0 || value > 10) return const SizedBox.shrink();
                              return Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text(
                                  '${value.toInt()}L',
                                  style: GoogleFonts.inter(
                                    fontSize: axisFontSize,
                                    color: const Color(0xff999999),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              );
                            },
                          ),
                        ),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          bottom: BorderSide(color: Color(0xffE0E0E0), width: 1),
                          left: BorderSide(color: Color(0xffE0E0E0), width: 1),
                        ),
                      ),
                      clipData: FlClipData.all(),
                      lineBarsData: [
                        // Revenue line (Teal) - Top trending line
                        LineChartBarData(
                          spots: data
                              .map((e) => FlSpot(e.day.toDouble(), e.revenue / 100000))
                              .toList(),
                          isCurved: true,
                          curveSmoothness: 0.35,
                          color: const Color(0xff2DD4BF),
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                        // Sales line (Blue) - Middle line
                        LineChartBarData(
                          spots: data
                              .map((e) => FlSpot(e.day.toDouble(), e.sales / 150000))
                              .toList(),
                          isCurved: true,
                          curveSmoothness: 0.35,
                          color: const Color(0xff60A5FA),
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                        // Orders line (Yellow) - Bottom flat line
                        LineChartBarData(
                          spots: data.map((e) => FlSpot(e.day.toDouble(), e.orders / 300)).toList(),
                          isCurved: true,
                          curveSmoothness: 0.35,
                          color: const Color(0xffFBBF24),
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildLegendItem(String label, String value, Color color, double fontSize) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          '$label ',
          style: GoogleFonts.inter(
            fontSize: fontSize,
            color: const Color(0xff5A5A5A),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: fontSize,
            color: const Color(0xff1A1A1A),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
