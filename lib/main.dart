
import 'package:flutter/material.dart';

void main() => runApp(const AzMarketApp());

const purple = Color(0xFF673AB7);

const translations = {
  'TM': {
    'fruit': 'Miwe',
    'laundry': 'Kir ýuwujy poroşoklar',
    'hygiene': 'Şampun we sabyn',
    'clean': 'Arassalaýjy serişdeler',
    'settings': 'Sazlamalar',
    'language': 'Dil saýla',
    'theme': 'Tema',
    'dark': 'Gara tema',
    'contact': 'Biz bilen habarlaşyň',
    'cart': 'Sebet',
    'empty': 'Sebediňiz boş',
    'add': 'Sebede goş',
    'continue': 'Dowam et',
    'address': 'Salgyňyz',
    'phone': 'Telefon belgiňiz',
    'region': 'Welaýaty saýlaň',
    'note': 'Goşmaça bellik (hökmany däl)',
    'payment': 'Töleg görnüşi',
    'cash': 'Ýerinde töleg',
    'card': 'Kart bilen töleg',
    'cardnumber': 'Karta belgisi (diňe synag üçin)',
    'confirm': 'Sargydy tassykla',
    'success': 'Töleg kabul edildi!',
    'success2': 'Az wagtdan harydyňyz eliňizde bolar.',
    'close': 'Ýap',
    'contacttext': 'Biz bilen habarlaşmak üçin maglumatlaryňyzy goýuň.',
    'added': 'Sebede goşuldy',
    'price': 'Bahasy',
  },
  'UZ': {
    'fruit': 'Mevalar',
    'laundry': 'Kir yuvish kukunlari',
    'hygiene': 'Shampun va sovun',
    'clean': 'Tozalash vositalari',
    'settings': 'Sozlamalar',
    'language': 'Tilni tanlang',
    'theme': 'Mavzu',
    'dark': 'Qora mavzu',
    'contact': 'Biz bilan bog‘lanish',
    'cart': 'Savat',
    'empty': 'Savatingiz bo‘sh',
    'add': 'Savatga qo‘shish',
    'continue': 'Davom etish',
    'address': 'Manzilingiz',
    'phone': 'Telefon raqamingiz',
    'region': 'Viloyatni tanlang',
    'note': 'Qo‘shimcha izoh (majburiy emas)',
    'payment': 'To‘lov turi',
    'cash': 'Joyida to‘lash',
    'card': 'Karta orqali to‘lash',
    'cardnumber': 'Karta raqami (faqat sinov uchun)',
    'confirm': 'Buyurtmani tasdiqlash',
    'success': 'To‘lov qabul qilindi!',
    'success2': 'Tez orada mahsulotingiz qo‘lingizda bo‘ladi.',
    'close': 'Yopish',
    'contacttext': 'Biz bilan bog‘lanish uchun xabaringizni qoldiring.',
    'added': 'Savatga qo‘shildi',
    'price': 'Narxi',
  },
  'TR': {
    'fruit': 'Meyveler',
    'laundry': 'Çamaşır deterjanları',
    'hygiene': 'Şampuan ve sabun',
    'clean': 'Temizlik ürünleri',
    'settings': 'Ayarlar',
    'language': 'Dil seçin',
    'theme': 'Tema',
    'dark': 'Koyu tema',
    'contact': 'Bizimle iletişime geçin',
    'cart': 'Sepet',
    'empty': 'Sepetiniz boş',
    'add': 'Sepete ekle',
    'continue': 'Devam et',
    'address': 'Adresiniz',
    'phone': 'Telefon numaranız',
    'region': 'Bölge seçin',
    'note': 'Ek not (isteğe bağlı)',
    'payment': 'Ödeme yöntemi',
    'cash': 'Kapıda ödeme',
    'card': 'Kart ile ödeme',
    'cardnumber': 'Kart numarası (sadece deneme)',
    'confirm': 'Siparişi onayla',
    'success': 'Ödeme kabul edildi!',
    'success2': 'Ürünleriniz kısa süre içinde elinizde olacak.',
    'close': 'Kapat',
    'contacttext': 'Bizimle iletişim kurmak için mesajınızı bırakın.',
    'added': 'Sepete eklendi',
    'price': 'Fiyat',
  },
};

class Product {
  final String id;
  final Map<String, String> names;
  final String price;
  final String image;
  final String emoji;
  final String category;

  const Product({
    required this.id,
    required this.names,
    required this.price,
    required this.image,
    required this.emoji,
    required this.category,
  });

  String name(String lang) => names[lang] ?? names['TM']!;
}

const productList = [
  Product(
    id: 'apple',
    names: {'TM': 'Alma', 'UZ': 'Olma', 'TR': 'Elma'},
    price: '20 manat',
    image: 'assets/images/alma.jpg',
    emoji: '🍎',
    category: 'fruit',
  ),
  Product(
    id: 'banana',
    names: {'TM': 'Banan', 'UZ': 'Banan', 'TR': 'Muz'},
    price: '35 manat',
    image: 'assets/images/banan.jpg',
    emoji: '🍌',
    category: 'fruit',
  ),
  Product(
    id: 'grape',
    names: {'TM': 'Üzüm', 'UZ': 'Uzum', 'TR': 'Üzüm'},
    price: '25 manat',
    image: 'assets/images/uzum.jpg',
    emoji: '🍇',
    category: 'fruit',
  ),
  Product(
    id: 'tomato',
    names: {'TM': 'Pomidor', 'UZ': 'Pomidor', 'TR': 'Domates'},
    price: '18 manat',
    image: 'assets/images/pomidor.jpg',
    emoji: '🍅',
    category: 'fruit',
  ),
  Product(
    id: 'orange',
    names: {'TM': 'Apelsin', 'UZ': 'Apelsin', 'TR': 'Portakal'},
    price: '30 manat',
    image: 'assets/images/apelsin.jpg',
    emoji: '🍊',
    category: 'fruit',
  ),
  Product(
    id: 'watermelon',
    names: {'TM': 'Garpyz', 'UZ': 'Tarvuz', 'TR': 'Karpuz'},
    price: '15 manat',
    image: 'assets/images/garpyz.jpg',
    emoji: '🍉',
    category: 'fruit',
  ),
  Product(
    id: 'potato',
    names: {'TM': 'Kartoşka', 'UZ': 'Kartoshka', 'TR': 'Patates'},
    price: '12 manat',
    image: 'assets/images/kartoshka.jpg',
    emoji: '🥔',
    category: 'fruit',
  ),
  Product(
    id: 'cucumber',
    names: {'TM': 'Hyýar', 'UZ': 'Bodring', 'TR': 'Salatalık'},
    price: '14 manat',
    image: 'assets/images/hyar.jpg',
    emoji: '🥒',
    category: 'fruit',
  ),
  Product(
    id: 'powder',
    names: {
      'TM': 'Kir ýuwujy poroşok',
      'UZ': 'Kir yuvish kukuni',
      'TR': 'Çamaşır deterjanı',
    },
    price: '45 manat',
    image: 'assets/images/poroshok.jpg',
    emoji: '🧺',
    category: 'laundry',
  ),
  Product(
    id: 'ariel',
    names: {
      'TM': 'Ariel poroşok',
      'UZ': 'Ariel kukuni',
      'TR': 'Ariel deterjan',
    },
    price: '55 manat',
    image: 'assets/images/ariel.jpg',
    emoji: '🫧',
    category: 'laundry',
  ),
  Product(
    id: 'shampoo',
    names: {'TM': 'Şampun', 'UZ': 'Shampun', 'TR': 'Şampuan'},
    price: '35 manat',
    image: 'assets/images/shampun.jpg',
    emoji: '🧴',
    category: 'hygiene',
  ),
  Product(
    id: 'soap',
    names: {'TM': 'Sabyn', 'UZ': 'Sovun', 'TR': 'Sabun'},
    price: '10 manat',
    image: 'assets/images/sabyn.jpg',
    emoji: '🧼',
    category: 'hygiene',
  ),
  Product(
    id: 'liquidsoap',
    names: {
      'TM': 'Suwuk sabyn',
      'UZ': 'Suyuq sovun',
      'TR': 'Sıvı sabun',
    },
    price: '25 manat',
    image: 'assets/images/suwuk_sabyn.jpg',
    emoji: '🧴',
    category: 'hygiene',
  ),
  Product(
    id: 'dish',
    names: {
      'TM': 'Gap-gaç ýuwujy',
      'UZ': 'Idish yuvish vositasi',
      'TR': 'Bulaşık deterjanı',
    },
    price: '30 manat',
    image: 'assets/images/gap_yuwujy.jpg',
    emoji: '🧽',
    category: 'clean',
  ),
  Product(
    id: 'floor',
    names: {
      'TM': 'Pol arassalaýjy',
      'UZ': 'Pol tozalagich',
      'TR': 'Yüzey temizleyici',
    },
    price: '35 manat',
    image: 'assets/images/pol.jpg',
    emoji: '🧹',
    category: 'clean',
  ),
];

const regions = [
  'Aşgabat',
  'Ahal welaýaty',
  'Balkan welaýaty',
  'Daşoguz welaýaty',
  'Lebap welaýaty',
  'Mary welaýaty',
];

class AzMarketApp extends StatefulWidget {
  const AzMarketApp({super.key});

  @override
  State<AzMarketApp> createState() => _AzMarketAppState();
}

class _AzMarketAppState extends State<AzMarketApp> {
  String lang = 'TM';
  bool dark = false;
  bool splash = true;
  final Map<String, int> cart = {};

  String tr(String key) => translations[lang]![key] ?? key;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => splash = false);
    });
  }

  void changeLanguage(String value) {
    setState(() => lang = value);
  }

  void changeTheme(bool value) {
    setState(() => dark = value);
  }

  void addProduct(Product product) {
    setState(() {
      cart[product.id] = (cart[product.id] ?? 0) + 1;
    });
  }

  void clearCart() {
    setState(() => cart.clear());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Az Market',
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorSchemeSeed: purple,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: purple,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: splash
          ? const SplashPage()
          : HomePage(
              lang: lang,
              dark: dark,
              cart: cart,
              tr: tr,
              onLanguage: changeLanguage,
              onTheme: changeTheme,
              onAdd: addProduct,
            ),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: purple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, color: Colors.white, size: 85),
            SizedBox(height: 15),
            Text(
              'Az Market',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String lang;
  final bool dark;
  final Map<String, int> cart;
  final String Function(String) tr;
  final ValueChanged<String> onLanguage;
  final ValueChanged<bool> onTheme;
  final ValueChanged<Product> onAdd;

  const HomePage({
    super.key,
    required this.lang,
    required this.dark,
    required this.cart,
    required this.tr,
    required this.onLanguage,
    required this.onTheme,
    required this.onAdd,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String category = 'fruit';

  int get cartCount =>
      widget.cart.values.fold<int>(0, (sum, count) => sum + count);

  void openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SettingsPage(
          lang: widget.lang,
          dark: widget.dark,
          tr: widget.tr,
          onLanguage: widget.onLanguage,
          onTheme: widget.onTheme,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleProducts =
        productList.where((p) => p.category == category).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Az Market',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: Badge(
              label: Text('$cartCount'),
              isLabelVisible: cartCount > 0,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartPage(
                    lang: widget.lang,
                    cart: widget.cart,
                    tr: widget.tr,
                  ),
                ),
              ).then((_) => setState(() {}));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: purple),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag, color: Colors.white, size: 55),
                    SizedBox(height: 8),
                    Text(
                      'Az Market',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.apple),
                title: Text(widget.tr('fruit')),
                selected: category == 'fruit',
                onTap: () {
                  setState(() => category = 'fruit');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.local_laundry_service),
                title: Text(widget.tr('laundry')),
                selected: category == 'laundry',
                onTap: () {
                  setState(() => category = 'laundry');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.shower),
                title: Text(widget.tr('hygiene')),
                selected: category == 'hygiene',
                onTap: () {
                  setState(() => category = 'hygiene');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cleaning_services),
                title: Text(widget.tr('clean')),
                selected: category == 'clean',
                onTap: () {
                  setState(() => category = 'clean');
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(widget.tr('settings')),
                onTap: () {
                  Navigator.pop(context);
                  openSettings();
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Text(
              widget.tr(category),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: visibleProducts.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.70,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final product = visibleProducts[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Center(
                            child: Text(
                              product.emoji,
                              style: const TextStyle(fontSize: 65),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: Text(
                          product.name(widget.lang),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(7),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                product.price,
                                style: const TextStyle(
                                  color: purple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton.filled(
                              onPressed: () {
                                widget.onAdd(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${product.name(widget.lang)} ${widget.tr('added')}',
                                    ),
                                    duration:
                                        const Duration(milliseconds: 800),
                                  ),
                                );
                                setState(() {});
                              },
                              icon: const Icon(Icons.add_shopping_cart),
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

class SettingsPage extends StatelessWidget {
  final String lang;
  final bool dark;
  final String Function(String) tr;
  final ValueChanged<String> onLanguage;
  final ValueChanged<bool> onTheme;

  const SettingsPage({
    super.key,
    required this.lang,
    required this.dark,
    required this.tr,
    required this.onLanguage,
    required this.onTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('settings'))),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(tr('language')),
            trailing: DropdownButton<String>(
              value: lang,
              items: const [
                DropdownMenuItem(value: 'TM', child: Text('Türkmençe')),
                DropdownMenuItem(value: 'UZ', child: Text('O‘zbekcha')),
                DropdownMenuItem(value: 'TR', child: Text('Türkçe')),
              ],
              onChanged: (value) {
                if (value != null) onLanguage(value);
                Navigator.pop(context);
              },
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: Text(tr('dark')),
            value: dark,
            onChanged: onTheme,
          ),
          ListTile(
            leading: const Icon(Icons.contact_support),
            title: Text(tr('contact')),
            subtitle: Text(tr('contacttext')),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(tr('contact')),
                  content: Text(tr('contacttext')),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(tr('close')),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final String lang;
  final Map<String, int> cart;
  final String Function(String) tr;

  const CartPage({
    super.key,
    required this.lang,
    required this.cart,
    required this.tr,
  });

  @override
  Widget build(BuildContext context) {
    final entries = cart.entries.toList();
    final hasProducts = entries.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('cart')),
     
