
import 'package:flutter/material.dart';

void main() {
  runApp(const AzMarketApp());
}

const purple = Color(0xFF673AB7);
const orange = Color(0xFFFF9800);

class Product {
  final String name;
  final String category;
  final String emoji;
  final double price;
  final String unit;

  const Product({
    required this.name,
    required this.category,
    required this.emoji,
    required this.price,
    this.unit = 'kg',
  });
}

const products = [
  Product(name: 'Alma', category: 'Fruits', emoji: '🍎', price: 25),
  Product(name: 'Banan', category: 'Fruits', emoji: '🍌', price: 32),
  Product(name: 'Üzüm', category: 'Fruits', emoji: '🍇', price: 45),
  Product(name: 'Apelsin', category: 'Fruits', emoji: '🍊', price: 30),
  Product(name: 'Garpyz', category: 'Fruits', emoji: '🍉', price: 12),
  Product(name: 'Pomidor', category: 'Vegetables', emoji: '🍅', price: 28),
  Product(name: 'Hyýar', category: 'Vegetables', emoji: '🥒', price: 18),
  Product(name: 'Kartoşka', category: 'Vegetables', emoji: '🥔', price: 15),
  Product(name: 'Süýt', category: 'Drinks', emoji: '🥛', price: 22, unit: 'pcs'),
  Product(name: 'Şire', category: 'Drinks', emoji: '🧃', price: 20, unit: 'pcs'),
  Product(name: 'Suw', category: 'Drinks', emoji: '💧', price: 8, unit: 'pcs'),
  Product(name: 'Şampun', category: 'Cleaning', emoji: '🧴', price: 65, unit: 'pcs'),
  Product(name: 'Sabyn', category: 'Cleaning', emoji: '🧼', price: 15, unit: 'pcs'),
  Product(name: 'Kir ýuwujy poroşok', category: 'Cleaning', emoji: '🫧', price: 85, unit: 'pcs'),
  Product(name: 'Gap-gaç ýuwujy', category: 'Cleaning', emoji: '🧽', price: 35, unit: 'pcs'),
  Product(name: 'Çörek', category: 'Food', emoji: '🍞', price: 12, unit: 'pcs'),
  Product(name: 'Ýumurtga', category: 'Food', emoji: '🥚', price: 5, unit: 'pcs'),
  Product(name: 'Peýnir', category: 'Food', emoji: '🧀', price: 90),
];

class AzMarketApp extends StatefulWidget {
  const AzMarketApp({super.key});

  @override
  State<AzMarketApp> createState() => _AzMarketAppState();
}

class _AzMarketAppState extends State<AzMarketApp> {
  bool darkMode = false;
  String language = 'TM';
  bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AZ MARKET',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: darkMode ? Brightness.dark : Brightness.light,
        ),
        scaffoldBackgroundColor:
            darkMode ? const Color(0xFF171421) : const Color(0xFFF7F5FB),
        appBarTheme: const AppBarTheme(
          backgroundColor: purple,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: loggedIn
          ? MarketHome(
              language: language,
              onLanguage: (v) => setState(() => language = v),
              darkMode: darkMode,
              onTheme: () => setState(() => darkMode = !darkMode),
              onLogout: () => setState(() => loggedIn = false),
            )
          : LoginPage(
              language: language,
              onLanguage: (v) => setState(() => language = v),
              onLogin: () => setState(() => loggedIn = true),
            ),
    );
  }
}

class Words {
  static const data = {
    'TM': {
      'login': 'Hoş geldiňiz!',
      'subtitle': 'AZ MARKET bilen söwda etmek aňsat',
      'name': 'Adyňyz',
      'password': 'Açar söz',
      'enter': 'Giriş',
      'guest': 'Myhman hökmünde gir',
      'home': 'Baş sahypa',
      'search': 'Haryt gözle...',
      'categories': 'Bölümler',
      'all': 'Hemmesi',
      'fruits': 'Miwe',
      'vegetables': 'Gök önümler',
      'drinks': 'Içgiler',
      'cleaning': 'Arassaçylyk',
      'food': 'Iýmit',
      'popular': 'Meşhur harytlar',
      'cart': 'Sebet',
      'favorites': 'Halanlarym',
      'settings': 'Sazlamalar',
      'add': 'Sebede goş',
      'empty': 'Sebediňiz boş',
      'total': 'Jemi',
      'order': 'Sargyt et',
      'checkout': 'Sargydy tassyklamak',
      'success': 'Synag sargydyňyz kabul edildi!',
      'language': 'Dil',
      'theme': 'Garaňky görnüş',
      'logout': 'Çykmak',
      'close': 'Ýap',
      'remove': 'Aýyrmak',
      'quantity': 'Sany',
      'delivery': 'Eltip bermek',
      'address': 'Salgyňyz',
      'phone': 'Telefon belgiňiz',
      'payment': 'Töleg usuly',
      'cash': 'Nagt töleg',
      'card': 'Bank kartasy',
      'continue': 'Dowam et',
      'emptyFav': 'Halanýan haryt ýok',
    },
    'UZ': {
      'login': 'Xush kelibsiz!',
      'subtitle': 'AZ MARKET bilan xarid qilish oson',
      'name': 'Ismingiz',
      'password': 'Parol',
      'enter': 'Kirish',
      'guest': 'Mehmon sifatida kirish',
      'home': 'Bosh sahifa',
      'search': 'Mahsulot qidirish...',
      'categories': 'Bo‘limlar',
      'all': 'Hammasi',
      'fruits': 'Mevalar',
      'vegetables': 'Sabzavotlar',
      'drinks': 'Ichimliklar',
      'cleaning': 'Tozalik',
      'food': 'Oziq-ovqat',
      'popular': 'Mashhur mahsulotlar',
      'cart': 'Savatcha',
      'favorites': 'Sevimlilar',
      'settings': 'Sozlamalar',
      'add': 'Savatchaga qo‘shish',
      'empty': 'Savatchangiz bo‘sh',
      'total': 'Jami',
      'order': 'Buyurtma berish',
      'checkout': 'Buyurtmani tasdiqlash',
      'success': 'Sinov buyurtmangiz qabul qilindi!',
      'language': 'Til',
      'theme': 'Tungi rejim',
      'logout': 'Chiqish',
      'close': 'Yopish',
      'remove': 'O‘chirish',
      'quantity': 'Soni',
      'delivery': 'Yetkazib berish',
      'address': 'Manzilingiz',
      'phone': 'Telefon raqamingiz',
      'payment': 'To‘lov usuli',
      'cash': 'Naqd pul',
      'card': 'Bank kartasi',
      'continue': 'Davom etish',
      'emptyFav': 'Sevimli mahsulotlar yo‘q',
    },
    'TR': {
      'login': 'Hoş geldiniz!',
      'subtitle': 'AZ MARKET ile alışveriş çok kolay',
      'name': 'Adınız',
      'password': 'Şifre',
      'enter': 'Giriş yap',
      'guest': 'Misafir olarak gir',
      'home': 'Ana sayfa',
      'search': 'Ürün ara...',
      'categories': 'Kategoriler',
      'all': 'Tümü',
      'fruits': 'Meyveler',
      'vegetables': 'Sebzeler',
      'drinks': 'İçecekler',
      'cleaning': 'Temizlik',
      'food': 'Gıda',
      'popular': 'Popüler ürünler',
      'cart': 'Sepet',
      'favorites': 'Favorilerim',
      'settings': 'Ayarlar',
      'add': 'Sepete ekle',
      'empty': 'Sepetiniz boş',
      'total': 'Toplam',
      'order': 'Sipariş ver',
      'checkout': 'Siparişi onayla',
      'success': 'Deneme siparişiniz alındı!',
      'language': 'Dil',
      'theme': 'Karanlık mod',
      'logout': 'Çıkış yap',
      'close': 'Kapat',
      'remove': 'Kaldır',
      'quantity': 'Adet',
      'delivery': 'Teslimat',
      'address': 'Adresiniz',
      'phone': 'Telefon numaranız',
      'payment': 'Ödeme yöntemi',
      'cash': 'Nakit',
      'card': 'Banka kartı',
      'continue': 'Devam et',
      'emptyFav': 'Favori ürün yok',
    },
  };

  static String get(String lang, String key) {
    return data[lang]?[key] ?? data['TM']![key] ?? key;
  }
}

class LoginPage extends StatefulWidget {
  final String language;
  final ValueChanged<String> onLanguage;
  final VoidCallback onLogin;

  const LoginPage({
    super.key,
    required this.language,
    required this.onLanguage,
    required this.onLogin,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  String t(String key) => Words.get(widget.language, key);

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF311B92), Color(0xFF673AB7), Color(0xFF9575CD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: DropdownButton<String>(
                        value: widget.language,
                        dropdownColor: Colors.white,
                        underline: const SizedBox(),
                        style: const TextStyle(color: Colors.black),
                        items: const [
                          DropdownMenuItem(value: 'TM', child: Text('🇹🇲 Türkmen')),
                          DropdownMenuItem(value: 'UZ', child: Text('🇺🇿 O‘zbek')),
                          DropdownMenuItem(value: 'TR', child: Text('🇹🇷 Türkçe')),
                        ],
                        onChanged: (v) {
                          if (v != null) widget.onLanguage(v);
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: 145,
                      height: 145,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(38),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 25,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text('🛒', style: TextStyle(fontSize: 76)),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'AZ MARKET',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                      ),
                    ),
                    const Text(
                      'ARZAN MARKET',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      t('subtitle'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 35),
                    Card(
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          children: [
                            Text(
                              t('login'),
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: purple,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: t('name'),
                                prefixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: t('password'),
                                prefixIcon: const Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: purple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: widget.onLogin,
                                child: Text(t('enter')),
                              ),
                            ),
                            TextButton(
                              onPressed: widget.onLogin,
                              child: Text(t('guest')),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'AZ MARKET • ARZAN MARKET',
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MarketHome extends StatefulWidget {
  final String language;
  final ValueChanged<String> onLanguage;
  final bool darkMode;
  final VoidCallback onTheme;
  final VoidCallback onLogout;

  const MarketHome({
    super.key,
    required this.language,
    required this.onLanguage,
    required this.darkMode,
    required this.onTheme,
    required this.onLogout,
  });

  @override
  State<MarketHome> createState() => _MarketHomeState();
}

class _MarketHomeState extends State<MarketHome> {
  final Map<Product, int> cart = {};
  final Set<Product> favorites = {};
  final searchController = TextEditingController();

  String selectedCategory = 'All';
  String searchText = '';
  int page = 0;

  String t(String key) => Words.get(widget.language, key);

  String categoryName(String category) {
    switch (category) {
      case 'Fruits':
        return t('fruits');
      case 'Vegetables':
        return t('vegetables');
      case 'Drinks':
        return t('drinks');
      case 'Cleaning':
        return t('cleaning');
      case 'Food':
        return t('food');
      default:
        return t('all');
    }
  }

  List<Product> get filteredProducts {
    return products.where((p) {
      final matchesCategory =
          selectedCategory == 'All' || p.category == selectedCategory;
      final matchesSearch =
          p.name.toLowerCase().contains(searchText.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  int get cartCount => cart.values.fold(0, (a, b) => a + b);

  double get total =>
      cart.entries.fold(0, (sum, item) => sum + item.key.price * item.value);

  void add(Product product) {
    setState(() => cart[product] = (cart[product] ?? 0) + 1);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} — ${t('add')}'),
        duration: const Duration(milliseconds: 700),
      ),
    );
  }

  void changeQuantity(Product product, int amount) {
    setState(() {
      final next = (cart[product] ?? 0) + amount;
      if (next <= 0) {
        cart.remove(product);
      } else {
        cart[product] = next;
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AZ MARKET', style: TextStyle(fontWeight: FontWeight.w900)),
            Text(
              'ARZAN MARKET',
              style: TextStyle(fontSize: 10, letterSpacing: 2),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: t('favorites'),
            onPressed: () => setState(() => page = 2),
            icon: const Icon(Icons.favorite_border),
          ),
          Stack(
            children: [
              IconButton(
                tooltip: t('cart'),
                onPressed: () => setState(() => page = 1),
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              if (cartCount > 0)
                Positioned(
                  right: 5,
                  top: 3,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: orange,
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 5),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [purple, Color(0xFF9575CD)]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.shopping_bag, color: Colors.white, size: 45),
                  SizedBox(height: 8),
                  Text(
                    'AZ MARKET',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('ARZAN MARKET', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(t('home')),
              onTap: () {
                setState(() => page = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: Text(t('cart')),
              trailing: Text('$cartCount'),
              onTap: () {
                setState(() => page = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: Text(t('favorites')),
              onTap: () {
                setState(() => page = 2);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            
                ListTile(
                  leading: const Icon(Icons.close),
                  title: Text(t('close')),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showCheckout() {
    final addressController = TextEditingController();
    final phoneController = TextEditingController();
    String payment = 'cash';

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(t('checkout')),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: t('address'),
                      prefixIcon: const Icon(Icons.location_on),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: t('phone'),
                      prefixIcon: const Icon(Icons.phone),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      t('payment'),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: Text(t('cash')),
                    value: 'cash',
                    groupValue: payment,
                    onChanged: (v) {
                      setDialogState(() => payment = v!);
                    },
                  ),
                  RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: Text(t('card')),
                    value: 'card',
                    groupValue: payment,
                    onChanged: (v) {
                      setDialogState(() => payment = v!);
                    },
                  ),
                  Text(
                    '${t('total')}: ${total.toStringAsFixed(2)} TL',
                    style: const TextStyle(
                      color: purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Bu diňe synag sargydydyr. Hakyky töleg geçirilmeýär.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(t('close')),
              ),
              FilledButton(
                onPressed: () {
                  if (addressController.text.trim().isEmpty ||
                      phoneController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(content: Text(t('address'))),
                    );
                    return;
                  }

                  Navigator.pop(dialogContext);

                  setState(() {
                    cart.clear();
                    page = 0;
                  });

                  ScaffoldMessenger.of(this.context).showSnackBar(
                    SnackBar(content: Text(t('success'))),
                  );
                },
                child: Text(t('order')),
              ),
            ],
          );
        },
      ),
    );
  }
}

          
