import 'package:flutter/material.dart';
import '../entities/Product.dart';
import '../shared/colors.dart';
import '../shared/styles.dart';
import '../entities/CartItems.dart';

Widget foodItem(Product food,
    {double? imgWidth, onLike, onTapped, bool isProductPage = false}) {
  return GestureDetector(
      onTap: onTapped, // 将 onTapped 绑定到 GestureDetector
      child: Container(
        width: 180,
        height: 240,
        margin: EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // 阴影偏移
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 图片
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                child: Image.asset(
                  food.image,
                  width: 180,
                  fit: BoxFit.cover, // 确保图片占满空间
                ),
              ),
            ),
            Container(
              height: 1, // 分割线高度
              margin: EdgeInsets.symmetric(horizontal: 8), // 左右间距
              decoration: BoxDecoration(
                color: Colors.grey.shade300, // 分割线颜色
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // 阴影颜色
                    spreadRadius: 1, // 阴影扩散范围
                    blurRadius: 3, // 阴影模糊半径
                    offset: Offset(0, 2), // 阴影偏移
                  ),
                ],
              ),
            ),
            // 文字
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(food.name, style: foodNameText),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$"+food.price.toStringAsFixed(2), style: priceText),
                      TextButton(
                        onPressed: () {
                          // 处理购物车点击事件
                          Cartitems.addToCart(food, 1); // 添加商品到购物车
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text('${product.name} added to cart')),
                          // );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(8),
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
}
