import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> order;

  DetailPage({required this.order});

  @override
  Widget build(BuildContext context) {
    int total = 0;

    for (var item in order['items']) {
      int jumlah = int.tryParse(item['jumlah']) ?? 0;
      int harga = int.tryParse(item['harga']) ?? 0;
      total += jumlah * harga;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Rincian Pesanan"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama: ${order['nama']}",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: order['items'].length,
                itemBuilder: (context, index) {
                  var item = order['items'][index];
                  int jumlah = int.tryParse(item['jumlah']) ?? 0;
                  int harga = int.tryParse(item['harga']) ?? 0;
                  int subtotal = jumlah * harga;

                  return Card(
                    child: ListTile(
                      title: Text(item['jenis']),
                      subtitle: Text(
                          "$jumlah pcs x Rp $harga = Rp $subtotal"),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Text(
              "Total Bayar: Rp $total",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
            ),
          ],
        ),
      ),
    );
  }
}