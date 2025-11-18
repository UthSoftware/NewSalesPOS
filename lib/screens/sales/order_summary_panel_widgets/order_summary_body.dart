import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/constants/my_colour.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

// ignore: must_be_immutable
class OrderSummaryBody extends StatelessWidget {
  OrderSummaryBody({super.key});
  List<OrderSummaryItem> orderSummaryItemList = [
    OrderSummaryItem(itemName: "Cold Coffee", quantity: 1, notes: "", price: 90.0),
    OrderSummaryItem(
      itemName: "Chicken Biryani",
      quantity: 2,
      notes: "Note : Crispy tortilla chips with melted cheese, jalapeños, and salsa.",
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
    return Expanded(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: MyColors.borderColor)),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                              color: Color(0XFF3B82F6),
                              // fontWeight: FontWeight.w600,
                              fontSize: getProportionateScreenWidth(4.1),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Dhina', style: GoogleFonts.openSans(color: Color(0XFF3A3A3A))),
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
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: orderSummaryItemList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    // color: Colors.green,
                    border: Border(bottom: BorderSide(color: MyColors.borderColor, width: 1.5)),
                  ),
                  child: Column(
                    children: [
                      Row(
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
                                Text(
                                  orderSummaryItemList[index].itemName,
                                  style: GoogleFonts.openSans(
                                    color: Color(0XFF3A3A3A),
                                    fontWeight: FontWeight.w500,
                                    fontSize: getProportionateScreenWidth(4.3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                orderSummaryItemList[index].notes.isNotEmpty
                                    ? "assets/noted_icon.svg"
                                    : "assets/notes_icon.svg",
                                height: getProportionateScreenHeight(29),
                                width: getProportionateScreenHeight(29),
                              ),
                              SizedBox(width: getProportionateScreenWidth(6)),
                              SizedBox(
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
                                      orderSummaryItemList[index].quantity.toString(),
                                      style: GoogleFonts.openSans(
                                        color: Color(0XFF3A3A3A),
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
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(25),
                                child: Text(
                                  '₹${orderSummaryItemList[index].price.toStringAsFixed(2)}',
                                  style: GoogleFonts.openSans(
                                    color: Color(0XFF008A05),
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
                      ),
                      if (orderSummaryItemList[index].notes.isNotEmpty) ...[
                        LayoutBuilder(
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
                                      text: orderSummaryItemList[index].notes,
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
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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
