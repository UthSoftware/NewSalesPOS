// ------------------------------- Product Menu Grid ------------------------------- //

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(debugShowCheckedModeBanner: false, home: const FoodMenuScreen());
//   }
// }

// class FoodMenuScreen extends StatelessWidget {
//   const FoodMenuScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text('Food Menu'),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: const ResponsiveFoodGrid(),
//     );
//   }
// }

// class ResponsiveFoodGrid extends StatelessWidget {
//   const ResponsiveFoodGrid({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     // Fixed item width - adjust this value as needed
//     const double itemWidth = 280.0;
//     const double spacing = 16.0;
//     const double padding = 16.0;

//     // Calculate how many items can fit
//     final availableWidth = screenWidth - (padding * 2);
//     int crossAxisCount = (availableWidth / (itemWidth + spacing)).floor();

//     // Ensure at least 1 column
//     if (crossAxisCount < 1) crossAxisCount = 1;

//     return GridView.builder(
//       padding: const EdgeInsets.all(padding),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: crossAxisCount,
//         crossAxisSpacing: spacing,
//         mainAxisSpacing: spacing,
//         childAspectRatio: 0.82,
//       ),
//       itemCount: foodItems.length,
//       itemBuilder: (context, index) {
//         return FoodMenuItem(item: foodItems[index]);
//       },
//     );
//   }
// }

// class FoodMenuItem extends StatelessWidget {
//   final FoodItem item;

//   const FoodMenuItem({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Image Section
//           Expanded(
//             flex: 3,
//             child: Stack(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                     image: DecorationImage(image: NetworkImage(item.imageUrl), fit: BoxFit.cover),
//                   ),
//                 ),
//                 // Rating Badge
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Icon(Icons.star, color: Colors.amber, size: 14),
//                         const SizedBox(width: 4),
//                         Text(
//                           item.rating.toString(),
//                           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Details Section
//           Expanded(
//             flex: 2,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Title and Price
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         item.name,
//                         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         '₹${item.price}',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.grey[700],
//                         ),
//                       ),
//                     ],
//                   ),
//                   // Category and Action Button
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(item.category, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
//                       Container(
//                         width: 32,
//                         height: 32,
//                         decoration: BoxDecoration(
//                           color: item.isVeg ? Colors.green : Colors.red,
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(Icons.add, color: Colors.white, size: 20),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Data Model
// class FoodItem {
//   final String name;
//   final String category;
//   final int price;
//   final double rating;
//   final String imageUrl;
//   final bool isVeg;

//   FoodItem({
//     required this.name,
//     required this.category,
//     required this.price,
//     required this.rating,
//     required this.imageUrl,
//     required this.isVeg,
//   });
// }

// // Sample Data
// final List<FoodItem> foodItems = [
//   FoodItem(
//     name: 'Bruschetta',
//     category: 'بروشيتا',
//     price: 150,
//     rating: 4.7,
//     imageUrl: 'https://images.unsplash.com/photo-1572695157366-5e585ab2b69f?w=400',
//     isVeg: true,
//   ),
//   FoodItem(
//     name: 'Calamari',
//     category: 'حبار مقلي',
//     price: 80,
//     rating: 4.5,
//     imageUrl: 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=400',
//     isVeg: false,
//   ),
//   FoodItem(
//     name: 'Chicken Wings',
//     category: 'أجنحة دجاج',
//     price: 80,
//     rating: 4.9,
//     imageUrl: 'https://images.unsplash.com/photo-1608039755401-742074f0548d?w=400',
//     isVeg: false,
//   ),
//   FoodItem(
//     name: 'Nachos',
//     category: 'أجبنة دجاج',
//     price: 80,
//     rating: 4.0,
//     imageUrl: 'https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?w=400',
//     isVeg: true,
//   ),
//   FoodItem(
//     name: 'Chicken Wings',
//     category: 'أجنحة دجاج',
//     price: 80,
//     rating: 4.9,
//     imageUrl: 'https://images.unsplash.com/photo-1608039755401-742074f0548d?w=400',
//     isVeg: false,
//   ),
//   FoodItem(
//     name: 'Nachos',
//     category: 'أجبنة دجاج',
//     price: 80,
//     rating: 4.0,
//     imageUrl: 'https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?w=400',
//     isVeg: true,
//   ),
//   FoodItem(
//     name: 'Bruschetta',
//     category: 'بروشيتا',
//     price: 150,
//     rating: 4.7,
//     imageUrl: 'https://images.unsplash.com/photo-1572695157366-5e585ab2b69f?w=400',
//     isVeg: true,
//   ),
//   FoodItem(
//     name: 'Calamari',
//     category: 'حبار مقلي',
//     price: 80,
//     rating: 4.7,
//     imageUrl: 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=400',
//     isVeg: false,
//   ),
// ];
