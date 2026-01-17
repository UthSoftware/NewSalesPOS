import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/controller/dashboard/dashboard_controller.dart';
import 'package:soft_sales/screens/dashboard/sales_widgets/date_picker.dart';
import 'package:soft_sales/screens/dashboard/sales_widgets/statcard_container.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class OverallStatisticsSection extends StatefulWidget {
  final StatsController controller;
  final bool isMobile;
  final double width;

  const OverallStatisticsSection({
    super.key,
    required this.controller,
    required this.isMobile,
    required this.width,
  });

  @override
  State<OverallStatisticsSection> createState() => _OverallStatisticsSectionState();
}

class _OverallStatisticsSectionState extends State<OverallStatisticsSection> {
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
    SizeConfig().init(context);

    return Column(
      children: [
        // Header with date dropdown
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile
                ? getProportionateScreenWidth(7)
                : getProportionateScreenWidth(7),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Overall Statistics',
                  style: GoogleFonts.openSans(
                    color: const Color(0xff1E1E1E),
                    fontSize: widget.isMobile
                        ? getProportionateScreenHeight(18)
                        : getProportionateScreenHeight(24),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _showCustomDateRangePicker(context);
                },
                child: Container(
                  height: getProportionateScreenHeight(35),
                  width: widget.isMobile
                      ? getProportionateScreenWidth(140)
                      : getProportionateScreenWidth(55),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(3)),
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
                        Icon(
                          Icons.calendar_today,
                          size: getProportionateScreenHeight(16),
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: widget.isMobile
              ? getProportionateScreenHeight(16)
              : getProportionateScreenHeight(24),
        ),

        // Stats Grid Section
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.width >= 600
                ? getProportionateScreenWidth(7)
                : getProportionateScreenWidth(10),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              double childAspectRatio;
              double crossAxisSpacing;
              double mainAxisSpacing;

              // 🖥️ DESKTOP LAYOUT (Image 2 - Large screens with more spacing)
              if (widget.width >= 1400) {
                // Extra large desktop
                crossAxisCount = 4;
                childAspectRatio = 2 / 4;
                crossAxisSpacing = 20;
                mainAxisSpacing = 20;
              } else if (widget.width >= 1200) {
                // Desktop - 4 columns with larger spacing
                crossAxisCount = 4;
                childAspectRatio = 2 / 1;
                crossAxisSpacing = 18;
                mainAxisSpacing = 18;
              }
              // 💻 WEB/TABLET LAYOUT (Image 3 - Compact 4 columns)
              else if (widget.width >= 900) {
                // Medium desktop
                crossAxisCount = 4;
                childAspectRatio = 2 / 1;
                crossAxisSpacing = 14;
                mainAxisSpacing = 14;
              } else if (widget.width >= 768) {
                // Web/Tablet - 4 columns more compact
                crossAxisCount = 4;
                childAspectRatio = 2.0;
                crossAxisSpacing = 12;
                mainAxisSpacing = 12;
              } else if (widget.width >= 600) {
                // Small tablet - 4 columns tight
                crossAxisCount = 4;
                childAspectRatio = 1.6;
                crossAxisSpacing = 10;
                mainAxisSpacing = 10;
              }
              // 📱 MOBILE LAYOUT (Image 1 - 2x2 grid)
              else {
                // Mobile - 2 columns
                crossAxisCount = 2;
                childAspectRatio = 1.8;
                crossAxisSpacing = 12;
                mainAxisSpacing = 12;
              }

              return Obx(() {
                final statsList = widget.controller.stats;

                if (statsList.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
                    ),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: crossAxisSpacing,
                    mainAxisSpacing: mainAxisSpacing,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: statsList.length,
                  itemBuilder: (context, index) => StatCard(stat: statsList[index]),
                );
              });
            },
          ),
        ),
      ],
    );
  }
}
