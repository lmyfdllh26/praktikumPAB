import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {

  final order;

  DetailPage({required this.order});

  int hitungTotal(){
    int jumlah = order['jumlah'] ?? 0;
    int harga = order['harga'] ?? 0;

    return jumlah * harga;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Detail Pesanan"),
      ),

      body: Padding(

        padding: EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(bottom:15),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Nama Pelanggan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      order['nama'] ?? '',
                      style: TextStyle(fontSize:16),
                    ),

                    SizedBox(height:10),

                    Text(
                      "Tanggal Pengambilan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      order['tanggal_pengambilan'] ?? '',
                      style: TextStyle(fontSize:16),
                    ),

                  ],
                ),
              ),
            ),

            SizedBox(height:20),

            Card(
              elevation: 3,
              child: ListTile(
                title: Text(order['jenis'] ?? ''),
                subtitle: Text(
                  "Jumlah: ${order['jumlah']} | Harga: ${order['harga']}"
                ),
                trailing: Text(
                  "Rp ${hitungTotal()}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Spacer(),

            Divider(),

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Text(
                  "Total Harga",
                  style: TextStyle(
                    fontSize:18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "Rp ${hitungTotal()}",
                  style: TextStyle(
                    fontSize:18,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),

              ],

            )

          ],
        ),
      ),
    );
  }
}