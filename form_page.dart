import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  final Map<String, dynamic>? order;

  FormPage({this.order});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final namaController = TextEditingController();
  List<Map<String, TextEditingController>> items = [];

  @override
  void initState() {
    super.initState();

    if (widget.order != null) {
      namaController.text = widget.order!['nama'];

      for (var item in widget.order!['items']) {
        items.add({
          'jenis': TextEditingController(text: item['jenis']),
          'jumlah': TextEditingController(text: item['jumlah']),
          'harga': TextEditingController(text: item['harga']),
        });
      }
    } else {
      addItem();
    }
  }

  void addItem() {
    setState(() {
      items.add({
        'jenis': TextEditingController(),
        'jumlah': TextEditingController(),
        'harga': TextEditingController(),
      });
    });
  }

  void saveData() {
    List<Map<String, String>> itemList = [];

    for (var item in items) {
      itemList.add({
        'jenis': item['jenis']!.text,
        'jumlah': item['jumlah']!.text,
        'harga': item['harga']!.text,
      });
    }

    Navigator.pop(context, {
      'nama': namaController.text,
      'items': itemList,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.order == null
            ? "Tambah Pesanan"
            : "Edit Pesanan"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: "Nama Pelanggan"),
            ),
            SizedBox(height: 20),
            Column(
              children: List.generate(items.length, (index) {
                return Card(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text("Varian ${index + 1}"),
                        TextField(
                          controller: items[index]['jenis'],
                          decoration:
                              InputDecoration(labelText: "Jenis Cookies"),
                        ),
                        TextField(
                          controller: items[index]['jumlah'],
                          decoration:
                              InputDecoration(labelText: "Jumlah"),
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          controller: items[index]['harga'],
                          decoration:
                              InputDecoration(labelText: "Harga per pcs"),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            ElevatedButton(
              onPressed: addItem,
              child: Text("Tambah Varian"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveData,
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}