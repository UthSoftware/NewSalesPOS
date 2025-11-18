class BaseType {
  final String nameEn;
  final String nameReg;
  final String thamnailChar;

  BaseType({required this.nameEn, required this.nameReg, String? thamnailChar})
    : thamnailChar = thamnailChar ?? _generateInitials(nameEn);

  // Helper method to generate initials
  static String _generateInitials(String name) {
    return name
        .split(' ')
        .where((part) => part.isNotEmpty)
        .map((part) => part[0].toUpperCase())
        .join();
  }
}

class OrderType extends BaseType {
  OrderType({required super.nameEn, required super.nameReg, super.thamnailChar});
}
