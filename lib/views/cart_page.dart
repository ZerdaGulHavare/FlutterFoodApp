import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../viewmodels/food_viewmodel.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<FoodViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text("Sepetim")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.cartItems.length,
              itemBuilder: (context, index) {
                var item = viewModel.cartItems[index];
                return ListTile(
                  leading: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${item.yemek_resim_adi}"),
                  title: Text(item.yemek_adi),
                  subtitle: Text("${item.yemek_siparis_adet} Adet - ₺${item.yemek_fiyat}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => viewModel.deleteFromCart(int.parse(item.sepet_yemek_id)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
              onPressed: () => _showOrderAnimation(context),
              child: Text("Siparişi Tamamla"),
            ),
          )
        ],
      ),
    );
  }

  void _showOrderAnimation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/motorcycle.json'), // motorcycle.json dosyasını assets'e koymalısın
            Text("Siparişiniz Yolda! 🏍️"),
          ],
        ),
      ),
    );
  }
}