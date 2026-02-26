import 'package:flutter/material.dart';
import 'form_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> orders = [];

  void addOrder(Map<String, dynamic> order) {
    setState(() {
      orders.add(order);
    });
  }

  void updateOrder(int index, Map<String, dynamic> order) {
    setState(() {
      orders[index] = order;
    });
  }

  void deleteOrder(int index) {
    setState(() {
      orders.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Pesanan Cookies"),
      ),
      body: orders.isEmpty
          ? Center(child: Text("Belum ada pesanan"))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(orders[index]['nama']),
                    subtitle: Text(
                        "Jumlah Varian: ${orders[index]['items'].length}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(order: orders[index]),
                        ),
                      );
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FormPage(order: orders[index]),
                              ),
                            );
                            if (result != null) {
                              updateOrder(index, result);
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteOrder(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormPage()),
          );
          if (result != null) {
            addOrder(result);
          }
        },
      ),
    );
  }
}