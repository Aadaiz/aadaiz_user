import 'dart:convert';
import 'dart:developer';

import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/category_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/category_list_model.dart'
    as material;
import 'package:aadaiz_customer_crm/src/views/material/model/filter_category.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/material_cart_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/material_category_model.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/material_category_model.dart'
    as category;
import 'package:aadaiz_customer_crm/src/views/material/model/material_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/material_repository.dart';

class MaterialController extends GetxController {
  static MaterialController get to => Get.put(MaterialController());
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCart();
  }

  var repo = MaterialRepository();

  final currentPage = 1.obs;
  final totalPages = 1.obs;
  var materialList = <material.Datum>[].obs;
  var likeList = [].obs;
  var peopleMostViewList = <material.Datum>[].obs;
  var materialLoading = false.obs;

  var price = 'low_to_high'.obs;

  // Add these variables to track cart quantities
  var itemQuantities = <String, int>{}.obs; // Map to store itemId -> quantity
  var cartItems = <String>{}.obs; // Set to track which items are in cart

  Future<dynamic> getMaterials({
    bool isRefresh = false,
    dynamic search,
    dynamic color,
    dynamic category,
    dynamic minPrice,
    dynamic maxPrice,
    dynamic rating,
  }) async {

    if (isRefresh) {
      currentPage.value = 1;
    } else {
      currentPage.value++;
    }
    materialLoading(true);
    final MaterialListRes res = await repo.getMaterialList(
      page: currentPage.value,
      search: search,
      priceLowHigh: price.value,
      color: color,
      category: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
      rating: rating,
    );
    if (res.status == true) {
      materialLoading(false);
      if (res.materialList!.data!.isNotEmpty) {
        peopleMostViewList.value = res.peopleMostViewlist!;
        if (isRefresh) {
          materialList.value = res.materialList!.data!;
          likeList.value = List.generate(
            materialList.value.length,
            (i) => materialList.value[i].isLiked == 0 ? false : true ?? false,
          );
        } else {
          final newItems = res.materialList!.data! ?? [];
          materialList.addAll(newItems);
          likeList.value = List.generate(
            materialList.value.length,
            (i) => materialList.value[i].isLiked == 0 ? false : true ?? false,
          );
        }
      }
    } else {
      materialList.clear();
    }
    return true;
  }

  var orderLoading = false.obs;

  var categoryList = <category.Fabric>[].obs;
  var filterLoading = false.obs;
  var filterListCategories = <Category>[].obs;
  var filterListColors = <String>[].obs;

  getFilterCategory() async {
    filterLoading(true);
    final FilterCategory res = await repo.getFilterCategory();
    filterLoading(false);

    if (res.status == true) {
      filterListCategories.value = res.categories ?? [];
      filterListColors.value = res.colors ?? [];
    } else {
      filterListCategories.clear();
      filterListColors.clear();
    }
  }

  getCategory() async {
    orderLoading(true);
    final MaterialCategoryListRes res = await repo.getMaterialCategory();
    orderLoading(false);
    if (res.success == true) {
      categoryList.value = res.fabric!;
    } else {
      categoryList.clear();
    }
  }

  TextEditingController length = TextEditingController();
  var cartLoading = false.obs;
  var addLoading = false.obs;

  Future<dynamic> addToCart({id, quantity}) async {
    addLoading(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final Map body = {'material_id': id, 'quantity': quantity, 'token': token};
    print('Add to cart body: $body');
    final MaterialRes res = await repo.addToCart(body: jsonEncode(body));
    addLoading(false);

    if (res.success == true) {
      // Add item to cart tracking
      cartItems.add(id.toString());
      itemQuantities[id.toString()] = quantity ?? 1;
      CommonToast.show(msg: res.message);
    } else {
      CommonToast.show(msg: res.message);
    }

    // Refresh cart list
    await getCart();
  }

  var cartListLoading = false.obs;
  var cartList = MaterialCartListRes().data.obs;

  Future<dynamic> getCart({couponCode}) async {
    cartListLoading(true);
    final MaterialCartListRes res = await repo.getCart(couponCode: couponCode);
    cartListLoading(false);
    if (res.success == true) {
      cartList.value = res.data;

      // Update local cart tracking from API response
      if (cartList.value?.items != null) {
        itemQuantities.clear();
        cartItems.clear();

        for (var item in cartList.value!.items!) {
          // Get product ID from the nested product object
          final productId = item.product?.id?.toString();
          if (productId != null) {
            cartItems.add(productId);
            // Store the actual quantity from API response
            itemQuantities[productId] = item.quantity ?? 1;
          }
        }
        print('Updated cart quantities from API: $itemQuantities');
      }
    } else {
      // Clear cart tracking if API fails
      itemQuantities.clear();
      cartItems.clear();
    }
  }

  // Helper methods for cart management

  // Check if item is in cart
  bool isItemInCart(dynamic itemId) {
    return cartItems.contains(itemId.toString());
  }

  // Get item quantity from cart
  int getItemQuantity(dynamic itemId) {
    return itemQuantities[itemId.toString()] ?? 1;
  }

  // Get CartItem by product ID
  CartItem? getCartItemByProductId(dynamic productId) {
    if (cartList.value?.items == null) return null;

    return cartList.value!.items!.firstWhere(
      (item) => item.product?.id?.toString() == productId.toString(),
    );
  }

  // Get total items count (sum of all quantities)
  int getTotalItemsCount() {
    int total = 0;
    itemQuantities.forEach((key, value) {
      total += value;
    });
    return total;
  }

  // ====== QUANTITY UPDATE METHODS ======

  // Increment quantity immediately and call API
  Future<void> incrementQuantity(dynamic itemId) async {
    final int currentQty = getItemQuantity(itemId);
    // Since API adds quantity, we only send 1 to increment by 1
    final int quantityToSend = 1;

    // Update immediately in UI - add 1 locally
    final int newQty = currentQty + 1;
    itemQuantities[itemId.toString()] = newQty;
    update(); // Notify listeners

    // Call API to update in backend - send only 1
    await _updateQuantityInBackend(itemId, quantityToSend);
  }

  // Decrement quantity immediately and call API
  Future<void> decrementQuantity(dynamic itemId) async {
    final int currentQty = getItemQuantity(itemId);
    if (currentQty <= 1) {
      // Remove from cart if quantity is 1 or less
      await _removeItemFromCart(itemId);
      return;
    }

    // Since API adds quantity, we send -1 to decrement
    final int quantityToSend = -1;

    // Update immediately in UI - subtract 1 locally
    final int newQty = currentQty - 1;
    itemQuantities[itemId.toString()] = newQty;
    update(); // Notify listeners

    // Call API to update in backend - send -1
    await _updateQuantityInBackend(itemId, quantityToSend);
  }

  // Private method to update quantity in backend
  Future<void> _updateQuantityInBackend(
    dynamic itemId,
    int quantityChange,
  ) async {
    cartLoading(true);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final Map body = {
        'material_id': itemId,
        'quantity': quantityChange, // Send only the change (+1 or -1)
        'token': token,
      };

      print('Updating quantity change: $body');

      final MaterialRes res = await repo.addToCart(body: jsonEncode(body));

      if (res.success == true) {
        // Refresh cart to get updated totals
        await getCart();

        // Show appropriate message
        if (quantityChange > 0) {
          CommonToast.show(msg: 'Quantity increased');
        } else if (quantityChange < 0) {
          CommonToast.show(msg: 'Quantity decreased');
        }
      } else {
        CommonToast.show(msg: res.message);
        // If API fails, revert to previous state by refreshing
        await getCart(); // Refresh to get correct state from server
      }
    } catch (e) {
      CommonToast.show(msg: 'Failed to update quantity');
      // If error, refresh to get correct state
      await getCart();
    } finally {
      cartLoading(false);
    }
  }

  // Private method to remove item from cart
  Future<void> _removeItemFromCart(dynamic itemId) async {
    // Remove immediately from UI
    cartItems.remove(itemId.toString());
    itemQuantities.remove(itemId.toString());
    update(); // Notify listeners

    cartLoading(true);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      // Since API adds quantity, to remove completely we need to send negative of current quantity
      final int currentQty = getItemQuantity(itemId);
      final int quantityToRemove = -currentQty;

      final Map body = {
        'material_id': itemId,
        'quantity': quantityToRemove, // Send negative of current quantity
        'token': token,
      };

      print('Removing item: $body');

      final MaterialRes res = await repo.addToCart(body: jsonEncode(body));

      if (res.success == true) {
        CommonToast.show(msg: 'Item removed from cart');
        // Refresh cart list
        await getCart();
      } else {
        CommonToast.show(msg: res.message);
        // If fails, refresh to get correct state
        await getCart();
      }
    } catch (e) {
      CommonToast.show(msg: 'Failed to remove item ${e.toString()}');
      log('Failed to remove item ${e.toString()}');
      // If error, refresh to get correct state
      await getCart();
    } finally {
      cartLoading(false);
    }
  }

  // Public method to remove item from cart (completely)
  Future<void> removeFromCart(dynamic itemId) async {
    await _removeItemFromCart(itemId);
  }

  // Get cart summary for display
  Map<String, dynamic> getCartSummary() {
    if (cartList.value == null) {
      return {
        'subtotal': 0.0,
        'discounts': 0.0,
        'taxAndCharges': 0.0,
        'deliveryCharges': 0.0,
        'total': 0.0,
      };
    }

    return {
      'subtotal': cartList.value!.subtotal?.toDouble() ?? 0.0,
      'discounts': cartList.value!.discounts?.toDouble() ?? 0.0,
      'taxAndCharges': cartList.value!.taxAndCharges?.toDouble() ?? 0.0,
      'deliveryCharges': cartList.value!.deliveryCharges?.toDouble() ?? 0.0,
      'total': cartList.value!.total?.toDouble() ?? 0.0,
    };
  }

  // Get product from cart by index
  Product? getProductAtIndex(int index) {
    if (cartList.value?.items == null ||
        cartList.value!.items!.length <= index) {
      return null;
    }
    return cartList.value!.items![index].product;
  }

  // Get quantity from cart by index
  int getQuantityAtIndex(int index) {
    if (cartList.value?.items == null ||
        cartList.value!.items!.length <= index) {
      return 1;
    }
    return cartList.value!.items![index].quantity ?? 1;
  }

  // Update addToCart method to handle quantity properly
  Future<dynamic> addToCartWithQuantity({id, quantity}) async {
    cartLoading(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    // Check if item is already in cart
    final bool isInCart = isItemInCart(id);
    int quantityToSend = quantity;

    if (isInCart) {
      // If item is already in cart, send only the additional quantity
      final int currentQty = getItemQuantity(id);
      quantityToSend = quantity - currentQty;
    }

    final Map body = {
      'material_id': id,
      'quantity': quantityToSend,
      'token': token,
    };

    print('Add to cart with quantity body: $body');
    final MaterialRes res = await repo.addToCart(body: jsonEncode(body));
    cartLoading(false);

    if (res.success == true) {
      // Update local tracking
      cartItems.add(id.toString());
      itemQuantities[id.toString()] = quantity;
      CommonToast.show(msg: res.message);

      // Refresh cart list
      await getCart();
    } else {
      CommonToast.show(msg: res.message);
    }
  }
}
