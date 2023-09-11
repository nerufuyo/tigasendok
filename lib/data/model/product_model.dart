import 'package:tigasendok/data/model/unit_model.dart';

class ProductResponse {
  final int currentPage;
  final List<Product> product;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;

  ProductResponse({
    required this.currentPage,
    required this.product,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        currentPage: json["current_page"],
        product:
            List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(product.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Product {
  final int id;
  final String uuid;
  final String code;
  final String name;
  final int price;
  final Unit unit;

  Product({
    required this.id,
    required this.uuid,
    required this.code,
    required this.name,
    required this.price,
    required this.unit,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        uuid: json["uuid"],
        code: json["code"],
        name: json["name"],
        price: json["price"],
        unit: Unit.fromJson(json["unit"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "code": code,
        "name": name,
        "price": price,
        "unit": unit.toJson(),
      };
}
