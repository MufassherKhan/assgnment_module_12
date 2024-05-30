import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:assgnment_module_12/image_class.dart';
import 'package:assgnment_module_12/detail_screen.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {

  List<Images>imageList = [];

  @override
  void initState() {
    super.initState();
    _getImageList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          'Photo Gallery',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: imageList.length,
        itemBuilder: (context, index){
          return _imageList(imageList[index],context);
        },
        separatorBuilder: (_, __) => const SizedBox(
          height: 12,
        ),
      ),
    );
  }
  Widget _imageList(Images images, BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () => Navigator.push(
          context, MaterialPageRoute(
            builder: (context) => DetailScreen(
              imageUrl : images.url,
              title : images.title,
              id : images.id,
            ),
        ),
        ),
        child: Image.network(
          images.thumbnailUrl,
          height: 120,
        ),
      ),
      title: Text(images.title),
    );
  }
  Future<void> _getImageList() async {
    setState(() {});
    imageList.clear();
    const String apiURL = 'https://jsonplaceholder.typicode.com/photos';
    Uri uri = Uri.parse(apiURL);
    Response response = await get(uri);

    if(response.statusCode == 200) {
      List<dynamic> jsonImageList = jsonDecode(response.body);

      for(Map<String, dynamic> img in jsonImageList) {
        Images images = Images(
          albumId : img['albumId'] ?? '',
          id : img['id'] ?? '',
          title : img['title'] ?? '',
          url : img['url'] ?? '',
          thumbnailUrl : img['thumbnailUrl'] ?? '',
        );
        imageList.add(images);
      }
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong...')),
      );
    }
    setState(() {});
  }
}