import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  
  final String imageUrl;
  final String title;
  final int id;

  const DetailScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          'Photo Detail',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(imageUrl),
              const SizedBox(height: 20),
              Text('Title : $title', style: const TextStyle(fontSize: 16),),
              const SizedBox(height: 10),
              Text('Id : $id', style: const TextStyle(fontSize: 16),)
            ],
          ),
        ),
      ),
    );
  }
}
