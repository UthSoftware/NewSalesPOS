import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:soft_sales/controller/dashboard/dashboard_controller.dart';
import 'package:soft_sales/screens/dashboard/customer_report.dart';
import 'package:soft_sales/screens/dashboard/desktop_sales_dashboard_content.dart';
import 'package:soft_sales/screens/dashboard/inventory_report.dart';
import 'package:soft_sales/screens/dashboard/order_list.dart';
import 'package:soft_sales/screens/dashboard/sales_report.dart';
import 'package:soft_sales/screens/dashboard/sales_widgets/customdrawer.dart';
import 'package:soft_sales/screens/dashboard/setting.dart';
import 'package:soft_sales/screens/sales/sales_screen.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class DashboardScreenSalesUiHandler extends StatefulWidget {
  const DashboardScreenSalesUiHandler({super.key});

  @override
  _DashboardScreenSalesUiHandlerState createState() => _DashboardScreenSalesUiHandlerState();
}

class _DashboardScreenSalesUiHandlerState extends State<DashboardScreenSalesUiHandler> {
  final StatsController controller = Get.put(StatsController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String selectedItem = 'Dashboard';
  bool isReportsExpanded = false;
  bool isDrawerExpanded = false;
  int selectedIndex = 0;

  void setScreen(String item) {
    setState(() {
      selectedItem = item;

      // Update selectedIndex based on item
      if (item == 'Dashboard') {
        selectedIndex = 0;
      } else if (item == 'Sales') {
        selectedIndex = 1;
      } else if (item == 'Order List') {
        selectedIndex = 2;
      } else if (item == 'Reports' ||
          item == 'Sales Report' ||
          item == 'Customer Report' ||
          item == 'Inventory Report') {
        // All report-related items should highlight the Reports tab
        selectedIndex = 3;
      } else if (item == 'Settings') {
        selectedIndex = 4;
      }
    });
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

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,

      drawer: (isMobile || isTablet)
          ? Drawer(
              width: isMobile ? mediaQuery.width * 0.40 : mediaQuery.width * 0.25,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: CustomDrawer(
                selectedItem: selectedItem,
                isReportsExpanded: isReportsExpanded,
                isDrawerExpanded: true,
                isMobileDrawer: true,
                onItemSelected: (item) {
                  print('🎯 Drawer item selected: "$item"');
                  // ✅ Close drawer first, then update state
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                  // ✅ Update state after a small delay
                  Future.delayed(Duration(milliseconds: 100), () {
                    setScreen(item);
                    setState(() {
                      isReportsExpanded = false;
                    });
                  });
                },
                onReportsToggle: () {
                  setState(() {
                    isReportsExpanded = !isReportsExpanded;
                  });
                },
                onDrawerToggle: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.pop(context);
                  }
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
                        return _buildContents();
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
              width: isDrawerExpanded ? 200 : 70,
              child: CustomDrawer(
                selectedItem: selectedItem,
                isReportsExpanded: isReportsExpanded,
                isDrawerExpanded: isDrawerExpanded,
                isMobileDrawer: false,
                onItemSelected: (item) {
                  // ✅ REMOVED Navigator.pop for desktop - it's not a drawer that needs closing
                  setScreen(item);
                  setState(() {
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
              currentIndex: selectedIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;

                  if (index == 0) selectedItem = 'Dashboard';
                  if (index == 1) selectedItem = 'Sales';
                  if (index == 2) selectedItem = 'Order List';
                  if (index == 3) selectedItem = 'Reports';
                  if (index == 4) selectedItem = 'Settings';
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
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/sales_images/reports.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      selectedIndex == 3 ? const Color(0xffD2303F) : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Reports',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/sales_images/settings.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      selectedIndex == 4 ? const Color(0xffD2303F) : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Settings',
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildContents() {
    print('🔍 DEBUG: Building content for: "$selectedItem"');
    print('🔍 DEBUG: selectedIndex = $selectedIndex');

    // void openDrawer() {
    //   if (_scaffoldKey.currentState != null && !_scaffoldKey.currentState!.isDrawerOpen) {
    //     _scaffoldKey.currentState!.openDrawer();
    //   }
    // }
    void openDrawer() {
      // ✅ Add safety checks
      if (_scaffoldKey.currentState != null) {
        if (_scaffoldKey.currentState!.hasDrawer) {
          if (!_scaffoldKey.currentState!.isDrawerOpen) {
            _scaffoldKey.currentState!.openDrawer();
          }
        }
      }
    }

    // ✅ Safe wrapper to catch widget errors
    Widget buildSafeScreen(String screenName, Widget Function() builder) {
      try {
        return builder();
      } catch (e, stackTrace) {
        print('❌ ERROR loading $screenName: $e');
        print('Stack: $stackTrace');
        return _buildErrorScreen(screenName, e.toString());
      }
    }

    switch (selectedItem) {
      case 'Dashboard':
        print('✅ Loading Dashboard');
        return buildSafeScreen('Dashboard', () => DashboardContent(onMenuPressed: openDrawer));

      case 'Sales':
        print('✅ Loading Sales');
        return buildSafeScreen('Sales', () => SalesScreen(onMenuPressed: openDrawer));

      case 'Order List':
        print('✅ Loading Order List');
        return buildSafeScreen('Order List', () => OrderList(onMenuPressed: openDrawer));

      case 'Reports':
        print('✅ Loading Reports');
        return buildSafeScreen('Reports', () => SalesReport(onMenuPressed: openDrawer));

      case 'Settings':
        print('✅ Loading Settings');
        return buildSafeScreen('Settings', () => SettingReort(onMenuPressed: openDrawer));

      case 'Inventory Report':
        print('✅ Loading Inventory Report');
        // Try without onMenuPressed first
        return buildSafeScreen('Inventory Report', () {
          return InventoryReport(onMenuPressed: openDrawer);
        });
      case 'Sales Report':
        print('✅ Loading Sales Report');
        // Try without onMenuPressed first
        return buildSafeScreen('Sales Report', () {
          return SalesReport(onMenuPressed: openDrawer);
        });

      case 'Customer Report':
        print('✅ Loading Customer Report');
        return buildSafeScreen('Customer Report', () => CustomerReport(onMenuPressed: openDrawer));

      default:
        print('❌ ERROR: Unknown screen: "$selectedItem"');
        return _buildErrorScreen('Unknown', 'Screen "$selectedItem" not found');
    }
  }

  // ✅ Helper method to build error screen
  Widget _buildErrorScreen(String screenName, String error) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 80, color: Colors.red.shade300),
              SizedBox(height: 24),
              Text(
                'Error Loading $screenName',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Text(
                  error,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red.shade900,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    selectedItem = 'Dashboard';
                    selectedIndex = 0;
                  });
                },
                icon: Icon(Icons.home),
                label: Text('Go to Dashboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffD2303F),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
