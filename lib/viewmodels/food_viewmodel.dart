import 'package:flutter/material.dart';
import '../models/food_models.dart';
import '../repository/food_repository.dart';

class FoodViewModel extends ChangeNotifier {
  final FoodRepository _repo = FoodRepository();
  final String defaultUser = "Zerda Gül Havare";

  List<Food> foods = [];
  List<Food> filteredFoods = [];
  List<CartFood> cartItems = [];
  bool isLoading = false;

  Future<void> loadFoods() async {
    isLoading = true;
    notifyListeners();
    foods = await _repo.getAllFoods();
    filteredFoods = foods;
    isLoading = false;
    notifyListeners();
  }

  void filterFoods(String query) {
    if (query.isEmpty) {
      filteredFoods = foods;
    } else {
      filteredFoods = foods.where((f) => f.yemek_adi.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }

  Future<void> addToCart(Food food, int quantity) async {
    await _repo.addToCart(food.yemek_adi, food.yemek_resim_adi, int.parse(food.yemek_fiyat), quantity, defaultUser);
    loadCart();
  }

  Future<void> loadCart() async {
    cartItems = await _repo.getCartFoods(defaultUser);
    notifyListeners();
  }

  Future<void> deleteFromCart(int sepetId) async {
    await _repo.removeFromCart(sepetId, defaultUser);
    loadCart();
  }
}