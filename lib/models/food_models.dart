class Food {
  final String yemek_id;
  final String yemek_adi;
  final String yemek_resim_adi;
  final String yemek_fiyat;

  Food({required this.yemek_id, required this.yemek_adi, required this.yemek_resim_adi, required this.yemek_fiyat});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      yemek_id: json['yemek_id'],
      yemek_adi: json['yemek_adi'],
      yemek_resim_adi: json['yemek_resim_adi'],
      yemek_fiyat: json['yemek_fiyat'],
    );
  }
}

class CartFood {
  final String sepet_yemek_id;
  final String yemek_adi;
  final String yemek_resim_adi;
  final String yemek_fiyat;
  final String yemek_siparis_adet;
  final String kullanici_adi;

  CartFood({
    required this.sepet_yemek_id,
    required this.yemek_adi,
    required this.yemek_resim_adi,
    required this.yemek_fiyat,
    required this.yemek_siparis_adet,
    required this.kullanici_adi,
  });

  factory CartFood.fromJson(Map<String, dynamic> json) {
    return CartFood(
      sepet_yemek_id: json['sepet_yemek_id'],
      yemek_adi: json['yemek_adi'],
      yemek_resim_adi: json['yemek_resim_adi'],
      yemek_fiyat: json['yemek_fiyat'].toString(),
      yemek_siparis_adet: json['yemek_siparis_adet'].toString(),
      kullanici_adi: json['kullanici_adi'],
    );
  }
}