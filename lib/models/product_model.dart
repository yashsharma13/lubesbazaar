class ProductModel {
  final String id;
  final String title;
  final String description;
  final String price;
  final String oldPrice;
  final String discount;
  final String imageUrl;

  // 🔥 Extra fields from API
  final String? fuel;
  final String? packSize;
  final String? unit;
  final String? subunit;
  final String? productCode;
  final String? batchNumber;
  final String? discPrice;

  int quantity; // ✅ For cart purpose

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.imageUrl,
    this.fuel,
    this.packSize,
    this.unit,
    this.subunit,
    this.productCode,
    this.batchNumber,
    this.discPrice,
    this.quantity = 1,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: json['price']?.toString() ?? '0',
      oldPrice: json['old_price']?.toString() ?? '0',
      discount: (json['discount_percent']?.toString() ?? '0'),
      imageUrl: json['product_image']?.toString() ?? '',

      // 🔥 extra fields
      fuel: json['fuel']?.toString(),
      packSize: json['packsize']?.toString(),
      unit: json['unit']?.toString(),
      subunit: json['subunit']?.toString(),
      productCode: json['productcode']?.toString(),
      batchNumber: json['batchnumber']?.toString(),
      discPrice: json['disc_price']?.toString(),

      quantity: (json['quantity'] is int && json['quantity'] > 0)
          ? json['quantity']
          : 1,
    );
  }

  // ✅ Convert object to JSON (useful for cart or local storage)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'old_price': oldPrice,
      'discount_percent': discount,
      'product_image': imageUrl,
      'fuel': fuel,
      'packsize': packSize,
      'unit': unit,
      'subunit': subunit,
      'productcode': productCode,
      'batchnumber': batchNumber,
      'disc_price': discPrice,
      'quantity': quantity,
    };
  }
}
