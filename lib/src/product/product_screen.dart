import 'dart:convert';

import 'package:aksapp/src/product/product_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../main.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<dynamic> _products = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _products = data['data'];
        });
      } else {
        setState(() => _errorMessage = "Failed to load products");
      }
    } catch (e) {
      setState(() => _errorMessage = "Network Error: Server unreachable");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(symbol: '\₹');

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(onPressed: _fetchProducts, icon: const Icon(Icons.refresh))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductScreen()),
          );
          if (result == true) {
            _fetchProducts();
          }
        },
        label: const Text("Add Product"),
        icon: const Icon(Icons.add),
        backgroundColor: const Color(0xFF6750A4),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 10),
            Text(_errorMessage!),
            TextButton(onPressed: _fetchProducts, child: const Text("Retry"))
          ],
        ),
      )
          : _products.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 10),
            Text("No products found", style: GoogleFonts.poppins(color: Colors.grey)),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return Container(
             decoration: BoxDecoration(
               color: Colors.grey.shade200,
               borderRadius: BorderRadius.all(Radius.circular(12))
             ),
            margin: const EdgeInsets.only(bottom: 12),
             child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF6750A4).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF6750A4)),
              ),
              title: Text(
                product['name'],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              trailing: Text(
                currencyFormatter.format(product['price']),
                style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}