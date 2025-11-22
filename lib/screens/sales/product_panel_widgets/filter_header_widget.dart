import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/constants/my_colour.dart';
import 'package:soft_sales/models/sales/order_type.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class FilterHeaderWidget extends StatefulWidget {
  final VoidCallback? onMenuPressed;

  const FilterHeaderWidget({super.key, this.onMenuPressed});

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
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet =
        MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width <= 1000;

    return SingleChildScrollView(
      child: SizedBox(
        height: getProportionateScreenWidth(22), // ✅ Increased from 20 to 22
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Logo for mobile/tablet
            if (isMobile || isTablet)
              InkWell(
                onTap: widget.onMenuPressed,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(2),
                    right: getProportionateScreenWidth(5),
                    top: getProportionateScreenHeight(15),
                  ),
                  child: SvgPicture.asset('assets/sales_images/uthpos.svg', width: 24, height: 24),
                ),
              ),

            // ✅ Filter list takes remaining space
            Expanded(
              child: SizedBox(
                height: getProportionateScreenWidth(19), // ✅ Increased from 17 to 19
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
            ),
          ],
        ),
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
        if (_width != size.width && mounted) {
          // ✅ Added mounted check
          setState(() {
            _width = size.width;
          });
        }
      },
      child: Column(
        // ✅ REMOVED mainAxisSize: MainAxisSize.min to fix overflow
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text content with padding
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 14,
            ), // ✅ Reduced vertical from 6 to 4
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
          // Bottom line with centered alignment
          SizedBox(
            height: 8,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: _width,
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

// Fixed MeasureSize widget with proper disposal handling
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
    // ✅ Check if widget is still mounted before calling onChange
    if (!mounted) return;

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
