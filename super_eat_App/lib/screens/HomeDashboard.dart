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
  String selectedCategory = 'Pizza';

  void updateCategories(String newCategory) {
    setState(() {
      selectedCategory = newCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _tabs = [
      StorePage(),
      MapPage(pageTitle: 'Map'), // Tab2 显示 MapPage
      homeTab(context, selectedCategory, updateCategories),
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
    Function(String) updateCategories) {
  // will pick it up from here
  // am to start another template
  List<Product> hamburgers = [
    Product(
      id: 1000,
      name: "Chicken Burger",
      image: "images/chickenburger.png",
      price: 25,
      userAddToCart: true,
      description: "A juicy grilled chicken burger with fresh vegetables.",
      isHamburger: true,
      isRecommended:true,
    ),
    Product(
      id: 1001,
      name: "Cheese Burger",
      image: "images/Cheeseburger.png",
      price: 15,
      userAddToCart: false,
      description: "A classic cheeseburger with a melted cheddar topping.",
      isHamburger: true,
    ),
    Product(
      id: 1002,
      name: "Extra Long Burger",
      image: 'images/extralongburger.png',
      price: 10.99,
      userAddToCart: false,
      description: "A delicious extra-long burger with crispy lettuce.",
      isHamburger: true,
    ),
    Product(
      id: 1003,
      name: "Veggie Burger",
      image: "images/veggieburger.png",
      price: 50.00,
      userAddToCart: true,
      description: "A delicious extra-long burger with crispy lettuce.",
      isHamburger: true,
    ),
  ];
  List<Product> pizza = [
    Product(
      id: 2000,
      name: "Hawaii Pizza",
      image: "images/Hawaiianpizza.jpg",
      price: 18,
      userAddToCart: true,
      description: "Nice Pizza.",
      isHamburger: null,
      isRecommended:true,
    ),
    Product(
      id: 2001,
      name: "pepperoni pizza",
      image: "images/Peperonipizza.jpeg",
      price: 10,
      userAddToCart: false,
      description: "pizza with pepperoni meat.",
      isHamburger: null,
    ),
    Product(
      id: 2002,
      name: "roast chicken pizza",
      image: 'images/Roastchickenpizza.jpeg',
      price: 12,
      userAddToCart: false,
      description: "pizza with roast chicken and mushroom.",
      isHamburger: null,
    ),
    Product(
      id: 2003,
      name: "Veggie Pizza",
      image: "images/Veggiepizza.jpeg",
      price: 8.00,
      userAddToCart: true,
      description: "A pizza with many kinds of vegetable.",
      isHamburger: null,
    ),
  ];
  List<Product> salads = [
    Product(
      id: 3000,
      name: "Beef Salad",
      image: "images/beefSalad.png",
      price: 45.12,
      userAddToCart: true,
      description: "A flavorful beef salad with a tangy vinaigrette dressing.",
      isHamburger: null,
    ),
    Product(
      id: 3001,
      name: "Caesar Salad",
      image: "images/caesarSalad.png",
      price: 25.12,
      userAddToCart: true,
      description: "A classic Caesar salad with crunchy croutons and parmesan.",
      isHamburger: null,
    ),
    Product(
      id: 3002,
      name: "Chicken Salad",
      image: "images/chickenSalad.png",
      price: 15,
      userAddToCart: true,
      description: "A hearty chicken salad with fresh greens and creamy dressing.",
      isHamburger: null,
    ),
  ];


  List<Product> selects = [];

  switch (selectedCategory) {
    case 'Hamburger':
      selects = hamburgers.toList();
      break;
    case 'Pizza':
      selects = pizza.toList();
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
