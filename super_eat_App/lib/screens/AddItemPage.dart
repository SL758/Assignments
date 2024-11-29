import 'package:flutter/material.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/inputFields.dart';
import '../shared/sectionHeader_widgets.dart';
import '../shared/buttons.dart';
import 'dart:io'; // 用于处理文件



class AddItemPage extends StatefulWidget {
  final String? pageTitle;

  AddItemPage({Key? key, this.pageTitle}) : super(key: key);

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  String? selectedCategory;
  bool isTipIncluded = false;
  File? _imageFile; // 用于存储上传的图片文件



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 18, right: 18),
          child: Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add An Item', style: h3),
                  Text('Item Name:', style: h6),
                  TextInput('Item Name'),
                  // 上传图片区域
                  Text('Upload Item Image:', style: h6),
                  GestureDetector(
                    onTap: () async {
                      // 打开图片选择器（需进一步实现，具体使用 `image_picker` 包）
                      // File? image = await pickImage();
                      // setState(() => _imageFile = image);
                      // 示例：此处模拟选择图片
                      print('Image upload button tapped!');
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[400]!),
                      ),
                      child: _imageFile == null
                          ? const Center(
                        child: Text(
                          'Tap to upload image',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                          : Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                        height: 150,
                      ),
                    ),
                  ),
                  Text('Item Price:', style: h6),
                  TextInput('Item Price'),

                  //switch button
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Text('Includes a 10% default tip?:', style: h6),
                        Switch(
                          value: isTipIncluded,
                          onChanged: (bool newValue) {
                            setState(() {
                              isTipIncluded = newValue;
                            });
                          },
                          activeColor: primaryColor,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey.withOpacity(0.3),
                        ),

                      ]

                  ),

                  //3 radio buttons
                  Text('Item Category:', style: h6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Radio<String>(
                        value: 'Pizza',
                        groupValue: selectedCategory,
                        onChanged: (String? value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                      Text('Pizza', style: h6),
                      Radio<String>(
                        value: 'Burger',
                        groupValue: selectedCategory,
                        onChanged: (String? value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                      Text('Burger', style: h6),
                      Radio<String>(
                        value: 'Salad',
                        groupValue: selectedCategory,
                        onChanged: (String? value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                      Text('Salad', style: h6),
                    ],
                  ),

                  Container(
                    alignment: Alignment.center,
                    width: 400,
                    child: seFlatBtn('Add An Item', () {}),
                  )
                ],
              ),
            ],
          ),
          height: 750,
          width: double.infinity,
          decoration: authPlateDecoration,
        ),

      ],
    ));
  }
}
