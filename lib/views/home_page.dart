import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/food_viewmodel.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<FoodViewModel>().loadFoods());
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<FoodViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text("Yemek App")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(hintText: "Yemek Ara...", prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
              onChanged: (v) => viewModel.filterFoods(v),
            ),
          ),
          Expanded(
            child: viewModel.isLoading
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8),
              itemCount: viewModel.filteredFoods.length,
              itemBuilder: (context, index) {
                var food = viewModel.filteredFoods[index];
                return Card(
                  child: InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => DetailPage(food: food))),
                    child: Column(
                      children: [
                        Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${food.yemek_resim_adi}", height: 100),
                        Text(food.yemek_adi, style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("₺${food.yemek_fiyat}"),
                        ElevatedButton(
                            onPressed: () {
                              viewModel.addToCart(food, 1);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sepete Eklendi")));
                            },
                            child: Text("Sepete Ekle")
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}