import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ana Sahypa"),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Yzyna geçmek üçin
          },
        ),
      ),
      body: const Center(
        child: Text(
          "Programma Başlady!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
