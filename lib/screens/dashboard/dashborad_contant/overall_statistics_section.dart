import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/controller/dashboard/dashboard_controller.dart';
import 'package:soft_sales/screens/dashboard/sales_widgets/date_picker.dart';
import 'package:soft_sales/screens/dashboard/sales_widgets/statcard_container.dart';

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
    return Column(
      children: [
        // Header with date dropdown
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 20 : 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Overall Statistics',
                  style: GoogleFonts.openSans(
                    color: const Color(0xff1E1E1E),
                    fontSize: widget.isMobile ? 16 : 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
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
          ),
        ),
        SizedBox(height: widget.isMobile ? 16 : 24),

        // Stats Grid Section
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.width >= 600 ? 20 : 15),
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

  // void _showDateRangePicker(BuildContext context) {
  //   double dialogWidth;
  //   double dialogHeight;

  //   if (widget.isMobile) {
  //     dialogWidth = MediaQuery.of(context).size.width * 0.65;
  //     dialogHeight = MediaQuery.of(context).size.height * 0.90;
  //   } else if (widget.width < 900) {
  //     dialogWidth = MediaQuery.of(context).size.width * 0.45;
  //     dialogHeight = MediaQuery.of(context).size.height * 98;
  //   } else {
  //     dialogWidth = MediaQuery.of(context).size.width * 0.28;
  //     dialogHeight = MediaQuery.of(context).size.height * 60;
  //   }

  //   showDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext dialogContext) {
  //       return Dialog(
  //         backgroundColor: Colors.white,
  //         child: SizedBox(
  //           width: dialogWidth,
  //           height: dialogHeight,
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
