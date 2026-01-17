import 'package:flutter/material.dart';
import 'package:soft_sales/screens/order_list/running_screen/running_list_expanded.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class OrderList extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const OrderList({super.key, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(6),
                vertical: getProportionateScreenWidth(4),
              ),
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(children: [

                





                    
                
                    
              ],
            
            
            ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(6),
                vertical: getProportionateScreenWidth(4),
              ),
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Column(children: [RunningListExpanded()]),
            ),
          ),
        ],
      ),
    );
  }
}
