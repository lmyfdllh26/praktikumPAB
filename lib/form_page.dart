import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

class FormPage extends StatefulWidget {
  final order;

  FormPage({this.order});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final _formKey = GlobalKey<FormState>();

  SupabaseService service = SupabaseService();

  TextEditingController tanggalController = TextEditingController();
  TextEditingController namaController = TextEditingController();

  List<Map<String, TextEditingController>> items = [];

  @override
  void initState() {
    super.initState();

    if(widget.order != null){

      tanggalController.text = widget.order['tanggal_pengambilan'];
      namaController.text = widget.order['nama'];

      items.add({
        'jenis': TextEditingController(text: widget.order['jenis']),
        'jumlah': TextEditingController(text: widget.order['jumlah'].toString()),
        'harga': TextEditingController(text: widget.order['harga'].toString()),
      });

    }else{
      addItem();
    }
  }

  void addItem(){
    setState(() {
      items.add({
        'jenis': TextEditingController(),
        'jumlah': TextEditingController(),
        'harga': TextEditingController(),
      });
    });
  }

Future saveData() async {

  try {

    print("SAVE DATA DIPANGGIL");

    for(var item in items){

      int jumlah = int.tryParse(item['jumlah']!.text) ?? 0;
      int harga = int.tryParse(item['harga']!.text) ?? 0;

      await service.addOrder(
        namaController.text,
        tanggalController.text,
        item['jenis']!.text,
        jumlah,
        harga,
      );

    }

    print("SELESAI INSERT");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Pesanan berhasil disimpan"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context, true);

  } catch (e) {

    print("ERROR: $e");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Terjadi error: $e"),
        backgroundColor: Colors.red,
      ),
    );

  }

}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Cookies Order"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 215, 226, 66),
      ),

      body: SingleChildScrollView(

        padding: EdgeInsets.all(16),

        child: Form(

          key: _formKey,

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(
                "Form Pesanan Cookies",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height:20),

              TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                  labelText: "Nama Pelanggan",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Nama tidak boleh kosong";
                  }
                  return null;
                },
              ),

              SizedBox(height:15),

              TextFormField(
                controller: tanggalController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Tanggal Pengambilan",
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Tanggal pengambilan harus diisi";
                  }
                  return null;
                },
                onTap: () async {

                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                  );

                  if(pickedDate != null){

                    String formattedDate =
                    "${pickedDate.year}-${pickedDate.month.toString().padLeft(2,'0')}-${pickedDate.day.toString().padLeft(2,'0')}";

                    setState(() {
                      tanggalController.text = formattedDate;
                    });

                  }

                },
              ),

              SizedBox(height:20),

              ListView.builder(

                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),

                itemCount: items.length,

                itemBuilder: (context,index){

                  return Card(

                    elevation: 3,
                    margin: EdgeInsets.only(bottom:15),

                    child: Padding(

                      padding: EdgeInsets.all(10),

                      child: Column(

                        children: [

                          TextFormField(
                            controller: items[index]['jenis'],
                            decoration: InputDecoration(
                              labelText: "Jenis Cookies",
                              prefixIcon: Icon(Icons.cookie),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Jenis tidak boleh kosong";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height:10),

                          TextFormField(
                            controller: items[index]['jumlah'],
                            decoration: InputDecoration(
                              labelText: "Jumlah",
                              prefixIcon: Icon(Icons.numbers),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value){

                              if(value == null || value.isEmpty){
                                return "Jumlah tidak boleh kosong";
                              }

                              if(int.tryParse(value) == null){
                                return "Jumlah harus angka";
                              }

                              return null;
                            },
                          ),

                          SizedBox(height:10),

                          TextFormField(
                            controller: items[index]['harga'],
                            decoration: InputDecoration(
                              labelText: "Harga",
                              prefixIcon: Icon(Icons.attach_money),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value){

                              if(value == null || value.isEmpty){
                                return "Harga tidak boleh kosong";
                              }

                              if(int.tryParse(value) == null){
                                return "Harga harus angka";
                              }

                              return null;
                            },
                          ),

                        ],
                      ),
                    ),
                  );

                },

              ),

              SizedBox(height:15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text("Tambah Jenis Cookies"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Color.fromARGB(255, 228, 226, 101),
                  ),
                  onPressed: addItem,
                ),
              ),

              SizedBox(height:15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.save),
                  label: Text("Simpan Pesanan"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Color.fromARGB(255, 149, 193, 150),
                  ),
                  onPressed: () async {

                    if (_formKey.currentState!.validate()) {
                      await saveData();
                    }

                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}