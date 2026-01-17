class AddonCategory {
  final String categoryname;
  final int selectedProduct;
  final String image;
  // AddonInputType inputType; // 👈 ADD THIS

  final int id;

  // ✅ Missing field added with correct type
  final List<CategoryProduct> categoryProduct;

  final AddonCategoryType addonCategoryType;

  AddonCategory({
    required this.categoryname,
    required this.selectedProduct,
    required this.image,
    required this.id,
    required this.addonCategoryType,

    // required this.inputType, // 👈 ADD THIS
    required this.categoryProduct,
  });
}

enum AddonCategoryType { radio, checkBox, qty, drink }

class CategoryProduct {
  final String productName;
  final double price;
  final String image;
  final double priviuosamt;
  int selectedqty;

  CategoryProduct({
    required this.productName,
    required this.price,
    required this.image,
    required this.priviuosamt,
    required this.selectedqty,
  });
}

// Data Model (keeping only first 4 items for brevity)
class FoodItem {
  final String name;
  final String category;
  final int price;
  final double rating;
  final String imageUrl;
  final bool isVeg;
  final bool isAdd;
  final bool isAddons;

  final List<AddonCategory> addonCategory;

  FoodItem({
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.isVeg,
    required this.isAdd,
    required this.isAddons,
    required this.addonCategory,
  });
}
