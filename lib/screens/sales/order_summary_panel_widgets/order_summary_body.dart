import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/constants/my_colour.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class OrderSummaryBody extends StatelessWidget {
  OrderSummaryBody({super.key});

  final List<OrderSummaryItem> orderSummaryItemList = [
    OrderSummaryItem(itemName: "Cold Coffee", quantity: 1, notes: "", price: 90.0),
    OrderSummaryItem(
      itemName: "Chicken Biryani",
      quantity: 2,
      notes: "Crispy tortilla chips with melted cheese, jalapeños, and salsa.",
      price: 180.0,
    ),
    OrderSummaryItem(itemName: "Paneer Butter Masala", quantity: 1, notes: "", price: 150.0),
    OrderSummaryItem(itemName: "Tandoori Roti", quantity: 3, notes: "Crispy", price: 30.0),
    OrderSummaryItem(
      itemName: "Mutton Curry",
      quantity: 1,
      notes: "Spicy and tender",
      price: 250.0,
    ),
    OrderSummaryItem(itemName: "Fresh Lime Soda", quantity: 1, notes: "Without sugar", price: 60.0),
    OrderSummaryItem(itemName: "Gulab Jamun", quantity: 2, notes: "", price: 80.0),
    OrderSummaryItem(itemName: "Veg Fried Rice", quantity: 1, notes: "Less salt", price: 120.0),
    OrderSummaryItem(itemName: "Butter Naan", quantity: 2, notes: "", price: 40.0),
    OrderSummaryItem(itemName: "Masala Chai", quantity: 1, notes: "Extra hot", price: 25.0),
    OrderSummaryItem(
      itemName: "Grilled Sandwich",
      quantity: 1,
      notes: "Add extra cheese",
      price: 70.0,
    ),
    OrderSummaryItem(itemName: "Prawn Fry", quantity: 1, notes: "Well cooked", price: 300.0),
    OrderSummaryItem(itemName: "Chicken 65", quantity: 1, notes: "", price: 160.0),
    OrderSummaryItem(itemName: "Curd Rice", quantity: 1, notes: "", price: 80.0),
    OrderSummaryItem(itemName: "Mango Juice", quantity: 1, notes: "Chilled", price: 50.0),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      children: [
        _buildHeader(),

        Expanded(
          child: ListView.builder(
            itemCount: orderSummaryItemList.length,
            itemBuilder: (context, index) {
              final item = orderSummaryItemList[index];

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: MyColors.borderColor, width: 1.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildItemRow(item),
                    if (item.notes.isNotEmpty) _buildNotes(item.notes),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: MyColors.borderColor)),
      ),
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

  Widget _buildItemRow(OrderSummaryItem item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// LEFT SIDE — delete icon + name
        Expanded(
          flex: 3,
          child: Row(
            children: [
              SizedBox(width: getProportionateScreenWidth(3)),
              SvgPicture.asset("assets/delete_icon.svg", height: getProportionateScreenHeight(23)),
              SizedBox(width: getProportionateScreenWidth(3)),
              Flexible(
                child: Text(
                  item.itemName,
                  overflow: TextOverflow.ellipsis, // prevents overflow
                  style: GoogleFonts.openSans(
                    color: const Color(0XFF3A3A3A),
                    fontWeight: FontWeight.w500,
                    fontSize: getProportionateScreenWidth(4.3),
                  ),
                ),
              ),
            ],
          ),
        ),

        /// RIGHT SIDE — (notes icon) (qty) (price)
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                item.notes.isNotEmpty ? "assets/noted_icon.svg" : "assets/notes_icon.svg",
                height: getProportionateScreenHeight(29),
              ),

              SizedBox(width: getProportionateScreenWidth(6)),

              /// Quantity buttons
              SizedBox(
                width: getProportionateScreenWidth(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset("assets/minus_qty.svg", height: 24),
                    Text(
                      item.quantity.toString(),
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenWidth(4.3),
                      ),
                    ),
                    SvgPicture.asset("assets/add_qty.svg", height: 24),
                  ],
                ),
              ),

              SizedBox(width: getProportionateScreenWidth(4)),

              /// Price
              SizedBox(
                width: getProportionateScreenWidth(18),
                child: Text(
                  '₹${item.price.toStringAsFixed(2)}',
                  textAlign: TextAlign.end,
                  style: GoogleFonts.openSans(
                    color: const Color(0XFF008A05),
                    fontWeight: FontWeight.w700,
                    fontSize: getProportionateScreenWidth(4.3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotes(String notes) {
    return Container(
      margin: const EdgeInsets.only(top: 14, left: 8, right: 8),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0XFF3B82F6), width: 0.5),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 14, color: Colors.black),
          children: [
            const TextSpan(
              text: 'Notes : ',
              style: TextStyle(fontWeight: FontWeight.w500, color: Color(0XFF3B82F6)),
            ),
            TextSpan(
              text: notes,
              style: const TextStyle(color: Color(0XFF6A6A6A)),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSummaryItem {
  String itemName;
  double quantity;
  String notes;
  double price;

  OrderSummaryItem({
    required this.itemName,
    required this.quantity,
    required this.notes,
    required this.price,
  });
}
