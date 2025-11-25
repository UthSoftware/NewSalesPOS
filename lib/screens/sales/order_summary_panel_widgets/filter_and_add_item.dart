import 'package:flutter/material.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class FilterAndAddItem extends StatefulWidget {
  const FilterAndAddItem({super.key});

  @override
  State<FilterAndAddItem> createState() => _FilterAndAddItemState();
}

class _FilterAndAddItemState extends State<FilterAndAddItem> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    nameController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget space = SizedBox(width: getProportionateScreenWidth(2));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: const BoxDecoration(color: Color(0xFFf7f7f7)),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildTextField(
                controller: codeController,
                hint: 'Code',
                showLeftBorder: false,
              ),
            ),
            space,
            Expanded(
              flex: 5,
              child: _buildTextField(
                controller: nameController,
                hint: 'Name',
                showLeftBorder: true,
              ),
            ),
            space,
            Expanded(
              flex: 2,
              child: _buildTextField(
                controller: quantityController,
                hint: 'Quantity',
                showLeftBorder: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required bool showLeftBorder,
  }) {
    final double fontSize = getProportionateScreenWidth(4);
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: fontSize, color: Color(0xFF333333)),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,

        hintText: hint,
        hintStyle: TextStyle(fontSize: fontSize, color: Color(0xFF999999)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50), // Border radius
          borderSide: BorderSide(color: Color(0XFFeeefee)), // Remove default border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50), // Border radius
          borderSide: BorderSide(color: Color(0XFFeeefee)), // Remove default border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50), // Border radius
          borderSide: BorderSide(color: Color(0XFFeeefee)), // Remove default border
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
