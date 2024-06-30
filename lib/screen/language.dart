import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thay đổi ngôn ngữ',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {

          }, child: Text('Viet Nam')),
          ElevatedButton(onPressed: () {

          }, child: Text('English')),
          ElevatedButton(onPressed: () {

          }, child: Text('Portuguese'))
        ],
      )
    );
  }
}
