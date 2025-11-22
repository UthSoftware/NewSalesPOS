// Controller
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StatsController extends GetxController {
  var stats = <StatModel>[].obs;
  var isLoading = false.obs;

  var salesList = <SalesData>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadStats();
    fetchSalesData();
  }

  var salesTypes = ["Counter Sales", "Dine-In", "Online Orders"].obs;
  var selectedSales = "Counter Sales".obs;
  var salesDate = ["2/01/2025-11/01/2025", "2/02/2025-11/02/2025", "2/03/2025-11/03/2025"].obs;
  var selectedDate = "2/01/2025-11/01/2025".obs;
  void updateSelectedDate(String newDate) {
    selectedDate.value = newDate;
    debugPrint("Selected date changed → $newDate");
  }

  // TOP SELLING PRODUCTS DATA
  final topSelling = <TopSellingProduct>[
    TopSellingProduct(
      rank: '01',
      name: 'Chicken Biryani',
      unitsSold: 22500,
      price: 250.00,
      revenue: 56250000.00,
    ),
    TopSellingProduct(
      rank: '02',
      name: 'Cheese Pizza',
      unitsSold: 2000,
      price: 180.00,
      revenue: 360000.00,
    ),
    TopSellingProduct(
      rank: '03',
      name: 'Cold Coffee',
      unitsSold: 1950,
      price: 110.00,
      revenue: 214500.00,
    ),
    TopSellingProduct(
      rank: '04',
      name: 'Paneer Tikka',
      unitsSold: 1850,
      price: 160.00,
      revenue: 296000.00,
    ),
    TopSellingProduct(
      rank: '05',
      name: 'Veg Fried Rice',
      unitsSold: 1800,
      price: 120.00,
      revenue: 216000.00,
    ),
    TopSellingProduct(
      rank: '06',
      name: 'Masala Dosa',
      unitsSold: 1750,
      price: 70.00,
      revenue: 122500.00,
    ),
    TopSellingProduct(
      rank: '07',
      name: 'Chocolate Milkshake',
      unitsSold: 1710,
      price: 80.00,
      revenue: 136800.00,
    ),
    TopSellingProduct(
      rank: '08',
      name: 'French Fries',
      unitsSold: 1650,
      price: 60.00,
      revenue: 99000.00,
    ),
    TopSellingProduct(
      rank: '09',
      name: 'Egg Sandwich',
      unitsSold: 1620,
      price: 100.00,
      revenue: 162000.00,
    ),
    TopSellingProduct(
      rank: '10',
      name: 'Lemon Iced Tea',
      unitsSold: 1600,
      price: 40.00,
      revenue: 64000.00,
    ),
  ].obs;

  RxList<List<String>> topSellingList = <List<String>>[].obs;

  List<List<String>> buildTopSellingRows() {
    final currencyFormatter = NumberFormat('#,##,##0.00'); // Indian format
    // OR use: NumberFormat('#,###.00') for international format (12,000.00)

    return topSelling.map((product) {
      return [
        product.rank,
        product.name,
        product.unitsSold.toString(),
        currencyFormatter.format(product.price),
        currencyFormatter.format(product.revenue),
      ];
    }).toList();
  }

  RxList<List<String>> nonMovingList = <List<String>>[].obs;

  List<List<String>> buildNonMovingRows() {
    return nonMoving.map((product) {
      return [
        product.rank,
        product.name,
        product.soldQty.toString(),
        product.age.toString(),
        product.unsoldStock.toString(),
      ];
    }).toList();
  }

  final nonMoving = <NonMovingProduct>[
    NonMovingProduct(rank: '01', name: 'Truffle Oil Fries', soldQty: 25, age: 15, unsoldStock: 0),
    NonMovingProduct(rank: '02', name: 'Lobster Bisque', soldQty: 23, age: 15, unsoldStock: 0),
    NonMovingProduct(rank: '03', name: 'Quinoa Salad', soldQty: 10, age: 14, unsoldStock: 0),
    NonMovingProduct(rank: '04', name: 'Foie Gras Appetizer', soldQty: 10, age: 13, unsoldStock: 0),
    NonMovingProduct(rank: '05', name: 'Gluten-Free Brownie', soldQty: 10, age: 13, unsoldStock: 0),
    NonMovingProduct(rank: '06', name: 'Kombucha on Tap', soldQty: 12, age: 12, unsoldStock: 0),
    NonMovingProduct(rank: '07', name: 'Venison Steak', soldQty: 12, age: 12, unsoldStock: 0),
    NonMovingProduct(rank: '08', name: 'Oysters Rockefeller', soldQty: 12, age: 12, unsoldStock: 0),
    NonMovingProduct(
      rank: '09',
      name: 'Artisanal Cheese Plate',
      soldQty: 11,
      age: 11,
      unsoldStock: 0,
    ),
    NonMovingProduct(rank: '10', name: 'Avocado Toast', soldQty: 11, age: 11, unsoldStock: 0),
  ].obs;
  void fetchSalesData() {
    salesList.value = [
      // Days 1-5: Starting low, gradual increase
      SalesData(day: 1, revenue: 250000, sales: 150000, orders: 50),
      SalesData(day: 2, revenue: 280000, sales: 155000, orders: 52),
      SalesData(day: 3, revenue: 260000, sales: 158000, orders: 51),
      SalesData(day: 4, revenue: 320000, sales: 162000, orders: 53),
      SalesData(day: 5, revenue: 300000, sales: 165000, orders: 52),

      // Days 6-10: Dip and recovery
      SalesData(day: 6, revenue: 280000, sales: 168000, orders: 54),
      SalesData(day: 7, revenue: 290000, sales: 170000, orders: 53),
      SalesData(day: 8, revenue: 310000, sales: 173000, orders: 55),
      SalesData(day: 9, revenue: 330000, sales: 175000, orders: 54),
      SalesData(day: 10, revenue: 350000, sales: 178000, orders: 56),

      // Days 11-15: Steady middle growth
      SalesData(day: 11, revenue: 370000, sales: 180000, orders: 55),
      SalesData(day: 12, revenue: 380000, sales: 183000, orders: 57),
      SalesData(day: 13, revenue: 390000, sales: 185000, orders: 56),
      SalesData(day: 14, revenue: 400000, sales: 188000, orders: 58),
      SalesData(day: 15, revenue: 420000, sales: 190000, orders: 57),

      // Days 16-20: Plateau with slight variations
      SalesData(day: 16, revenue: 430000, sales: 193000, orders: 59),
      SalesData(day: 17, revenue: 435000, sales: 195000, orders: 58),
      SalesData(day: 18, revenue: 440000, sales: 198000, orders: 60),
      SalesData(day: 19, revenue: 430000, sales: 200000, orders: 59),
      SalesData(day: 20, revenue: 450000, sales: 203000, orders: 61),

      // Days 21-25: Small dip then sharp rise
      SalesData(day: 21, revenue: 420000, sales: 205000, orders: 60),
      SalesData(day: 22, revenue: 480000, sales: 208000, orders: 62),
      SalesData(day: 23, revenue: 500000, sales: 210000, orders: 61),
      SalesData(day: 24, revenue: 520000, sales: 213000, orders: 63),
      SalesData(day: 25, revenue: 550000, sales: 215000, orders: 62),

      // Days 26-30: Strong upward trend to end
      SalesData(day: 26, revenue: 580000, sales: 218000, orders: 64),
      SalesData(day: 27, revenue: 620000, sales: 220000, orders: 63),
      SalesData(day: 28, revenue: 650000, sales: 223000, orders: 65),
      SalesData(day: 29, revenue: 700000, sales: 225000, orders: 64),
      SalesData(day: 30, revenue: 750000, sales: 228000, orders: 66),
    ];
  }

  void loadStats() {
    stats.value = [
      StatModel(
        label: 'Total Number of Orders',
        value: '10,056',
        trend: 'Yesterday',
        isTrendUp: true,
        num: 2,
        percent: '%',
        color: 0xFF2B76F1,
      ),
      StatModel(
        label: 'Total Sales (₹)',
        value: '₹1,05,25,025.00',
        trend: 'Yesterday',
        isTrendUp: true,
        num: 2,
        percent: '%',

        color: 0xff00AD74,
      ),
      StatModel(
        label: 'Average Order Value (₹)',
        value: '₹5,500.00',
        trend: 'Yesterday',
        num: 3,
        percent: '%',

        isTrendUp: false,
        color: 0xFFDA9725,
      ),
      StatModel(
        label: 'Net Revenue (₹)',
        value: '₹1,10,25,658.00',
        trend: 'Yesterday',
        percent: '%',

        num: 2,

        isTrendUp: true,
        color: 0xff02AAC4,
      ),
    ];
  }

  // void updateDateRange(String newRange) {
  //   dateRange.value = newRange;
  //   // Call API to refresh stats with new date range
  // }
}

// Model
class StatModel {
  final String label;
  final String value;
  final String trend;
  final int? num;
  final String percent;
  final bool isTrendUp;
  final int color;

  StatModel({
    required this.label,
    required this.value,
    required this.trend,
    required this.percent,
    required this.isTrendUp,
    required this.color,
    required this.num,
  });
}

// Models
class TopSellingProduct {
  final String rank;
  final String name;
  double unitsSold;
  final double price;
  final double revenue;

  TopSellingProduct({
    required this.rank,
    required this.name,
    required this.unitsSold,
    required this.price,
    required this.revenue,
  });
}

class NonMovingProduct {
  final String rank;
  final String name;
  final int soldQty;
  final int age;
  final int unsoldStock;

  NonMovingProduct({
    required this.rank,
    required this.name,
    required this.soldQty,
    required this.age,
    required this.unsoldStock,
  });
}

class SalesData {
  final int day;
  final double revenue;
  final double sales;
  final double orders;

  SalesData({required this.day, required this.revenue, required this.sales, required this.orders});
}

class StockItem {
  final String name;
  final String category;
  final String usage;

  StockItem({required this.name, required this.category, required this.usage});
}
