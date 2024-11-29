import 'Product.dart';

class Cartitems {

  final Product product; // 单个商品信息
  int quantity; // 商品数量

  Cartitems({
    required this.product,
    this.quantity = 1,
  });

  // 获取单个商品的总价
  double get totalPrice => product.price * quantity;

  // 静态购物车列表，用于存储所有购物车项
  static List<Cartitems> items = [];

  // 添加商品到购物车
  static void addToCart(Product product, int quantity) {
    // 检查购物车中是否已存在该商品
    final index = items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      // 如果商品已存在，增加数量
      items[index].quantity += quantity;
    } else {
      // 如果商品不存在，添加新的购物车项
      items.add(Cartitems(product: product));
    }
  }

  // 从购物车中移除商品
  static void removeFromCart(int index) {
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
    }
  }

  // 清空购物车
  static void clearCart() {
    items.clear();
  }

  // 计算购物车总价
  static double getTotalPrice() {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }
}
