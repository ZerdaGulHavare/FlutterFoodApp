import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/food_models.dart';

class FoodRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://kasimadalan.pe.hu/"));

  // Yardımcı fonksiyon: Gelen verinin tipini kontrol eder ve Map'e çevirir.
  Map<String, dynamic> _handleResponse(dynamic data) {
    if (data is String) {
      return json.decode(data);
    }
    return data as Map<String, dynamic>;
  }

  Future<List<Food>> getAllFoods() async {
    try {
      var response = await _dio.get("yemekler/tumYemekleriGetir.php");
      if (response.statusCode == 200) {
        var jsonData = _handleResponse(response.data);
        var list = jsonData["yemekler"] as List;
        return list.map((e) => Food.fromJson(e)).toList();
      }
    } catch (e) {
      print("Yemek listesi yüklenirken hata oluştu: $e");
    }
    return [];
  }

  Future<void> addToCart(String ad, String resim, int fiyat, int adet, String kullanici) async {
    try {
      var data = FormData.fromMap({
        "yemek_adi": ad,
        "yemek_resim_adi": resim,
        "yemek_fiyat": fiyat,
        "yemek_siparis_adet": adet,
        "kullanici_adi": kullanici
      });
      await _dio.post("yemekler/sepeteYemekEkle.php", data: data);
    } catch (e) {
      print("Sepete ekleme hatası: $e");
    }
  }

  Future<List<CartFood>> getCartFoods(String kullanici) async {
    try {
      var data = FormData.fromMap({"kullanici_adi": kullanici});
      var response = await _dio.post("yemekler/sepettekiYemekleriGetir.php", data: data);

      if (response.statusCode == 200) {
        var jsonData = _handleResponse(response.data);
        // API sepet boşsa hata döndürebilir veya 'sepet_yemekler' null gelebilir
        if (jsonData["sepet_yemekler"] != null) {
          var list = jsonData["sepet_yemekler"] as List;
          return list.map((e) => CartFood.fromJson(e)).toList();
        }
      }
    } catch (e) {
      print("Sepet listelenirken hata (Muhtemelen sepet boş): $e");
    }
    return [];
  }

  Future<void> removeFromCart(int sepetYemekId, String kullanici) async {
    try {
      var data = FormData.fromMap({
        "sepet_yemek_id": sepetYemekId,
        "kullanici_adi": kullanici
      });
      await _dio.post("yemekler/sepettenYemekSil.php", data: data);
    } catch (e) {
      print("Sepetten silme hatası: $e");
    }
  }
}