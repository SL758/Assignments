import '../entities/Product.dart';
import '../shared/local_storage_helper.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/inputFields.dart';
import '../shared/sectionHeader_widgets.dart';
import '../shared/buttons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:flutter/material.dart';
import 'HomeDashboard.dart';
import 'package:image_picker/image_picker.dart';

class AddItemPage extends StatefulWidget {
  final String? pageTitle;

  AddItemPage({Key? key, this.pageTitle}) : super(key: key);

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? selectedCategory;
  bool isRecommended = false;
  bool categoryError = false; // 新增一个状态变量，用来控制错误消息的显示

  File? _selectedImage; // 本地选择的图片文件

  void _addItem() {
    setState(() {
      categoryError = selectedCategory == null; // 如果没有选择类别，显示错误消息
    });

    if (_formKey.currentState?.validate() ?? false) {

      if (selectedCategory == null) {
        return; // 如果没有选择类别，停止执行下面的代码
      }

      final newItem = Product(
        name: _nameController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        description: _descriptionController.text.trim(),
        isHamburger: selectedCategory == "Burger"
            ? true
            : selectedCategory == "Pizza"
            ? false
            : null,
        isRecommended: isRecommended,
      );

      // 根据选择的类别来保存数据
      if (selectedCategory == 'Burger') {
        LocalStorageHelper.saveProductsToLocalStorage('hamburgers', [newItem]);
      } else if (selectedCategory == 'Pizza') {
        LocalStorageHelper.saveProductsToLocalStorage('pizzas', [newItem]);
      } else if (selectedCategory == 'Salad') {
        LocalStorageHelper.saveProductsToLocalStorage('salads', [newItem]);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item added successfully!')),
      );

      // 清空表单
      _formKey.currentState?.reset();
      _nameController.clear();
      _priceController.clear();
      _descriptionController.clear();
      setState(() {
        selectedCategory = null;
        isRecommended = false;
        categoryError = false; // 重置错误状态
      });
    }
    // else {
    //   // 如果表单验证失败，提示错误
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Please fill in all required fields')),
    //   );
    // }
  }


  final ImagePicker _picker = ImagePicker(); // 初始化图片选择器

  Future<void> _pickAndSaveImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      final appDir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory(path.join(appDir.path, 'images'));
      if (!imagesDir.existsSync()) {
        imagesDir.createSync(recursive: true);
      }

      final fileName = path.basename(pickedFile.path);
      final savedImage = await File(pickedFile.path).copy(
        path.join(imagesDir.path, fileName),
      );

      setState(() {
        _selectedImage = savedImage;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("图片已成功保存到 ${imagesDir.path}")),
      );
    } catch (e) {
      print("图片选择或保存失败：$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Form(
              key: _formKey, // 使用Form的key来触发验证
              child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add An Item', style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),

                    GestureDetector(
                      onTap: _pickAndSaveImage,
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: _selectedImage != null
                            ? Image.file(_selectedImage!, fit: BoxFit.cover)
                            : Center(
                          child: Icon(Icons.add_a_photo, size: 50,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    Text('Item Name:', style: TextStyle(fontSize: 16)),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(hintText: 'Enter item name'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Item Name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    Text('Item Price:', style: TextStyle(fontSize: 16)),
                    TextFormField(
                      controller: _priceController,
                      decoration: InputDecoration(hintText: 'Enter item price'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Item Price cannot be empty';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Item Price must be a number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    Text('Item Description:', style: TextStyle(fontSize: 16)),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(hintText: 'Enter item description'),
                      validator: (value) => value == null || value.trim().isEmpty ? 'Item Description cannot be empty' : null,
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('It is Recommended by chef', style: TextStyle(fontSize: 16)),
                        Switch(
                          value: isRecommended,
                          onChanged: (bool newValue) {
                            setState(() {
                              isRecommended = newValue;
                            });
                          },
                          activeColor: Colors.green,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey.withOpacity(0.3),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    Text('Item Category:', style: TextStyle(fontSize: 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCategoryRadio('Pizza'),
                        _buildCategoryRadio('Burger'),
                        _buildCategoryRadio('Salad'),
                      ],
                    ),
                    // 如果没有选择类别，显示红色的错误提示
                    if (categoryError) ...[
                      SizedBox(height: 5),
                      Text('Please select a category', style: TextStyle(color: Colors.red)),
                    ],
                    SizedBox(height: 20),

                    Container(
                      alignment: Alignment.center,
                      width: 400,
                      child: ElevatedButton(
                        onPressed: _addItem,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text(
                          "Add An Item",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),

            ),
            height: 800,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRadio(String category) {
    return Row(
      children: [
        Radio<String>(
          value: category,
          groupValue: selectedCategory,
          onChanged: (String? value) {
            setState(() {
              selectedCategory = value;
              categoryError = false; // 当选择了类别时，隐藏错误消息
            });
          },
        ),
        Text(category, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}


