class OrdersData {
    final bool status;
    final Data? data;
    final String? message;

    OrdersData({
        required this.status,
        this.data,
        this.message,
    });

    factory OrdersData.fromMap(Map<String, dynamic> json) => OrdersData(
        status: json["status"] ?? false,
        data: json["data"] != null ? Data.fromMap(json["data"]) : null,
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "data": data?.toMap(),
        "message": message,
    };
}

class Data {
    final OrderList? newOrders;
    final OrderList? existingOrders;

    Data({
        this.newOrders,
        this.existingOrders,
    });

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        newOrders: json["newOrders"] != null
            ? OrderList.fromMap(json["newOrders"])
            : null,
        existingOrders: json["existingOrders"] != null
            ? OrderList.fromMap(json["existingOrders"])
            : null,
    );

    Map<String, dynamic> toMap() => {
        "newOrders": newOrders?.toMap(),
        "existingOrders": existingOrders?.toMap(),
    };
}

class OrderList {
    final int currentPage;
    final List<OrderItem> data;
    final String? firstPageUrl;
    final int? from;
    final int lastPage;
    final String? lastPageUrl;
    final List<Link> links;
    final String? nextPageUrl;
    final String path;
    final int perPage;
    final String? prevPageUrl;
    final int? to;
    final int total;

    OrderList({
        required this.currentPage,
        required this.data,
        this.firstPageUrl,
        this.from,
        required this.lastPage,
        this.lastPageUrl,
        required this.links,
        this.nextPageUrl,
        required this.path,
        required this.perPage,
        this.prevPageUrl,
        this.to,
        required this.total,
    });

    factory OrderList.fromMap(Map<String, dynamic> json) => OrderList(
        currentPage: json["current_page"] ?? 1,
        data: json["data"] != null
            ? List<OrderItem>.from(
            json["data"].map((x) => OrderItem.fromMap(x)))
            : [],
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"] ?? 1,
        lastPageUrl: json["last_page_url"],
        links: json["links"] != null
            ? List<Link>.from(json["links"].map((x) => Link.fromMap(x)))
            : [],
        nextPageUrl: json["next_page_url"],
        path: json["path"] ?? "",
        perPage: json["per_page"] ?? 10,
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"] ?? 0,
    );

    Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class OrderItem {
    final int id;
    final String orderNo;
    final String subadminId;
    final dynamic empId;
    final String customerName;
    final String contactNumber;
    final String shippingAddress;
    final String createDate;
    final String deliveryDate;
    final String productId;
    final dynamic subTotal;
    final dynamic gst;
    final dynamic gstAmount;
    final dynamic advanceAmount;
    final String pendingAmount;
    final String totalAmount;
    final dynamic paymentStatus;
    final String orderStatus;
    final String createdAt;
    final DateTime updatedAt;
    final int customerId;
    final String shopName;
    final bool isCompleted;
    final dynamic freeServiceDays; // NEW FIELD: Can be String or int
    final List<OrderProduct> newOrdersProduct;
    final List<OrderProduct> existingOrdersProduct;
    final Subadmin? subadmin; // NEW FIELD: Added subadmin object

    OrderItem({
        required this.id,
        required this.orderNo,
        required this.subadminId,
        this.empId,
        required this.customerName,
        required this.contactNumber,
        required this.shippingAddress,
        required this.createDate,
        required this.deliveryDate,
        required this.productId,
        this.subTotal,
        this.gst,
        this.gstAmount,
        this.advanceAmount,
        required this.pendingAmount,
        required this.totalAmount,
        this.paymentStatus,
        required this.orderStatus,
        required this.createdAt,
        required this.updatedAt,
        required this.customerId,
        required this.shopName,
        required this.isCompleted,
        this.freeServiceDays, // NEW FIELD
        this.newOrdersProduct = const [],
        this.existingOrdersProduct = const [],
        this.subadmin, // NEW FIELD
    });

    factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
        id: json["id"] ?? 0,
        orderNo: json["order_no"]?.toString() ?? "",
        subadminId: json["subadmin_id"]?.toString() ?? "",
        empId: json["emp_id"],
        customerName: json["customer_name"]?.toString() ?? "",
        contactNumber: json["contact_number"]?.toString() ?? "",
        shippingAddress: json["shipping_address"]?.toString() ?? "",
        createDate: json["create_date"]?.toString() ?? "",
        deliveryDate: json["delivery_date"]?.toString() ?? "",
        productId: json["product_id"]?.toString() ?? "",
        subTotal: json["sub_total"],
        gst: json["gst"],
        gstAmount: json["gst_amount"],
        advanceAmount: json["advance_amount"],
        pendingAmount: json["pending_amount"]?.toString() ?? "",
        totalAmount: json["total_amount"]?.toString() ?? "",
        paymentStatus: json["payment_status"],
        orderStatus: json["order_status"]?.toString() ?? "",
        createdAt: json["created_at"]?.toString() ?? "",
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"].toString())
            : DateTime.now(),
        customerId: json["customer_id"] ?? 0,
        shopName: json["shop_name"]?.toString() ?? "",
        isCompleted: json['is_completed'] ?? false,
        freeServiceDays: json["free_service_days"], // NEW FIELD
        newOrdersProduct: json["newOrdersProduct"] != null
            ? List<OrderProduct>.from(
            json["newOrdersProduct"].map((x) => OrderProduct.fromMap(x)))
            : [],
        existingOrdersProduct: json["existingOrdersProduct"] != null
            ? List<OrderProduct>.from(json["existingOrdersProduct"]
            .map((x) => OrderProduct.fromMap(x)))
            : [],
        subadmin: json["subadmin"] != null // NEW FIELD
            ? Subadmin.fromMap(json["subadmin"])
            : null,
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "order_no": orderNo,
        "subadmin_id": subadminId,
        "emp_id": empId,
        "customer_name": customerName,
        "contact_number": contactNumber,
        "shipping_address": shippingAddress,
        "create_date": createDate,
        "delivery_date": deliveryDate,
        "product_id": productId,
        "sub_total": subTotal,
        "gst": gst,
        "gst_amount": gstAmount,
        "advance_amount": advanceAmount,
        "pending_amount": pendingAmount,
        "total_amount": totalAmount,
        "payment_status": paymentStatus,
        "order_status": orderStatus,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "customer_id": customerId,
        "shop_name": shopName,
        'is_completed': isCompleted,
        "free_service_days": freeServiceDays, // NEW FIELD
        "newOrdersProduct":
        List<dynamic>.from(newOrdersProduct.map((x) => x.toMap())),
        "existingOrdersProduct":
        List<dynamic>.from(existingOrdersProduct.map((x) => x.toMap())),
        "subadmin": subadmin?.toMap(), // NEW FIELD
    };
}

class Subadmin {
    final int id;
    final String? adId;
    final int userId;
    final int adminId;
    final String name;
    final String? email;
    final String? fcmToken;
    final String mobile;
    final String password;
    final String? profileImage;
    final String confirmPassword;
    final int totalCallMinutes;
    final DateTime createdAt;
    final DateTime updatedAt;
    final Admin admin; // NEW FIELD: Added admin object

    Subadmin({
        required this.id,
        this.adId,
        required this.userId,
        required this.adminId,
        required this.name,
        this.email,
        this.fcmToken,
        required this.mobile,
        required this.password,
        this.profileImage,
        required this.confirmPassword,
        required this.totalCallMinutes,
        required this.createdAt,
        required this.updatedAt,
        required this.admin, // NEW FIELD
    });

    factory Subadmin.fromMap(Map<String, dynamic> json) => Subadmin(
        id: json["id"] ?? 0,
        adId: json["ad_id"]?.toString(),
        userId: json["user_id"] ?? 0,
        adminId: json["admin_id"] ?? 0,
        name: json["name"]?.toString() ?? "",
        email: json["email"]?.toString(),
        fcmToken: json["fcm_token"]?.toString(),
        mobile: json["mobile"]?.toString() ?? "",
        password: json["password"]?.toString() ?? "",
        profileImage: json["profile_image"]?.toString(),
        confirmPassword: json["confirm_password"]?.toString() ?? "",
        totalCallMinutes: json["total_call_minutes"] ?? 0,
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"].toString())
            : DateTime.now(),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"].toString())
            : DateTime.now(),
        admin: Admin.fromMap(json["admin"]), // NEW FIELD
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "ad_id": adId,
        "user_id": userId,
        "admin_id": adminId,
        "name": name,
        "email": email,
        "fcm_token": fcmToken,
        "mobile": mobile,
        "password": password,
        "profile_image": profileImage,
        "confirm_password": confirmPassword,
        "total_call_minutes": totalCallMinutes,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "admin": admin.toMap(), // NEW FIELD
    };
}

class Admin {
    final int id;
    final String name;
    final String? email;
    final String? gst;
    final String? mobile;
    final String? password;
    final String? profileImage;
    final String? fcmToken;
    final dynamic plan;
    final dynamic planType;
    final dynamic paymentToken;
    final dynamic shopName;
    final dynamic areaStreet;
    final dynamic city;
    final dynamic state;
    final dynamic country;
    final dynamic pincode;
    final DateTime createdAt;
    final DateTime updatedAt;
    final dynamic userId;
    final FreeServiceDays? freeServiceDays; // NEW FIELD

    Admin({
        required this.id,
        required this.name,
        this.email,
        this.gst,
        this.mobile,
        this.password,
        this.profileImage,
        this.fcmToken,
        this.plan,
        this.planType,
        this.paymentToken,
        this.shopName,
        this.areaStreet,
        this.city,
        this.state,
        this.country,
        this.pincode,
        required this.createdAt,
        required this.updatedAt,
        this.userId,
        this.freeServiceDays, // NEW FIELD
    });

    factory Admin.fromMap(Map<String, dynamic> json) => Admin(
        id: json["id"] ?? 0,
        name: json["name"]?.toString() ?? "",
        email: json["email"]?.toString(),
        gst: json["gst"]?.toString(),
        mobile: json["mobile"]?.toString(),
        password: json["password"]?.toString(),
        profileImage: json["profile_image"]?.toString(),
        fcmToken: json["fcm_token"]?.toString(),
        plan: json["plan"],
        planType: json["plan_type"],
        paymentToken: json["payment_token"],
        shopName: json["shop_name"],
        areaStreet: json["area_street"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pincode: json["pincode"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"].toString())
            : DateTime.now(),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"].toString())
            : DateTime.now(),
        userId: json["user_id"],
        freeServiceDays: json["free_service_days"] != null // NEW FIELD
            ? FreeServiceDays.fromMap(json["free_service_days"])
            : null,
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "gst": gst,
        "mobile": mobile,
        "password": password,
        "profile_image": profileImage,
        "fcm_token": fcmToken,
        "plan": plan,
        "plan_type": planType,
        "payment_token": paymentToken,
        "shop_name": shopName,
        "area_street": areaStreet,
        "city": city,
        "state": state,
        "country": country,
        "pincode": pincode,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
        "free_service_days": freeServiceDays?.toMap(), // NEW FIELD
    };
}

class FreeServiceDays {
    final int id;
    final String adminId;
    final String days;
    final DateTime createdAt;
    final DateTime updatedAt;

    FreeServiceDays({
        required this.id,
        required this.adminId,
        required this.days,
        required this.createdAt,
        required this.updatedAt,
    });

    factory FreeServiceDays.fromMap(Map<String, dynamic> json) => FreeServiceDays(
        id: json["id"] ?? 0,
        adminId: json["admin_id"]?.toString() ?? "",
        days: json["days"]?.toString() ?? "",
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"].toString())
            : DateTime.now(),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"].toString())
            : DateTime.now(),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "admin_id": adminId,
        "days": days,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class OrderProduct {
    final int id;
    final String productCreateId;
    final String subadminId;
    final String category;
    final StyleName? styleName;

    final String quantity;
    final String price;
    final String totalAmount;
    final String status;
    final dynamic others;
    final String? materialImage1Name;
    final String? materialImage1;
    final String? materialImage2Name;
    final String? materialImage2;
    final dynamic materialImage3Name;
    final dynamic materialImage3;
    final dynamic addImage1Name;
    final dynamic addImage1;
    final dynamic addImage2Name;
    final dynamic addImage2;
    final dynamic addImage3Name;
    final dynamic addImage3;
    final String? productImage1Name;
    final String? productImage1;
    final dynamic productImage2Name;
    final dynamic productImage2;
    final dynamic productImage3Name;
    final dynamic productImage3;
    final String requiredFullLength;
    final DateTime createdAt;
    final DateTime updatedAt;
    final bool productStatus;

    OrderProduct({
        required this.id,
        required this.productCreateId,
        required this.subadminId,
        required this.category,
        this.styleName,
        required this.quantity,
        required this.price,
        required this.totalAmount,
        required this.status,
        this.others,
        this.materialImage1Name,
        this.materialImage1,
        this.materialImage2Name,
        this.materialImage2,
        this.materialImage3Name,
        this.materialImage3,
        this.addImage1Name,
        this.addImage1,
        this.addImage2Name,
        this.addImage2,
        this.addImage3Name,
        this.addImage3,
        this.productImage1Name,
        this.productImage1,
        this.productImage2Name,
        this.productImage2,
        this.productImage3Name,
        this.productImage3,
        required this.requiredFullLength,
        required this.createdAt,
        required this.updatedAt,
        required this.productStatus,
    });


    factory OrderProduct.fromMap(Map<String, dynamic> json) => OrderProduct(
        id: json["id"] ?? 0,
        productCreateId: json["product_create_id"]?.toString() ?? "",
        subadminId: json["subadmin_id"]?.toString() ?? "",
        category: json["category"]?.toString() ?? "",

        /// 👇 style_name object handling
        styleName: json["style_name"] != null &&
            json["style_name"] is Map<String, dynamic>
            ? StyleName.fromMap(json["style_name"])
            : null,

        quantity: json["quantity"]?.toString() ?? "",
        price: json["price"]?.toString() ?? "",
        totalAmount: json["total_amount"]?.toString() ?? "",
        status: json["status"]?.toString() ?? "",
        others: json["others"],
        materialImage1Name: json["material_image_1_name"]?.toString(),
        materialImage1: json["material_image_1"]?.toString(),
        materialImage2Name: json["material_image_2_name"]?.toString(),
        materialImage2: json["material_image_2"]?.toString(),
        materialImage3Name: json["material_image_3_name"],
        materialImage3: json["material_image_3"],
        addImage1Name: json["add_image_1_name"],
        addImage1: json["add_image_1"],
        addImage2Name: json["add_image_2_name"],
        addImage2: json["add_image_2"],
        addImage3Name: json["add_image_3_name"],
        addImage3: json["add_image_3"],
        productImage1Name: json["product_image_1_name"]?.toString(),
        productImage1: json["product_image_1"]?.toString(),
        productImage2Name: json["product_image_2_name"],
        productImage2: json["product_image_2"],
        productImage3Name: json["product_image_3_name"],
        productImage3: json["product_image_3"],
        requiredFullLength: json["required_full_length"]?.toString() ?? "",
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"].toString())
            : DateTime.now(),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"].toString())
            : DateTime.now(),
        productStatus: json["product_status"] ?? false,
    );


    Map<String, dynamic> toMap() => {
        "id": id,
        "product_create_id": productCreateId,
        "subadmin_id": subadminId,
        "category": category,
        "style_name": styleName?.toMap(),
        "quantity": quantity,
        "price": price,
        "total_amount": totalAmount,
        "status": status,
        "others": others,
        "material_image_1_name": materialImage1Name,
        "material_image_1": materialImage1,
        "material_image_2_name": materialImage2Name,
        "material_image_2": materialImage2,
        "material_image_3_name": materialImage3Name,
        "material_image_3": materialImage3,
        "add_image_1_name": addImage1Name,
        "add_image_1": addImage1,
        "add_image_2_name": addImage2Name,
        "add_image_2": addImage2,
        "add_image_3_name": addImage3Name,
        "add_image_3": addImage3,
        "product_image_1_name": productImage1Name,
        "product_image_1": productImage1,
        "product_image_2_name": productImage2Name,
        "product_image_2": productImage2,
        "product_image_3_name": productImage3Name,
        "product_image_3": productImage3,
        "required_full_length": requiredFullLength,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product_status": productStatus,
    };

}
class StyleName {
    final int id;
    final String adminId;
    final String categoryType;
    final String categoryName;
    final String categoryStatus;
    final DateTime createdAt;
    final DateTime updatedAt;

    StyleName({
        required this.id,
        required this.adminId,
        required this.categoryType,
        required this.categoryName,
        required this.categoryStatus,
        required this.createdAt,
        required this.updatedAt,
    });

    factory StyleName.fromMap(Map<String, dynamic> json) => StyleName(
        id: json["id"] ?? 0,
        adminId: json["admin_id"]?.toString() ?? "",
        categoryType: json["category_type"]?.toString() ?? "",
        categoryName: json["category_name"]?.toString() ?? "",
        categoryStatus: json["category_status"]?.toString() ?? "",
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"].toString())
            : DateTime.now(),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"].toString())
            : DateTime.now(),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "admin_id": adminId,
        "category_type": categoryType,
        "category_name": categoryName,
        "category_status": categoryStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Link {
    final String? url;
    final String label;
    final bool active;

    Link({
        this.url,
        required this.label,
        required this.active,
    });

    factory Link.fromMap(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"]?.toString() ?? "",
        active: json["active"] ?? false,
    );

    Map<String, dynamic> toMap() => {
        "url": url,
        "label": label,
        "active": active,
    };
}

// Removed StyleName class since it's not needed