// ignore_for_file: constant_identifier_names

class CustomerResponse {
  final int currentPage;
  final List<Customer> customer;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  // final List<Link> links;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;

  CustomerResponse({
    required this.currentPage,
    required this.customer,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    // required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      CustomerResponse(
        currentPage: json["current_page"],
        customer:
            List<Customer>.from(json["data"].map((x) => Customer.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        // links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(customer.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        // "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Customer {
  final int id;
  final String uuid;
  final String name;
  final String gender;
  final String phone;

  Customer({
    required this.id,
    required this.uuid,
    required this.name,
    required this.gender,
    required this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"],
        gender: json["gender"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
        "gender": gender,
        "phone": phone,
      };
}
