// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/controller/dashboard/dashboard_controller.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class CustomTableWidget extends StatefulWidget {
  final List<Headers> headers;
  final List<List<String>> data;
  final Color headerColor;

  final Color? headerTextColor;
  final bool showFilters; // 👈 Add this
  final VoidCallback? onFilterTap; // 👈 Add this
  final VoidCallback? onSortTap; // 👈 Add this
  final Widget? filterDropdown; // 👈 Add this for custom dropdown
  final Widget? sortDropdown; // 👈 Add this for custom dropdown

  const CustomTableWidget({
    super.key,
    required this.headers,
    required this.data,
    required this.headerColor,
    this.headerTextColor,

    this.showFilters = false, // 👈 Add this
    this.onFilterTap, // 👈 Add this
    this.onSortTap, // 👈 Add this
    this.filterDropdown, // 👈 Add this
    this.sortDropdown, // 👈 Add this
  });

  @override
  State<CustomTableWidget> createState() => _CustomTableWidgetState();
}

class _CustomTableWidgetState extends State<CustomTableWidget> {
  StatsController controller = Get.put(StatsController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    // Responsive font sizes
    final headerFontSize = isMobile ? 11.0 : 13.0;
    final rowFontSize = isMobile ? 10.0 : 12.0;
    final iconSize = isMobile ? 14.0 : 16.0;
    debugPrint("table data : ${widget.data}");

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ================= FILTER BAR (if enabled) =================
          if (widget.showFilters)
            Container(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10),
                horizontal: getProportionateScreenWidth(12),
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (isMobile)
                    // Mobile: Show icons
                    Row(
                      children: [
                        InkWell(
                          onTap: widget.onFilterTap,
                          child: Container(
                            padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Image.asset(
                              "assets/sales_images/filter.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                        SizedBox(width: getProportionateScreenWidth(8)),
                        InkWell(
                          onTap: widget.onSortTap,
                          child: Container(
                            padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(Icons.sort, size: 20, color: Colors.grey.shade700),
                          ),
                        ),
                      ],
                    )
                  else
                    // Desktop: Show dropdowns
                    Row(
                      children: [
                        if (widget.filterDropdown != null) ...[
                          widget.filterDropdown!,
                          SizedBox(width: getProportionateScreenWidth(8)),
                        ],
                        if (widget.sortDropdown != null) widget.sortDropdown!,
                      ],
                    ),
                ],
              ),
            ),

          // ================= HEADER =================
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [widget.headerColor.withOpacity(0.85), widget.headerColor.withOpacity(0.7)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: widget.showFilters
                  ? BorderRadius.zero
                  : const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(isMobile ? 8 : 15),
              horizontal: getProportionateScreenWidth(isMobile ? 6 : 8),
            ),
            child: Row(
              children: widget.headers.asMap().entries.map((entry) {
                int index = entry.key;
                // String header = entry.value;
                int flex = index == 1 ? 2 : 1;
                // bool isSortable = index == widget.defaultSortableColumn;

                return Expanded(
                  flex: flex,
                  child: GestureDetector(
                    onTap: widget.headers[index].isSortable != null
                        ? widget.headers[index].function
                        : () {},
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.headers[index].title,
                            style: GoogleFonts.openSans(
                              color: widget.headerTextColor ?? Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: headerFontSize,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (widget.headers[index].isSortable != null)
                          Icon(
                            widget.headers[index].isSortable == true
                                ? Icons
                                      .arrow_downward // ✅ Descending
                                : Icons.arrow_upward, // ✅ Ascending
                            size: iconSize,
                            color: widget.headerTextColor ?? Colors.white,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // ================= ROWS =================
          Column(
            children: widget.data.asMap().entries.map((entry) {
              int index = entry.key;
              List<String> row = entry.value;
              Color rowColor = index % 2 == 0 ? Colors.white : Colors.grey.shade50;

              return Container(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(isMobile ? 8 : 14),
                  horizontal: getProportionateScreenWidth(isMobile ? 6 : 8),
                ),
                decoration: BoxDecoration(
                  color: rowColor,
                  border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
                ),
                child: Row(
                  children: row.asMap().entries.map((col) {
                    int colIndex = col.key;
                    String value = col.value;
                    int flex = colIndex == 1 ? 2 : 1;

                    return Expanded(
                      flex: flex,
                      child: Text(
                        value,
                        style: GoogleFonts.openSans(
                          fontSize: rowFontSize,
                          color: colIndex == 4 ? Colors.black : Colors.black87,
                          fontWeight: colIndex == 4
                              ? FontWeight.w600
                              : FontWeight.normal, // Optional: make it bold
                          // Dark black for revenue
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class Headers {
  final String title;
  void Function()? function;
  bool? isSortable;

  Headers({required this.title, this.function, this.isSortable});
}
