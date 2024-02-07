import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/login_sigup/controller/adminC.dart';
import 'package:todo_list/login_sigup/model/admin_model.dart';
import 'package:todo_list/login_sigup/screen/admin/adm_home.dart';
import 'package:todo_list/login_sigup/screen/admin/adm_login.dart';
import 'package:todo_list/login_sigup/service/service_helper.dart';

final controller = Get.put(AdminC());

class ADM_Register extends StatefulWidget {
  const ADM_Register({super.key});

  @override
  State<ADM_Register> createState() => _ADM_RegisterState();
}

class _ADM_RegisterState extends State<ADM_Register> {
  final key = GlobalKey<FormState>();
  final usernameC = TextEditingController();
  final passC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Username is Required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person),
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
                        obscureText: controller.isVisible1.value,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Obx(() => IconButton(
                                onPressed: () {
                                  controller.isVisible1.toggle();
                                },
                                icon: Icon(controller.isVisible1.value
                                    ? Icons.visibility_off
                                    : Icons.visibility))),
                            border: OutlineInputBorder()),
                      )),
                  SizedBox(height: 15),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent),
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          final db = DBAdm();
                          db
                              .sigUp(Admin(
                                  username: usernameC.text,
                                  password: passC.text))
                              .whenComplete(() => Get.to(ADM_Login()));
                          Get.snackbar(
                            'Sukses',
                            'Username ${usernameC.text} Berhasil Mendaftar',
                          );
                        }
                        ;
                      },
                      child: Text('REGISTER'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
