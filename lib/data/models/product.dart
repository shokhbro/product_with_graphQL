class Product {
  final String id;
  String title;
  int price;
  String description;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "description": description,
    };
  }
}
