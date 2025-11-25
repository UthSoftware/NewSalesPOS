import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/constants/my_colour.dart';
import 'package:soft_sales/screens/sales/order_summary_panel_widgets/product_details_view.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

// ignore: must_be_immutable
class OrderSummaryBody extends StatefulWidget {
  const OrderSummaryBody({super.key});

  @override
  State<OrderSummaryBody> createState() => _OrderSummaryBodyState();
}

class _OrderSummaryBodyState extends State<OrderSummaryBody> {
  late OrderSummary orderSummary;

  final List<OrderSummaryItem> orderSummaryItemListNew = [
    OrderSummaryItem(itemName: "Paneer Tikka", quantity: 1, notes: "Extra grilled", price: 180.0),
    OrderSummaryItem(itemName: "Chicken Biryani", quantity: 1, price: 220.0),
  ];

  List<OrderSummaryItem> orderSummaryItemList1 = [
    OrderSummaryItem(
      itemName: "Cold Coffee",
      quantity: 1,
      notes: "",
      price: 90.0,
      addOnItems: [
        AddonItem(addOnName: "Cheese Cake", addOnPrice: 90, addOnQty: 2),
        AddonItem(addOnName: "Cool Drink", addOnPrice: 40, addOnQty: 1),
      ],
    ),
  ];
  final List<OrderSummaryItem> orderSummaryItemList2 = [
    OrderSummaryItem(
      itemName: "Veg Burger",
      quantity: 1,
      notes: "Extra mayo",
      price: 90.0,
      addOnItems: [
        AddonItem(addOnName: "Cheese Slice", addOnPrice: 20, addOnQty: 1),
        AddonItem(addOnName: "French Fries", addOnPrice: 50, addOnQty: 1),
      ],
    ),
  ];
  final List<OrderSummaryItem> orderSummaryItemList3 = [
    OrderSummaryItem(itemName: "Chicken Tikka", quantity: 1, notes: "", price: 220.0),
  ];
  final List<OrderSummaryItem> orderSummaryItemList4 = [
    OrderSummaryItem(itemName: "Watermelon Juice", quantity: 1, notes: "No sugar", price: 50.0),
  ];

  @override
  void initState() {
    orderSummary = OrderSummary(
      orderId: "54124512444",
      kotDetails: [
        KotDetail(items: orderSummaryItemListNew),
        KotDetail(kotId: "1", items: orderSummaryItemList1, kotTime: "11:35 AM"),
        KotDetail(kotId: "2", items: orderSummaryItemList2, kotTime: "11:00 AM"),
        KotDetail(kotId: "3", items: orderSummaryItemList3, kotTime: "10:45 AM"),
        KotDetail(kotId: "4", items: orderSummaryItemList4, kotTime: "10:35 AM"),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Expanded(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: orderSummary.kotDetails.length,
              itemBuilder: (context, index) => _buildKotItem(index),
            ),
          ),
        ],
      ),
    );
  }

  // Animation durations
  static const _expandDuration = Duration(milliseconds: 300);
  static const _rotateDuration = Duration(milliseconds: 250);

  Widget _buildHeader() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: MyColors.orderSummaryHeaderBackground,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Order Summary',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                    fontSize: getProportionateScreenWidth(4.5),
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(3)),
                Text(
                  'Bill No : 54124512445',
                  style: GoogleFonts.openSans(
                    color: const Color(0XFF3B82F6),
                    fontSize: getProportionateScreenWidth(4.1),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Container(
                        width: getProportionateScreenWidth(5.3),
                        height: getProportionateScreenWidth(5.3),
                        decoration: BoxDecoration(
                          color: true ? Color(0xFFD64545) : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Color(0xFFD64545), width: 2),
                        ),
                        child: true
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: getProportionateScreenWidth(4.1),
                              )
                            : null,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "KOT",
                        style: GoogleFonts.openSans(
                          color: const Color(0XFF3A3A3A),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(4)),
                Text('Dhina', style: GoogleFonts.openSans(color: const Color(0XFF3A3A3A))),
                SizedBox(width: getProportionateScreenWidth(1.4)),
                SvgPicture.asset(
                  "assets/waiter_icon.svg",
                  height: getProportionateScreenHeight(28),
                  width: getProportionateScreenHeight(28),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKotItem(int index) {
    final kot = orderSummary.kotDetails[index];
    final isExpanded = index == orderSummary.openedKotIndex;

    // Check if this is a "New Items" section (items not yet sent to kitchen)
    // kotId == null means items are newly added but KOT not generated yet
    final isNewItems = kot.kotId == null;

    // Check if first item is new (determines label positioning)
    final firstItemIsNew = orderSummary.kotDetails.first.kotId == null;

    // Show labels logic:
    // - "New Items": Show at index 0 only if first item is new
    // - "Ordered Items": Show at index 0 if first item has kotId, OR at index 1 if first item is new
    final showNewItemsLabel = index == 0 && firstItemIsNew;
    final showOrderedItemsLabel = (index == 0 && !firstItemIsNew) || (index == 1 && firstItemIsNew);

    final bool ifShowLable =
        !(orderSummary.kotDetails.length == 1 && orderSummary.kotDetails[0].kotId == null);

    return Column(
      children: [
        // Show section label for "New Items" or "Ordered Items"
        if (ifShowLable && showNewItemsLabel)
          _buildSectionLabel('New Items')
        else if (ifShowLable && showOrderedItemsLabel)
          _buildSectionLabel('Ordered Items'),

        // Show KOT header only for items that have been sent to kitchen (have kotId)
        // New items are displayed directly without collapsible header
        if (!isNewItems) _buildKotHeader(index, kot, isExpanded),

        // Show items with expand/collapse animation
        // - For new items: always show all items (no expand/collapse)
        // - For ordered items: show only when expanded
        AnimatedSize(
          duration: _expandDuration,
          curve: Curves.easeInOut,
          child: (isNewItems || isExpanded)
              ? Column(children: kot.items.map((item) => _buildOrderItem(item)).toList())
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  // Section label for "New Items" or "Ordered Items"
  Widget _buildSectionLabel(String label) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: MyColors.selectedBackgroundColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              label,
              style: GoogleFonts.openSans(
                color: MyColors.selectedForegroundColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 3),
        ],
      ),
    );
  }

  // KOT header with expand/collapse functionality
  // Only shown for items that have been sent to kitchen
  Widget _buildKotHeader(int index, KotDetail kot, bool isExpanded) {
    return GestureDetector(
      onTap: () {
        setState(() {
          orderSummary.openedKotIndex = index == orderSummary.openedKotIndex ? -1 : index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: MyColors.orderSummaryKotBackground,
          boxShadow: isExpanded
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    'KOT #${kot.kotId}',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                      fontSize: getProportionateScreenWidth(4.5),
                    ),
                  ),
                  SizedBox(width: getProportionateScreenWidth(3)),
                  Text(
                    '(${kot.items.length} Items)',
                    style: GoogleFonts.openSans(
                      color: MyColors.selectedForegroundColor,
                      fontSize: getProportionateScreenWidth(4),
                    ),
                  ),
                  SizedBox(width: getProportionateScreenWidth(3)),
                  Text(
                    '- ${kot.kotTime}',
                    style: GoogleFonts.openSans(
                      color: const Color(0XFF6A6A6A),
                      fontSize: getProportionateScreenWidth(4),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                // Reprint icon with scale animation on tap
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 1.0, end: 1.0),
                  duration: const Duration(milliseconds: 150),
                  builder: (context, value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: SvgPicture.asset(
                    "assets/sales_images/reprint_icon.svg",
                    height: getProportionateScreenHeight(25),
                    width: getProportionateScreenHeight(25),
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(5)),
                // Animated arrow rotation
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0.0, // 0.5 turns = 180 degrees
                  duration: _rotateDuration,
                  curve: Curves.easeInOut,
                  child: SvgPicture.asset(
                    "assets/up_arrow.svg",
                    height: getProportionateScreenHeight(12),
                    width: getProportionateScreenHeight(12),
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(2)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Individual order item display
  Widget _buildOrderItem(OrderSummaryItem item) {
    final hasNotes = item.notes != null && item.notes!.isNotEmpty;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 10 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: MyColors.borderColor, width: 1.5)),
        ),
        child: Column(
          children: [
            _buildItemRow(item, hasNotes),
            if (item.addOnItems != null && item.addOnItems!.isNotEmpty)
              _buildAddOnItems(item.addOnItems!),
            if (hasNotes) _buildNotes(item.notes!),
          ],
        ),
      ),
    );
  }

  // Item row: name, notes icon, quantity controls, price
  Widget _buildItemRow(OrderSummaryItem item, bool hasNotes) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              SizedBox(width: getProportionateScreenWidth(3)),
              SvgPicture.asset(
                "assets/delete_icon.svg",
                height: getProportionateScreenHeight(23),
                width: getProportionateScreenHeight(23),
              ),
              SizedBox(width: getProportionateScreenWidth(3)),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    _openProductEdit(context);
                  },
                  child: Text(
                    item.itemName,
                    style: GoogleFonts.openSans(
                      color: const Color(0XFF3A3A3A),
                      fontWeight: FontWeight.w500,
                      fontSize: getProportionateScreenWidth(4.3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            SvgPicture.asset(
              hasNotes ? "assets/noted_icon.svg" : "assets/notes_icon.svg",
              height: getProportionateScreenHeight(29),
              width: getProportionateScreenHeight(29),
            ),
            SizedBox(width: getProportionateScreenWidth(6)),
            _buildQuantityControls(item.quantity),
            SizedBox(
              width: getProportionateScreenWidth(25),
              child: Text(
                '₹${item.price.toStringAsFixed(2)}',
                style: GoogleFonts.openSans(
                  color: const Color(0XFF008A05),
                  fontWeight: FontWeight.w700,
                  fontSize: getProportionateScreenWidth(4.3),
                ),
                textAlign: TextAlign.end,
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(2.5)),
          ],
        ),
      ],
    );
  }

  // Quantity increment/decrement controls
  Widget _buildQuantityControls(double quantity) {
    return SizedBox(
      width: getProportionateScreenHeight(130),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            "assets/minus_qty.svg",
            height: getProportionateScreenHeight(27),
            width: getProportionateScreenHeight(27),
          ),
          Text(
            quantity.toString(),
            style: GoogleFonts.openSans(
              color: const Color(0XFF3A3A3A),
              fontWeight: FontWeight.w500,
              fontSize: getProportionateScreenWidth(4.3),
            ),
          ),
          SvgPicture.asset(
            "assets/add_qty.svg",
            height: getProportionateScreenHeight(27),
            width: getProportionateScreenHeight(27),
          ),
        ],
      ),
    );
  }

  // Display add-on items for the main item
  Widget _buildAddOnItems(List<AddonItem> addOnItems) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(10),
        right: getProportionateScreenWidth(3),
        top: 14,
        bottom: 4,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0XFFF9F9F9),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: addOnItems
              .map(
                (addOn) => Padding(
                  padding: EdgeInsets.only(bottom: getProportionateScreenWidth(2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${addOn.addOnName} - ${addOn.addOnQty.toStringAsFixed(0)}",
                            style: GoogleFonts.openSans(
                              color: const Color(0XFF5A5A5A),
                              fontSize: getProportionateScreenWidth(4),
                            ),
                          ),
                          SizedBox(width: getProportionateScreenWidth(7)),
                          SvgPicture.asset("assets/minus_qty_filled.svg"),
                        ],
                      ),
                      Text(
                        '₹${addOn.addOnPrice.toStringAsFixed(2)}',
                        style: GoogleFonts.openSans(
                          color: const Color(0XFF495057),
                          fontWeight: FontWeight.w600,
                          fontSize: getProportionateScreenWidth(4.18),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  // Display special notes for the item
  Widget _buildNotes(String notes) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth * 0.85,
          margin: EdgeInsets.only(top: 14, bottom: 4),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Color(0XFF3B82F6), width: 0.5),
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Colors.black),
              children: [
                TextSpan(
                  text: 'Notes : ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0XFF3B82F6),
                    // fontSize: getProportionateScreenWidth(4.3),
                  ),
                ),
                TextSpan(
                  text: notes,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color(0XFF6A6A6A),
                    fontSize: getProportionateScreenWidth(3.5),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Smart navigation based on screen size
  void _openProductEdit(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      // Mobile: Navigate to new screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResponsiveProductEditScreen()),
      );
    } else {
      // Tablet/Desktop: Show dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ResponsiveProductEditScreen(),
      );
    }
  }
}

class OrderSummary {
  final String orderId;
  int openedKotIndex = 0;
  final List<KotDetail> kotDetails;

  OrderSummary({required this.orderId, required this.kotDetails});
}

class KotDetail {
  final String? kotId;
  final List<OrderSummaryItem> items;
  final String? kotTime;

  KotDetail({this.kotId, required this.items, this.kotTime});
}

class OrderSummaryItem {
  final String? kotId;
  final String itemName;
  final double quantity;
  final String? notes;
  final double price;
  final List<AddonItem>? addOnItems;

  OrderSummaryItem({
    this.kotId,
    required this.itemName,
    required this.quantity,
    this.notes,
    required this.price,
    this.addOnItems,
  });
}

class AddonItem {
  final String addOnName;
  final double addOnPrice;
  final double addOnQty;
  final bool isMandatory;

  AddonItem({
    required this.addOnName,
    required this.addOnPrice,
    required this.addOnQty,
    this.isMandatory = false,
  });
}
