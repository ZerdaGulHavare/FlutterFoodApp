import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/food_models.dart';
import '../viewmodels/food_viewmodel.dart';

class DetailPage extends StatefulWidget {
  final Food food;

  const DetailPage({Key? key, required this.food}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<FoodViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food.yemek_adi),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CachedNetworkImage(
                imageUrl: "http://kasimadalan.pe.hu/yemekler/resimler/${widget.food.yemek_resim_adi}",
                height: 250,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(height: 20),
              Text(
                widget.food.yemek_adi,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "₺${widget.food.yemek_fiyat}",
                style: const TextStyle(fontSize: 24, color: Colors.orange, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                    icon: const Icon(Icons.remove_circle_outline, size: 40, color: Colors.orange),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      quantity.toString(),
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    icon: const Icon(Icons.add_circle_outline, size: 40, color: Colors.orange),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder( // Hata burada düzeltildi
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      viewModel.addToCart(widget.food, quantity);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${widget.food.yemek_adi} (x$quantity) sepete eklendi!"),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "SEPETE EKLE",
                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}