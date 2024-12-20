import 'package:flutter/material.dart';
import '../entities/Product.dart';
import '../shared/colors.dart';
import '../shared/styles.dart';
import '../entities/CartItems.dart';
import 'dart:convert';  // 导入base64解码库
import 'dart:typed_data';  // 导入Uint8List

Widget foodItem(Product food,
    {double? imgWidth, onLike, onTapped, bool isProductPage = false}) {
  return GestureDetector(
    onTap: onTapped, // 将 onTapped 绑定到 GestureDetector
    child: Container(
      width: 180,
      height: 300, // 调整高度以容纳大拇指图标
      margin: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // 阴影偏移
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 大拇指图标占一行
          Row(
            mainAxisAlignment: MainAxisAlignment.end, // 图标靠右
            children: [
              IconButton(
                icon: Icon(
                  Icons.thumb_up,
                  color: food.isRecommended == true ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  if (onLike != null) {
                    onLike();
                  }
                },
              ),
            ],
          ),
          // 图片
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
              child: food.image != null && food.image!.isNotEmpty
                  ? food.image!.endsWith('.png') || food.image!.endsWith('.jpg') // 判断是否是 asset 路径
                  ? Image.asset(
                food.image!,
                width: 180,
                fit: BoxFit.cover, // 确保图片占满空间
              )
                  : food.image!.startsWith('http') // 判断是否是网络图片 URL
                  ? Image.network(
                food.image!,
                width: 180,
                fit: BoxFit.cover,
              )
                  : Image.memory( // 否则直接尝试解码 Base64
                base64Decode(food.image!),
                width: 180,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                'assets/placeholder_image.png', // 加载占位符图片
                width: 180,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 分割线
          Container(
            height: 1, // 分割线高度
            margin: const EdgeInsets.symmetric(horizontal: 8), // 左右间距
            decoration: BoxDecoration(
              color: Colors.grey.shade300, // 分割线颜色
            ),
          ),
          // 文字和购物车图标
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(food.name, style: foodNameText),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$${food.price.toStringAsFixed(2)}",
                        style: priceText),
                    TextButton(
                      onPressed: () {
                        // 处理购物车点击事件
                        Cartitems.addToCart(food, 1); // 添加商品到购物车
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(8),
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
    ),
  );
}


// Widget foodItem(Product food,
//     {double? imgWidth, onLike, onTapped, bool isProductPage = false}) {
//   return GestureDetector(
//       onTap: onTapped, // 将 onTapped 绑定到 GestureDetector
//       child: Container(
//         width: 180,
//         height: 240,
//         margin: EdgeInsets.only(left: 20),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: Offset(0, 3), // 阴影偏移
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 图片
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
//                 child: Image.asset(
//                   food.image,
//                   width: 180,
//                   fit: BoxFit.cover, // 确保图片占满空间
//                 ),
//               ),
//             ),
//             Container(
//               height: 1, // 分割线高度
//               margin: EdgeInsets.symmetric(horizontal: 8), // 左右间距
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300, // 分割线颜色
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1), // 阴影颜色
//                     spreadRadius: 1, // 阴影扩散范围
//                     blurRadius: 3, // 阴影模糊半径
//                     offset: Offset(0, 2), // 阴影偏移
//                   ),
//                 ],
//               ),
//             ),
//             // 文字
//             Padding(
//               padding: EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(food.name, style: foodNameText),
//                   SizedBox(height: 5),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("\$" + food.price.toStringAsFixed(2),
//                           style: priceText),
//
//                       Row(children: [
//                         // 大拇指图标
//                         IconButton(
//                           icon: Icon(
//                             Icons.thumb_up,
//                             color:
//                                 food.isRecommended==true ? Colors.green : Colors.grey,
//                           ),
//                           onPressed: () {
//                             if (onLike != null) {
//                               onLike();
//                             }
//                           },
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             // 处理购物车点击事件
//                             Cartitems.addToCart(food, 1); // 添加商品到购物车
//                             // ScaffoldMessenger.of(context).showSnackBar(
//                             //   SnackBar(content: Text('${product.name} added to cart')),
//                             // );
//                           },
//                           style: TextButton.styleFrom(
//                             backgroundColor: Colors.white,
//                             shape: CircleBorder(),
//                             padding: EdgeInsets.all(8),
//                           ),
//                           child: Icon(
//                             Icons.shopping_cart,
//                             color: primaryColor,
//                             size: 24,
//                           ),
//                         ),
//                       ],
//
//                       ),
//
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ));
// }
