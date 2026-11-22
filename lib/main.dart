
import 'package:flutter/material.dart';

void main() => runApp(const MarketApp());

const purple = Color(0xFF673AB7);
const darkPurple = Color(0xFF32145F);

class MarketApp extends StatefulWidget {
  const MarketApp({super.key});

  @override
  State<MarketApp> createState() => _MarketAppState();
}

class _MarketAppState extends State<MarketApp> {
  bool dark = false;
  String language = 'Türkmençe';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: LoginPage(
        dark: dark,
        language: language,
        onTheme: (v) => setState(() => dark = v),
        onLanguage: (v) => setState(() => language = v),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  final bool dark;
  final String language;
  final ValueChanged<bool> onTheme;
  final ValueChanged<String> onLanguage;

  const LoginPage({
    super.key,
    required this.dark,
    required this.language,
    required this.onTheme,
    required this.onLanguage,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final name = TextEditingController();
  final password = TextEditingController();
  bool hidePassword = true;

  @override
  void dispose() {
    name.dispose();
    password.dispose();
    super.dispose();
  }

  void enter() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MarketHome(
          dark: widget.dark,
          language: widget.language,
          onTheme: widget.onTheme,
          onLanguage: widget.onLanguage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [darkPurple, purple, Color(0xFF9C65E8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Container(
                    width: 115,
                    height: 115,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 25,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.shopping_basket_rounded,
                      color: purple,
                      size: 72,
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'AZ MARKET',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                    ),
                  ),
                  const Text(
                    'ARZAN MARKET',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      letterSpacing: 7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Hemmesi bir ýerde, elýeterli bahadan!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  const SizedBox(height: 45),
                  Container(
                    padding: const EdgeInsets.all(23),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Hoş geldiňiz!',
                          style: TextStyle(
                            color: darkPurple,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 22),
                        TextField(
                          controller: name,
                          decoration: InputDecoration(
                            labelText: 'Adyňyz',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: password,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            labelText: 'Açar sözi',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () => setState(
                                () => hidePassword = !hidePassword,
                              ),
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        SizedBox(
                          width: double.infinity,
                          height: 53,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: purple,
                            ),
                            onPressed: enter,
                            child: const Text(
                              'GIRMEK',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: enter,
                          child: const Text(
                            'Myhman hökmünde gir',
                            style: TextStyle(color: purple),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'AZ MARKET • ARZAN MARKET',
                    style: TextStyle(
                      color: Colors.white70,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MarketHome extends StatefulWidget {
  final bool dark;
  final String language;
  final ValueChanged<bool> onTheme;
  final ValueChanged<String> onLanguage;

  const MarketHome({
    super.key,
    required this.dark,
    required this.language,
    required this.onTheme,
    required this.onLanguage,
  });

  @override
  State<MarketHome> createState() => _MarketHomeState();
}

class _MarketHomeState extends State<MarketHome> {
  int selectedCategory = 0;
  int page = 0;
  String search = '';

  final Map<String, int> cart = {};

  final categories = [
    'Hemmesi',
    'Miwe',
    'Gök önümler',
    'Içgiler',
    'Kir ýuwujy',
    'Şampun',
    'Arassalaýjy',
  ];

  final products = [
    ['Alma', '20 manat', '🍎', 'Miwe'],
    ['Banan', '35 manat', '🍌', 'Miwe'],
    ['Üzüm', '25 manat', '🍇', 'Miwe'],
    ['Apelsin', '30 manat', '🍊', 'Miwe'],
    ['Garpyz', '15 manat', '🍉', 'Miwe'],
    ['Pomidor', '18 manat', '🍅', 'Gök önümler'],
    ['Kartoşka', '12 manat', '🥔', 'Gök önümler'],
    ['Hyýar', '14 manat', '🥒', 'Gök önümler'],
    ['Suw', '5 manat', '💧', 'Içgiler'],
    ['Şire', '18 manat', '🧃', 'Içgiler'],
    ['Kir ýuwujy poroşok', '45 manat', '🧺', 'Kir ýuwujy'],
    ['Ariel', '55 manat', '🫧', 'Kir ýuwujy'],
    ['Şampun', '35 manat', '🧴', 'Şampun'],
    ['Sabyn', '10 manat', '🧼', 'Şampun'],
    ['Gap-gaç ýuwujy', '30 manat', '🧽', 'Arassalaýjy'],
    ['Pol arassalaýjy', '35 manat', '🧹', 'Arassalaýjy'],
  ];

  int get count => cart.values.fold(0, (a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    final shown = products.where((p) {
      final categoryMatch = selectedCategory == 0 ||
          p[3] == categories[selectedCategory];
      final searchMatch =
          p[0].toLowerCase().contains(search.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AZ MARKET',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() => page = 1),
            icon: Badge(
              label: Text('$count'),
              isLabelVisible: count > 0,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
          IconButton(
            onPressed: () => setState(() => page = 2),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: page == 1
          ? cartPage()
          : page == 2
              ? settingsPage()
              : homePage(shown),
      bottomNavigationBar: NavigationBar(
        selectedIndex: page,
        onDestinationSelected: (v) => setState(() => page = v),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.storefront),
            label: 'Dukan',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_basket),
            label: 'Sebet',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Sazlamalar',
          ),
        ],
      ),
    );
  }

  Widget homePage(List<List<String>> shown) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        Container(
          padding: const EdgeInsets.all(23),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [darkPurple, purple],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AZ MARKET',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Arzan bahalar, gowy harytlar!',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              SizedBox(height: 12),
              Icon(Icons.shopping_basket, color: Colors.white, size: 45),
            ],
          ),
        ),
        const SizedBox(height: 18),
        TextField(
          onChanged: (v) => setState(() => search = v),
          decoration: InputDecoration(
            hintText: 'Haryt gözle...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Kategoriýalar',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 43,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(categories[i]),
                selected: selectedCategory == i,
                onSelected: (_) => setState(() => selectedCategory = i),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'Harytlar (${shown.length})',
          style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: shown.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.78,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, i) {
            final p = shown[i];
            return Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: purple.withValues(alpha: 0.08),
                      child: Center(
                        child: Text(p[2], style: const TextStyle(fontSize: 65)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(
                          p[0],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          p[1],
                          style: const TextStyle(
                            color: purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: () {
                              setState(() {
                                cart[p[0]] = (cart[p[0]] ?? 0) + 1;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${p[0]} sebede goşuldy'),
                                  duration: const Duration(milliseconds: 700),
                                ),
                              );
                            },
                            icon: const Icon(Icons.add_shopping_cart),
                            label: const Text('Sebede goş'),
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
      ],
    );
  }

  Widget cartPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Siziň sebediňiz',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        if (cart.isEmpty)
          const Padding(
            padding: EdgeInsets.all(40),
            child: Center(child: Text('Sebediňiz boş')),
          ),
        ...cart.entries.map((e) {
          final p = products.firstWhere((p) => p[0] == e.key);
          return Card(
            child: ListTile(
              leading: Text(p[2], style: const TextStyle(fontSize: 30)),
              title: Text(p[0]),
              subtitle: Text(p[1]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => setState(() {
                      if (e.value > 1) {
                        cart[e.key] = e.value - 1;
                      } else {
                        cart.remove(e.key);
                      }
                    }),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text('${e.value}'),
                  IconButton(
                    onPressed: () => setState(() {
                      cart[e.key] = e.value + 1;
                    }),
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
            ),
          );
        }),
        if (cart.isNotEmpty)
          FilledButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Sargyt kabul edildi!'),
                  content: const Text(
                    'Bu synag görnüşidir. Hakyky sargyt iberilmedi.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          cart.clear();
                          page = 0;
                        });
                      },
                      child: const Text('Bolýar'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Sargyt et'),
          ),
      ],
    );
  }

  Widget settingsPage() {
    return ListView(
      children: [
        const ListTile(
          title: Text(
            'Sazlamalar',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('Dil saýla'),
          trailing: DropdownButton<String>(
            value: widget.language,
            items: const [
              DropdownMenuItem(
                value: 'Türkmençe',
                child: Text('Türkmençe'),
              ),
              DropdownMenuItem(
                value: 'O‘zbekcha',
                child: Text('O‘zbekcha'),
              ),
              DropdownMenuItem(
                value: 'Türkçe',
                child: Text('Türkçe'),
              ),
            ],
            onChanged: (v) {
              if (v != null) widget.onLanguage(v);
            },
          ),
        ),
        SwitchListTile(
          secondary: const Icon(Icons.dark_mode),
      
