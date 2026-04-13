import 'dart:convert';

class BuyAndSellListModel {
  bool? status;
  OurProductsClass? ourProducts;
  OurProductsClass? products;
  Products? purchasedProducts;
  Products? orderProducts;
  String? message;

  BuyAndSellListModel({
    this.status,
    this.ourProducts,
    this.products,
    this.purchasedProducts,
    this.orderProducts,
    this.message,
  });

  factory BuyAndSellListModel.fromJson(String str) => BuyAndSellListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BuyAndSellListModel.fromMap(Map<String, dynamic> json) => BuyAndSellListModel(
    status: json["status"],
    ourProducts: json["our_products"] == null ? null : OurProductsClass.fromMap(json["our_products"]),
    products: json["products"] == null ? null : OurProductsClass.fromMap(json["products"]),
    purchasedProducts: json["purchased_products"] == null ? null : Products.fromMap(json["purchased_products"]),
    orderProducts: json["order_products"] == null ? null : Products.fromMap(json["order_products"]),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "our_products": ourProducts?.toMap(),
    "products": products?.toMap(),
    "purchased_products": purchasedProducts?.toMap(),
    "order_products": orderProducts?.toMap(),
    "message": message,
  };
}

class Products {
  List<OrderProductsDatum>? data;
  Pagination? pagination;

  Products({
    this.data,
    this.pagination,
  });

  factory Products.fromJson(String str) => Products.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Products.fromMap(Map<String, dynamic> json) => Products(
    data: json["data"] == null ? [] : List<OrderProductsDatum>.from(json["data"]!.map((x) => OrderProductsDatum.fromMap(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromMap(json["pagination"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "pagination": pagination?.toMap(),
  };
}

class OrderProductsDatum {
  int? orderId;
  String? productName;
  String? price;
  Images? images;
  Buyer? buyer;
  String? status;
  bool? isCancelled;
  dynamic awbCode;

  OrderProductsDatum({
    this.orderId,
    this.productName,
    this.price,
    this.images,
    this.buyer,
    this.status,
    this.isCancelled,
    this.awbCode,
  });

  factory OrderProductsDatum.fromJson(String str) => OrderProductsDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderProductsDatum.fromMap(Map<String, dynamic> json) => OrderProductsDatum(
    orderId: json["order_id"],
    productName: json["product_name"],
    price: json["price"],
    images: json["images"] == null ? null : Images.fromMap(json["images"]),
    buyer: json["buyer"] == null ? null : Buyer.fromMap(json["buyer"]),
    status: json["status"],
    isCancelled: json["is_cancelled"],
    awbCode: json["awb_code"],
  );

  Map<String, dynamic> toMap() => {
    "order_id": orderId,
    "product_name": productName,
    "price": price,
    "images": images?.toMap(),
    "buyer": buyer?.toMap(),
    "status": status,
    "is_cancelled": isCancelled,
    "awb_code": awbCode,
  };
}

class Buyer {
  int? id;
  String? name;
  String? email;

  Buyer({
    this.id,
    this.name,
    this.email,
  });

  factory Buyer.fromJson(String str) => Buyer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Buyer.fromMap(Map<String, dynamic> json) => Buyer(
    id: json["id"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
  };
}

class Pagination {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  Pagination({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  factory Pagination.fromJson(String str) => Pagination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    perPage: json["per_page"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "last_page": lastPage,
    "per_page": perPage,
    "total": total,
  };
}

class OurProductsClass {
  List<OurProductsDatum>? data;
  Pagination? pagination;

  OurProductsClass({
    this.data,
    this.pagination,
  });

  factory OurProductsClass.fromJson(String str) => OurProductsClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OurProductsClass.fromMap(Map<String, dynamic> json) => OurProductsClass(
    data: json["data"] == null ? [] : List<OurProductsDatum>.from(json["data"]!.map((x) => OurProductsDatum.fromMap(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromMap(json["pagination"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "pagination": pagination?.toMap(),
  };
}

class OurProductsDatum {
  int? id;
  String? productName;
  String? subProductName;
  String? category;
  dynamic subCategory;
  String? product;
  String? description;
  String? price;
  String? size;
  Location? location;
  Images? images;
  bool? inCart;
  bool? isWishlisted;



  OurProductsDatum({
    this.id,
    this.productName,
    this.subProductName,
    this.category,
    this.subCategory,
    this.product,
    this.description,
    this.price,
    this.size,
    this.location,
    this.images,
    this.inCart,
    this.isWishlisted,
  });

  factory OurProductsDatum.fromJson(String str) => OurProductsDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OurProductsDatum.fromMap(Map<String, dynamic> json) => OurProductsDatum(
    id: json["id"],
    productName: json["product_name"],
    subProductName: json["sub_product_name"],
    category: json["category"],
    subCategory: json["sub_category"],
    product: json["product"],
    description: json["description"],
    price: json["price"],
    size: json["size"],
    location: json["location"] == null ? null : Location.fromMap(json["location"]),
    images: json["images"] == null ? null : Images.fromMap(json["images"]),
    inCart: json["in_cart"],
    isWishlisted: json["is_wishlisted"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_name": productName,
    "sub_product_name": subProductName,
    "category": category,
    "sub_category": subCategory,
    "product": product,
    "description": description,
    "price": price,
    "size": size,
    "location": location?.toMap(),
    "images": images?.toMap(),
    "in_cart": inCart,
    "is_wishlisted": isWishlisted,
  };
}

class Images {
  String? main;
  String? front;
  String? back;

  Images({
    this.main,
    this.front,
    this.back,
  });

  factory Images.fromJson(String str) => Images.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Images.fromMap(Map<String, dynamic> json) => Images(
    main: json["main"],
    front: json["front"],
    back: json["back"],
  );

  Map<String, dynamic> toMap() => {
    "main": main,
    "front": front,
    "back": back,
  };
}

class Location {
  String? area;
  String? city;
  String? state;
  String? country;
  String? pincode;

  Location({
    this.area,
    this.city,
    this.state,
    this.country,
    this.pincode,
  });

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
    area: json["area"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    pincode: json["pincode"],
  );

  Map<String, dynamic> toMap() => {
    "area": area,
    "city": city,
    "state": state,
    "country": country,
    "pincode": pincode,
  };
}
