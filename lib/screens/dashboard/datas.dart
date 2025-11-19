// ==================== STATIC DATA SERVICE ====================

class StaticDataService {
  // Simulate API delay
  Future<void> _delay() async {
    await Future.delayed(Duration(milliseconds: 500));
  }

  // ==================== API 1: Overall Statistics ====================
  // GET /api/dashboard/statistics?start_date=xxx&end_date=xxx
  Future<Map<String, dynamic>> getOverallStatistics({
    required String startDate,
    required String endDate,
  }) async {
    await _delay();

    return {
      'total_number_of_orders': {
        'value': 10056,
        'percentage': 2.0,
        'percentage_value': '2%', // or '2% than Previous Month'
        'percentage_label': 'Yesterday',
        'percentage_status': 'POSITIVE', // or 'NEGATIVE'
      },
      'total_sales': {
        'value': 10525025.00,
        'percentage': 2.0,
        'percentage_value': '2%', // or '2% than Previous Month'

        'percentage_label': 'Yesterday',
        'percentage_status': 'POSITIVE',
      },
      'average_order_value': {
        'value': 5500.00,
        'percentage': 2.0,
        'percentage_value': '3%', // or '2% than Previous Month'

        'percentage_label': 'Yesterday',
        'percentage_status': 'POSITIVE',
      },
      'net_revenue': {
        'value': 11025658.00,
        'percentage': 2.0,
        'percentage_value': '2%', // or '2% than Previous Month'

        'percentage_label': 'Yesterday',
        'percentage_status': 'POSITIVE',
      },
    };
  }

  // ==================== API 2: Sales Chart Data ====================
  // GET /api/dashboard/sales-chart?start_date=xxx&end_date=xxx&sales_type=xxx
  Future<Map<String, dynamic>> getSalesChartData({
    required String startDate,
    required String endDate,
    String? salesType, // 'dine-in', 'counter-sales', 'delivery', 'takeaway'
  }) async {
    await _delay();

    return {
      'revenue': [
        {'date': '2024-01-01', 'value': 45000.0},
        {'date': '2024-01-02', 'value': 48000.0},
        {'date': '2024-01-03', 'value': 52000.0},
        {'date': '2024-01-04', 'value': 49000.0},
        {'date': '2024-01-05', 'value': 55000.0},
        {'date': '2024-01-06', 'value': 58000.0},
        {'date': '2024-01-07', 'value': 62000.0},
        {'date': '2024-01-08', 'value': 59000.0},
        {'date': '2024-01-09', 'value': 64000.0},
        {'date': '2024-01-10', 'value': 67000.0},
        {'date': '2024-01-11', 'value': 71000.0},
        {'date': '2024-01-12', 'value': 69000.0},
        {'date': '2024-01-13', 'value': 73000.0},
        {'date': '2024-01-14', 'value': 76000.0},
        {'date': '2024-01-15', 'value': 80000.0},
        {'date': '2024-01-16', 'value': 78000.0},
        {'date': '2024-01-17', 'value': 82000.0},
        {'date': '2024-01-18', 'value': 85000.0},
        {'date': '2024-01-19', 'value': 88000.0},
        {'date': '2024-01-20', 'value': 92000.0},
      ],
      'orders': [
        {'date': '2024-01-01', 'value': 25.0},
        {'date': '2024-01-02', 'value': 28.0},
        {'date': '2024-01-03', 'value': 30.0},
        {'date': '2024-01-04', 'value': 27.0},
        {'date': '2024-01-05', 'value': 32.0},
        {'date': '2024-01-06', 'value': 35.0},
        {'date': '2024-01-07', 'value': 38.0},
        {'date': '2024-01-08', 'value': 34.0},
        {'date': '2024-01-09', 'value': 40.0},
        {'date': '2024-01-10', 'value': 42.0},
        {'date': '2024-01-11', 'value': 45.0},
        {'date': '2024-01-12', 'value': 43.0},
        {'date': '2024-01-13', 'value': 47.0},
        {'date': '2024-01-14', 'value': 50.0},
        {'date': '2024-01-15', 'value': 52.0},
        {'date': '2024-01-16', 'value': 48.0},
        {'date': '2024-01-17', 'value': 54.0},
        {'date': '2024-01-18', 'value': 56.0},
        {'date': '2024-01-19', 'value': 58.0},
        {'date': '2024-01-20', 'value': 60.0},
      ],
    };
  }

  // ==================== API 3: Inventory Alerts Summary ====================
  // GET /api/dashboard/inventory-alerts
  Future<List<Map<String, dynamic>>> getInventoryAlerts() async {
    await _delay();

    return [
      {'alert_type': '0 Items Out of Stock', 'count': 0},
      {'alert_type': 'Low Stock Ingredients', 'count': 3},
      {'alert_type': 'Stockist / Vendor Stock', 'count': 5},
      {'alert_type': 'Expiring Soon', 'count': 2},
      {'alert_type': 'Frozen Stock Alert', 'count': 1},
      {'alert_type': 'Current Inventory Value', 'count': 232025},
    ];
  }

  // ==================== API 4: Inventory Alert Details ====================
  // GET /api/dashboard/inventory-alerts/{alert_type}
  Future<List<Map<String, dynamic>>> getInventoryAlertDetails({required String alertType}) async {
    await _delay();

    // Different data based on alert type
    if (alertType.contains('Out of Stock') || alertType.contains('0 Items')) {
      return [
        {
          'product_name': 'No items currently out of stock',
          'current_stock': 0,
          'reorder_level': 0,
          'status': 'Good',
        },
      ];
    } else if (alertType.contains('Low Stock')) {
      return [
        {'product_name': 'Tomatoes', 'current_stock': 5, 'reorder_level': 20, 'status': 'Critical'},
        {'product_name': 'Onions', 'current_stock': 8, 'reorder_level': 25, 'status': 'Low'},
        {
          'product_name': 'Chicken Breast',
          'current_stock': 3,
          'reorder_level': 15,
          'status': 'Critical',
        },
      ];
    } else if (alertType.contains('Expiring')) {
      return [
        {
          'product_name': 'Fresh Milk',
          'current_stock': 10,
          'reorder_level': 20,
          'status': 'Expires in 2 days',
        },
        {
          'product_name': 'Mozzarella Cheese',
          'current_stock': 5,
          'reorder_level': 10,
          'status': 'Expires in 3 days',
        },
      ];
    } else if (alertType.contains('Vendor') || alertType.contains('Stockist')) {
      return [
        {
          'product_name': 'Basmati Rice - Vendor A',
          'current_stock': 100,
          'reorder_level': 50,
          'status': 'In Stock',
        },
        {
          'product_name': 'Wheat Flour - Vendor B',
          'current_stock': 75,
          'reorder_level': 40,
          'status': 'In Stock',
        },
        {
          'product_name': 'Cooking Oil - Vendor C',
          'current_stock': 50,
          'reorder_level': 30,
          'status': 'In Stock',
        },
        {
          'product_name': 'Sugar - Vendor A',
          'current_stock': 80,
          'reorder_level': 45,
          'status': 'In Stock',
        },
        {
          'product_name': 'Salt - Vendor D',
          'current_stock': 60,
          'reorder_level': 35,
          'status': 'In Stock',
        },
      ];
    } else if (alertType.contains('Frozen')) {
      return [
        {'product_name': 'Frozen Prawns', 'current_stock': 2, 'reorder_level': 10, 'status': 'Low'},
      ];
    } else if (alertType.contains('Value') || alertType.contains('Inventory')) {
      return [
        {
          'product_name': 'Total Inventory Items',
          'current_stock': 150,
          'reorder_level': 0,
          'status': 'Value: ₹2,32,025',
        },
      ];
    }

    return [];
  }

  // ==================== API 5: Top 10 Selling Products ====================
  // GET /api/dashboard/top-selling-products?start_date=xxx&end_date=xxx
  Future<List<Map<String, dynamic>>> getTopSellingProducts({
    required String startDate,
    required String endDate,
  }) async {
    await _delay();

    return [
      {
        'rank': 1,
        'product_name': 'Chicken Biryani',
        'units_sold': 2550,
        'price': 250.0,
        'revenue': 637500.0,
      },
      {
        'rank': 2,
        'product_name': 'Paneer Tikka',
        'units_sold': 2000,
        'price': 180.0,
        'revenue': 360000.0,
      },
      {
        'rank': 3,
        'product_name': 'Cold Coffee',
        'units_sold': 1900,
        'price': 110.0,
        'revenue': 209000.0,
      },
      {
        'rank': 4,
        'product_name': 'Paneer Tikka',
        'units_sold': 1850,
        'price': 160.0,
        'revenue': 296000.0,
      },
      {
        'rank': 5,
        'product_name': 'Veg Fried Rice',
        'units_sold': 1600,
        'price': 120.0,
        'revenue': 192000.0,
      },
      {
        'rank': 6,
        'product_name': 'Masala Dosa',
        'units_sold': 1750,
        'price': 70.0,
        'revenue': 122500.0,
      },
      {
        'rank': 7,
        'product_name': 'Chocolate Milkshake',
        'units_sold': 1770,
        'price': 80.0,
        'revenue': 141600.0,
      },
      {
        'rank': 8,
        'product_name': 'French Fries',
        'units_sold': 1600,
        'price': 60.0,
        'revenue': 96000.0,
      },
      {
        'rank': 9,
        'product_name': 'Egg Sandwich',
        'units_sold': 1470,
        'price': 100.0,
        'revenue': 147000.0,
      },
      {
        'rank': 10,
        'product_name': 'Lemon Iced Tea',
        'units_sold': 1600,
        'price': 40.0,
        'revenue': 64000.0,
      },
    ];
  }

  // ==================== API 6: Top 10 Non-Moving Products ====================
  // GET /api/dashboard/non-moving-products?start_date=xxx&end_date=xxx
  Future<List<Map<String, dynamic>>> getTopNonMovingProducts({
    required String startDate,
    required String endDate,
  }) async {
    await _delay();

    return [
      {
        'rank': 1,
        'product_name': 'Truffle Oil Pasta',
        'units_sold': 25,
        'price': 450.0,
        'revenue': 11250.0,
        'age': 45,
        'unsold_stock': 150,
      },
      {
        'rank': 2,
        'product_name': 'Caviar Blinis',
        'units_sold': 25,
        'price': 850.0,
        'revenue': 21250.0,
        'age': 15,
        'unsold_stock': 200,
      },
      {
        'rank': 3,
        'product_name': 'Quinoa Salad',
        'units_sold': 10,
        'price': 280.0,
        'revenue': 2800.0,
        'age': 14,
        'unsold_stock': 150,
      },
      {
        'rank': 4,
        'product_name': 'Foie Gras Appetizer',
        'units_sold': 10,
        'price': 950.0,
        'revenue': 9500.0,
        'age': 13,
        'unsold_stock': 120,
      },
      {
        'rank': 5,
        'product_name': 'Saffron Risotto',
        'units_sold': 15,
        'price': 420.0,
        'revenue': 6300.0,
        'age': 11,
        'unsold_stock': 130,
      },
      {
        'rank': 6,
        'product_name': 'Kombucha Tea on Tap',
        'units_sold': 12,
        'price': 180.0,
        'revenue': 2160.0,
        'age': 12,
        'unsold_stock': 150,
      },
      {
        'rank': 7,
        'product_name': 'Venison Steak',
        'units_sold': 12,
        'price': 1200.0,
        'revenue': 14400.0,
        'age': 12,
        'unsold_stock': 180,
      },
      {
        'rank': 8,
        'product_name': 'Oysters Rockefeller',
        'units_sold': 12,
        'price': 650.0,
        'revenue': 7800.0,
        'age': 12,
        'unsold_stock': 200,
      },
      {
        'rank': 9,
        'product_name': 'Artisanal Cheese Plate',
        'units_sold': 11,
        'price': 380.0,
        'revenue': 4180.0,
        'age': 11,
        'unsold_stock': 120,
      },
      {
        'rank': 10,
        'product_name': 'Avocado Toast',
        'units_sold': 11,
        'price': 220.0,
        'revenue': 2420.0,
        'age': 11,
        'unsold_stock': 100,
      },
    ];
  }
}

// ==================== USAGE EXAMPLE ====================

/*
// How to use this service in your existing UI:

class YourDashboardScreen extends StatefulWidget {
  @override
  _YourDashboardScreenState createState() => _YourDashboardScreenState();
}

class _YourDashboardScreenState extends State<YourDashboardScreen> {
  final StaticDataService _dataService = StaticDataService();
  
  // Load data example
  Future<void> loadData() async {
    // 1. Get Overall Statistics
    final stats = await _dataService.getOverallStatistics(
      startDate: '2024-01-01',
      endDate: '2024-01-31',
    );
    
    // Access data like this:
    print('Total Orders: ${stats['total_number_of_orders']['value']}');
    print('Percentage: ${stats['total_number_of_orders']['percentage']}%');
    print('Label: ${stats['total_number_of_orders']['percentage_label']}');
    print('Status: ${stats['total_number_of_orders']['percentage_status']}');
    
    // For Total Sales
    print('Total Sales: ₹${stats['total_sales']['value']}');
    print('Sales Change: ${stats['total_sales']['percentage_label']}');
    
    // 2. Get Sales Chart Data
    final chartData = await _dataService.getSalesChartData(
      startDate: '2024-01-01',
      endDate: '2024-01-31',
      salesType: 'dine-in', // optional: null, 'dine-in', 'counter-sales', 'delivery', 'takeaway'
    );
    print('Revenue data: ${chartData['revenue']}');
    
    // 3. Get Inventory Alerts
    final alerts = await _dataService.getInventoryAlerts();
    print('Alerts: $alerts');
    
    // 4. Get Inventory Alert Details
    final alertDetails = await _dataService.getInventoryAlertDetails(
      alertType: 'Low Stock Ingredients',
    );
    print('Alert Details: $alertDetails');
    
    // 5. Get Top Selling Products
    final topProducts = await _dataService.getTopSellingProducts(
      startDate: '2024-01-01',
      endDate: '2024-01-31',
    );
    print('Top Products: $topProducts');
    
    // 6. Get Non-Moving Products
    final nonMoving = await _dataService.getTopNonMovingProducts(
      startDate: '2024-01-01',
      endDate: '2024-01-31',
    );
    print('Non-Moving Products: $nonMoving');
  }
  
  // Example: Build UI Card for Total Orders
  Widget buildStatCard() {
    return FutureBuilder<Map<String, dynamic>>(
      future: _dataService.getOverallStatistics(
        startDate: '2024-01-01',
        endDate: '2024-01-31',
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final ordersData = snapshot.data!['total_number_of_orders'];
          return Card(
            child: Column(
              children: [
                Text('Total Number of Orders'),
                Text('${ordersData['value']}'),
                Row(
                  children: [
                    Icon(
                      ordersData['percentage_status'] == 'POSITIVE'
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: ordersData['percentage_status'] == 'POSITIVE'
                          ? Colors.green
                          : Colors.red,
                    ),
                    Text(ordersData['percentage_label']),
                  ],
                ),
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
*/
