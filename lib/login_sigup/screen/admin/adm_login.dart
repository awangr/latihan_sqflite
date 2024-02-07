import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/login_sigup/controller/adminC.dart';
import 'package:todo_list/login_sigup/model/admin_model.dart';
import 'package:todo_list/login_sigup/screen/admin/adm_home.dart';
import 'package:todo_list/login_sigup/service/service_helper.dart';

final controller = Get.put(AdminC());

class ADM_Login extends StatefulWidget {
  const ADM_Login({super.key});

  @override
  State<ADM_Login> createState() => _ADM_LoginState();
}

class _ADM_LoginState extends State<ADM_Login> {
  final usernameC = TextEditingController();
  final passC = TextEditingController();
  final key = GlobalKey<FormState>();
  final db = DBAdm();
  bool isLoginTrue = false;
  login() async {
    var response =
        await db.login(Admin(username: usernameC.text, password: passC.text));
    if (response == true) {
      Get.to(ADM_Home());
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
        title: Text('Admin Login'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
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
                        obscureText: controller.isVisible.value,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Obx(() => IconButton(
                                onPressed: () {
                                  controller.isVisible.toggle();
                                },
                                icon: Icon(controller.isVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility))),
                            border: OutlineInputBorder()),
                      )),
                  SizedBox(height: 15),
                  ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          login();
                        }
                        ;
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
