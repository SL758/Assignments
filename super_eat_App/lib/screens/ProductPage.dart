import 'package:flutter/material.dart';
import '../entities/Product.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/partials.dart';
import '../shared/buttons.dart';

class ProductPage extends StatefulWidget {
  final String pageTitle;
  final Product productData;

  ProductPage({Key? key, this.pageTitle='', Product? productData}) : productData = productData ?? Product(),super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bgColor,
          centerTitle: true,
          leading: BackButton(
            color: darkText,
          ),
          title: Text(widget.productData.name, style: h4),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                      margin: EdgeInsets.only(top: 100, bottom: 100),
                      padding: EdgeInsets.only(top: 100, bottom: 50),
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Text(widget.productData.name, style: h5),
                          // Text(widget.productData.price, style: h3),
                          Container(
                            margin: EdgeInsets.only(top: 100, bottom: 20),

                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 25),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text('Quantity', style: h6),
                                  margin: EdgeInsets.only(bottom: 15),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          _quantity += 1;
                                        });
                                      },
                                      child: Center(
                                        child: Icon(Icons.add),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: Size(55, 55),
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),

                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Text(_quantity.toString(), style: h3),
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (_quantity == 1) return;
                                          _quantity -= 1;
                                        });
                                      },
                                      child: Center(
                                        child: Icon(Icons.remove),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: Size(55, 55),
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),


                                  ],
                                )
                              ],
                            ),
                          ),

                          Container(
                            width: 180,
                            child: seFlatBtn('Add to Cart', () {}),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 15,
                                spreadRadius: 5,
                                color: Color.fromRGBO(0, 0, 0, .05))
                          ]),
                    ),
                    ),
                    Align(
                        alignment: Alignment.center,
                      child: SizedBox(
                        width: 200,
                        height: 250,
                        child: foodItem(widget.productData,
                            isProductPage: true,
                            onTapped: () {},
                            imgWidth: 250,
                            onLike: () {}),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
