import 'package:flutter/material.dart';
import '../entities/CartItems.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import './ProductPage.dart';
import '../shared/buttons.dart';
import './AddItemPage.dart';
import '../entities/Product.dart';
import '../shared/partials.dart';
import '../shared/categoryWidgets.dart';
import '../shared/sectionHeader_widgets.dart';
import 'CartPage.dart';
import 'Map.dart'; // 导入 Map.dart 文件
import './Store.dart'; // 添加新的页面引用
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // 用于 JSON 编解码
import '../shared/local_storage_helper.dart'; // 导入工具类文件

class HomeDashboard extends StatefulWidget {
  final String pageTitle;

  HomeDashboard({
    Key? key,
    this.pageTitle = '',
  }) : super(key: key);

  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  int _selectedIndex = 2;
  String selectedCategory = 'Hamburger';

  void updateCategories(String newCategory) {
    setState(() {
      selectedCategory = newCategory;
    });
  }

  // 数据列表
  List<Product> hamburgers = [];
  List<Product> pizzas = [];
  List<Product> salads = [];

  @override
  void initState() {
    super.initState();
    _loadAllCategories(); // 加载所有分类数据
  }

  // 加载所有分类数据
  Future<void> _loadAllCategories() async {
    // 加载 Hamburger 数据
    List<Product> loadedHamburgers = await _loadCategory('hamburgers', LocalStorageHelper.initializeDefaultHamburgers);

    // 加载 Pizza 数据
    List<Product> loadedPizzas = await _loadCategory('pizzas', LocalStorageHelper.initializeDefaultPizzas);

    // 加载 Salad 数据
    List<Product> loadedSalads = await _loadCategory('salads', LocalStorageHelper.initializeDefaultSalads);

    // 更新 UI
    setState(() {
      hamburgers = loadedHamburgers;
      pizzas = loadedPizzas;
      salads = loadedSalads;
    });
  }

  // 通用的加载方法
  Future<List<Product>> _loadCategory(
      String key, Future<void> Function() initializeDefault) async {
    List<Product> loadedItems = await LocalStorageHelper.loadProductsFromLocalStorage(key);
    if (loadedItems.isEmpty) {
      // 如果本地没有数据，则初始化默认值
      await initializeDefault();
      loadedItems = await LocalStorageHelper.loadProductsFromLocalStorage(key);
    }
    return loadedItems;
  }



  @override
  Widget build(BuildContext context) {
    final _tabs = [
      StorePage(),
      MapPage(pageTitle: 'Map'), // Tab2 显示 MapPage
      homeTab(context, selectedCategory, updateCategories,hamburgers,pizzas,salads),
      CartPage(),
      AddItemPage(),
    ];

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: primaryColor,
          title: Text('Super Eat',
              style: logoWhiteStyle, textAlign: TextAlign.center),
        ),
        body: _tabs[_selectedIndex],

        //刷新整个页面
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // 点击按钮时刷新数据
            _loadAllCategories(); // 重新加载数据
          },
          child: Icon(Icons.refresh), // 使用刷新图标
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'My Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_business),
              label: 'Add Item',
            )
          ],
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.green[800],
          onTap: _onItemTapped,
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

Widget homeTab(BuildContext context, String selectedCategory,
    Function(String) updateCategories,List<Product> hamburgers,
    List<Product> pizzas,List<Product> salads) {


  List<Product> selects = [];

  switch (selectedCategory) {
    case 'Hamburger':
      selects = hamburgers.toList();
      break;
    case 'Pizza':
      selects = pizzas.toList();
      break;
    case 'Salad':
      selects = salads.toList();
      break;
    default:
      selects = [];
      break;
  }

  return ListView(padding: EdgeInsets.symmetric(vertical: 10), children: [
    sectionHeader('All Categories'),
    HeaderTopCategories(onCategoryChanged: updateCategories),
    sectionHeader(selectedCategory),
    Wrap(
      spacing: 1, // 每列之间的间距
      runSpacing: 20, // 每行之间的间距
      children: selects.map((product) {

        return Container(
          width: MediaQuery.of(context).size.width / 2 -
              15, // 每个 `foodItem` 占一半宽度（减去间距）

          child: foodItem(
            product,
            imgWidth: 250,
            onLike: () {},
            onTapped: () {
              // // Cartitems.addToCart(product, 1); // 添加商品到购物车
              // ScaffoldMessenger.of(context).showSnackBar(
              // //   SnackBar(content: Text('${product.name} added to cart')),
              // // );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProductPage(productData: product);
                  },
                ),
              );
            },
          ),
        );
      }).toList(),
    ),
  ]);
}



// wrap the horizontal listview inside a sizedBox..

Widget deals(String dealTitle, {onViewMore, List<Widget>? items}) {
  return Container(
    margin: EdgeInsets.only(top: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sectionHeader(dealTitle),
        SizedBox(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: (items != null)
                ? items
                : <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text('No items available at this moment.',
                          style: taglineText),
                    )
                  ],
          ),
        )
      ],
    ),
  );
}
