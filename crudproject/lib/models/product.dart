class Product {
  final String id;
  final String productName;
  final String productCode;
  final String productImage;
  final String unitPrice;
  final String quentity;
  final String totalPrice;
  final String createAt;

  Product(
      {
      required this.id,
      required this.productName,
      required this.productCode,
      required this.productImage,
      required this.unitPrice,
      required this.quentity,
      required this.totalPrice,
      required this.createAt});
}