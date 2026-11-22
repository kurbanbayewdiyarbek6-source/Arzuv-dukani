
import 'package:flutter/material.dart';

void main() => runApp(const AzMarketApp());

const Map<String, Map<String, String>> words = {
  'TM': {
    'title': 'Az Market',
    'cart': 'Sebet',
    'empty': 'Sebediňiz boş',
    'add': 'Sebede goş',
    'language': 'Dil saýla',
    'fruit': 'Miwe',
    'laundry': 'Kir ýuwujy poroşok',
    'hygiene': 'Şampun we sabyn',
    'clean': 'Arassalaýjy serişdeler',
    'payment': 'Töleg',
    'card': 'Bank kartasy bilen töleg',
    'cash': 'Ýerinde töleg',
    'cardNumber': 'Karta belgisi (diňe synag üçin)',
    'test': 'Bu diňe synag. Hakyky töleg ýok.',
    'continue': 'Dowam et',
    'back': 'Yza',
    'added': 'Sebede goşuldy',
    'choose': 'Töleg görnüşini saýlaň',
  },
  'UZ': {
    'title': 'Az Market',
    'cart': 'Savat',
    'empty': 'Savatingiz bo‘sh',
    'add': 'Savatga qo‘shish',
    'language': 'Tilni tanlang',
    'fruit': 'Mevalar',
    'laundry': 'Kir yuvish kukuni',
    'hygiene': 'Shampun va sovun',
    'clean': 'Tozalash vositalari',
    'payment': 'To‘lov',
    'card': 'Bank kartasi orqali to‘lov',
    'cash': 'Joyida to‘lash',
    'cardNumber': 'Karta raqami (faqat sinov uchun)',
    'test': 'Bu faqat sinov. Haqiqiy to‘lov yo‘q.',
    'continue': 'Davom etish',
    'back': 'Orqaga',
    'added': 'Savatga qo‘shildi',
    'choose': 'To‘lov turini tanlang',
  },
  'TR': {
    'title': 'Az Market',
    'cart': 'Sepet',
    'empty': 'Sepetiniz boş',
    'add': 'Sepete ekle',
    'language': 'Dil seçin',
    'fruit': 'Meyveler',
    'laundry': 'Çamaşır deterjanı',
    'hygiene': 'Şampuan ve sabun',
    'clean': 'Temizlik ürünleri',
    'payment': 'Ödeme',
    'card': 'Banka kartı ile ödeme',
    'cash': 'Kapıda ödeme',
    'cardNumber': 'Kart numarası (sadece deneme)',
    'test': 'Bu sadece denemedir. Gerçek ödeme yok.',
    'continue': 'Devam et',
    'back': 'Geri',
    'added': 'Sepete eklendi',
    'choose': 'Ödeme türünü seçin',
  },
};

class Product {
  final String name;
  final String price;
  final String image;
  final String emoji;

  const Product(this.name, this.price, this.image, this.emoji);
}

const categories = [
  'fruit',
  'laundry',
  'hygiene',
  'clean',
];

const products = [
  [
    Product('Alma', '20 manat', 'assets/images/alma.jpg', '🍎'),
    Product('Banan', '35 manat', 'assets/images/banan.jpg', '🍌'),
    Product('Üzüm', '25 manat', 'assets/images/uzum.jpg', '🍇'),
    Product('Pomidor', '18 manat', 'assets/images/pomidor.jpg', '🍅'),
    Product('Apelsin', '30 manat', 'assets/images/apelsin.jpg', '🍊'),
    Product('Garpyz', '15 manat', 'assets/images/garpyz.jpg', '🍉'),
  ],
  [
    Product('Kir ýuwujy poroşok', '45 manat', 'assets/images/poroshok.jpg', '🧺'),
    Product('Ariel poroşok', '55 manat', 'assets/images/ariel.jpg', '🧼'),
    Product('Suwuk ýuwujy serişde', '40 manat', 'assets/images/gel.jpg', '🫧'),
  ],
  [
    Product('Şampun', '35 manat', 'assets/images/shampun.jpg', '🧴'),
    Product('Saç şampuny', '45 manat', 'assets/images/shampun2.jpg', '🧴'),
    Product('Sabyn', '10 manat', 'assets/images/sabyn.jpg', '🧼'),
    Product('Suwuk sabyn', '25 manat', 'assets/images/suwuk_sabyn.jpg', '🧴'),
  ],
  [
    Product('Gap-gaç ýuwujy', '30 manat', 'assets/images/gap_yuwujy.jpg', '🧽'),
    Product('Pol arassalaýjy', '35 manat', 'assets/images/pol.jpg', '🧹'),
    Product('Arassalaýjy serişde', '28 manat', 'assets/images/arassala.jpg', '🫧'),
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
  String lang = 'TM';
  int selectedCategory = 0;
  final PageController pageController = PageController();
  final Map<String, int> cart = {};

  String tr(String key) => words[lang]![key] ?? key;

  void addToCart(Product product) {
    setState(() {
      cart[product.name] = (cart[product.name] ?? 0) + 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} ${tr('added')}'),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartCount = cart.values.fold<int>(0, (a, b) => a + b);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('title'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<String>(
            tooltip: tr('language'),
            icon: const Icon(Icons.language),
            onSelected: (value) => setState(() => lang = value),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'TM', child: Text('Türkmençe')),
              PopupMenuItem(value: 'UZ', child: Text('O‘zbekcha')),
              PopupMenuItem(value: 'TR', child: Text('Türkçe')),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartPage(
                    cart: cart,
                    lang: lang,
                  ),
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: List.generate(categories.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(tr(categories[index])),
                    selected: selectedCategory == index,
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
              }),
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
                final list = products[categoryIndex];

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final product = list[index];

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
  final String lang;

  const CartPage({
    super.key,
    required this.cart,
    required this.lang,
  });

  String tr(String key) => words[lang]![key] ?? key;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('cart'))),
      body: cart.isEmpty
          ? Center(child: Text(tr('empty')))
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: cart.entries.map((entry) {
                      return ListTile(
                        leading: const Icon(Icons.shopping_basket),
                        title: Text(entry.key),
                        trailing: Text('x${entry.value}'),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CheckoutPage(lang: lang),
                          ),
                        );
                      },
                      child: Text(tr('continue')),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  final String lang;

  const CheckoutPage({super.key, required this.lang});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String payment = 'cash';
  String cardNumber = '';

  String tr(String key) => words[widget.lang]![key] ?? key;

  String get cardBrand {
    if (cardNumber.startsWith('51')) return 'Mastercard';
    if (cardNumber.startsWith('41')) return 'Visa';
    if (cardNumber.startsWith('21')) return 'Altyn Asyr';
    return '';
  }

  IconData get cardIcon {
    if (cardBrand == 'Mastercard') return Icons.credit_card;
    if (cardBrand == 'Visa') return Icons.credit_card;
    if (cardBrand == 'Altyn Asyr') return Icons.account_balance;
    return Icons.credit_card_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('payment'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            tr('choose'),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          RadioListTile<String>(
            value: 'cash',
            groupValue: payment,
            title: Text(tr('cash')),
            onChanged: (value) => setState(() => payment = value!),
          ),
          RadioListTile<String>(
            value: 'card',
            groupValue: payment,
            title: Text(tr('card')),
            onChanged: (value) => setState(() => payment = value!),
          ),
          if (payment == 'card') ...[
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 19,
              onChanged: (value) {
                setState(() => cardNumber = value.replaceAll(' ', ''));
              },
              decoration: InputDecoration(
                labelText: tr('cardNumber'),
                border: const OutlineInputBorder(),
                prefixIcon: Icon(cardIcon),
                suffixText: cardBrand.isEmpty ? null : cardBrand,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              tr('test'),
              style: const TextStyle(color: Colors.red),
            ),
          ],
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              if (payment == 'card') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(tr('test'))),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(tr('continue'))),
                );
              }
            },
            child: Text(tr('continue')),
          ),
        ],
      ),
    );
  }
}
