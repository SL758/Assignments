import 'package:flutter/material.dart';
import '../entities/CartItems.dart';
import '../entities/Product.dart';
import 'HomeDashboard.dart';

class CartPage extends StatefulWidget {
  final String? pageTitle;
  const CartPage({Key? key, this.pageTitle}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isTipIncluded = false; // 标记是否包含10%小费

  // 获取购物车总金额
  double getTotalPrice() {
    double total = Cartitems.items.fold(0.0, (sum, item) => sum + item.totalPrice);
    if (isTipIncluded) {
      total += total * 0.1; // 如果包含小费，增加10%
    }
    return total;
  }

  // 删除购物车中的商品
  void removeItem(int index) {
    setState(() {
      Cartitems.items.removeAt(index);
    });
  }

  // 增加商品数量
  void incrementQuantity(int index) {
    setState(() {
      Cartitems.items[index].quantity++;
    });
  }

  // 减少商品数量
  void decrementQuantity(int index) {
    setState(() {
      if (Cartitems.items[index].quantity > 1) {
        Cartitems.items[index].quantity--;
      } else {
        removeItem(index); // 如果数量减到 0，则删除商品
      }
    });
  }

  // 清空购物车
  void clearCart() {
    setState(() {
      Cartitems.items.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeDashboard()),
            );
          },
        ),
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 判断购物车是否为空
          Cartitems.items.isEmpty
              ? Expanded(
            child: Center(
              child: Text(
                "Your cart is empty!",
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            ),
          )
              : Expanded(
            child: ListView.builder(
              itemCount: Cartitems.items.length,
              itemBuilder: (context, index) {
                final item = Cartitems.items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 商品图片
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(item.product.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // 商品名称和价格
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${item.product.price.toStringAsFixed(2)}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      // 商品数量和操作按钮
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                            onPressed: () => decrementQuantity(index),
                          ),
                          Text(
                            "${item.quantity}",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                            onPressed: () => incrementQuantity(index),
                          ),
                          const SizedBox(width: 8),
                          // 删除按钮
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => removeItem(index),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // 显示小费选项、购物车总金额和支付按钮
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                // 小费开关
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Includes a 10% default tip?:",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Switch(
                      value: isTipIncluded,
                      onChanged: (bool newValue) {
                        setState(() {
                          isTipIncluded = newValue;
                        });
                      },
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.grey.withOpacity(0.3),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // 总金额显示
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Price",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$${getTotalPrice().toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // 支付按钮
                ElevatedButton(
                  onPressed: () {
                    if (Cartitems.items.isNotEmpty) {
                      // 支付逻辑
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Payment Successful!")),
                      );
                      clearCart(); // 支付成功后清空购物车
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    "Pay Now",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                // 清空购物车按钮
                ElevatedButton(
                  onPressed: clearCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    "Clear Cart",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
