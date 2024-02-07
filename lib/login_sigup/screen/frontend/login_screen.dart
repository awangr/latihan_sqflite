import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/login_sigup/controller/frontendC.dart';
import 'package:todo_list/login_sigup/model/user_model.dart';
import 'package:todo_list/login_sigup/screen/admin/adm_login.dart';
import 'package:todo_list/login_sigup/screen/frontend/home_screen.dart';
import 'package:todo_list/login_sigup/service/service_helper.dart';

import 'sigup_screen.dart';

final controller = Get.put(FrontendC());

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final key = GlobalKey<FormState>();
  final usernameC = TextEditingController();
  final passC = TextEditingController();
  final db = DBHelper();
  bool isLoginTrue = false;
  login() async {
    var res = await db
        .login(UserModel(username: usernameC.text, password: passC.text));
    if (res == true) {
      Get.to(HomeScreen());
      usernameC.text = "";
      passC.text = "";
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users Login',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(ADM_Login());
              },
              icon: Icon(
                Icons.login,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: key,
              child: Column(
                children: [
                  Image.asset('asset/images/login.png'),
                  SizedBox(height: 15),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: usernameC,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person),
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 10))),
                  ),
                  SizedBox(height: 15),
                  Obx(() => TextFormField(
                        style: TextStyle(color: Colors.white),
                        obscureText: controller.isVisible.value,
                        controller: passC,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Obx(() => IconButton(
                                onPressed: () {
                                  controller.isVisible.toggle();
                                },
                                icon: Icon(
                                    controller.isVisible.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white))),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder()),
                      )),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Belum Memiliki akun?',
                        style: TextStyle(color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(SigupScreen());
                        },
                        child: Text('Daftar',
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          ///jika validasi dari textformfield berhasil
                          ///maka langsung eksekusi function dibawah

                          login();
                        }
                      },
                      child: Text('LOGIN'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
