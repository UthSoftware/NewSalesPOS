// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class ResponsiveFoodGrid extends StatelessWidget {
  const ResponsiveFoodGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Fixed item width - adjust this value as needed
    const double itemWidth = 280.0;
    const double spacing = 16.0;
    const double padding = 16.0;

    // Calculate how many items can fit
    final availableWidth = screenWidth - (padding * 2);
    int crossAxisCount = (availableWidth / (itemWidth + spacing)).floor();

    // Ensure at least 1 column
    if (crossAxisCount < 1) crossAxisCount = 1;

    return Container(
      color: Color(0XFFF6F6F6),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: GridView.builder(
        // padding: const EdgeInsets.all(padding),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: 0.95,
        ),
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          return FoodMenuItem(item: foodItems[index]);
        },
      ),
    );
  }
}

class FoodMenuItem extends StatelessWidget {
  final FoodItem item;

  const FoodMenuItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: item.isAdd ? Color(0XFF12A877) : Colors.transparent, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section - 70%
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(item.imageUrl), fit: BoxFit.cover),
                    ),
                  ),
                ),
                // Rating Badge
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          item.rating.toString(),
                          style: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Details Section - 30%
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.name,
                        style: GoogleFonts.openSans(
                          fontSize: getProportionateScreenWidth(4.2),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${item.price}',
                        style: GoogleFonts.openSans(
                          fontSize: getProportionateScreenWidth(4.3),
                          fontWeight: FontWeight.w700,
                          color: Color(0XFF008A05),
                        ),
                      ),
                    ],
                  ),
                  // Category and Action Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        item.category,
                        style: GoogleFonts.openSans(fontSize: getProportionateScreenWidth(3.8)),
                      ),
                      SizedBox(width: getProportionateScreenWidth(4)),
                      SvgPicture.asset(
                        item.isAdd
                            ? "assets/remove_product_item.svg"
                            : "assets/add_product_item.svg",
                        height: getProportionateScreenWidth(6),
                        width: getProportionateScreenWidth(6),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Data Model
class FoodItem {
  final String name;
  final String category;
  final int price;
  final double rating;
  final String imageUrl;
  final bool isVeg;
  final bool isAdd;

  FoodItem({
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.isVeg,
    required this.isAdd,
  });
}

// Sample Data
final List<FoodItem> foodItems = [
  FoodItem(
    name: 'Bruschetta',
    category: 'بروشيتا',
    price: 150,
    rating: 4.7,
    imageUrl: 'https://images.unsplash.com/photo-1572695157366-5e585ab2b69f?w=400',
    isVeg: true,
    isAdd: false,
  ),
  FoodItem(
    name: 'Calamari',
    category: 'حبار مقلي',
    price: 80,
    rating: 4.5,
    imageUrl: 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=400',
    isVeg: false,
    isAdd: false,
  ),
  FoodItem(
    name: 'Chicken Wings',
    category: 'أجنحة دجاج',
    price: 80,
    rating: 4.9,
    imageUrl: 'https://images.unsplash.com/photo-1608039755401-742074f0548d?w=400',
    isVeg: false,
    isAdd: false,
  ),
  FoodItem(
    name: 'Nachos',
    category: 'أجبنة دجاج',
    price: 80,
    rating: 4.0,
    imageUrl: 'https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?w=400',
    isVeg: true,
    isAdd: true,
  ),
  FoodItem(
    name: 'Chicken Wings',
    category: 'أجنحة دجاج',
    price: 80,
    rating: 4.9,
    imageUrl: 'https://images.unsplash.com/photo-1608039755401-742074f0548d?w=400',
    isVeg: false,
    isAdd: false,
  ),
  FoodItem(
    name: 'Nachos',
    category: 'أجبنة دجاج',
    price: 80,
    rating: 4.0,
    imageUrl: 'https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?w=400',
    isVeg: true,
    isAdd: true,
  ),
  FoodItem(
    name: 'Bruschetta',
    category: 'بروشيتا',
    price: 150,
    rating: 4.7,
    imageUrl: 'https://images.unsplash.com/photo-1572695157366-5e585ab2b69f?w=400',
    isVeg: true,
    isAdd: true,
  ),
  FoodItem(
    name: 'Calamari',
    category: 'حبار مقلي',
    price: 80,
    rating: 4.7,
    imageUrl: 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=400',
    isVeg: false,
    isAdd: false,
  ),
  FoodItem(
    name: 'Bruschetta',
    category: 'بروشيتا',
    price: 150,
    rating: 4.7,
    imageUrl: 'https://images.unsplash.com/photo-1572695157366-5e585ab2b69f?w=400',
    isVeg: true,
    isAdd: true,
  ),
  FoodItem(
    name: 'Calamari',
    category: 'حبار مقلي',
    price: 80,
    rating: 4.5,
    imageUrl: 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=400',
    isVeg: false,
    isAdd: false,
  ),
  FoodItem(
    name: 'Chicken Wings',
    category: 'أجنحة دجاج',
    price: 80,
    rating: 4.9,
    imageUrl: 'https://images.unsplash.com/photo-1608039755401-742074f0548d?w=400',
    isVeg: false,
    isAdd: false,
  ),
  FoodItem(
    name: 'Nachos',
    category: 'أجبنة دجاج',
    price: 80,
    rating: 4.0,
    imageUrl: 'https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?w=400',
    isVeg: true,
    isAdd: true,
  ),
  FoodItem(
    name: 'Chicken Wings',
    category: 'أجنحة دجاج',
    price: 80,
    rating: 4.9,
    imageUrl: 'https://images.unsplash.com/photo-1608039755401-742074f0548d?w=400',
    isVeg: false,
    isAdd: false,
  ),
  FoodItem(
    name: 'Nachos',
    category: 'أجبنة دجاج',
    price: 80,
    rating: 4.0,
    imageUrl: 'https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?w=400',
    isVeg: true,
    isAdd: true,
  ),
  FoodItem(
    name: 'Bruschetta',
    category: 'بروشيتا',
    price: 150,
    rating: 4.7,
    imageUrl: 'https://images.unsplash.com/photo-1572695157366-5e585ab2b69f?w=400',
    isVeg: true,
    isAdd: true,
  ),
  FoodItem(
    name: 'Calamari',
    category: 'حبار مقلي',
    price: 80,
    rating: 4.7,
    imageUrl: 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=400',
    isVeg: false,
    isAdd: false,
  ),
];
