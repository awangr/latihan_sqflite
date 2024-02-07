import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/service/db.dart';

class HomeController extends GetxController {
  RxList<Map<String, dynamic>> allData = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;
  void refreshData() async {
    final data = await SqlDb.listData();
    allData.value = data;
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  final namaKegiatanC = TextEditingController();
  final lokasiC = TextEditingController();
  final jamC = TextEditingController();

  void addData() async {
    await SqlDb.createDate(namaKegiatanC.text, lokasiC.text, jamC.text);
    refreshData();
  }

  void updateData(int id) async {
    await SqlDb.updateData(id, namaKegiatanC.text, lokasiC.text, jamC.text);
    refreshData();
  }

  void deleteData(int id) async {
    try {
      await SqlDb.deleteData(id);
      refreshData();
      Get.snackbar('Berhasil', 'Berhasil menghapus');
    } catch (e) {
      print('Errorr  $e');
    }
  }

  void showBotomSheet(int? id) {
    if (id != null) {
      final dataExist = allData.firstWhere((element) => element['id'] == id);
      namaKegiatanC.text = dataExist['namaKegiatan'];
      jamC.text = dataExist['jam'];
      lokasiC.text = dataExist['lokasi'];
    }
    Get.bottomSheet(Container(
      color: Colors.amber,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          children: [
            TextFormField(
              controller: namaKegiatanC,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Nama Kegiatan'),
            ),
            SizedBox(height: 5),
            TextFormField(
                controller: lokasiC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Lokasi')),
            SizedBox(height: 5),
            TextFormField(
                controller: jamC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Jam')),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Cancel')),
                ElevatedButton(
                    onPressed: () async {
                      if (id == null) {
                        addData();
                        print('Nama kegiatan' + namaKegiatanC.text);
                      }
                      if (id != null) {
                        updateData(id);
                      }

                      Get.back();
                    },
                    child: Text(id == null ? 'ADD' : 'Update'))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
