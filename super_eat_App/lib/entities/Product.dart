class Product
{
  int id;
  String name;
  double price;
  String image;
  String description;
  bool? userAddToCart;
  bool? includeTip;
  bool? isHamburger;
  //isHamburger=true:Hamburger,
  //isHamburger=false:Pizza,
  //isHamburger=null:Salad,
  Product({
    this.id=0,
    this.name='',
    this.price=0.00,
    this.image='',
    required this.description,
    this.userAddToCart=false,
    this.includeTip=false,
    this.isHamburger=false,
  });

}