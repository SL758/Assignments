import 'package:flutter/material.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import './ProductPage.dart';
import './AddItemPage.dart';
import '../entities/Product.dart';
import '../shared/partials.dart';
import '../shared/category_widgets.dart';
import '../shared/sectionHeader_widgets.dart';

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
      Text('Tab1'),
      Text('Tab2'),
      homeTab(context, selectedCategory, updateCategories),
      Text('Tab4'),
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
              icon: Icon(Icons.settings),
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
      id: 0,
      name: "Chicken Burger",
      image: "images/chickenburger.png",
      price: 25,
      userAddToCart: true,
      isHamburger: true,
    ),
    Product(
      id: 1,
      name: "Cheese Burger",
      image: "images/Cheeseburger.png",
      price: 15,
      userAddToCart: false,
      isHamburger: true,
    ),
    Product(
      id: 2,
      name: "Extra Long Burger",
      image: 'images/extralongburger.png',
      price: 10.99,
      userAddToCart: false,
      isHamburger: true,
    ),
    Product(
      id: 3,
      name: "Veggie Burger",
      image: "images/veggieburger.png",
      price: 50.00,
      userAddToCart: true,
      isHamburger: true,
    ),
  ];

  List<Product> salads = [
    Product(
      id: 0,
      name: "Beef Salad",
      image: "images/beefSalad.png",
      price: 45.12,
      userAddToCart: true,
      isHamburger: null,
    ),
    Product(
      id: 1,
      name: "Caesar Salad",
      image: "images/caesarSalad.png",
      price: 25.12,
      userAddToCart: true,
      isHamburger: null,
    ),
    Product(
      id: 2,
      name: "Chicken Salad",
      image: "images/chickenSalad.png",
      price: 15,
      userAddToCart: true,
      isHamburger: null,
    ),
  ];
  List<Product> selects = [];

  switch (selectedCategory) {
    case 'Hamburger':
      selects = hamburgers.toList();
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
              //有bug
              print('Tapped on: ${product.name}');
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
