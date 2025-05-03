import 'dart:convert';
class OrdersData {
    bool? status;
    Data? data;
    String? message;
    OrdersData({
        this.status,
        this.data,
        this.message,
    });
    factory OrdersData.fromJson(String str) => OrdersData.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());
    factory OrdersData.fromMap(Map<String, dynamic> json) => OrdersData(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        message: json["message"],
    );
    Map<String, dynamic> toMap() => {
        "status": status,
        "data": data?.toMap(),
        "message": message,
    };
}
class Data {
    Orders? newOrders;
    Orders? existingOrders;
    Data({
        this.newOrders,
        this.existingOrders,
    });
    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());
    factory Data.fromMap(Map<String, dynamic> json) => Data(
        newOrders: json["newOrders"] == null ? null : Orders.fromMap(json["newOrders"]),
        existingOrders: json["existingOrders"] == null ? null : Orders.fromMap(json["existingOrders"]),
    );
    Map<String, dynamic> toMap() => {
        "newOrders": newOrders?.toMap(),
        "existingOrders": existingOrders?.toMap(),
    };
}
class Orders {
    int? currentPage;
    List<Datum>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    dynamic nextPageUrl;
    String? path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;
    Orders({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });
    factory Orders.fromJson(String str) => Orders.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());
    factory Orders.fromMap(Map<String, dynamic> json) => Orders(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );
    Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}
class Datum {
    int? id;
    String? empId;
    String? createdSubadminId;
    String? productId;
    String? customerName;
    String? contactNumber;
    String? customerMail;
    String? shippingAddress;
    String? category;
    String? styleName;
    dynamic shopName;
    dynamic others;
    String? deliveryDate;
    String? image1;
    String? image2;
    String? image3;
    dynamic image1Content;
    dynamic image2Content;
    dynamic image3Content;
    dynamic quantity;
    String? price;
    String? paymentType;
    String? paidAmount;
    String? createdAt;
    DateTime? updatedAt;
    List<OrdersProduct>? existingOrdersProduct;
    List<OrdersProduct>? newOrdersProduct;
    Datum({
        this.id,
        this.empId,
        this.createdSubadminId,
        this.productId,
        this.customerName,
        this.contactNumber,
        this.customerMail,
        this.shippingAddress,
        this.category,
        this.styleName,
        this.shopName,
        this.others,
        this.deliveryDate,
        this.image1,
        this.image2,
        this.image3,
        this.image1Content,
        this.image2Content,
        this.image3Content,
        this.quantity,
        this.price,
        this.paymentType,
        this.paidAmount,
        this.createdAt,
        this.updatedAt,
        this.existingOrdersProduct,
        this.newOrdersProduct,
    });
    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());
    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        empId: json["emp_id"],
        createdSubadminId: json["created_subadmin_id"],
        productId: json["product_id"],
        customerName: json["customer_name"],
        contactNumber: json["contact_number"],
        customerMail: json["customer_mail"],
        shippingAddress: json["shipping_address"],
        category: json["category"],
        styleName: json["style_name"],
        shopName: json["shop_name"],
        others: json["others"],
        deliveryDate: json["delivery_date"],
        image1: json["image_1"],
        image2: json["image_2"],
        image3: json["image_3"],
        image1Content: json["image_1_content"],
        image2Content: json["image_2_content"],
        image3Content: json["image_3_content"],
        quantity: json["quantity"],
        price: json["price"],
        paymentType: json["payment_type"],
        paidAmount: json["paid_amount"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        existingOrdersProduct: json["existingOrdersProduct"] == null ? [] : List<OrdersProduct>.from(json["existingOrdersProduct"]!.map((x) => OrdersProduct.fromMap(x))),
        newOrdersProduct: json["newOrdersProduct"] == null ? [] : List<OrdersProduct>.from(json["newOrdersProduct"]!.map((x) => OrdersProduct.fromMap(x))),
    );
    Map<String, dynamic> toMap() => {
        "id": id,
        "emp_id": empId,
        "created_subadmin_id": createdSubadminId,
        "product_id": productId,
        "customer_name": customerName,
        "contact_number": contactNumber,
        "customer_mail": customerMail,
        "shipping_address": shippingAddress,
        "category": category,
        "style_name": styleName,
        "shop_name": shopName,
        "others": others,
        "delivery_date": deliveryDate,
        "image_1": image1,
        "image_2": image2,
        "image_3": image3,
        "image_1_content": image1Content,
        "image_2_content": image2Content,
        "image_3_content": image3Content,
        "quantity": quantity,
        "price": price,
        "payment_type": paymentType,
        "paid_amount": paidAmount,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
        "existingOrdersProduct": existingOrdersProduct == null ? [] : List<dynamic>.from(existingOrdersProduct!.map((x) => x.toMap())),
        "newOrdersProduct": newOrdersProduct == null ? [] : List<dynamic>.from(newOrdersProduct!.map((x) => x.toMap())),
    };
}
class OrdersProduct {
    int? id;
    int? subadminId;
    String? name;
    String? status;
    String? image1;
    String? image2;
    String? image3;
    int? quantity;
    int? price;
    dynamic measurement;
    DateTime? createdAt;
    DateTime? updatedAt;
    bool? productStatus;
    OrdersProduct({
        this.id,
        this.subadminId,
        this.name,
        this.status,
        this.image1,
        this.image2,
        this.image3,
        this.quantity,
        this.price,
        this.measurement,
        this.createdAt,
        this.updatedAt,
        this.productStatus,
    });
    factory OrdersProduct.fromJson(String str) => OrdersProduct.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());
    factory OrdersProduct.fromMap(Map<String, dynamic> json) => OrdersProduct(
        id: json["id"],
        subadminId: json["subadmin_id"],
        name: json["name"],
        status: json["status"],
        image1: json["image_1"],
        image2: json["image_2"],
        image3: json["image_3"],
        quantity: json["quantity"],
        price: json["price"],
        measurement: json["measurement"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        productStatus: json["product_status"],
    );
    Map<String, dynamic> toMap() => {
        "id": id,
        "subadmin_id": subadminId,
        "name": name,
        "status": status,
        "image_1": image1,
        "image_2": image2,
        "image_3": image3,
        "quantity": quantity,
        "price": price,
        "measurement": measurement,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product_status": productStatus,
    };
}
class Link {
    String? url;
    String? label;
    bool? active;
    Link({
        this.url,
        this.label,
        this.active,
    });
    factory Link.fromJson(String str) => Link.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());
    factory Link.fromMap(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );
    Map<String, dynamic> toMap() => {
        "url": url,
        "label": label,
        "active": active,
    };
}