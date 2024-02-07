import 'package:flutter/material.dart';

class ADM_Home extends StatefulWidget {
  const ADM_Home({super.key});

  @override
  State<ADM_Home> createState() => _ADM_HomeState();
}

class _ADM_HomeState extends State<ADM_Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ini Halaman Admin'),
        centerTitle: true,
      ),
    );
  }
}
