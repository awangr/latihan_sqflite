import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/service/db.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Map<String, dynamic>> allData = [];
  final TextEditingController namaKegiatanC = TextEditingController();
  final TextEditingController jamC = TextEditingController();
  final lokasiC = TextEditingController();
  final key = GlobalKey<FormState>();
  void refreshData() async {
    final data = await SqlDb.listData();
    setState(() {
      allData = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void showBotomModel(int? id) {
    if (id != null) {
      final exisData = allData.firstWhere((element) => element['id'] == id);
      namaKegiatanC.text = exisData['namaKegiatan'];
      lokasiC.text = exisData['lokasi'];
      jamC.text = exisData['jam'];
    }
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                  top: 30,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 50),
              child: Form(
                key: key,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Nama Kegiatan is required';
                          }
                          return null;
                        },
                        controller: namaKegiatanC,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Nama Kegiatan'),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Lokasi is required';
                          }
                          return null;
                        },
                        controller: lokasiC,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: 'Lokasi'),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Jam is required';
                          }
                          return null;
                        },
                        controller: jamC,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: 'Jam'),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                              onPressed: () => Get.back(),
                              child: Text('Cancel')),
                          SizedBox(width: 6),
                          ElevatedButton(
                            onPressed: () async {
                              if (namaKegiatanC.text.isEmpty &&
                                  lokasiC.text.isEmpty &&
                                  jamC.text.isEmpty) {
                                if (key.currentState!.validate()) ;
                              } else {
                                if (id == null) {
                                  Get.back();
                                  namaKegiatanC.text = "";
                                  lokasiC.text = "";
                                  jamC.text = "";
                                  addData();
                                }
                                if (id != null) {
                                  updateData(id);
                                }
                                Get.back();
                              }
                            },
                            child: Text(
                              id == null ? 'Tambah' : 'Update',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  void addData() async {
    await SqlDb.createDate(namaKegiatanC.text, lokasiC.text, jamC.text);
    refreshData();
  }

  void updateData(int id) async {
    await SqlDb.updateData(id, namaKegiatanC.text, lokasiC.text, jamC.text);
    refreshData();
  }

  void deleteData(int id) async {
    await SqlDb.deleteData(id);

    setState(() {});
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showBotomModel(null);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: allData.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 9,
                  child: ListTile(
                    title: Text(allData[index]['namaKegiatan']),
                    subtitle: Text(allData[index]['lokasi']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showBotomModel(allData[index]['id']);
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              deleteData(allData[index]['id']);
                              Get.snackbar('Suksess',
                                  'Berhasil hapus ${allData[index]['namaKegiatan']}');
                              setState(() {});
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
