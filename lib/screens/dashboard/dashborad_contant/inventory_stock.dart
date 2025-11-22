import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryStockAlertCard extends StatefulWidget {
  const InventoryStockAlertCard({super.key});

  @override
  State<InventoryStockAlertCard> createState() => _InventoryStockAlertCardState();
}

class _InventoryStockAlertCardState extends State<InventoryStockAlertCard> {
  String? openedAlertType;
  String selectedHeader = "6 Items Out of Stock";

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width > 1000;
    final bool isTablet = width >= 600 && width <= 1000;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Inventory & Stock Alert",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xff2D2D2D),
            ),
          ),
          const SizedBox(height: 16),
          // Mobile and Desktop: Show one at a time
          // Tablet: Show both side by side
          if (isMobile || isDesktop)
            openedAlertType == null
                ? _buildAlertList()
                : Padding(padding: const EdgeInsets.only(right: 10), child: _buildRightPanel())
          else if (isTablet)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 45, child: _buildAlertList()),
                const SizedBox(width: 15),
                Expanded(flex: 55, child: _buildRightPanel()),
              ],
            ),
        ],
      ),
    );
  }

  // 🔹 Left panel — clickable alerts
  Widget _buildAlertList() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xffE0E0E0), width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAlertHeader(),
          _buildAlertItem(
            '6 Items Out of Stock',
            type: 'outOfStock',
            onTap: () {
              setState(() {
                openedAlertType = 'outOfStock';
                selectedHeader = '6 Items Out of Stock';
              });
            },
          ),
          _divider(),
          _buildAlertItem(
            'Low Stock Ingredients',
            type: 'lowStock',
            onTap: () {
              setState(() {
                openedAlertType = 'lowStock';
                selectedHeader = 'Low Stock Ingredients';
              });
            },
          ),
          _divider(),
          _buildAlertItem(
            'Spoiled / Wasted Goods',
            type: 'spoiled',
            onTap: () {
              setState(() {
                openedAlertType = 'spoiled';
                selectedHeader = 'Spoiled / Wasted Goods';
              });
            },
          ),
          _divider(),
          _buildAlertItem(
            'Expiring Soon',
            type: 'expiring',
            onTap: () {
              setState(() {
                openedAlertType = 'expiring';
                selectedHeader = 'Expiring Soon';
              });
            },
          ),
          _divider(),
          _buildAlertItem(
            'Frozen Stock Alert',
            type: 'frozen',
            onTap: () {
              setState(() {
                openedAlertType = 'frozen';
                selectedHeader = 'Frozen Stock Alert';
              });
            },
          ),
          _divider(),
          _buildInventoryValue(),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildAlertHeader() {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xffEBFFF8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Text(
        'Alert Type',
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          color: const Color(0xff00AF81),
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildAlertItem(String title, {String? type, VoidCallback? onTap}) {
    final bool isSelected = openedAlertType == type;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: double.infinity,
        color: isSelected ? const Color(0xffE8F5F2) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? const Color(0xff00AD74) : const Color(0xff2D2D2D),
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: isSelected ? const Color(0xff00AD74) : const Color(0xff999999),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(height: 1, color: const Color(0xffE0E0E0));
  }

  Widget _buildInventoryValue() {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 7),
          Text(
            'Current Inventory Value',
            style: GoogleFonts.inter(fontSize: 12, color: const Color(0xff6F6F6F)),
          ),
          const SizedBox(height: 4),
          Text(
            '₹2,02,025.00',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xff00AD74),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Right panel (detail view with back button)
  Widget _buildRightPanel() {
    final width = MediaQuery.of(context).size.width;
    final bool isTablet = width >= 600 && width <= 1000;

    final items = [
      ["Chicken Breast", "Meat", "High Usage", const Color(0xffFF0000)],
      ["Mozzarella Cheese", "Dairy", "Medium Usage", const Color(0xffFFA500)],
      ["Whole Wheat Burger", "Bakery", "High Usage", const Color(0xffFF0000)],
      ["Lettuce", "Vegetable", "Medium Usage", const Color(0xffFFA500)],
      ["French Fries", "Snacks", "High Usage", const Color(0xffFF0000)],
      ["Sprite 500ml", "Beverages", "High Usage", const Color(0xffFF0000)],
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffE8F5F2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xffE0E0E0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with back button (hide on tablet)
          if (!isTablet)
            Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffE8F5F2),
                borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        openedAlertType = null;
                      });
                    },
                    icon: const Icon(Icons.arrow_back_ios, size: 16, color: Color(0xff00AD74)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    selectedHeader,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff00AD74),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          // Header without back button (show on tablet)
          if (isTablet)
            Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffE8F5F2),
                borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                "6 Items Out of Stock",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff00AD74),
                  fontSize: 14,
                ),
              ),
            ),
          // Items list with white background
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Column(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            items[i][0] as String,
                            style: GoogleFonts.openSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff2D2D2D),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            items[i][1] as String,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              color: const Color(0xff6F6F6F),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            items[i][2] as String,
                            textAlign: TextAlign.end,
                            style: GoogleFonts.openSans(
                              color: items[i][3] as Color,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (i < items.length - 1) Container(height: 1, color: const Color(0xffE0E0E0)),
                ],

                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
