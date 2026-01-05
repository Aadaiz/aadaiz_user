import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/home/controller/home_controller.dart';
import 'package:aadaiz_customer_crm/src/views/material/controller/material_controller.dart';
import 'package:aadaiz_customer_crm/src/views/order/material_cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

class MaterialDetails extends StatefulWidget {
  const MaterialDetails({super.key, this.data, required this.rating ,required this.index});
  final dynamic data;
  final double rating;
  final int index;

  @override
  State<MaterialDetails> createState() => _MaterialDetailsState();
}

class _MaterialDetailsState extends State<MaterialDetails> {
  final List<String> _fabric = ["5", "10"];
  String size = '';
  String displayImage = '';
  int selected = 0;
  List images = [];
  final TextEditingController _quantityController = TextEditingController();

  // Track if cart is loaded
  bool _cartLoaded = false;

   int cartQuantity=0;

  bool isInCart=false;



  @override
  void initState() {
    super.initState();
    images = widget.data!.image.split(',');
    displayImage = images[0];
    HomeController.to.cartLoading(false);
    MaterialController.to.cartLoading(false);

    // Set initial quantity to 1
    _quantityController.text = '1';

    // Load cart data when screen opens
    _loadCartData();

    Future.delayed(const Duration(milliseconds: 500), () {
      HomeController.to.getReviewList(
        isRefresh: true,
        value: 'material_id',
        id: widget.data!.id,
      );
    });
  }

  // Method to load cart data
  Future<void> _loadCartData() async {
    try {
      await MaterialController.to.getCart();
      _cartLoaded = true;
setState(() {
  isInCart = MaterialController.to.isItemInCart(widget.data.id);
});
      // Check if current product is in cart and set quantity

      if (isInCart) {
        setState(() {
          cartQuantity = MaterialController.to.getItemQuantity(widget.data.id);
          _quantityController.text = cartQuantity.toString();

        });


      }
    } catch (e) {
      print('Error loading cart: $e');

          }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  // Helper method to get cart quantity for this product
  int _getCartQuantity() {
    if (!_cartLoaded || MaterialController.to.cartList.value == null) {
      return 0;
    }

    // Find this product in cart items
    var cartItems = MaterialController.to.cartList.value!.items;
    if (cartItems == null || cartItems.isEmpty) {
      return 0;
    }

    for (var cartItem in cartItems) {
      if (cartItem.product?.id == widget.data.id) {
        return cartItem.quantity ?? 0;
      }
    }

    return 0;
  }

  // Helper method to check if product is in cart
  bool _isProductInCart() {
    return _getCartQuantity() > 0;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.016),
            child: Image.asset('assets/images/back.png'),
          ),
        ),
        actions: [
          // Cart Icon with badge
          Obx(() {
            int cartCount = MaterialController.to.getTotalItemsCount();
            return Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MaterialCart(),
                      ),
                    );
                  },
                  icon: Image.asset(
                    'assets/images/bag.png',
                    height: screenHeight * 0.025,
                  ),
                ),
                if (cartCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        cartCount.toString(),
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          }),
          SizedBox(width: screenWidth * 0.02),
        ],
        shadowColor: AppColor.black,
        forceMaterialTransparency: false,
        elevation: 4,
      ),
      body: Obx(() {
        bool isLoading = MaterialController.to.cartLoading.value;

        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Images Section
                  SizedBox(height: screenHeight * 0.01),
                  // Main Product Image
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          height: screenHeight * 0.28,
                          width: screenWidth * 0.9,
                          decoration: BoxDecoration(
                            color: AppColor.productBgColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: displayImage,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                color: Colors.grey,
                                size: screenHeight * 0.1,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 5,
                            right: 5,
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  widget.data.isLiked = widget.data.isLiked == 0 ? 1 : 0;
                                  MaterialController.to.likeList[widget.index];
                                });
                                 HomeController.to.addFavorite('material_id', widget.data.id);
                                MaterialController.to
                                    .getMaterials(isRefresh: true);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      shape: BoxShape.circle
                                  ),
                                  padding: const EdgeInsets.all(6),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 8,
                                    child: widget.data.isLiked==1
                                        ? Icon(
                                      Icons.favorite,
                                      size: 2.0.hp,
                                      color: AppColor.red,
                                    )
                                        : Icon(
                                      Icons.favorite_border_rounded,
                                      size: 2.0.hp,
                                      color: AppColor.greyTitleColor,
                                    ),
                                  )
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Thumbnail Images
                  SizedBox(
                    height: screenHeight * 0.09,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? screenWidth * 0.05 : 8,
                            right: index == images.length - 1
                                ? screenWidth * 0.05
                                : 0,
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                displayImage = images[index];
                                selected = index;
                              });
                            },
                            child: Container(
                              width: screenHeight * 0.08,
                              height: screenHeight * 0.08,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selected == index
                                      ? AppColor.primary
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: CachedNetworkImage(
                                  imageUrl: images[index],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Product Info Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.data!.title ?? '',
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.00.sp,
                                      color: AppColor.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: screenHeight * 0.005),
                                  Text(
                                    widget.data!.subtitle ?? '',
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.00.sp,
                                      color: AppColor.subTitleColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '₹${widget.data!.price ?? ''}',
                                  style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24.00.sp,
                                    color: AppColor.primary,
                                  ),
                                ),
                                if (widget.data!.aadaizPrice != null &&
                                    widget.data!.aadaizPrice != widget.data!.price)
                                  Text(
                                    '₹${widget.data!.aadaizPrice}',
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.00.sp,
                                      color: AppColor.subTitleColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        // Rating
                        Row(
                          children: [
                            RatingBar(
                              initialRating: widget.rating,
                              direction: Axis.horizontal,
                              ignoreGestures: true,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 18,
                              unratedColor: Colors.grey[300],
                              ratingWidget: RatingWidget(
                                full: const Icon(
                                  Icons.star_rounded,
                                  color: Color(0xffFFA800),
                                ),
                                half: const Icon(
                                  Icons.star_half_rounded,
                                  color: Color(0xffFFA800),
                                ),
                                empty: const Icon(
                                  Icons.star_outline_rounded,
                                  color: Color(0xffFFA800),
                                ),
                              ),
                              onRatingUpdate: (value) {},
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              'View Review',
                              style: GoogleFonts.dmSans(
                                fontSize: 12.00.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColor.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.025),
                       if(cartQuantity!=0||isInCart)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Required Quantity',
                              style: GoogleFonts.dmSans(
                                fontSize: 14.00.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColor.black,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              children: [
                                // Quantity Controls
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColor.primary,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Minus Button
                                      InkWell(
                                        onTap: isLoading
                                            ? null
                                            : () async {
                                          bool isInCart = _isProductInCart();
                                          if (isInCart) {
                                            // If item is in cart, use controller method
                                            await MaterialController.to
                                                .decrementQuantity(widget.data.id);
                                          } else {
                                            // If not in cart, just update local controller
                                            int currentQty = int.tryParse(
                                                _quantityController.text) ??
                                                1;
                                            if (currentQty > 1) {
                                              setState(() {
                                                _quantityController.text =
                                                    (currentQty - 1).toString();
                                              });
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: screenWidth * 0.1,
                                          height: screenHeight * 0.045,
                                          decoration: BoxDecoration(
                                            color: AppColor.primary,
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(7),
                                              bottomLeft: Radius.circular(7),
                                            ),
                                          ),
                                          child: isLoading
                                              ? const Center(
                                            child: SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                              : const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      // Quantity Display
                                      Container(
                                        width: screenWidth * 0.12,
                                        height: screenHeight * 0.045,
                                        color: Colors.white,
                                        alignment: Alignment.center,
                                        child: Obx(() {
                                          bool isInCart = MaterialController.to
                                              .isItemInCart(widget.data.id);
                                          int cartQuantity = MaterialController.to
                                              .getItemQuantity(widget.data.id);

                                          return Text(
                                            isInCart
                                                ? '$cartQuantity'
                                                : _quantityController.text,
                                            style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.00.sp,
                                              color: AppColor.black,
                                            ),
                                          );
                                        }),
                                      ),
                                      // Plus Button
                                      InkWell(
                                        onTap: isLoading
                                            ? null
                                            : () async {
                                          bool isInCart = _isProductInCart();
                                          if (isInCart) {
                                            // If item is in cart, use controller method
                                            await MaterialController.to
                                                .incrementQuantity(widget.data.id);
                                          } else {
                                            // If not in cart, just update local controller
                                            int currentQty = int.tryParse(
                                                _quantityController.text) ??
                                                1;
                                            setState(() {
                                              _quantityController.text =
                                                  (currentQty + 1).toString();
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: screenWidth * 0.1,
                                          height: screenHeight * 0.045,
                                          decoration: BoxDecoration(
                                            color: AppColor.primary,
                                            borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(7),
                                              bottomRight: Radius.circular(7),
                                            ),
                                          ),
                                          child: isLoading
                                              ? const Center(
                                            child: SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                              : const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                // Quantity Input Field
                                Expanded(
                                  child: Obx(() {
                                    bool isInCart = MaterialController.to
                                        .isItemInCart(widget.data.id);

                                    // Get quantity from cart if item is in cart
                                    int cartQuantity = _getCartQuantity();

                                    // Sync text field with cart quantity
                                    if (isInCart && _quantityController.text != cartQuantity.toString()) {
                                      _quantityController.text = cartQuantity.toString();
                                    }

                                    return TextFormField(
                                      controller: _quantityController,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      readOnly: isInCart,
                                      onChanged: (value) {
                                        if (value.isEmpty) {
                                          _quantityController.text = '1';
                                        } else {
                                          int qty = int.tryParse(value) ?? 1;
                                          if (qty < 1) {
                                            _quantityController.text = '1';
                                          }
                                        }
                                      },
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: isInCart
                                            ? 'In Cart'
                                            : 'Enter quantity',
                                        hintStyle: GoogleFonts.dmSans(
                                          color: isInCart
                                              ? AppColor.primary
                                              : AppColor.black.withOpacity(0.5),
                                          fontSize: 12.00.sp,
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: isInCart
                                                ? AppColor.primary
                                                : AppColor.black.withOpacity(0.3),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: isInCart
                                                ? AppColor.primary
                                                : AppColor.black.withOpacity(0.3),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: AppColor.primary,
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        // Description
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.00.sp,
                                color: AppColor.black,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              widget.data!.description ?? '',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.00.sp,
                                color: AppColor.subTitleColor,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Action Buttons Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Share Button
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: screenHeight * 0.055,
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      // Share functionality
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.share,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        Text(
                                          'Share',
                                          style: GoogleFonts.dmSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.00.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.03),
                            // Add to Cart / View Cart Button
                            Expanded(
                              flex: 2,
                              child: Obx(() {
                                bool isInCart = MaterialController.to
                                    .isItemInCart(widget.data.id);
                                bool isLoading = MaterialController.to.cartLoading.value;

                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: isLoading
                                        ? null
                                        : () async {
                                      if (isInCart) {
                                        // Navigate to cart
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                            const MaterialCart(),
                                          ),
                                        );
                                      } else {
                                        // Add to cart
                                        int quantity = int.tryParse(
                                            _quantityController.text) ??
                                            1;
                                        if (quantity <= 0) {
                                          CommonToast.show(
                                              msg: 'Please enter a valid quantity');
                                          return;
                                        }

                                        // Use addToCart method (not addToCartWithQuantity)
                                        await MaterialController.to.addToCart(
                                          id: widget.data.id,
                                          quantity: quantity,
                                        );
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      height: screenHeight * 0.055,
                                      decoration: BoxDecoration(
                                        color: isInCart
                                            ? AppColor.primary
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: isInCart
                                              ? AppColor.primary
                                              : AppColor.black,
                                          width: 2,
                                        ),
                                      ),
                                      child: isLoading
                                          ? Center(
                                        child: LoadingAnimationWidget
                                            .horizontalRotatingDots(
                                          color: isInCart
                                              ? Colors.white
                                              : AppColor.primary,
                                          size: 30,
                                        ),
                                      )
                                          : Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            isInCart
                                                ? Icons.shopping_cart_checkout
                                                : Icons.shopping_cart_outlined,
                                            color: isInCart
                                                ? Colors.white
                                                : AppColor.black,
                                            size: 20,
                                          ),
                                          SizedBox(
                                              width: screenWidth * 0.02),
                                          Text(
                                            isInCart
                                                ? 'View in Cart'
                                                : 'Add to Cart',
                                            style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.00.sp,
                                              color: isInCart
                                                  ? Colors.white
                                                  : AppColor.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.03),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Loading overlay

          ],
        );
      }),
    );
  }
}