import 'package:tigasendok/data/model/customer_model.dart';
import 'package:tigasendok/data/model/product_model.dart';

class OrderResponse {
  final int currentPage;
  final List<Order> order;
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

  OrderResponse({
    required this.currentPage,
    required this.order,
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

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        currentPage: json["current_page"],
        order: List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
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
        "data": List<dynamic>.from(order.map((x) => x.toJson())),
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

class Order {
  final int id;
  final int qty;
  final int price;
  final int total;
  final int isPaid;
  final DateTime createdAt;
  final Customer customer;
  final Product product;

  Order({
    required this.id,
    required this.qty,
    required this.price,
    required this.total,
    required this.isPaid,
    required this.createdAt,
    required this.customer,
    required this.product,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        qty: json["qty"],
        price: json["price"],
        total: json["total"],
        isPaid: json["is_paid"],
        createdAt: DateTime.parse(json["created_at"]),
        customer: Customer.fromJson(json["customer"]),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "qty": qty,
        "price": price,
        "total": total,
        "is_paid": isPaid,
        "created_at": createdAt.toIso8601String(),
        "customer": customer.toJson(),
        "product": product.toJson(),
      };
}
