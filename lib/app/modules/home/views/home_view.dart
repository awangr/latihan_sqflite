import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List with Getx'),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.all(8),
              child: IconButton(
                  onPressed: () {
                    controller.showBotomSheet(null);
                  },
                  icon: Icon(Icons.add)),
            )
          ],
        ),
        body: Obx(() => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.allData.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: ListTile(
                      title: Text(controller.allData[index]['namaKegiatan']),
                      subtitle: Text(controller.allData[index]['lokasi']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.showBotomSheet(
                                    controller.allData[index]['id']);
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                controller.deleteData(
                                    controller.allData[index]['id']);
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  );
                },
              )));
  }
}
