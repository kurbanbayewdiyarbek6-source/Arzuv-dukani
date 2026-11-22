
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const AzMarketApp());

const purple = Color(0xFF673AB7);
final AudioPlayer _soundPlayer = AudioPlayer();

Future<void> playSound(String file) async {
  try {
    await _soundPlayer.stop();
    await _soundPlayer.play(AssetSource('sounds/$file.wav'));
  } catch (_) {}
}

String tr(String lang, String key) {
  const words = {
    'welcome': ['Hoş geldiňiz!', 'Добро пожаловать!', 'Hoş geldiniz!'],
    'fresh': ['Täze we ter önümler', 'Свежие продукты', 'Taze ve doğal ürünler'],
    'cart': ['Sebet', 'Корзина', 'Sepet'],
    'empty': ['Sebet boş', 'Корзина пуста', 'Sepet boş'],
    'add': ['Sebede goş', 'В корзину', 'Sepete ekle'],
    'order': ['Sargyt et', 'Заказать', 'Sipariş ver'],
    'total': ['Jemi', 'Итого', 'Toplam'],
    'settings': ['Sazlamalar', 'Настройки', 'Ayarlar'],
    'profile': ['Maglumatlarym', 'Мои данные', 'Bilgilerim'],
    'delivery': ['Eltip beriş maglumatlary', 'Данные доставки', 'Teslimat bilgileri'],
    'region': ['Şäher / welaýat', 'Город / область', 'Şehir / bölge'],
    'district': ['Etrap ýa-da şäher', 'Район или город', 'İlçe veya şehir'],
    'phone': ['Telefon belgisi', 'Номер телефона', 'Telefon numarası'],
    'address': ['Salgy / köçe / öý', 'Адрес / улица / дом', 'Adres / sokak / ev'],
    'continue': ['Dowam et', 'Продолжить', 'Devam et'],
    'payment': ['Töleg usuly', 'Способ оплаты', 'Ödeme yöntemi'],
    'bank': ['Bank kartasy bilen töleg', 'Оплата банковской картой', 'Banka kartı ile ödeme'],
    'cash': ['Ýerinde töleg', 'Оплата при получении', 'Kapıda ödeme'],
    'cashInfo': ['Sargyt gelende nagt töleg', 'Оплата наличными при доставке', 'Teslimatta nakit ödeme'],
    'cardName': ['Kartyň eýesiniň ady', 'Имя владельца карты', 'Kart sahibinin adı'],
    'cardNumber': ['Kart belgisi', 'Номер карты', 'Kart numarası'],
    'expiry': ['Möhleti MM/YY', 'Срок MM/YY', 'Son kullanma MM/YY'],
    'cvv': ['CVV', 'CVV', 'CVV'],
    'test': ['Synag sahypasy: maglumatlar töleg üçin iberilmeýär we saklanmaýar.',
      'Тестовая страница: данные не отправляются и не сохраняются.',
      'Deneme sayfası: bilgiler ödeme için gönderilmez ve kaydedilmez.'],
    'confirm': ['Tassyklamak', 'Подтвердить', 'Onayla'],
    'success': ['Harydyňyz kabul edildi!', 'Ваш заказ принят!', 'Siparişiniz alındı!'],
    'soon': ['Az wagtda eltip beriler.', 'Скоро будет доставлено.', 'En kısa sürede teslim edilecek.'],
    'home': ['Baş sahypa', 'Главная', 'Ana sayfa'],
    'dark': ['Garaňky / Ýagty görnüş', 'Тёмная / Светлая тема', 'Koyu / Açık tema'],
    'darkInfo': ['Gara ýa-da ak fon', 'Тёмный или светлый фон', 'Koyu veya açık arka plan'],
    'save': ['Sakla', 'Сохранить', 'Kaydet'],
    'saved': ['Maglumatlar saklandy', 'Данные сохранены', 'Bilgiler kaydedildi'],
    'name': ['Adyňyz', 'Ваше имя', 'Adınız'],
    'error': ['Etrap we telefon belgisi giriziň', 'Введите район и номер телефона', 'İlçe ve telefon numarası girin'],
    'language': ['Dil saýlaň', 'Выберите язык', 'Dil seçin'],
    'fruits': ['Miwe we gök önümler', 'Фрукты и овощи', 'Meyve ve sebzeler'],
    'laundry': ['Kir ýuwujy', 'Стиральные средства', 'Çamaşır deterjanı'],
    'shampoo': ['Şampun', 'Шампунь', 'Şampuan'],
    'cleaning': ['Arassaçylyk serişdeleri', 'Чистящие средства', 'Temizlik ürünleri'],
    'soap': ['Sabyn', 'Мыло', 'Sabun'],
    'updating': ['Harytlar tiz wagtda goşular', 'Товары скоро появятся', 'Ürünler yakında eklenecek'],
    'all': ['Ähli harytlar', 'Все товары', 'Tüm ürünler'],
  };

  final index = lang == 'ru' ? 1 : lang == 'tr' ? 2 : 0;
  return words[key]?[index] ?? key;
}

String phonePrefix(String value) {
  final cleaned = value.trim();
  if (cleaned.isEmpty) return '+993';
  return cleaned.startsWith('+993') ? cleaned : '+993${cleaned.replaceAll(RegExp(r'^\+?'), '')}';
}

class AzMarketApp extends StatefulWidget {
  const AzMarketApp({super.key});
  @override
  State<AzMarketApp> createState() => AzMarketAppState();
}

class AzMarketAppState extends State<AzMarketApp> {
  bool dark = false;
  String lang = 'tm';
  String customerName = '';
  String phone = '+993';
  String address = '';
  String region = 'Aşgabat';
  String district = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      dark = p.getBool('dark') ?? false;
      lang = p.getString('lang') ?? 'tm';
      customerName = p.getString('name') ?? '';
      phone = p.getString('phone') ?? '+993';
      address = p.getString('address') ?? '';
      region = p.getString('region') ?? 'Aşgabat';
      district = p.getString('district') ?? '';
    });
  }

  Future<void> saveProfile() async {
    final p = await SharedPreferences.getInstance();
    await p.setBool('dark', dark);
    await p.setString('lang', lang);
    await p.setString('name', customerName);
    await p.setString('phone', phone);
    await p.setString('address', address);
    await p.setString('region', region);
    await p.setString('district', district);
  }

  void toggleTheme(bool v) {
    setState(() => dark = v);
    saveProfile();
    playSound('click');
  }

  void changeLanguage(String value) {
    setState(() => lang = value);
    saveProfile();
    playSound('click');
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Az Market',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: purple,
        brightness: dark ? Brightness.dark : Brightness.light,
      ),
      scaffoldBackgroundColor:
          dark ? const Color(0xFF15131A) : const Color(0xFFF7F5FA),
    ),
    home: StoreHome(app: this),
  );
}

class Product {
  final String name;
  final String emoji;
  final int price;
  const Product(this.name, this.emoji, this.price);
}

const products = [
  Product('Pomidor', '🍅', 20),
  Product('Alma', '🍎', 25),
  Product('Kartoşka', '🥔', 12),
  Product('Banan', '🍌', 35),
  Product('Apelsin', '🍊', 30),
  Product('Üzüm', '🍇', 40),
  Product('Hyýar', '🥒', 18),
  Product('Garpyz', '🍉', 15),
];

class StoreHome extends StatefulWidget {
  final AzMarketAppState app;
  const StoreHome({super.key, required this.app});

  @override
  State<StoreHome> createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  final Map<Product, int> cart = {};
  String category = 'all';

  int get count => cart.values.fold(0, (a, b) => a + b);
  int get total => cart.entries.fold(0, (a, e) => a + e.key.price * e.value);

  void add(Product p) {
    setState(() => cart[p] = (cart[p] ?? 0) + 1);
    playSound('cart');
  }

  void openCart() {
    playSound('click');
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => CartPage(
        cart: cart,
        app: widget.app,
        onChanged: () => setState(() {}),
        onClear: () => setState(() => cart.clear()),
      ),
    ));
  }

  void selectCategory(String value) {
    setState(() => category = value);
    Navigator.pop(context);
    playSound('click');
  }

  @override
  Widget build(BuildContext context) {
    final app = widget.app;
    final lang = app.lang;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Az Market', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: openCart,
            icon: Badge(label: Text('$count'), child: const Icon(Icons.shopping_cart_outlined)),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            onSelected: (v) {
              playSound('click');
              if (v == 'settings') {
                Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage(app: app)));
              } else if (v == 'profile') {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage(app: app)));
              } else if (v.startsWith('lang_')) {
                app.changeLanguage(v.substring(5));
              } else {
                selectCategory(v);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'all', child: Text(tr(lang, 'all'))),
              PopupMenuItem(value: 'fruits', child: Text('🍎 ${tr(lang, 'fruits')}')),
              PopupMenuItem(value: 'laundry', child: Text('🧺 ${tr(lang, 'laundry')}')),
              PopupMenuItem(value: 'shampoo', child: Text('🧴 ${tr(lang, 'shampoo')}')),
              PopupMenuItem(value: 'cleaning', child: Text('🧹 ${tr(lang, 'cleaning')}')),
              PopupMenuItem(value: 'soap', child: Text('🧼 ${tr(lang, 'soap')}')),
              const PopupMenuDivider(),
              PopupMenuItem(value: 'settings', child: Text('⚙️ ${tr(lang, 'settings')}')),
              PopupMenuItem(value: 'profile', child: Text('👤 ${tr(lang, 'profile')}')),
              const PopupMenuDivider(),
              PopupMenuItem(value: 'lang_tm', child: const Text('🇹🇲 Türkmençe')),
              PopupMenuItem(value: 'lang_ru', child: const Text('🇷🇺 Русский')),
              PopupMenuItem(value: 'lang_tr', child: const Text('🇹🇷 Türkçe')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tr(lang, 'welcome'), style: Theme.of(context).textTheme.titleLarge),
                Text(tr(lang, 'fresh')),
                const SizedBox(height: 8),
                Text(
                  category == 'all' || category == 'fruits'
                      ? tr(lang, 'fruits')
                      : tr(lang, category),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: purple),
                ),
              ],
            ),
          ),
          Expanded(
            child: category != 'all' && category != 'fruits'
                ? Center(child: Text(tr(lang, 'updating')))
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .83,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, i) {
                      final p = products[i];
                      return Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(p.emoji, style: const TextStyle(fontSize: 65)),
                              ),
                            ),
                            Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('${p.price} manat / kg'),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: SizedBox(
                                width: double.infinity,
                                child: FilledButton(
                                  onPressed: () => add(p),
                                  child: Text(tr(lang, 'add')),
                                ),
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
  final Map<Product, int> cart;
  final VoidCallback onChanged;
  final VoidCallback onClear;
  final AzMarketAppState app;

  const CartPage({
    super.key,
    required this.cart,
    required this.onChanged,
    required this.onClear,
    required this.app,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final lang = widget.app.lang;
    final total = widget.cart.entries.fold(0, (a, e) => a + e.key.price * e.value);

    return Scaffold(
      appBar: AppBar(title: Text(tr(lang, 'cart'))),
      body: widget.cart.isEmpty
          ? Center(child: Text(tr(lang, 'empty')))
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: widget.cart.entries.map((e) => ListTile(
                      leading: Text(e.key.emoji, style: const TextStyle(fontSize: 30)),
                      title: Text(e.key.name),
                      subtitle: Text('${e.key.price} manat × ${e.value}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          setState(() => widget.cart.remove(e.key));
                          widget.onChanged();
                          playSound('click');
                        },
                      ),
                    )).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('${tr(lang, 'total')}: $total manat',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            playSound('click');
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => DeliveryInfoPage(
                                app: widget.app,
                                onContinue: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (_) => CheckoutPage(
                                      app: widget.app,
                                      onDone: widget.onClear,
                                    ),
                                  ));
                                },
                              ),
                            ));
                          },
                          child: Text(tr(lang, 'order')),
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

class DeliveryInfoPage extends StatefulWidget {
  final AzMarketAppState app;
  final VoidCallback onContinue;

  const DeliveryInfoPage({super.key, required this.app, required this.onContinue});

  @override
  State<DeliveryInfoPage> createState() => _DeliveryInfoPageState();
}

class _DeliveryInfoPageState extends State<DeliveryInfoPage> {
  late String region = widget.app.region;
  late final district = TextEditingController(text: widget.app.district);
  late final phone = TextEditingController(text: phonePrefix(widget.app.phone));
  late final address = TextEditingController(text: widget.app.address);

  final regions = ['Aşgabat', 'Ahal', 'Balkan', 'Daşoguz', 'Lebap', 'Mary'];

  @override
  void dispose() {
    district.dispose();
    phone.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.app.lang;

    return Scaffold(
      appBar: AppBar(title: Text(tr(lang, 'delivery'))),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(tr(lang, 'region'), style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: region,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: regions.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
            onChanged: (v) => setState(() => region = v ?? 'Aşgabat'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: district,
            decoration: InputDecoration(
              labelText: tr(lang, 'district'),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: tr(lang, 'phone'),
              border: const OutlineInputBorder(),
            ),
            onChanged: (v) {
              if (!v.startsWith('+993')) {
                phone.value = TextEditingValue(
                  text: phonePrefix(v),
                  selection: TextSelection.collapsed(offset: phonePrefix(v).length),
                );
              }
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: address,
            decoration: InputDecoration(
              labelText: tr(lang, 'address'),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 22),
          FilledButton(
            onPressed: () async {
              if (phone.text.trim().length <= 4 || district.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(tr(lang, 'error'))),
                );
                return;
              }
              widget.app.region = region;
              widget.app.district = district.text;
              widget.app.phone = phonePrefix(phone.text);
              widget.app.address = address.text;
              await widget.app.saveProfile();
              if (mounted) {
                playSound('click');
                widget.onContinue();
              }
            },
            child: Text(tr(lang, 'continue')),
          ),
        ],
      ),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  final AzMarketAppState app;
  final VoidCallback onDone;

  const CheckoutPage({super.key, required this.app, required this.onDone});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String method = 'card';
  final name = TextEditingController();
  final number = TextEditingController();
  final expiry = TextEditingController();
  final cvv = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    number.dispose();
    expiry.dispose();
    cvv.dispose();
    super.dispose();
  }

  String get cardBrand {
    final digits = number.text.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('51')) return 'Mastercard';
    if (digits.startsWith('41')) return 'VISA';
    if (digits.startsWith('21')) return 'Altyn Asyr';
    return '';
  }

  void finish() {
    playSound('success');
    widget.onDone();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => OrderSuccess(app: widget.app)),
      (r) => r.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.app.lang;

    return Scaffold(
      appBar: AppBar(title: Text(tr(lang, 'payment'))),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          RadioListTile<String>(
            value: 'card',
            groupValue: method,
   
