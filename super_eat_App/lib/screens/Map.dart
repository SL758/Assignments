import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  final String pageTitle;

  MapPage({Key? key, this.pageTitle = 'Map'}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // 页面背景颜色
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white, // AppBar背景颜色
        centerTitle: true,
        title: Text(
          widget.pageTitle, // 页面标题
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // 返回上一页面
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(16), // 留出页面边距
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300], // 中间空白部分的背景颜色
                  borderRadius: BorderRadius.circular(10), // 圆角边框
                  border: Border.all(
                    color: Colors.grey, // 边框颜色
                    width: 2, // 边框宽度
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Google Map Placeholder', // 用于占位的文字
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
