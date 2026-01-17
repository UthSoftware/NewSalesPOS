// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_sales/screens/sales/product_panel_widgets/addon_model_screen.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class ResponsiveFoodGrid extends StatefulWidget {
  const ResponsiveFoodGrid({super.key});

  @override
  State<ResponsiveFoodGrid> createState() => _ResponsiveFoodGridState();
}

class _ResponsiveFoodGridState extends State<ResponsiveFoodGrid> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    const double itemWidth = 280.0;
    const double spacing = 16.0;
    const double padding = 16.0;

    final availableWidth = screenWidth - (padding * 2);
    int crossAxisCount = (availableWidth / (itemWidth + spacing)).floor();

    if (crossAxisCount < 1) crossAxisCount = 1;

    return Container(
      color: Color(0XFFF6F6F6),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: GridView.builder(
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

class FoodMenuItem extends StatefulWidget {
  final FoodItem item;

  const FoodMenuItem({super.key, required this.item});

  @override
  State<FoodMenuItem> createState() => _FoodMenuItemState();
}

class _FoodMenuItemState extends State<FoodMenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showAddOnsDialog(context, widget.item);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.item.isAdd ? Color(0XFF12A877) : Colors.transparent,
            width: 1,
          ),
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
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.item.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
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
                            widget.item.rating.toString(),
                            style: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.item.name,
                            style: GoogleFonts.openSans(
                              fontSize: getProportionateScreenWidth(4.2),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '₹${widget.item.price}',
                          style: GoogleFonts.openSans(
                            fontSize: getProportionateScreenWidth(4.3),
                            fontWeight: FontWeight.w700,
                            color: Color(0XFF008A05),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.item.category,
                            style: GoogleFonts.openSans(fontSize: getProportionateScreenWidth(3.8)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: getProportionateScreenWidth(4)),
                        SvgPicture.asset(
                          widget.item.isAdd
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
      ),
    );
  }
}

void _showAddOnsDialog(BuildContext context, FoodItem item) {
  String selectedCategory = item.addonCategory.first.categoryname;
  int mainQuantity = 1;

  int selectedCategoryIndex = 0;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialog) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.85,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  // HEADER BAR
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffDC4A58),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Add ons",
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.white, size: 28),
                          onPressed: () => Navigator.pop(context),
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),

                  SizedBox(height: 15),

                  // TITLE + QTY + SEARCH
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Text(
                          item.name,
                          style: GoogleFonts.openSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffD2303F),
                          ),
                        ),
                        SizedBox(width: 15),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, size: 20),
                                onPressed: () {
                                  if (mainQuantity > 1) {
                                    setDialog(() {
                                      mainQuantity--;
                                    });
                                  }
                                },
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  mainQuantity.toString().padLeft(2, '0'),
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, size: 20),
                                onPressed: () {
                                  setDialog(() {
                                    mainQuantity++;
                                  });
                                },
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                            ],
                          ),
                        ),

                        Spacer(),

                        // Search field
                        SizedBox(
                          height: 40,
                          width: 300,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 8),

                  // Subtitle text
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Choose Min 0 and Max 2 add-ons for this Category",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.openSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff6A6A6A),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // MAIN BODY
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          // LEFT SIDE - CATEGORY LIST
                          SizedBox(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Category",
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Color(0xff1E1E1E),
                                      ),
                                    ),
                                    Text(
                                      "(${item.addonCategory.length} items)",
                                      style: GoogleFonts.openSans(
                                        color: Color(0xff5A5A5A),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: item.addonCategory.length,
                                    itemBuilder: (context, i) {
                                      final category = item.addonCategory[i];

                                      bool isSelected = category.categoryname == selectedCategory;

                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
                                        child: InkWell(
                                          onTap: () {
                                            selectedCategoryIndex = i;
                                            print('dcfd');
                                            setDialog(() {
                                              selectedCategory = category.categoryname;
                                            });
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: isSelected ? Color(0xffFFEBEE) : Colors.white,
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(width: 5),
                                                CircleAvatar(
                                                  radius: 22,
                                                  backgroundColor: Colors.white,
                                                  backgroundImage: AssetImage(category.image),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 20),
                                                  child: Center(
                                                    child: Text(
                                                      category.categoryname,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: isSelected
                                                            ? Color(0xffD2303F)
                                                            : Colors.black,
                                                        fontSize: 14,
                                                        fontWeight: isSelected
                                                            ? FontWeight.w600
                                                            : FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 20),

                          Expanded(
                            child: _buildCategoryProductDetails(
                              addonCategory: item.addonCategory[selectedCategoryIndex],
                              setDialog: setDialog,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Bottom buttons
                  Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 100,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffDC4A58),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

int currentQty = 0;
int currentQtyDrink = 0;
bool isSelected = false;
// Updated _buildCategoryProductDetails method
Widget _buildCategoryProductDetails({
  required AddonCategory addonCategory,
  required StateSetter setDialog,
}) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 5,
      mainAxisExtent: 150,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemCount: addonCategory.categoryProduct.length,
    itemBuilder: (context, index) {
      final product = addonCategory.categoryProduct[index];

      return Container(
        decoration: BoxDecoration(
          color: Color(0xffFFFFFf),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.4), blurRadius: 5, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Image.asset(product.image, fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: product.selectedqty == 1 ? Color(0xffFFEDEF) : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(2),
                        top: getProportionateScreenHeight(5),
                      ),
                      child: Text(
                        product.productName,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: Color(0xff1E1E1E),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(5)),
                    Row(
                      children: [
                        SizedBox(width: getProportionateScreenWidth(3)),
                        Text(
                          "₹${product.priviuosamt.toString()}",
                          style: GoogleFonts.openSans(
                            fontSize: 10,
                            color: Color(0xff6A6A6A),
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 5,
                          ),
                        ),
                        SizedBox(width: getProportionateScreenWidth(2)),

                        Text(
                          "₹${product.price.toString()}",
                          style: GoogleFonts.openSans(
                            fontSize: 12,
                            color: Color(0xff008A05),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),

                        if (addonCategory.addonCategoryType == AddonCategoryType.qty) ...[
                          if (product.selectedqty <= 0) ...[
                            InkWell(
                              onTap: () {
                                setDialog(() {
                                  print(
                                    "${addonCategory.selectedProduct} limit : $currentQty limit",
                                  );
                                  if (addonCategory.selectedProduct == currentQty) {
                                    print("You aleady reach the limit");
                                  } else {
                                    if (product.selectedqty == 0) {
                                      ++currentQty;
                                    }
                                    product.selectedqty = 1;
                                  }
                                });
                              },
                              child: SvgPicture.asset('assets/add_product_item.svg', height: 20),
                            ),
                          ] else ...[
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setDialog(() {
                                      if (product.selectedqty > 0) {
                                        product.selectedqty--;
                                      }
                                      if (product.selectedqty == 0) {
                                        --currentQty;
                                      }
                                    });
                                  },
                                  child: SvgPicture.asset('assets/minus_qty.svg', height: 20),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  product.selectedqty.toString(),
                                  style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 8),
                                InkWell(
                                  onTap: () {
                                    setDialog(() {
                                      product.selectedqty++;
                                    });
                                  },
                                  child: SvgPicture.asset('assets/add_qty.svg', height: 20),
                                ),
                              ],
                            ),
                          ],
                        ] else if (addonCategory.addonCategoryType ==
                            AddonCategoryType.checkBox) ...[
                          InkWell(
                            onTap: () {
                              if (product.selectedqty == 1) {
                                setDialog(() {
                                  product.selectedqty = 0;
                                  currentQty--;
                                  print(" Decrease the currentQty = $currentQty");
                                });
                                return;
                              }

                              if (currentQty >= addonCategory.selectedProduct) {
                                print("MAX LIMIT REACHED");
                                return;
                              }

                              setDialog(() {
                                product.selectedqty = 1;
                                currentQty++;
                                print("currentQty = $currentQty");
                              });
                            },

                            child: Row(
                              children: [
                                product.selectedqty == 1
                                    ? Image.asset("assets/sales_images/images/selected_note.png")
                                    : Image.asset("assets/sales_images/images/note.png"),
                                SizedBox(width: 25),
                                Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    border: Border.all(
                                      color: product.selectedqty == 1 ? Colors.green : Colors.grey,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    size: 14,
                                    color: product.selectedqty == 1 ? Colors.green : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else if (addonCategory.addonCategoryType == AddonCategoryType.radio) ...[
                          InkWell(
                            onTap: () {
                              if (product.selectedqty == 1) {
                                setDialog(() {
                                  product.selectedqty = 0;
                                  currentQty--;
                                  print(" Decrease the currentQty = $currentQty");
                                });
                                return;
                              }

                              if (currentQty >= addonCategory.selectedProduct) {
                                print("MAX LIMIT REACHED");
                                return;
                              }

                              setDialog(() {
                                product.selectedqty = 1;
                                currentQty++;
                                print("currentQty = $currentQty");
                              });
                            },

                            child: Row(
                              children: [
                                product.selectedqty == 1
                                    ? Image.asset("assets/sales_images/images/selected_note.png")
                                    : Image.asset("assets/sales_images/images/note.png"),
                                SizedBox(width: 25),
                                Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 1,
                                      color: product.selectedqty == 1 ? Colors.green : Colors.grey,
                                    ),
                                  ),
                                  child: product.selectedqty == 1
                                      ? Icon(Icons.circle, size: 15, color: Colors.green)
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ] else if (addonCategory.addonCategoryType == AddonCategoryType.drink) ...[
                          InkWell(
                            onTap: () {
                              if (product.selectedqty == 1) {
                                setDialog(() {
                                  product.selectedqty = 0;
                                  currentQtyDrink--;
                                  print(" Decrease the currentQtyDrink = $currentQtyDrink");
                                });
                                return;
                              }

                              if (currentQtyDrink == addonCategory.selectedProduct) {
                                print("MAX LIMIT REACHED");
                                return;
                              }

                              setDialog(() {
                                product.selectedqty = 1;
                                currentQtyDrink++;
                                print("currentQtyDrink = $currentQtyDrink");
                              });
                            },

                            child: Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  width: 1,
                                  color: product.selectedqty == 1 ? Colors.green : Colors.grey,
                                ),
                              ),
                              child: product.selectedqty == 1
                                  ? Icon(Icons.circle, size: 15, color: Colors.green)
                                  : null,
                            ),
                          ),
                        ],

                        SizedBox(width: 5),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

final List<FoodItem> foodItems = [
  FoodItem(
    name: 'Bruschetta',
    category: 'بروشيتا',
    price: 150,
    rating: 4.7,
    imageUrl: 'https://images.unsplash.com/photo-1572695157366-5e585ab2b69f?w=400',
    isVeg: true,
    isAdd: false,
    isAddons: true,
    addonCategory: [
      AddonCategory(
        categoryname: "Sauce",
        selectedProduct: 2,
        image: "assets/sales_images/images/sauce.png",
        id: 1,
        addonCategoryType: AddonCategoryType.qty,

        categoryProduct: [
          CategoryProduct(
            productName: "Cheese Sauce",
            price: 40.0,
            image: "assets/sales_images/images/cheese_sauce.png",
            priviuosamt: 50.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Garlic Mayo",
            price: 30.0,
            image: "assets/sales_images/images/garlic_sauce.png",
            priviuosamt: 40.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Classic Pizza Sauce",
            price: 35.0,
            image: "assets/sales_images/images/garlic_sauce.png",
            priviuosamt: 45.0,
            selectedqty: 0,
          ),
        ],
      ),
      AddonCategory(
        categoryname: "Toppings",
        selectedProduct: 5,
        image: "assets/sales_images/images/sauce.png",
        id: 2,
        addonCategoryType: AddonCategoryType.checkBox,
        categoryProduct: [
          CategoryProduct(
            productName: "Tomato",
            price: 50.0,
            image: "assets/sales_images/images/tomato.png",
            priviuosamt: 60.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Onion",
            price: 50.0,
            image: "assets/sales_images/images/onion.png",
            priviuosamt: 60.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Capsicum",
            price: 50.0,
            image: "assets/sales_images/images/capsicum.png",
            priviuosamt: 60.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Mushroom",
            price: 50.0,
            image: "assets/sales_images/images/mushroom.png",
            priviuosamt: 60.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Chicken Sausage",
            price: 50.0,
            image: "assets/sales_images/images/chicken_tikka_sausage_fried.png",
            priviuosamt: 60.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Fried Chicken",
            price: 50.0,
            image: "assets/sales_images/images/chicken_tikka_sausage_fried.png",
            priviuosamt: 60.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Chicken Tikka",
            price: 50.0,
            image: "assets/sales_images/images/chicken_tikka_sausage_fried.png",
            priviuosamt: 60.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Olives",
            price: 30.0,
            image: "assets/sales_images/images/olives.png",
            priviuosamt: 40.0,
            selectedqty: 0,
          ),
        ],
      ),
      AddonCategory(
        categoryname: "Beverage",
        selectedProduct: 2,
        addonCategoryType: AddonCategoryType.drink,

        image: "assets/sales_images/images/pepsi.png",
        id: 3,
        categoryProduct: [
          CategoryProduct(
            productName: "Coca Cola",
            price: 60.0,
            image: "assets/sales_images/images/pepsi.png",
            priviuosamt: 70.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Orange Juice",
            price: 80.0,
            image: "assets/sales_images/images/pepsi.png",
            priviuosamt: 90.0,
            selectedqty: 0,
          ),
        ],
      ),
      AddonCategory(
        categoryname: "Sides",
        selectedProduct: 2,
        addonCategoryType: AddonCategoryType.radio,
        image: "assets/sales_images/images/sauce.png",
        id: 4,
        categoryProduct: [
          CategoryProduct(
            productName: "Fries (Cheese Small)",
            price: 60.0,
            image: "assets/sales_images/images/fries.png",
            priviuosamt: 70.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Fries (Reg Small)",
            price: 80.0,
            image: "assets/sales_images/images/fries.png",
            priviuosamt: 90.0,
            selectedqty: 0,
          ),
        ],
      ),
    ],
  ),

  FoodItem(
    name: 'Chicken Wings',
    category: 'أجنحة دجاج',
    price: 80,
    rating: 4.9,
    imageUrl: 'https://images.unsplash.com/photo-1608039755401-742074f0548d?w=400',
    isVeg: false,
    isAdd: false,
    isAddons: true,
    addonCategory: [
      AddonCategory(
        categoryname: "Beverage",
        selectedProduct: 2,
        addonCategoryType: AddonCategoryType.drink,

        image: "assets/sales_images/images/pepsi.png",
        id: 3,
        categoryProduct: [
          CategoryProduct(
            productName: "Coca Cola",
            price: 60.0,
            image: "assets/sales_images/images/pepsi.png",
            priviuosamt: 70.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Orange Juice",
            price: 80.0,
            image: "assets/sales_images/images/pepsi.png",
            priviuosamt: 90.0,
            selectedqty: 0,
          ),
        ],
      ),
      AddonCategory(
        categoryname: "Sides",
        selectedProduct: 2,
        addonCategoryType: AddonCategoryType.radio,
        image: "assets/sales_images/images/sauce.png",
        id: 4,
        categoryProduct: [
          CategoryProduct(
            productName: "Fries (Cheese Small)",
            price: 60.0,
            image: "assets/sales_images/images/fries.png",
            priviuosamt: 70.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Fries (Reg Small)",
            price: 80.0,
            image: "assets/sales_images/images/fries.png",
            priviuosamt: 90.0,
            selectedqty: 0,
          ),
        ],
      ),
    ],
  ),

  FoodItem(
    name: 'Calamari',
    category: 'حبار مقلي',
    price: 80,
    rating: 4.7,
    imageUrl: 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=400',
    isVeg: false,
    isAdd: false,
    isAddons: true,
    addonCategory: [
      AddonCategory(
        categoryname: "Sauce",
        selectedProduct: 2,
        image: "assets/sales_images/images/sauce.png",
        id: 1,
        addonCategoryType: AddonCategoryType.qty,

        categoryProduct: [
          CategoryProduct(
            productName: "Cheese Sauce",
            price: 40.0,
            image: "assets/sales_images/images/cheese_sauce.png",
            priviuosamt: 50.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Garlic Mayo",
            price: 30.0,
            image: "assets/sales_images/images/garlic_sauce.png",
            priviuosamt: 40.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Classic Pizza Sauce",
            price: 35.0,
            image: "assets/sales_images/images/garlic_sauce.png",
            priviuosamt: 45.0,
            selectedqty: 0,
          ),
        ],
      ),
      AddonCategory(
        categoryname: "Sides",
        selectedProduct: 2,
        addonCategoryType: AddonCategoryType.radio,
        image: "assets/sales_images/images/sauce.png",
        id: 4,
        categoryProduct: [
          CategoryProduct(
            productName: "Fries (Cheese Small)",
            price: 60.0,
            image: "assets/sales_images/images/fries.png",
            priviuosamt: 70.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Fries (Reg Small)",
            price: 80.0,
            image: "assets/sales_images/images/fries.png",
            priviuosamt: 90.0,
            selectedqty: 0,
          ),
        ],
      ),
    ],
  ),

  FoodItem(
    name: 'Chicken Wings',
    category: 'أجنحة دجاج',
    price: 80,
    rating: 4.9,
    imageUrl: 'https://images.unsplash.com/photo-1608039755401-742074f0548d?w=400',
    isVeg: false,
    isAdd: false,
    isAddons: true,
    addonCategory: [
      AddonCategory(
        categoryname: "Sides",
        selectedProduct: 2,
        addonCategoryType: AddonCategoryType.radio,
        image: "assets/sales_images/images/sauce.png",
        id: 4,
        categoryProduct: [
          CategoryProduct(
            productName: "Fries (Cheese Small)",
            price: 60.0,
            image: "assets/sales_images/images/fries.png",
            priviuosamt: 70.0,
            selectedqty: 0,
          ),
          CategoryProduct(
            productName: "Fries (Reg Small)",
            price: 80.0,
            image: "assets/sales_images/images/fries.png",
            priviuosamt: 90.0,
            selectedqty: 0,
          ),
        ],
      ),
    ],
  ),
];
