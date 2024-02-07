import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/login_sigup/model/user_model.dart';
import 'package:todo_list/login_sigup/screen/admin/adm_login.dart';
import 'package:todo_list/login_sigup/service/service_helper.dart';

import '../../controller/frontendC.dart';
import 'login_screen.dart';

final controller = Get.put(FrontendC());

class SigupScreen extends StatefulWidget {
  const SigupScreen({super.key});

  @override
  State<SigupScreen> createState() => _SigupScreenState();
}

class _SigupScreenState extends State<SigupScreen> {
  final key = GlobalKey<FormState>();
  final usernameC = TextEditingController();
  final passC = TextEditingController();
  final confirmC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    controller: usernameC,
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Username is Required';
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
                        controller: passC,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is Required';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        obscureText: controller.isPass.value,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Obx(() => IconButton(
                                onPressed: () {
                                  controller.isPass.toggle();
                                },
                                icon: Icon(
                                    controller.isPass.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white))),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder()),
                      )),
                  SizedBox(height: 15),
                  Obx(() => TextFormField(
                        controller: confirmC,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Confim Password is Required';
                          } else if (confirmC.text != passC.text) {
                            return 'Password dont match';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        obscureText: controller.isConfirm.value,
                        decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Obx(() => IconButton(
                                onPressed: () {
                                  controller.isConfirm.toggle();
                                },
                                icon: Icon(
                                    controller.isConfirm.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white))),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder()),
                      )),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Sudah Memiliki akun?',
                          style: TextStyle(color: Colors.white)),
                      InkWell(
                        onTap: () {
                          Get.to(LoginScreen());
                        },
                        child: Text('Masuk',
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          final db = DBHelper();
                          db
                              .sigUp(UserModel(
                                  username: usernameC.text,
                                  password: passC.text))
                              .whenComplete(() => Get.to(LoginScreen()));
                          Get.snackbar('Sukses',
                              'Username ${usernameC.text} Berhasil Mendaftar',
                              colorText: Colors.white);
                        }
                      },
                      child: Text('DAFTAR')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
