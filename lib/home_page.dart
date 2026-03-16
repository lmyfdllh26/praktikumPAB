import 'package:flutter/material.dart';
import 'form_page.dart';
import 'detail_page.dart';
import '../services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List orders = [];

  SupabaseService service = SupabaseService();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {

    final data = await service.getOrders();

    setState(() {
      orders = data;
    });

  }

  void confirmDelete(index){

    final order = orders[index];

    showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        title: Text("Hapus Pesanan"),
        content: Text("Apakah yakin ingin menghapus pesanan ini?"),
        actions: [

          TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Batal"),
          ),

          TextButton(
            onPressed: () async {

              await service.deleteOrder(order['id'] ?? 0);

              Navigator.pop(context);

              loadData();

            },
            child: Text("Hapus"),
          )

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Cookies Order"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 227, 224, 65),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 162, 211, 46),
        child: Icon(Icons.add),
        onPressed: () async {

          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context)=>FormPage(),
            ),
          );

          if(result != null){
            loadData();
          }

        },
      ),

      body: Column(

        children: [

          ElevatedButton(
            onPressed: () async {

              await Supabase.instance.client.from('orders').insert({
                'nama': 'TEST',
                'tanggal_pengambilan': '2026-03-10',
                'jenis': 'Chocolate',
                'jumlah': 1,
                'harga': 10000
              });

              print("TEST INSERT BERHASIL");

              loadData();

            },
            child: Text("TEST INSERT"),
          ),

          Padding(
            padding: EdgeInsets.all(12),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 5, 65, 17),
                      Color.fromARGB(255, 32, 49, 38)
                    ],
                  ),
                ),
                child: Column(
                  children: [

                    Icon(
                      Icons.cookie,
                      size: 50,
                      color: Colors.white,
                    ),

                    SizedBox(height:10),

                    Text(
                      "Cookies Order App",
                      style: TextStyle(
                        fontSize:20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height:5),

                    Text(
                      "Kelola pesanan cookies dengan mudah",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal:15),
            child: Row(
              children: [

                Icon(Icons.list_alt,color: Color.fromARGB(255, 129, 87, 70)),

                SizedBox(width:8),

                Text(
                  "Total Pesanan : ${orders.length}",
                  style: TextStyle(
                    fontSize:16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),

          SizedBox(height:10),

          Expanded(

            child: orders.isEmpty
                ? Center(
                    child: Text(
                      "Belum ada pesanan",
                      style: TextStyle(fontSize:16),
                    ),
                  )

                : ListView.builder(

                    itemCount: orders.length,

                    itemBuilder: (context,index){

                      final order = orders[index];

                      return Card(

                        elevation:3,

                        margin: EdgeInsets.symmetric(
                          horizontal:12,
                          vertical:6,
                        ),

                        child: ListTile(

                          leading: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 152, 71, 41),
                            child: Icon(
                              Icons.cookie,
                              color: Colors.white,
                            ),
                          ),

                          title: Text(
                            order['nama'] ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          subtitle: Text(
                            "Tanggal: ${order['tanggal_pengambilan'] ?? '-'}\nJenis: ${order['jenis'] ?? '-'}",
                          ),

                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context)=>DetailPage(order: order),
                              ),
                            );
                          },

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              IconButton(
                                icon: Icon(Icons.edit,color: Color.fromARGB(255, 84, 132, 29)),
                                onPressed: () async {

                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context)=>FormPage(
                                        order: order,
                                      ),
                                    ),
                                  );

                                  if(result != null){
                                    loadData();
                                  }

                                },
                              ),

                              IconButton(
                                icon: Icon(Icons.delete,color: Color.fromARGB(255, 200, 64, 40)),
                                onPressed: (){
                                  confirmDelete(index);
                                },
                              )

                            ],
                          ),

                        ),
                      );

                    },
                  ),

          )

        ],

      ),

    );

  }

}