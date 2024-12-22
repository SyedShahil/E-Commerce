import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  // Original list of products
  final List<Map<String, String>> _products = [
    {
      'name': 'Laptop',
      'image': 'assets/images/laptop.jpeg',
    },
    {
      'name': 'Headphones',
      'image': 'assets/images/headphone.jpeg',
    },
    {
      'name': 'Smartphone',
      'image': 'assets/images/smartphone.jpeg',
    },
    {
      'name': 'Camera',
      'image': 'assets/images/camera.jpeg',
    },
    {
      'name': 'Smartwatch',
      'image': 'assets/images/watch.webp',
    },
    {
      'name': 'Shoes',
      'image': 'assets/images/shoe.webp',
    },
  ];

  // List for filtered products
  late List<Map<String, String>> _filteredProducts;

  // Getter for filtered products
  List<Map<String, String>> get filteredProducts => _filteredProducts;

  // Constructor to initialize filtered products
  HomeViewModel() {
    _filteredProducts = List.from(_products); // Initialize with all products
  }

  // Method to search products
  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = List.from(_products); // Reset to all products
    } else {
      _filteredProducts = _products
          .where((product) =>
          product['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // Notify listeners to update the UI
  }
}
