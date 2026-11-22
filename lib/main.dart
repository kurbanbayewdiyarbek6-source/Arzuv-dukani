import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const AzMarketApp());

const purple = Color(0xFF673AB7);
final AudioPlayer _soundPlayer = AudioPlayer();
Future<void> playSound(String file) async {
  try { await _soundPlayer.stop(); await _soundPlayer.play(AssetSource('sounds/$file.wav')); } catch (_) {}
}

class AzMarketApp extends StatefulWidget {
  const AzMarketApp({super.key});
  @override State<AzMarketApp> createState() => AzMarketAppState();
}
class AzMarketAppState extends State<AzMarketApp> {
  bool dark = false;
  String customerName = '', phone = '', address = '', region = 'Aşgabat', district = '';
  @override void initState() { super.initState(); _load(); }
  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() { dark=p.getBool('dark')??false; customerName=p.getString('name')??''; phone=p.getString('phone')??''; address=p.getString('address')??''; region=p.getString('region')??'Aşgabat'; district=p.getString('district')??''; });
  }
  Future<void> saveProfile() async {
    final p=await SharedPreferences.getInstance();
    await p.setBool('dark',dark); await p.setString('name',customerName); await p.setString('phone',phone); await p.setString('address',address); await p.setString('region',region); await p.setString('district',district);
  }
  void toggleTheme(bool v) { setState(()=>dark=v); saveProfile(); playSound('click'); }
  @override Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner:false, title:'Az Market',
    theme: ThemeData(useMaterial3:true,colorScheme:ColorScheme.fromSeed(seedColor:purple, brightness:dark?Brightness.dark:Brightness.light),scaffoldBackgroundColor:dark?const Color(0xFF15131A):const Color(0xFFF7F5FA)),
    home: StoreHome(app:this),
  );
}

class Product { final String name, image; final int price; const Product(this.name,this.image,this.price); }
const products=[Product('Pomidor','pomidor',20),Product('Alma','alma',25),Product('Kartoşka','kartoshka',12),Product('Banan','banan',35),Product('Apelsin','apelsin',30),Product('Üzüm','uzum',40),Product('Hyýar','hyar',18),Product('Garpyz','garpyz',15)];

class StoreHome extends StatefulWidget {
 final AzMarketAppState app; const StoreHome({super.key,required this.app});
 @override State<StoreHome> createState()=>_StoreHomeState();
}
class _StoreHomeState extends State<StoreHome> {
 final Map<Product,int> cart={};
 int get count=>cart.values.fold(0,(a,b)=>a+b);
 int get total=>cart.entries.fold(0,(a,e)=>a+e.key.price*e.value);
 void add(Product p){setState(()=>cart[p]=(cart[p]??0)+1);playSound('cart');}
 void openCart(){playSound('click');Navigator.push(context,MaterialPageRoute(builder:(_)=>CartPage(cart:cart,total:total,onChanged:()=>setState((){}),app:widget.app,onClear:()=>setState(cart.clear))));}
 @override Widget build(BuildContext context){final app=widget.app;return Scaffold(appBar:AppBar(title:const Text('Az Market',style:TextStyle(fontWeight:FontWeight.bold)),actions:[IconButton(onPressed:openCart,icon:Badge(label:Text('$count'),child:const Icon(Icons.shopping_cart_outlined))),PopupMenuButton<String>(icon:const Icon(Icons.menu),onSelected:(v){playSound('click');if(v=='settings')Navigator.push(context,MaterialPageRoute(builder:(_)=>SettingsPage(app:app)));if(v=='profile')Navigator.push(context,MaterialPageRoute(builder:(_)=>ProfilePage(app:app)));},itemBuilder:(_)=>const [PopupMenuItem(value:'settings',child:Text('Sazlamalar')),PopupMenuItem(value:'profile',child:Text('Maglumatlarym'))])]),body:Column(children:[Container(width:double.infinity,padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Hoş geldiňiz!',style:Theme.of(context).textTheme.titleLarge),Text('Täze we ter önümler',style:Theme.of(context).textTheme.bodyMedium)])),Expanded(child:GridView.builder(padding:const EdgeInsets.all(12),itemCount:products.length,gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:.73,crossAxisSpacing:12,mainAxisSpacing:12),itemBuilder:(context,i){final p=products[i];return Card(clipBehavior:Clip.antiAlias,child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[Expanded(child:Image.asset('assets/images/${p.image}.jpg',fit:BoxFit.cover,errorBuilder:(_,__,___)=>const Icon(Icons.image_not_supported,size:50))),Padding(padding:const EdgeInsets.fromLTRB(10,8,10,2),child:Text(p.name,style:const TextStyle(fontWeight:FontWeight.bold))),Padding(padding:const EdgeInsets.symmetric(horizontal:10),child:Text('${p.price} manat / kg')),Padding(padding:const EdgeInsets.all(8),child:FilledButton(onPressed:()=>add(p),child:const Text('Sebede goş')))]));}))]) );}
}

class CartPage extends StatefulWidget {final Map<Product,int> cart;final int total;final VoidCallback onChanged,onClear;final AzMarketAppState app;const CartPage({super.key,required this.cart,required this.total,required this.onChanged,required this.onClear,required this.app});@override State<CartPage> createState()=>_CartPageState();}
class _CartPageState extends State<CartPage>{@override Widget build(BuildContext context){final total=widget.cart.entries.fold(0,(a,e)=>a+e.key.price*e.value);return Scaffold(appBar:AppBar(title:const Text('Sebet')),body:widget.cart.isEmpty?const Center(child:Text('Sebet boş')):Column(children:[Expanded(child:ListView(children:widget.cart.entries.map((e)=>ListTile(title:Text(e.key.name),subtitle:Text('${e.key.price} manat × ${e.value}'),trailing:IconButton(icon:const Icon(Icons.delete_outline),onPressed:(){setState(()=>widget.cart.remove(e.key));widget.onChanged();playSound('click');}))).toList())),Padding(padding:const EdgeInsets.all(16),child:Column(children:[Text('Jemi: $total manat',style:Theme.of(context).textTheme.titleLarge),const SizedBox(height:10),SizedBox(width:double.infinity,child:FilledButton(onPressed:(){playSound('click');Navigator.push(context,MaterialPageRoute(builder:(_)=>DeliveryInfoPage(app:widget.app,onContinue:(){Navigator.push(context,MaterialPageRoute(builder:(_)=>CheckoutPage(app:widget.app,onDone:(){widget.onClear();})));})));},child:const Text('Sargyt et')))]))]));}}


class DeliveryInfoPage extends StatefulWidget {final AzMarketAppState app;final VoidCallback onContinue;const DeliveryInfoPage({super.key,required this.app,required this.onContinue});@override State<DeliveryInfoPage> createState()=>_DeliveryInfoPageState();}
class _DeliveryInfoPageState extends State<DeliveryInfoPage>{late String region=widget.app.region;late final district=TextEditingController(text:widget.app.district);late final phone=TextEditingController(text:widget.app.phone);late final address=TextEditingController(text:widget.app.address);final regions=['Aşgabat','Ahal','Balkan','Daşoguz','Lebap','Mary'];@override void dispose(){district.dispose();phone.dispose();address.dispose();super.dispose();}@override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Eltip beriş maglumatlary')),body:ListView(padding:const EdgeInsets.all(18),children:[const Text('Şäher / welaýat',style:TextStyle(fontWeight:FontWeight.bold)),const SizedBox(height:8),DropdownButtonFormField<String>(value:region,decoration:const InputDecoration(border:OutlineInputBorder()),items:regions.map((r)=>DropdownMenuItem(value:r,child:Text(r))).toList(),onChanged:(v)=>setState(()=>region=v??'Aşgabat')),const SizedBox(height:16),TextField(controller:district,decoration:const InputDecoration(labelText:'Etrap',border:OutlineInputBorder())),const SizedBox(height:16),TextField(controller:phone,keyboardType:TextInputType.phone,decoration:const InputDecoration(labelText:'Telefon belgisi',border:OutlineInputBorder())),const SizedBox(height:16),TextField(controller:address,decoration:const InputDecoration(labelText:'Salgy / köçe / öý',border:OutlineInputBorder())),const SizedBox(height:22),FilledButton(onPressed:()async{if(phone.text.trim().isEmpty||district.text.trim().isEmpty){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Etrap we telefon belgisi giriziň')));return;}widget.app.region=region;widget.app.district=district.text;widget.app.phone=phone.text;widget.app.address=address.text;await widget.app.saveProfile();if(mounted){playSound('click');widget.onContinue();}},child:const Text('Dowam et'))]));}

class CheckoutPage extends StatefulWidget {final AzMarketAppState app;final VoidCallback onDone;const CheckoutPage({super.key,required this.app,required this.onDone});@override State<CheckoutPage> createState()=>_CheckoutPageState();}
class _CheckoutPageState extends State<CheckoutPage>{String method='card';final name=TextEditingController();final number=TextEditingController();final expiry=TextEditingController();final cvv=TextEditingController();@override void dispose(){name.dispose();number.dispose();expiry.dispose();cvv.dispose();super.dispose();}void finish(){playSound('success');widget.onDone();Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(_)=>OrderSuccess(app:widget.app)),(r)=>r.isFirst);}
@override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Töleg usuly')),body:ListView(padding:const EdgeInsets.all(18),children:[RadioListTile<String>(value:'card',groupValue:method,title:const Text('Bank kartasy bilen töleg'),onChanged:(v)=>setState(()=>method=v!)),RadioListTile<String>(value:'cash',groupValue:method,title:const Text('Ýerinde töleg'),subtitle:const Text('Sargyt gelende nagt töleg'),onChanged:(v)=>setState(()=>method=v!)),if(method=='card')... [const Divider(),TextField(controller:name,decoration:const InputDecoration(labelText:'Kartyň eýesiniň ady')),TextField(controller:number,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'Kart belgisi')),Row(children:[Expanded(child:TextField(controller:expiry,decoration:const InputDecoration(labelText:'MM/YY'))),const SizedBox(width:12),Expanded(child:TextField(controller:cvv,decoration:const InputDecoration(labelText:'CVV'),keyboardType:TextInputType.number))]),const SizedBox(height:8),const Text('Synag sahypasy: maglumatlar töleg üçin iberilmeýär we saklanmaýar.',style:TextStyle(fontSize:12))],const SizedBox(height:20),FilledButton(onPressed:finish,child:const Text('Tassyklamak'))]));}

class OrderSuccess extends StatelessWidget {final AzMarketAppState app;const OrderSuccess({super.key,required this.app});@override Widget build(BuildContext context)=>Scaffold(body:Center(child:Padding(padding:const EdgeInsets.all(24),child:Column(mainAxisSize:MainAxisSize.min,children:[const Icon(Icons.check_circle,color:Colors.green,size:76),const SizedBox(height:12),const Text('Sargydyňyz kabul edildi!',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),const SizedBox(height:20),FilledButton(onPressed:()=>Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(_)=>StoreHome(app:app)),(r)=>false),child:const Text('Baş sahypa'))]))));}

class SettingsPage extends StatelessWidget {final AzMarketAppState app;const SettingsPage({super.key,required this.app});@override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Sazlamalar')),body:SwitchListTile(title:const Text('Garaňky / Ýagty görnüş'),subtitle:const Text('Gara ýa-da ak fon'),value:app.dark,onChanged:app.toggleTheme));}
class ProfilePage extends StatefulWidget {final AzMarketAppState app;const ProfilePage({super.key,required this.app});@override State<ProfilePage> createState()=>_ProfilePageState();}
class _ProfilePageState extends State<ProfilePage>{late final name=TextEditingController(text:widget.app.customerName);late final phone=TextEditingController(text:widget.app.phone);late final address=TextEditingController(text:widget.app.address);@override void dispose(){name.dispose();phone.dispose();address.dispose();super.dispose();}@override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Maglumatlarym')),body:ListView(padding:const EdgeInsets.all(18),children:[TextField(controller:name,decoration:const InputDecoration(labelText:'Adyňyz')),TextField(controller:phone,keyboardType:TextInputType.phone,decoration:const InputDecoration(labelText:'Telefon belgisi')),TextField(controller:address,decoration:const InputDecoration(labelText:'Salgy')),const SizedBox(height:20),FilledButton(onPressed:()async{widget.app.customerName=name.text;widget.app.phone=phone.text;widget.app.address=address.text;await widget.app.saveProfile();if(mounted){playSound('success');ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Maglumatlar saklandy')));}},child:const Text('Sakla'))]));}
