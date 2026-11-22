
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ArzuvDukan());
}

class ArzuvDukan extends StatelessWidget {
  const ArzuvDukan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arzuv Dukan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const ShopPage(),
    );
  }
}

final products = [
  {'name': 'Alma', 'price': 25, 'emoji': '🍎'},
  {'name': 'Banan', 'price': 35, 'emoji': '🍌'},
  {'name': 'Apelsin', 'price': 30, 'emoji': '🍊'},
  {'name': 'Çilek', 'price': 60, 'emoji': '🍓'},
  {'name': 'Üzüm', 'price': 45, 'emoji': '🍇'},
  {'name': 'Garpyz', 'price': 20, 'emoji': '🍉'},
  {'name': 'Ananas', 'price': 75, 'emoji': '🍍'},
  {'name': 'Şetdaly', 'price': 40, 'emoji': '🍑'},
  {'name': 'Armut', 'price': 30, 'emoji': '🍐'},
  {'name': 'Kiwi', 'price': 50, 'emoji': '🥝'},
];

final Map<String, List<String>> regions = {
  'Ahal welaýaty': [
    'Ak bugdaý', 'Altyn asyr', 'Bäherden',
    'Gökdepe', 'Kaka', 'Sarahs', 'Tejen'
  ],
  'Balkan welaýaty': [
    'Balkanabat şäheri', 'Türkmenbaşy şäheri',
    'Bereket', 'Etrek', 'Esenguly',
    'Magtymguly', 'Serdar'
  ],
  'Daşoguz welaýaty': [
    'Daşoguz şäheri', 'Akdepe', 'Boldumsaz',
    'Görogly', 'Gubadag', 'Garaşsyzlyk',
    'Köneürgenç', 'Ruhubelent'
  ],
  'Lebap welaýaty': [
    'Türkmenabat şäheri', 'Atamyrat',
    'Darganata', 'Döwletli', 'Farap',
    'Garabekewül', 'Halaç', 'Hojambaz',
    'Köýtendag', 'Saýat', 'Çärjew'
  ],
  'Mary welaýaty': [
    'Mary şäheri', 'Altyn sähra', 'Baýramaly',
    'Mary', 'Murgap', 'Oguz han', 'Sakarçäge',
    'Tagtabazar', 'Türkmengala', 'Wekilbazar',
    'Ýolöten'
  ],
  'Aşgabat şäheri': ['Aşgabat şäheri'],
};

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final Map<int, int> cart = {};

  int get cartCount =>
      cart.values.fold(0, (sum, quantity) => sum + quantity);

  void addProduct(int index) {
    setState(() {
      cart[index] = (cart[index] ?? 0) + 1;
    });
  }

  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartPage(
          cart: cart,
          onOrderFinished: () {
            setState(() {
              cart.clear();
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Arzuv Dukan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: openCart,
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_basket_outlined),
                if (cartCount > 0)
                  Positioned(
                    right: -8,
                    top: -8,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: Colors.red,
                      child: Text(
                        '$cartCount',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.78,
        ),
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product['emoji'] as String,
                    style: const TextStyle(fontSize: 55),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product['name'] as String,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text('${product['price']} manat'),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => addProduct(index),
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text('Satyn al'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: openCart,
        icon: const Icon(Icons.shopping_basket),
        label: Text('Sebet ($cartCount)'),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  final Map<int, int> cart;
  final VoidCallback onOrderFinished;

  const CartPage({
    super.key,
    required this.cart,
    required this.onOrderFinished,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int get total {
    int sum = 0;
    widget.cart.forEach((index, quantity) {
      sum += (products[index]['price'] as int) * quantity;
    });
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.cart.keys.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Sebet')),
      body: widget.cart.isEmpty
          ? const Center(child: Text('Sebediňiz boş'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      final index = items[i];
                      final product = products[index];
                      final quantity = widget.cart[index]!;

                      return Card(
                        child: ListTile(
                          leading: Text(
                            product['emoji'] as String,
                            style: const TextStyle(fontSize: 32),
                          ),
                          title: Text(product['name'] as String),
                          subtitle: Text(
                            '${product['price']} manat',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 1) {
                                      widget.cart[index] = quantity - 1;
                                    } else {
                                      widget.cart.remove(index);
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Text('$quantity'),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.cart[index] = quantity + 1;
                                  });
                                },
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Jemi: $total manat',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddressPage(
                                  onOrderFinished:
                                      widget.onOrderFinished,
                                ),
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

class AddressPage extends StatefulWidget {
  final VoidCallback onOrderFinished;

  const AddressPage({
    super.key,
    required this.onOrderFinished,
  });

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final houseController = TextEditingController();
  final extraController = TextEditingController();

  String? selectedRegion;
  String? selectedDistrict;

  @override
  void dispose() {
    phoneController.dispose();
    addressController.dispose();
    houseController.dispose();
    extraController.dispose();
    super.dispose();
  }

  Widget textField(
    String label,
    TextEditingController controller, {
    bool required = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (required &&
              (value == null || value.trim().isEmpty)) {
            return 'Bu meýdançany dolduryň';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eltip beriş salgysy')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              maxLength: 8,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: 'Telefon belgisi',
                prefixText: '+993 ',
                border: OutlineInputBorder(),
                counterText: '',
              ),
              validator: (value) {
                if (value == null || value.length != 8) {
                  return '8 san giriziň';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedRegion,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Welaýat saýla',
                border: OutlineInputBorder(),
              ),
              items: regions.keys.map((region) {
                return DropdownMenuItem(
                  value: region,
                  child: Text(region),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRegion = value;
                  selectedDistrict = null;
                });
              },
              validator: (value) =>
                  value == null ? 'Welaýaty saýlaň' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedDistrict,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Etrap ýa-da şäher saýla',
                border: OutlineInputBorder(),
              ),
              items: (selectedRegion == null
                      ? <String>[]
                      : regions[selectedRegion]!)
                  .map((district) {
                return DropdownMenuItem(
                  value: district,
                  child: Text(district),
                );
              }).toList(),
              onChanged: selectedRegion == null
                  ? null
                  : (value) {
                      setState(() {
                        selectedDistrict = value;
                      });
                    },
              validator: (value) =>
                  value == null ? 'Etraby saýlaň' : null,
            ),
            const SizedBox(height: 12),
            textField('Öý salgysy', addressController),
            textField(
              'Jaý belgisi (hökmany däl)',
              houseController,
              required: false,
            ),
            textField(
              'Goşmaça maglumat (hökmany däl)',
              extraController,
              required: false,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: FilledButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentPage(
                          onOrderFinished: widget.onOrderFinished,
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Dowam et'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  final VoidCallback onOrderFinished;

  const PaymentPage({
    super.key,
    required this.onOrderFinished,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String payment = 'Nagt töleg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Töleg usuly')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            RadioListTile<String>(
              title: const Text('Nagt töleg'),
              value: 'Nagt töleg',
              groupValue: payment,
              onChanged: (value) {
                setState(() => payment = value!);
              },
            ),
            RadioListTile<String>(
              title: const Text('Bank kartasy'),
              value: 'Bank kartasy',
              groupValue: payment,
              onChanged: (value) {
                setState(() => payment = value!);
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SuccessPage(
                        onFinish: widget.onOrderFinished,
                      ),
                    ),
                  );
                },
                child: const Text('Tassyklamak'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessPage extends StatefulWidget {
  final VoidCallback onFinish;

  const SuccessPage({
    super.key,
    required this.onFinish,
  });

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  void initState() {
    super.initState();
    SystemSound.play(SystemSoundType.alert).catchError((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 115,
                  height: 115,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE2F7E8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 90,
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Sag boluň!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Sargydyňyz kabul edildi.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Harydyňyz iň az wagtyň içinde eltip berler.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      widget.onFinish();
                      Navigator.popUntil(
                        context,
                        (route) => route.isFirst,
                      );
                    },
                    child: const Text('Baş sahypa'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
