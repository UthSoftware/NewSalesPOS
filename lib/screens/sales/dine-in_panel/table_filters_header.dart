import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/constants/my_colour.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class TableFiltersHeader extends StatefulWidget {
  const TableFiltersHeader({super.key});

  @override
  State<TableFiltersHeader> createState() => _TableFiltersHeaderState();
}

class _TableFiltersHeaderState extends State<TableFiltersHeader> {
  final List<String> diningAreas = ['All', 'Ground Floor', 'Family', 'Garden', 'Roof Top'];
  int selectedDiningAreaIndex = 0;

  final List<TableStatusModel> tableStatuses = [
    TableStatusModel(
      statusName: 'All',
      unselectedColor: const Color(0xFF8A8A8A),
      unselectedBackgroundColor: null,
      selectedColor: MyColors.selectedForegroundColor,
      selectedBackgroundColor: MyColors.selectedBackgroundColor,
    ),
    TableStatusModel(
      statusName: 'Available',
      unselectedColor: const Color(0XFF28A745),
      unselectedBackgroundColor: null,
      selectedColor: Colors.white,
      selectedBackgroundColor: const Color(0XFF28A745),
    ),
    TableStatusModel(
      statusName: 'On Going',
      unselectedColor: const Color(0XFFFD7E14),
      unselectedBackgroundColor: null,
      selectedColor: Colors.white,
      selectedBackgroundColor: const Color(0XFFFD7E14),
    ),
    TableStatusModel(
      statusName: 'Billed',
      unselectedColor: const Color(0XFF007BFF),
      unselectedBackgroundColor: null,
      selectedColor: Colors.white,
      selectedBackgroundColor: const Color(0XFF007BFF),
    ),
    TableStatusModel(
      statusName: 'Reserved',
      unselectedColor: const Color(0XFFFFC107),
      unselectedBackgroundColor: null,
      selectedColor: Colors.white,
      selectedBackgroundColor: const Color(0XFFFFC107),
    ),
  ];

  int selectedStatusIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Header Titles
          Padding(
            padding: const EdgeInsets.only(right: 6, left: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dining Areas',
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    fontSize: getProportionateScreenWidth(4.2),
                  ),
                ),
                Text(
                  'Table & Chair Status',
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    fontSize: getProportionateScreenWidth(4.2),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: getProportionateScreenHeight(16)),

          // Filter Lists
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Dining Areas Filter
              Expanded(
                child: SizedBox(
                  height: getProportionateScreenHeight(50),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: diningAreas.length,
                    itemBuilder: (context, index) {
                      bool isSelected = selectedDiningAreaIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDiningAreaIndex = index;
                            debugPrint('Dining Area Selected: $index');
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? MyColors.selectedBackgroundColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              diningAreas[index],
                              style: GoogleFonts.openSans(
                                color: isSelected
                                    ? MyColors.selectedForegroundColor
                                    : MyColors.unSelectedForegroundColor,
                                fontSize: getProportionateScreenWidth(4),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Table Status Filter
              Expanded(
                child: SizedBox(
                  height: getProportionateScreenHeight(50),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    itemCount: tableStatuses.length,
                    itemBuilder: (context, index) {
                      int reverseIndex = tableStatuses.length - 1 - index;
                      bool isSelected = selectedStatusIndex == reverseIndex;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedStatusIndex = reverseIndex;
                            debugPrint('Status Selected: $reverseIndex');
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? tableStatuses[reverseIndex].selectedBackgroundColor
                                : tableStatuses[reverseIndex].unselectedBackgroundColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              tableStatuses[reverseIndex].statusName,
                              style: GoogleFonts.openSans(
                                color: isSelected
                                    ? tableStatuses[reverseIndex].selectedColor
                                    : tableStatuses[reverseIndex].unselectedColor,
                                fontSize: getProportionateScreenWidth(4),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(12)),
        ],
      ),
    );
  }
}

//////////////////////// Models ////////////////////////

class TableStatusModel {
  final String statusName;
  final Color? unselectedColor;
  final Color? unselectedBackgroundColor;
  final Color? selectedColor;
  final Color? selectedBackgroundColor;

  const TableStatusModel({
    required this.statusName,
    this.unselectedColor,
    this.unselectedBackgroundColor,
    this.selectedColor,
    this.selectedBackgroundColor,
  });
}
