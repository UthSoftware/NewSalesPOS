import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/constants/my_colour.dart';
import 'package:soft_sales/models/sales/order_type.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class FilterHeaderWidget extends StatefulWidget {
  const FilterHeaderWidget({super.key});

  @override
  State<FilterHeaderWidget> createState() => _FilterHeaderWidgetState();
}

class _FilterHeaderWidgetState extends State<FilterHeaderWidget> {
  int selectedFilter = 0;

  final filterHeaderList = [
    FilterHeader(nameEn: "Brand", nameReg: "علامة تجارية"),
    FilterHeader(nameEn: "Concept", nameReg: "مفهوم"),
    FilterHeader(nameEn: "Section", nameReg: "قسم"),
    FilterHeader(nameEn: "Category", nameReg: "فئة"),
    FilterHeader(nameEn: "Sub Category", nameReg: "الفئة الفرعية"),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      height: getProportionateScreenWidth(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: getProportionateScreenWidth(17),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filterHeaderList.length,
              itemBuilder: (context, index) {
                final isSelected = selectedFilter == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilter = index;
                    });
                  },
                  child: _FilterItem(
                    nameEn: filterHeaderList[index].nameEn,
                    nameReg: filterHeaderList[index].nameReg,
                    isSelected: isSelected,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Custom widget that measures its own width INCLUDING padding
class _FilterItem extends StatefulWidget {
  final String nameEn;
  final String nameReg;
  final bool isSelected;

  const _FilterItem({required this.nameEn, required this.nameReg, required this.isSelected});

  @override
  State<_FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<_FilterItem> {
  double? _width;

  @override
  Widget build(BuildContext context) {
    return MeasureSize(
      onChange: (size) {
        if (_width != size.width) {
          setState(() {
            _width = size.width;
          });
        }
      },
      // 👇 Measure the ENTIRE item including padding
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text content with padding
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.nameEn,
                  style: GoogleFonts.openSans(
                    color: widget.isSelected
                        ? MyColors.selectedForegroundColor
                        : MyColors.unSelectedForegroundColor,
                    fontWeight: FontWeight.w500,
                    fontSize: getProportionateScreenWidth(4.2),
                  ),
                ),
                Text(
                  '(${widget.nameReg})',
                  style: GoogleFonts.openSans(
                    color: widget.isSelected
                        ? MyColors.selectedForegroundColor
                        : MyColors.unSelectedForegroundColor,
                    fontWeight: FontWeight.w500,
                    fontSize: getProportionateScreenWidth(3.2),
                  ),
                ),
              ],
            ),
          ),
          // 👇 Bottom line with centered alignment
          SizedBox(
            height: 8, // Fixed height container (4 + 4 margin)
            child: Align(
              alignment: Alignment.center, // Center the line vertically
              child: Container(
                width: _width, // Uses full measured width with padding
                height: widget.isSelected ? 4 : 0.2,
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? MyColors.selectedForegroundColor
                      : MyColors.unSelectedForegroundColor,
                  borderRadius: widget.isSelected ? BorderRadius.circular(100) : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget to measure size
class MeasureSize extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onChange;

  const MeasureSize({super.key, required this.onChange, required this.child});

  @override
  State<MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getSize());
  }

  @override
  void didUpdateWidget(MeasureSize oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _getSize());
  }

  void _getSize() {
    final context = _key.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox?;
      if (box != null && box.hasSize) {
        widget.onChange(box.size);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(key: _key, child: widget.child);
  }
}

class FilterHeader extends BaseType {
  FilterHeader({required super.nameEn, required super.nameReg, super.thamnailChar});
}
