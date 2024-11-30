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
  String? selectedCategory;
  bool isRecommended = false;
  File? _selectedImage; // 本地选择的图片文件

  final ImagePicker _picker = ImagePicker(); // 初始化图片选择器

  // 选择图片并保存到本地
  Future<void> _pickAndSaveImage() async {
    try {
      // 选择图片
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      // 获取应用的本地文档路径
      final appDir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory(path.join(appDir.path, 'images'));
      if (!imagesDir.existsSync()) {
        imagesDir.createSync(recursive: true); // 如果目录不存在，则创建
      }

      // 保存图片到本地
      final fileName = path.basename(pickedFile.path); // 获取图片文件名
      final savedImage = await File(pickedFile.path).copy(path.join(imagesDir.path, fileName));

      // 更新 UI
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
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add An Item', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),

                    // 图片选择按钮
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
                          child: Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    Text('Item Name:', style: TextStyle(fontSize: 16)),
                    TextField(decoration: InputDecoration(hintText: 'Enter item name')),

                    SizedBox(height: 20),
                    Text('Item Price:', style: TextStyle(fontSize: 16)),
                    TextField(decoration: InputDecoration(hintText: 'Enter item price')),

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
                        Radio<String>(
                          value: 'Pizza',
                          groupValue: selectedCategory,
                          onChanged: (String? value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                        ),
                        Text('Pizza', style: TextStyle(fontSize: 16)),
                        Radio<String>(
                          value: 'Burger',
                          groupValue: selectedCategory,
                          onChanged: (String? value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                        ),
                        Text('Burger', style: TextStyle(fontSize: 16)),
                        Radio<String>(
                          value: 'Salad',
                          groupValue: selectedCategory,
                          onChanged: (String? value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                        ),
                        Text('Salad', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 20),

                    Container(
                      alignment: Alignment.center,
                      width: 400,
                      child: ElevatedButton(
                        onPressed: () {
                          // 提交逻辑
                          print("Item added!");
                        },
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
              ],
            ),
            height: 750,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
