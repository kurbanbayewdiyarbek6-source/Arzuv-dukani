
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const AzMarket());
}

class AzMarket extends StatelessWidget {
  const AzMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Az Market',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}

void clickSound() {
  SystemSound.play(SystemSoundType.click);
}

class Product {
  final String name;
  final int price;
  final String image;

  Product(this.name, this.price, this.image);
}

final products = [
  Product('Alma', 20,
      'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=500'),
  Product('Pomidor', 15,
      'https://images.unsplash.com/photo-1546094096-0df4bcaaa337?w=500'),
  Product('Kartoşka', 10,
      'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=500'),
  Product('Sogan', 12,
      'https://images.unsplash.com/photo-1508747703725-719777637510?w=500'),
  Product('Banan', 35,
      'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=500'),
  Product('Üzüm', 30,
      'https://images.unsplash.com/photo-1537640538966-79f369143f8f?w=500'),
  Product('Apelsin', 25,
      'https://images.unsplash.com/photo-1547514701-42782101795e?w=500'),
  Product('Garpyz', 40,
      'https://images.unsplash.com/photo-1563114773-84221bd62daa?w=500'),
];

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.white,
              child: Icon(Icons.shopping_cart,
                  color: Colors.deepPurple, size: 65),
            ),
            SizedBox(height: 20),
            Text('AZ MARKET',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold)),
            Text('Söwda etmek aňsat!',
                style: TextStyle(color: Colors.white70, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Product> cart = [];

  void add(Product p) {
    clickSound();
    setState(() => cart.add(p));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${p.name} sebete goşuldy')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AZ MARKET',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              clickSound();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartPage(cart: cart),
                ),
              ).then((_) => setState(() {}));
            },
            icon: Badge(
              label: Text('${cart.length}'),
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            color: Colors.deepPurple,
            child: const Text(
              'Hoş geldiňiz!\nTäze we ter önümler',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: products.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, i) {
                final p = products[i];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          p.image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image_not_supported, size: 60),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(p.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17)),
                            Text('${p.price} manat'),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => add(p),
                                child: const Text('Sebete goş'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

class CartPage extends StatefulWidget {
  final List<Product> cart;

  const CartPage({super.key, required this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int get total =>
      widget.cart.fold(0, (sum, p) => sum + p.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sebet')),
      body: Column(
        children: [
          Expanded(
            child: widget.cart.isEmpty
                ? const Center(child: Text('Sebet boş'))
                : ListView.builder(
                    itemCount: widget.cart.length,
                    itemBuilder: (_, i) {
                      final p = widget.cart[i];
                      return ListTile(
                        title: Text(p.name),
                        subtitle: Text('${p.price} manat'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            clickSound();
                            setState(() => widget.cart.removeAt(i));
                          },
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Jemi: $total manat',
                    style: const TextStyle(
                        fontSize: 21, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: widget.cart.isEmpty
                        ? null
                        : () {
                            clickSound();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AddressPage()),
                            );
                          },
                    child: const Text('Dowam et'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final address = TextEditingController();
  final note = TextEditingController();

  String region = 'Aşgabat';

  final regions = [
    'Aşgabat',
    'Ahal welaýaty',
    'Balkan welaýaty',
    'Daşoguz welaýaty',
    'Lebap welaýaty',
    'Mary welaýaty',
  ];

  @override
  void dispose() {
    address.dispose();
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eltip bermek')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Welaýaty saýlaň'),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: region,
            decoration: const InputDecoration(
                border: OutlineInputBorder()),
            items: regions
                .map((r) => DropdownMenuItem(
                    value: r, child: Text(r)))
                .toList(),
            onChanged: (v) {
              if (v != null) setState(() => region = v);
            },
          ),
          const SizedBox(height: 18),
          TextField(
            controller: address,
            decoration: const InputDecoration(
              labelText: 'Salgyňyz',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: note,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Goşmaça bellik (hökmany däl)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (address.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Salgyňyzy ýazyň')),
                );
                return;
              }
              clickSound();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentPage(
                    region: region,
                    address: address.text,
                    note: note.text,
                  ),
                ),
              );
            },
            child: const Text('Tölege geç'),
          ),
        ],
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  final String region;
  final String address;
  final String note;

  const PaymentPage({
    super.key,
    required this.region,
    required this.address,
    required this.note,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final cardName = TextEditingController();
  final cardNumber = TextEditingController();
  final expiry = TextEditingController();
  final cvv = TextEditingController();

  @override
  void dispose() {
    cardName.dispose();
    cardNumber.dispose();
    expiry.dispose();
    cvv.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Synag tölegi')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(Icons.credit_card,
              size: 70, color: Colors.deepPurple),
          const SizedBox(height: 15),
          const Text(
            'Karta maglumatlary (diňe synag)',
            style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: cardName,
            decoration: const InputDecoration(
              labelText: 'Karta eýesiniň ady',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: cardNumber,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Karta belgisi',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: expiry,
                  decoration: const InputDecoration(
                    labelText: 'Möhleti',
                    hintText: 'MM/YY',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: cvv,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Bu diňe synag sahypasydyr. Islendik ýazylan maglumat kabul edilýär. Hakyky töleg geçirilmeýär we karta maglumatlary saklanmaýar.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                clickSound();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SuccessPage(),
                  ),
                );
              },
              child: const Text('Synagy tamamla'),
            ),
          ),
        ],
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle,
                  size: 90, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                'Synag üstünlikli tamamlandy!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  clickSound();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const HomePage()),
                    (route) => false,
                  );
                },
                child: const Text('Baş sahypa'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
