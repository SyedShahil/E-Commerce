import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:ecom/view_models/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchField(context),
            const SizedBox(height: 20),
            _buildCarouselSlider(),
            const SizedBox(height: 20),
            _buildProductList(context),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('E-Commerce App'),
      backgroundColor: Colors.blueAccent,
      actions: [
        IconButton(
          onPressed: () {
            // Placeholder for cart button action
          },
          icon: const Icon(Icons.shopping_cart),
        ),
      ],
    );
  }

  TextField _buildSearchField(BuildContext context) {
    return TextField(
      onChanged: (query) {
        context.read<HomeViewModel>().searchProducts(query);
      },
      decoration: InputDecoration(
        hintText: 'Search for products...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            // Clear the search field and show all products
            context.read<HomeViewModel>().searchProducts('');
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildCarouselSlider() {
    final List<String> imageUrls = [
      'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=600',
      'https://images.unsplash.com/photo-1523275335684-37898b6baf30?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=600',
      'https://images.unsplash.com/photo-1616627566163-714b1d9a9b4c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=600',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: true,
        autoPlayInterval: const Duration(seconds: 2),
      ),
      items: imageUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Expanded _buildProductList(BuildContext context) {
    return Expanded(
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, _) {
          final filteredProducts = viewModel.filteredProducts;
          return filteredProducts.isNotEmpty
              ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 images per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 3,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return _buildProductCard(product);
            },
          )
              : const Center(
            child: Text('No products found.'),
          );
        },
      ),
    );
  }

  Card _buildProductCard(Map<String, String> product) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset(
              product['image']!,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product['name']!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            onPressed: () {
              // Placeholder for adding to cart
            },
            icon: const Icon(Icons.add_shopping_cart),
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
