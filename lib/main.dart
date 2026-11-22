
import 'package:flutter/material.dart';

void main() {
  runApp(const AzMarketApp());
}

class Product {
  final String name;
  final String price;
  final String image;
  final String emoji;

  const Product({
    required this.name,
    required this.price,
    required this.image,
    required this.emoji,
  });
}

const categories = [
  'Miwe',
  'Kir ýuwujy poroşok',
  'Şampun we sabyn',
  'Arassalaýjy serişdeler',
];

const products = [
  [
    Product(name: 'Alma', price: '20 manat', image: 'assets/images/alma.jpg', emoji: '🍎'),
    Product(name: 'Banan', price: '35 manat', image: 'assets/images/banan.jpg', emoji: '🍌'),
    Product(name: 'Üzüm', price: '25 manat', image: 'assets/images/uzum.jpg', emoji: '🍇'),
    Product(name: 'Pomidor', price: '18 manat', image: 'assets/images/pomidor.jpg', emoji: '🍅'),
    Product(name: 'Apelsin', price: '30 manat', image: 'assets/images/apelsin.jpg', emoji: '🍊'),
    Product(name: 'Garpyz', price: '15 manat', image: 'assets/images/garpyz.jpg', emoji: '🍉'),
  ],
  [
    Product(name: 'Kir ýuwujy poroşok', price: '45 manat', image: 'assets/images/poroshok.jpg', emoji: '🧺'),
    Product(name: 'Ariel poroşok', price: '55 manat', image: 'assets/images/ariel.jpg', emoji: '🧼'),
    Product(name: 'Suwuk ýuwujy serişde', price: '40 manat', image: 'assets/images/gel.jpg', emoji: '🫧'),
  ],
  [
    Product(name: 'Şampun', price: '35 manat', image: 'assets/images/shampun.jpg', emoji: '🧴'),
    Product(name: 'Saç şampuny', price: '45 manat', image: 'assets/images/shampun2.jpg', emoji: '🧴'),
    Product(name: 'Sabyn', price: '10 manat', image: 'assets/images/sabyn.jpg', emoji: '🧼'),
    Product(name: 'Suwuk sabyn', price: '25 manat', image: 'assets/images/suwuk_sabyn.jpg', emoji: '🧴'),
  ],
  [
    Product(name: 'Gap-gaç ýuwujy', price: '30 manat', image: 'assets/images/gap_yuwujy.jpg', emoji: '🧽'),
    Product(name: 'Pol arassalaýjy', price: '35 manat', image: 'assets/images/pol.jpg', emoji: '🧹'),
    Product(name: 'Arassalaýjy serişde', price: '28 manat', image: 'assets/images/arassala.jpg', emoji: '🫧'),
  ],
];

class AzMarketApp extends StatelessWidget {
  const AzMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Az Market',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF673AB7),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController();
  int selectedCategory = 0;
  final Map<String, int> cart = {};

  void addToCart(Product product) {
    setState(() {
      cart[product.name] = (cart[product.name] ?? 0) + 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} sebede goşuldy'),
        duration: const Duration(milliseconds: 900),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartCount = cart.values.fold<int>(0, (a, b) => a + b);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Az Market',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartPage(cart: cart),
                ),
              );
            },
            icon: Badge(
              label: Text('$cartCount'),
              isLabelVisible: cartCount > 0,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          SizedBox(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final selected = selectedCategory == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(categories[index]),
                    selected: selected,
                    onSelected: (_) {
                      setState(() => selectedCategory = index);
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: categories.length,
              onPageChanged: (index) {
                setState(() => selectedCategory = index);
              },
              itemBuilder: (context, categoryIndex) {
                final categoryProducts = products[categoryIndex];

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: categoryProducts.length,
                  itemBuilder: (context, index) {
                    final product = categoryProducts[index];

                    return Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.asset(
                              product.image,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) {
                                return Center(
                                  child: Text(
                                    product.emoji,
                                    style: const TextStyle(fontSize: 65),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    product.price,
                                    style: const TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton.filled(
                                  onPressed: () => addToCart(product),
                                  icon: const Icon(Icons.add_shopping_cart),
                                  iconSize: 19,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final Map<String, int> cart;

  const CartPage({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sebet')),
      body: cart.isEmpty
          ? const Center(child: Text('Sebediňiz boş'))
          : ListView(
              children: cart.entries.map((entry) {
                return ListTile(
                  leading: const Icon(Icons.shopping_basket),
                  title: Text(entry.key),
                  trailing: Text('x${entry.value}'),
                );
              }).toList(),
            ),
    );
  }
}
