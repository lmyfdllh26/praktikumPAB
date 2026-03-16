import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {

  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getOrders() async {

    try {

      final data = await supabase
          .from('orders')
          .select();

      return List<Map<String, dynamic>>.from(data);

    } catch (e) {

      print("ERROR GET ORDERS: $e");
      return [];

    }

  }

  Future<void> addOrder(
      String nama,
      String tanggal,
      String jenis,
      int jumlah,
      int harga
      ) async {

    try {

      await supabase.from('orders').insert({
        'nama': nama,
        'tanggal_pengambilan': tanggal,
        'jenis': jenis,
        'jumlah': jumlah,
        'harga': harga
      });

      print("DATA BERHASIL DISIMPAN");

    } catch (e) {

      print("ERROR SUPABASE: $e");

    }

  }

  Future<void> updateOrder(
      int id,
      String nama,
      String tanggal,
      String jenis,
      int jumlah,
      int harga
      ) async {

    try {

      await supabase
          .from('orders')
          .update({
        'nama': nama,
        'tanggal_pengambilan': tanggal,
        'jenis': jenis,
        'jumlah': jumlah,
        'harga': harga
      })
          .eq('id', id);

      print("DATA BERHASIL DIUPDATE");

    } catch (e) {

      print("ERROR UPDATE: $e");

    }

  }

  Future<void> deleteOrder(int id) async {

    try {

      await supabase
          .from('orders')
          .delete()
          .eq('id', id);

      print("DATA BERHASIL DIHAPUS");

    } catch (e) {

      print("ERROR DELETE: $e");

    }

  }

}