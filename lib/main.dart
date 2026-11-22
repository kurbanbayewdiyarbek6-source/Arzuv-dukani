
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

final AudioPlayer soundPlayer = AudioPlayer();

Future<void> playSound(String file) async {
  try {
    await soundPlayer.stop();
    await soundPlayer.play(AssetSource('sounds/$file.wav'));
  } catch (_) {}
}

void main() {
  runApp(const AzMarketApp());
}

class Product {
  final String name;
  final String image;
  final int price;

  const Product(this.name, this.image, this.price);
}

const products = [
  Product('Üzüm', 'uzum.jpg', 35),
  Product('Banan', 'banan.jpg', 45),
  Product('Kartoşka', 'kartoshka.jpg', 12),
  Product('Hyýar', 'hyar.jpg', 18),
  Product('Pomidor', 'pomidor.jpg', 25),
  Product('Garpyz', 'garpyz.jpg', 10),
  Product('Alma', 'alma.jpg', 30),
  Product('Apelsin', 'apelsin.jpg', 40),
];

class AzMarketApp extends StatefulWidget {
  const AzMarketApp({super.key});

  @override
  State<AzMarketApp> createState() => _AzMarketAppState();
}

class _AzMarketAppState extends State<AzMarketApp> {
  bool darkMode = false;
  Map<Product, int> cart = {};

  String customerName = '';
  String phone = '';
  String address = '';

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      customerName = prefs.getString('name') ?? '';
      phone = prefs.getString('phone') ?? '';
      address = prefs.getString('address') ?? '';
      darkMode = prefs.getBool('dark') ?? false;
    });
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', customerName);
    await prefs.setString('phone', phone);
    await prefs.setString('address', address);
  }

  void addProduct(Product product) {
    setState(() {
      cart[product] = (cart[product] ?? 0) + 1;
    });
    playSound('cart');
  }

  void changeQuantity(Product product, int amount) {
    setState(() {
      final count = (cart[product] ?? 0) + amount;
      if (count <= 0) {
        cart.remove(product);
      } else {
        cart[product] = count;
      }
    });
  }

  int get total =>
      cart.entries.fold(0, (sum, item) => sum + item.key.price * item.value);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Az Market',
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF673AB7),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color(0xFF9575CD),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: StoreHome(app: this),
    );
  }
}

class StoreHome extends StatelessWidget {
  final _AzMarketAppState app;
  const StoreHome({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Az Market'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CartPage(app: app),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF673AB7)),
              child: Center(
                child: Text(
                  'Az Market',
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Baş sahypa'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Şahsy maglumatlar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfilePage(app: app),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Sazlamalar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingsPage(app: app),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/${product.image}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (_, __, ___) => const Center(
                      child: Icon(Icons.shopping_basket, size: 65),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    product.name,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                Text('${product.price} TMT'),
                const SizedBox(height: 5),
                FilledButton.icon(
                  onPressed: () => app.addProduct(product),
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Sebete goş'),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  final _AzMarketAppState app;
  const CartPage({super.key, required this.app});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final app = widget.app;

    return Scaffold(
      appBar: AppBar(title: const Text('Söwda sebedi')),
      body: app.cart.isEmpty
          ? const Center(child: Text('Sebediňiz boş'))
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: app.cart.entries.map((entry) {
                      return ListTile(
                        title: Text(entry.key.name),
                        subtitle: Text('${entry.key.price} TMT'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                app.changeQuantity(entry.key, -1);
                                setState(() {});
                              },
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text('${entry.value}'),
                            IconButton(
                              onPressed: () {
                                app.changeQuantity(entry.key, 1);
                                setState(() {});
                              },
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Jemi: ${app.total} TMT',
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CheckoutPage(app: app),
                              ),
                            );
                          },
                          child: const Text('Sargyt et'),
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

class CheckoutPage extends StatefulWidget {
  final _AzMarketAppState app;
  const CheckoutPage({super.key, required this.app});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final district = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final note = TextEditingController();

  String region = 'Aşgabat';
  String payment = 'Ýerinde töleg';

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
    district.dispose();
    phone.dispose();
    address.dispose();
    note.dispose();
    super.dispose();
  }

  void order() {
    if (district.text.trim().isEmpty ||
        phone.text.trim().isEmpty ||
        address.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maglumatlary dolduryň')),
      );
      return;
    }

    widget.app.phone = phone.text.trim();
    widget.app.address = address.text.trim();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => OrderSuccess(app: widget.app),
      ),
    );
    playSound('success');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sargyt maglumatlary')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Welaýaty saýlaň',
            style: TextStyle(fontSize: 18),
          ),
          DropdownButtonFormField<String>(
            value: region,
            isExpanded: true,
            items: regions.map((r) {
              return DropdownMenuItem(value: r, child: Text(r));
            }).toList(),
            onChanged: (value) {
              if (value != null) setState(() => region = value);
            },
          ),
          const SizedBox(height: 14),
          TextField(
            controller: district,
            decoration: const InputDecoration(
              labelText: 'Etrap / Şäher',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: phone,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Telefon belgisi',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: address,
            decoration: const InputDecoration(
              labelText: 'Doly salgy',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: note,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Goşmaça bellik (hökmany däl)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Töleg görnüşi',
            style: TextStyle(fontSize: 18),
          ),
          RadioListTile<String>(
            value: 'card',
            groupValue: payment,
            title: const Text('Bank kartasy bilen töleg'),
            onChanged: (value) => setState(() => payment = value!),
          ),
          RadioListTile<String>(
            value: 'Ýerinde töleg',
            groupValue: payment,
            title: const Text('Ýerinde töleg'),
            onChanged: (value) => setState(() => payment = value!),
          ),
          if (payment == 'card')
            const Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Synag düzgüni: hakyky töleg kabul edilmeýär. '
                  'Bank kart maglumatlaryňyzy girizmäň.',
                ),
              ),
            ),
          const SizedBox(height: 16),
          Text(
            'Jemi: ${widget.app.total} TMT',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: order,
            child: const Text('Sargydy tassyklamak'),
          ),
        ],
      ),
    );
  }
}

class OrderSuccess extends StatelessWidget {
  final _AzMarketAppState app;
  const OrderSuccess({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sargyt')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 90,
              ),
              const SizedBox(height: 20),
              const Text(
                'Sargydyňyz kabul edildi!',
                style: TextStyle(fontSize: 23),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  app.setState(() {
                    app.cart.clear();
                  });
                  Navigator.of(context).popUntil((route) => route.isFirst);
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

class ProfilePage extends StatefulWidget {
  final _AzMarketAppState app;
  const ProfilePage({super.key, required this.app});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController name;
  late final TextEditingController phone;
  late final TextEditingController address;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.app.customerName);
    phone = TextEditingController(text: widget.app.phone);
    address = TextEditingController(text: widget.app.address);
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    address.dispose();
    super.dispose();
  }

  Future<void> save() async {
    widget.app.setState(() {
      widget.app.customerName = name.text;
      widget.app.phone = phone.text;
      widget.app.address = address.text;
    });
    await widget.app.saveProfile();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Maglumatlar saklandy')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Şahsy maglumatlar')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(labelText: 'Adyňyz'),
          ),
          TextField(
            controller: phone,
            decoration: const InputDecoration(labelText: 'Telefon'),
          ),
          TextField(
            controller: address,
            decoration: const InputDecoration(labelText: 'Salgy'),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: save,
            child: const Text('Ýatda sakla'),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  final _AzMarketAppState app;
  const SettingsPage({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sazlamalar')),
      body: SwitchListTile(
        title: const Text('Gara / Ak tema'),
        value: app.darkMode,
        onChanged: (value) async {
          app.setState(() => app.darkMode = value);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('dark', value);
        },
      ),
    );
  }
}
