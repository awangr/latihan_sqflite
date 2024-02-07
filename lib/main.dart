import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:todo_list/app/page/home_page.dart';
import 'package:todo_list/login_sigup/screen/admin/adm_login.dart';
import 'package:todo_list/login_sigup/screen/admin/adm_register.dart';

import 'app/routes/app_pages.dart';
import 'login_sigup/screen/frontend/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
