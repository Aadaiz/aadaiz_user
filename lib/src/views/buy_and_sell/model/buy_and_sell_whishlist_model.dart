
import 'dart:convert';

class BuyAndSellWishlistModel {
  bool? status;
  WishlistProducts? products;
  String? message;

  BuyAndSellWishlistModel({this.status, this.products, this.message});

  factory BuyAndSellWishlistModel.fromJson(String str) =>
      BuyAndSellWishlistModel.fromMap(json.decode(str));

  factory BuyAndSellWishlistModel.fromMap(Map<String, dynamic> json) =>
      BuyAndSellWishlistModel(
        status: json["status"],
        products: json["products"] == null
            ? null
            : WishlistProducts.fromMap(json["products"]),
        message: json["message"],
      );
}

class WishlistProducts {
  List<WishlistDatum>? data;

  WishlistProducts({this.data});

  factory WishlistProducts.fromMap(Map<String, dynamic> json) =>
      WishlistProducts(
        data: json["data"] == null
            ? []
            : List<WishlistDatum>.from(
            json["data"]!.map((x) => WishlistDatum.fromMap(x))),
      );
}

class WishlistDatum {
  int? id;
  String? productName;
  String? subProductName;
  String? category;
  String? description;
  String? price;
  String? size;
  WishlistLocation? location;
  WishlistImages? images;
  bool? inCart;

  WishlistDatum({
    this.id,
    this.productName,
    this.subProductName,
    this.category,
    this.description,
    this.price,
    this.size,
    this.location,
    this.images,
    this.inCart,
  });

  factory WishlistDatum.fromMap(Map<String, dynamic> json) => WishlistDatum(
    id: json["id"],
    productName: json["product_name"],
    subProductName: json["sub_product_name"],
    category: json["category"],
    description: json["description"],
    price: json["price"],
    size: json["size"],
    location: json["location"] == null
        ? null
        : WishlistLocation.fromMap(json["location"]),
    images: json["images"] == null
        ? null
        : WishlistImages.fromMap(json["images"]),
    inCart: json["in_cart"],
  );
}

class WishlistLocation {
  String? area;
  String? city;
  String? state;
  String? country;
  String? pincode;

  WishlistLocation({this.area, this.city, this.state, this.country, this.pincode});

  factory WishlistLocation.fromMap(Map<String, dynamic> json) =>
      WishlistLocation(
        area: json["area"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pincode: json["pincode"],
      );
}

class WishlistImages {
  String? main;
  String? front;
  String? back;

  WishlistImages({this.main, this.front, this.back});

  factory WishlistImages.fromMap(Map<String, dynamic> json) => WishlistImages(
    main: json["main"],
    front: json["front"],
    back: json["back"],
  );
}