// CUSTOMDRAWER.DART - SMOOTH ANIMATION & NO TOOLTIPS

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class CustomDrawer extends StatelessWidget {
  final String selectedItem;
  final bool isReportsExpanded;
  final bool isDrawerExpanded;
  final bool isMobileDrawer;
  final Function(String) onItemSelected;
  final VoidCallback onReportsToggle;
  final VoidCallback onDrawerToggle;

  const CustomDrawer({
    super.key,
    required this.selectedItem,
    required this.isReportsExpanded,
    required this.isDrawerExpanded,
    required this.onItemSelected,
    required this.onReportsToggle,
    required this.onDrawerToggle,
    this.isMobileDrawer = false,
  });

  @override
  Widget build(BuildContext context) {
    void handleItemTap(String title) async {
      if (isMobileDrawer) {
        onItemSelected(title);
        Navigator.of(context).pop();
      } else {
        if (!isDrawerExpanded) {
          onDrawerToggle();
        } else {
          onItemSelected(title);
          onDrawerToggle();
        }
      }
      // Optionally add small delay after visual feedback, non-blocking
      await Future.delayed(Duration(milliseconds: 50));
    }

    SizeConfig().init(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    final menuFontSize = isMobile ? 14.0 : 14.0;
    final submenuFontSize = isMobile ? 14.0 : 13.0;
    final versionFontSize = isMobile ? 12.0 : 11.0;

    final iconWidth = isMobile ? 20.0 : getProportionateScreenWidth(6.5);
    final iconHeight = isMobile ? 20.0 : getProportionateScreenHeight(26);

    final logoWidth = isMobile
        ? (isDrawerExpanded ? 50.0 : 30.0)
        : (isDrawerExpanded ? getProportionateScreenWidth(35) : getProportionateScreenWidth(10));
    final logoHeight = isMobile ? 30.0 : getProportionateScreenHeight(45);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 0, offset: const Offset(1, 0)),
        ],
      ),
      child: Column(
        children: [
          // Header Logo
          Container(
            height: isMobile ? 50.0 : getProportionateScreenHeight(70),
            decoration: BoxDecoration(
              color: isDrawerExpanded ? Color(0xffEEEEEE) : Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
            ),
            child: InkWell(
              onTap: () {
                if (isMobileDrawer) {
                  handleItemTap('Dashboard');
                } else {
                  onDrawerToggle();
                }
              },
              child: Center(
                child: ClipRect(
                  child: SizedBox(
                    width: logoWidth,
                    height: logoHeight,
                    child: SvgPicture.asset('assets/sales_images/uthpos.svg', fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 8.0 : getProportionateScreenHeight(8),
              ),
              children: [
                DrawerMenuItem(
                  iconPath: 'assets/sales_images/dashboard.svg',
                  title: 'Dashboard',
                  isSelected: selectedItem == 'Dashboard',
                  isExpanded: isDrawerExpanded,
                  fontSize: menuFontSize,
                  iconWidth: iconWidth,
                  iconHeight: iconHeight,
                  isMobile: isMobile,
                  isMobileDrawer: isMobileDrawer,
                  onTap: () => handleItemTap('Dashboard'),
                ),
                DrawerMenuItem(
                  iconPath: 'assets/sales_images/sales.svg',
                  title: 'Sales',
                  isSelected: selectedItem == 'Sales',
                  isExpanded: isDrawerExpanded,
                  fontSize: menuFontSize,
                  iconWidth: iconWidth,
                  iconHeight: iconHeight,
                  isMobile: isMobile,
                  isMobileDrawer: isMobileDrawer,
                  onTap: () => handleItemTap('Sales'),
                ),
                DrawerMenuItem(
                  iconPath: 'assets/sales_images/orderlist.svg',
                  title: 'Order List',
                  isSelected: selectedItem == 'Order List',
                  isExpanded: isDrawerExpanded,
                  fontSize: menuFontSize,
                  iconWidth: iconWidth,
                  iconHeight: iconHeight,
                  isMobile: isMobile,
                  isMobileDrawer: isMobileDrawer,
                  onTap: () => handleItemTap('Order List'),
                ),
                DrawerMenuItemWithSubmenu(
                  iconPath: 'assets/sales_images/reports.svg',
                  title: 'Reports',
                  isSelected: selectedItem.contains('Report'),
                  isExpanded: isDrawerExpanded,
                  isSubmenuExpanded: isReportsExpanded,
                  fontSize: menuFontSize,
                  submenuFontSize: submenuFontSize,
                  iconWidth: iconWidth,
                  iconHeight: iconHeight,
                  isMobile: isMobile,
                  isMobileDrawer: isMobileDrawer,
                  onTap: () {
                    if (isMobileDrawer || isDrawerExpanded) {
                      onReportsToggle();
                    } else {
                      onDrawerToggle();
                    }
                  },
                  submenuItems: isDrawerExpanded
                      ? [
                          SubMenuItem(
                            title: 'Sales Report',
                            isSelected: selectedItem == 'Sales Report',
                            fontSize: submenuFontSize,
                            isMobile: isMobile,
                            onTap: () => handleItemTap('Sales Report'),
                          ),
                          SubMenuItem(
                            title: 'Inventory Report',
                            isSelected: selectedItem == 'Inventory Report',
                            fontSize: submenuFontSize,
                            isMobile: isMobile,
                            onTap: () => handleItemTap('Inventory Report'),
                          ),
                          SubMenuItem(
                            title: 'Customer Report',
                            isSelected: selectedItem == 'Customer Report',
                            fontSize: submenuFontSize,
                            isMobile: isMobile,
                            onTap: () => handleItemTap('Customer Report'),
                          ),
                        ]
                      : [],
                ),
                DrawerMenuItem(
                  iconPath: 'assets/sales_images/settings.svg',
                  title: 'Settings',
                  isSelected: selectedItem == 'Settings',
                  isExpanded: isDrawerExpanded,
                  fontSize: menuFontSize,
                  iconWidth: iconWidth,
                  iconHeight: iconHeight,
                  isMobile: isMobile,
                  isMobileDrawer: isMobileDrawer,
                  onTap: () => handleItemTap('Settings'),
                ),
                SizedBox(height: isMobile ? 8.0 : getProportionateScreenHeight(8)),
                DrawerMenuItem(
                  iconPath: 'assets/sales_images/logout.svg',
                  title: 'Logout',
                  isSelected: false,
                  isExpanded: isDrawerExpanded,
                  isLogout: true,
                  fontSize: menuFontSize,
                  iconWidth: iconWidth,
                  iconHeight: iconHeight,
                  isMobile: isMobile,
                  isMobileDrawer: isMobileDrawer,
                  onTap: () {
                    // Add logout logic here
                  },
                ),
              ],
            ),
          ),

          // Collapse/Expand button - Hide in mobile drawer
          if (!isMobileDrawer)
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[200]!)),
              ),
              child: InkWell(
                onTap: onDrawerToggle,
                child: SizedBox(
                  height: isMobile ? 40.0 : getProportionateScreenHeight(48),
                  child: Icon(
                    isDrawerExpanded ? Icons.keyboard_arrow_left : Icons.keyboard_arrow_right,
                    color: Colors.grey[600],
                    size: isMobile ? 24.0 : 20.0,
                  ),
                ),
              ),
            ),

          // Version Info
          if (isDrawerExpanded)
            Padding(
              padding: EdgeInsets.all(isMobile ? 3.0 : getProportionateScreenWidth(3)),
              child: Text(
                'Version 1.00.23.000',
                style: TextStyle(fontSize: versionFontSize, color: Colors.grey[600]),
              ),
            ),
        ],
      ),
    );
  }
}

class DrawerMenuItem extends StatefulWidget {
  final String iconPath;
  final String title;
  final bool isSelected;
  final bool isExpanded;
  final bool isLogout;
  final bool isMobileDrawer;
  final double fontSize;
  final double iconWidth;
  final double iconHeight;
  final bool isMobile;
  final VoidCallback onTap;

  const DrawerMenuItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.isSelected,
    required this.isExpanded,
    required this.onTap,
    required this.fontSize,
    required this.iconWidth,
    required this.iconHeight,
    required this.isMobile,
    this.isLogout = false,
    this.isMobileDrawer = false,
  });

  @override
  State<DrawerMenuItem> createState() => _DrawerMenuItemState();
}

class _DrawerMenuItemState extends State<DrawerMenuItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final Color baseColor = widget.isLogout
        ? Colors.red
        : widget.isSelected
        ? Colors.red
        : isHovered
        ? Colors.grey.shade800
        : Colors.grey.shade800;

    final Color bgColor = widget.isSelected
        ? Colors.pink[50]!
        : isHovered
        ? Colors.grey.shade300.withOpacity(.3)
        : Colors.grey.shade50.withOpacity(.1);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: widget.onTap,
        child: AnimatedContainer(
          // ✅ SMOOTH ANIMATION - Increased duration for smoother transition
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOutCubic, // ✅ Smoother curve
          height: widget.isMobile ? 40.0 : getProportionateScreenHeight(44),
          margin: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 2.3 : getProportionateScreenWidth(2.3),
            vertical: widget.isMobile ? 3.0 : getProportionateScreenHeight(3),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isExpanded
                ? (widget.isMobile ? 2.0 : getProportionateScreenWidth(2))
                : 0,
          ),
          decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
          child: ClipRect(
            child: widget.isExpanded
                ? Row(
                    children: [
                      SizedBox(
                        width: widget.iconWidth,
                        height: widget.iconHeight,
                        child: SvgPicture.asset(
                          widget.iconPath,
                          color: widget.isSelected ? Colors.red : baseColor,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: widget.isMobile ? 2.0 : getProportionateScreenWidth(2)),
                      Expanded(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            color: widget.isSelected ? Colors.red : baseColor,
                            fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w500,
                            fontSize: widget.fontSize,
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: SizedBox(
                      width: widget.iconWidth,
                      height: widget.iconHeight,
                      child: SvgPicture.asset(
                        widget.iconPath,
                        color: baseColor,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class DrawerMenuItemWithSubmenu extends StatefulWidget {
  final String iconPath;
  final String title;
  final bool isSelected;
  final bool isExpanded;
  final bool isSubmenuExpanded;
  final bool isMobileDrawer;
  final double fontSize;
  final double submenuFontSize;
  final double iconWidth;
  final double iconHeight;
  final bool isMobile;
  final VoidCallback onTap;
  final List<SubMenuItem> submenuItems;

  const DrawerMenuItemWithSubmenu({
    super.key,
    required this.iconPath,
    required this.title,
    required this.isSelected,
    required this.isExpanded,
    required this.isSubmenuExpanded,
    required this.onTap,
    required this.submenuItems,
    required this.fontSize,
    required this.submenuFontSize,
    required this.iconWidth,
    required this.iconHeight,
    required this.isMobile,
    this.isMobileDrawer = false,
  });

  @override
  State<DrawerMenuItemWithSubmenu> createState() => _DrawerMenuItemWithSubmenuState();
}

class _DrawerMenuItemWithSubmenuState extends State<DrawerMenuItemWithSubmenu> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final Color baseColor = widget.isSelected
        ? Colors.pink
        : isHovered
        ? Colors.grey.shade800
        : Colors.grey[800]!;

    final Color bgColor = widget.isSelected
        ? Colors.pink[50]!
        : isHovered
        ? Colors.white
        // light grey background on hover
        : Colors.grey.shade100;

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => isHovered = false),
            onExit: (_) => setState(() => isHovered = true),
            cursor: SystemMouseCursors.click,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: widget.onTap,
              child: AnimatedContainer(
                // ✅ SMOOTH ANIMATION
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOutCubic,
                height: widget.isMobile ? 30.0 : getProportionateScreenHeight(40),
                margin: EdgeInsets.symmetric(
                  horizontal: widget.isMobile ? 0.3 : getProportionateScreenWidth(0.3),
                  vertical: widget.isMobile ? 3.0 : getProportionateScreenHeight(6),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: widget.isExpanded
                      ? (widget.isMobile ? 2.0 : getProportionateScreenWidth(2))
                      : 0,
                ),
                decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
                child: ClipRect(
                  child: widget.isExpanded
                      ? Row(
                          children: [
                            SizedBox(
                              width: widget.iconWidth,
                              height: widget.iconHeight,
                              child: SvgPicture.asset(
                                widget.iconPath,
                                color: baseColor,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(width: widget.isMobile ? 2.0 : getProportionateScreenWidth(2)),
                            Expanded(
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  color: baseColor,
                                  fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w500,
                                  fontSize: widget.fontSize,
                                ),
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                            Icon(
                              widget.isSubmenuExpanded
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              color: baseColor,
                              size: widget.isMobile ? 18.0 : 20.0,
                            ),
                          ],
                        )
                      : Center(
                          child: SizedBox(
                            width: widget.iconWidth,
                            height: widget.iconHeight,
                            child: SvgPicture.asset(
                              widget.iconPath,
                              color: baseColor,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
          // ✅ SMOOTH SUBMENU ANIMATION WITH SLIDE
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            firstCurve: Curves.easeInOutCubic,
            secondCurve: Curves.easeInOutCubic,
            sizeCurve: Curves.easeInOutCubic,
            crossFadeState: widget.isSubmenuExpanded && widget.isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: Column(children: widget.submenuItems),
          ),
        ],
      ),
    );
  }
}

class SubMenuItem extends StatefulWidget {
  final String title;
  final bool isSelected;
  final double fontSize;
  final bool isMobile;
  final VoidCallback onTap;

  const SubMenuItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.fontSize,
    required this.isMobile,
  });

  @override
  State<SubMenuItem> createState() => _SubMenuItemState();
}

class _SubMenuItemState extends State<SubMenuItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Color bgColor;
    Color textColor;

    if (widget.isSelected) {
      bgColor = Colors.pink[50]!;
      textColor = Colors.pink;
    } else if (isHovered) {
      bgColor = Colors.grey.shade100; // Light grey hover background
      textColor = Colors.black; // Black text on hover
    } else {
      bgColor = Colors.transparent;
      textColor = Colors.grey[800]!; // Default text color
    }

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          height: widget.isMobile ? 30.0 : getProportionateScreenHeight(38),
          margin: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 0.5 : getProportionateScreenWidth(2),
            vertical: widget.isMobile ? 2.0 : getProportionateScreenHeight(2),
          ),
          padding: EdgeInsets.only(
            left: widget.isMobile ? 11.0 : getProportionateScreenWidth(11),
            right: widget.isMobile ? 2.0 : getProportionateScreenWidth(1),
          ),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(6)),
          child: ClipRect(
            child: Text(
              widget.title,
              style: TextStyle(
                color: textColor,
                fontSize: widget.fontSize,
                fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              overflow: TextOverflow.clip,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ),
      ),
    );
  }
}
