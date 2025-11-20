// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/controller/dashboard/dashboard_controller.dart';
import 'package:soft_sales/screens/dashboard/desktop_sales_dashboard_content.dart';
import 'package:soft_sales/screens/dashboard/sales_widgets/customdrawer.dart';
import 'package:soft_sales/screens/dashboard/sales_widgets/sales_header.dart';
import 'package:soft_sales/screens/sales/sales_screen.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class DashboardScreenSalesUiHandler extends StatefulWidget {
  const DashboardScreenSalesUiHandler({super.key});

  @override
  _DashboardScreenSalesUiHandlerState createState() => _DashboardScreenSalesUiHandlerState();
}

class _DashboardScreenSalesUiHandlerState extends State<DashboardScreenSalesUiHandler> {
  final StatsController controller = Get.put(StatsController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // ✅ Add this

  String selectedItem = 'Dashboard';
  bool isReportsExpanded = false;
  bool isDrawerExpanded = false;
  int selectedIndex = 0;

  // ✅ Add method to open drawer
  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final isMobile = mediaQuery.width < 600;
    final isTablet = mediaQuery.width >= 600 && mediaQuery.width <= 1000;
    final isDesktop = mediaQuery.width > 1000;
    SizeConfig().init(context);

    // Drawer widths
    final collapsedDrawerWidth = isMobile
        ? getProportionateScreenWidth(10)
        : getProportionateScreenWidth(18);
    final expandedDrawerWidth = isMobile
        ? getProportionateScreenWidth(20)
        : isTablet
        ? getProportionateScreenWidth(30)
        : getProportionateScreenWidth(55);

    return Scaffold(
      key: _scaffoldKey, // ✅ Add scaffold key
      backgroundColor: Colors.white,

      // ✅ Add drawer for mobile/tablet
      drawer: (isMobile || isTablet)
          ? Drawer(
              width: isMobile
                  ? mediaQuery.width * 0.40
                  : mediaQuery.width * 0.25, // Set drawer width

              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // 👈 removes all rounding
              ),
              child: CustomDrawer(
                selectedItem: selectedItem,
                isReportsExpanded: isReportsExpanded,
                isDrawerExpanded: true, // Always expanded in drawer
                isMobileDrawer: true, // ✅ Add flag to identify mobile drawer
                onItemSelected: (item) {
                  debugPrint('Selected item: $item'); // ✅ Debug print
                  setState(() {
                    selectedItem = item;
                    isReportsExpanded = false;
                    Navigator.pop(context); // Close drawer after selection

                    // ✅ Update bottom nav bar index based on item
                    if (item == 'Dashboard') {
                      selectedIndex = 0;
                    } else if (item == 'Sales') {
                      selectedIndex = 1;
                    } else if (item == 'Order List') {
                      selectedIndex = 2;
                    } else {
                      // For items not in bottom nav (Settings, Reports), keep current selection
                      // This prevents the bottom nav from deselecting all items
                      // selectedIndex stays as is
                    }
                  });
                  debugPrint(
                    'Drawer closed, showing: $item, bottomNav index: $selectedIndex',
                  ); // ✅ Debug print
                },
                onReportsToggle: () {
                  setState(() {
                    isReportsExpanded = !isReportsExpanded;
                  });
                },
                onDrawerToggle: () {
                  Navigator.pop(context); // Close drawer
                },
              ),
            )
          : null,

      body: Stack(
        children: [
          // Main Content
          AnimatedPadding(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOutCubic,
            padding: EdgeInsets.only(left: (isDesktop ? collapsedDrawerWidth : 0)),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                              minWidth: constraints.maxWidth,
                            ),
                            child: _buildContents(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (isDesktop)
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
              width: isDrawerExpanded ? expandedDrawerWidth : collapsedDrawerWidth,
              child: CustomDrawer(
                selectedItem: selectedItem,
                isReportsExpanded: isReportsExpanded,
                isDrawerExpanded: isDrawerExpanded,
                isMobileDrawer: false,
                onItemSelected: (item) {
                  setState(() {
                    selectedItem = item;
                    isReportsExpanded = false;
                  });
                },
                onReportsToggle: () {
                  setState(() => isReportsExpanded = !isReportsExpanded);
                },
                onDrawerToggle: () {
                  setState(() {
                    isDrawerExpanded = !isDrawerExpanded;
                    if (!isDrawerExpanded) isReportsExpanded = false;
                  });
                },
              ),
            ),
        ],
      ),

      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
              backgroundColor: const Color(0xffFFFFFF),
              selectedItemColor: const Color(0xffD2303F),
              unselectedItemColor: Colors.grey,
              currentIndex: selectedIndex.clamp(0, 2), // ✅ Ensure index is always valid (0-2)
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;

                  if (index == 0) {
                    selectedItem = 'Dashboard';
                  } else if (index == 1) {
                    selectedItem = 'Sales';
                  } else if (index == 2) {
                    selectedItem = 'Order List';
                  }
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/sales_images/dashboard.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      selectedIndex == 0 ? const Color(0xffD2303F) : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/sales_images/sales.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      selectedIndex == 1 ? const Color(0xffD2303F) : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Sales',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/sales_images/orderlist.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      selectedIndex == 2 ? const Color(0xffD2303F) : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Order List',
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildContents() {
    SizeConfig().init(context);
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet =
        MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width <= 1000;

    switch (selectedItem) {
      case 'Dashboard':
        return DashboardContent(onMenuPressed: _openDrawer);

      case 'Sales':
        return SizedBox(height: 600, child: SalesScreen());

      case 'Order List':
        return _buildScreenWithHeader(
          'Order List Screen',
          'assets/sales_images/orderlist.svg',
          isMobile,
          isTablet,
        );
      case 'Sales Report':
        return _buildScreenWithHeader(
          'Sales Report Screen',
          'assets/sales_images/reports.svg',
          isMobile,
          isTablet,
        );
      case 'Inventory Report':
        return _buildScreenWithHeader(
          'Inventory Report Screen',
          'assets/sales_images/reports.svg',
          isMobile,
          isTablet,
        );
      case 'Customer Report':
        return _buildScreenWithHeader(
          'Customer Report Screen',
          'assets/sales_images/reports.svg',
          isMobile,
          isTablet,
        );
      case 'Settings':
        return _buildScreenWithHeader(
          'Settings Screen',
          'assets/sales_images/settings.svg',
          isMobile,
          isTablet,
        );
      default:
        return _buildCenterText('Select a menu item', isMobile);
    }
  }

  Widget _buildScreenWithHeader(String screenName, String iconPath, bool isMobile, bool isTablet) {
    return Column(
      children: [
        // Header with menu button afor mobile/tablet
        SalesHeader(
          selectedItem: selectedItem,
          imageMap: {selectedItem: iconPath},
          onMenuPressed: _openDrawer,
        ),
      ],
    );
  }

  Widget _buildCenterText(String text, bool isMobile) {
    return Center(
      child: Text(
        text,
        style: GoogleFonts.openSans(fontSize: isMobile ? 20 : 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
