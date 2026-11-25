import 'package:flutter/material.dart';

void main() => runApp(const GoServicesApp());

const navy = Color(0xFF093B78);
const blue = Color(0xFF086CCB);
const green = Color(0xFF43C735);
const bg = Color(0xFFF3F7FA);

class GoServicesApp extends StatelessWidget {
  const GoServicesApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'GO Services!', debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme.fromSeed(seedColor: blue),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15))),
    home: const LoginPage(),
  );
}

class Pro {
  final String name, job, initials, about;
  final double rating, distance;
  final int years;
  const Pro(this.name, this.job, this.initials, this.about, this.rating, this.distance, this.years);
}
const pros = [
  Pro('Carlos Mendes','Eletricista residencial','CM','Especialista em instalações, manutenção e reparos elétricos residenciais.',4.9,1.2,8),
  Pro('Ana Ribeiro','Encanadora e manutenção','AR','Serviços hidráulicos, instalação e reparos residenciais.',4.8,2.5,6),
  Pro('Paulo Silva','Mecânico automotivo','PS','Manutenção e diagnóstico de veículos.',4.7,3.2,10),
];
class Request {
  final String professional, service, description, address, date;
  String status;
  Request(this.professional,this.service,this.description,this.address,this.date,{this.status='Pendente'});
}
final requests = <Request>[];

Widget primaryButton(String label, VoidCallback onPressed) => SizedBox(width: double.infinity, height: 49,
  child: FilledButton(style: FilledButton.styleFrom(backgroundColor: blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))),
    onPressed: onPressed, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))));
Widget section(String text) => Padding(padding: const EdgeInsets.only(top: 18,bottom: 10),child: Text(text,style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 17,color: navy)));
Widget panel(Widget child) => Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(16),border: Border.all(color: const Color(0xFFE7EDF4))),child: child);
void message(BuildContext c,String text) => ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text(text)));

class LoginPage extends StatefulWidget { const LoginPage({super.key}); @override State<LoginPage> createState()=>_LoginPageState(); }
class _LoginPageState extends State<LoginPage> {
  final email=TextEditingController(),password=TextEditingController(); bool register=false, provider=false;
  @override void dispose(){email.dispose();password.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>Scaffold(body:SafeArea(child:Center(child:SingleChildScrollView(padding: const EdgeInsets.all(28),child:ConstrainedBox(constraints: const BoxConstraints(maxWidth:420),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
    const Text('A AJUDA CHEGOU.',style:TextStyle(color:blue,fontWeight:FontWeight.w800,letterSpacing:1)),
    const SizedBox(height:20), Image.asset('assets/logo.jpeg',height:185),
    const SizedBox(height:12),const Text('Entre e encontre quem resolve.',style:TextStyle(fontSize:26,fontWeight:FontWeight.w900,color:navy)),
    const Text('Profissionais por perto, quando você precisa.',style:TextStyle(color:Colors.black54)),
    const SizedBox(height:25),TextField(controller:email,keyboardType:TextInputType.emailAddress,decoration:const InputDecoration(hintText:'Seu e-mail')),
    const SizedBox(height:10),TextField(controller:password,obscureText:true,decoration:const InputDecoration(hintText:'Sua senha')),
    if(register) ...[const SizedBox(height:15),const Text('Tipo de conta',style:TextStyle(fontWeight:FontWeight.bold)),SwitchListTile(contentPadding:EdgeInsets.zero,title:Text(provider?'Prestador de serviços':'Cliente'),value:provider,onChanged:(v)=>setState(()=>provider=v))],
    const SizedBox(height:18),primaryButton(register?'Cadastrar':'Entrar',(){
      if(email.text.trim().isEmpty || password.text.isEmpty){message(context,'Preencha o e-mail e a senha.');return;}
      Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>provider?const ProviderPage():const HomePage()));
    }),const SizedBox(height:15),TextButton(onPressed:()=>setState(()=>register=!register),child:Text(register?'Já tem uma conta? Entrar':'Ainda não tem uma conta? Cadastre-se')),
    TextButton(onPressed:()=>Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const HomePage())),child:const Text('Explorar demonstração sem conta')),
    const Text('Protótipo demonstrativo: autenticação ainda não conectada a servidor.',textAlign:TextAlign.center,style:TextStyle(fontSize:11,color:Colors.black45)),
  ]))))));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int tab = 0;
  String query = '';
  String category = 'Todos';
  final categories = ['Todos', 'Elétrica', 'Mecânica', 'Hidráulica', 'Limpeza', 'Reparos'];
  @override
  Widget build(BuildContext context) {
    final filtered = pros.where((p) {
      final matchesCategory = category == 'Todos' ||
          (category == 'Elétrica' && p.job.contains('Eletricista')) ||
          (category == 'Hidráulica' && p.job.contains('Encanadora')) ||
          (category == 'Mecânica' && p.job.contains('Mecânico')) ||
          (category == 'Reparos');
      final matchesQuery = p.name.toLowerCase().contains(query.toLowerCase()) ||
          p.job.toLowerCase().contains(query.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
    return Scaffold(
      body: SafeArea(
        child: tab == 0
            ? ListView(children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 26, 20, 24),
                  decoration: const BoxDecoration(color: navy, borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('LOCALIZAÇÃO ATUAL', style: TextStyle(color: Colors.white70, fontSize: 11)),
                    const Text('📍 Localização não configurada', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 20),
                    const Text('Encontre ajuda\nperto de você.', style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900, color: Colors.white)),
                    const SizedBox(height: 18),
                    TextField(onChanged: (v) => setState(() => query = v), decoration: const InputDecoration(prefixIcon: Icon(Icons.search, color: blue), hintText: 'Qual serviço você procura?')),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    section('Categorias de serviços'),
                    Wrap(spacing: 8, runSpacing: 8, children: categories.map((c) => ChoiceChip(label: Text(c), selected: category == c, onSelected: (_) => setState(() => category = c))).toList()),
                    section('Profissionais disponíveis (exemplo)'),
                    if (filtered.isEmpty) panel(const Text('Nenhum profissional nesta categoria no modo demonstração.')),
                    ...filtered.map((p) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfessionalPage(pro: p))),
                        child: panel(Row(children: [
                          CircleAvatar(backgroundColor: const Color(0xFFE8F5FF), child: Text(p.initials, style: const TextStyle(color: blue, fontWeight: FontWeight.bold))),
                          const SizedBox(width: 12),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(p.job, style: const TextStyle(fontSize: 12)),
                            Text('★ ${p.rating}  •  ${p.distance.toStringAsFixed(1)} km (ilustrativo)', style: const TextStyle(color: blue, fontSize: 12)),
                          ])),
                          const Icon(Icons.chevron_right),
                        ])),
                      ),
                    )),
                  ]),
                ),
              ])
            : tab == 1 ? const RequestsPage() : tab == 2 ? const FavoritesPage() : const AccountPage(),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Início'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'Pedidos'),
          NavigationDestination(icon: Icon(Icons.favorite_border), label: 'Favoritos'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
    );
  }
}
final favorites=<String>{};
class ProfessionalPage extends StatefulWidget{final Pro pro;const ProfessionalPage({super.key,required this.pro});@override State<ProfessionalPage> createState()=>_ProfessionalPageState();}
class _ProfessionalPageState extends State<ProfessionalPage>{@override Widget build(BuildContext context){final p=widget.pro;return Scaffold(appBar:AppBar(title:const Text('Perfil profissional'),backgroundColor:navy,foregroundColor:Colors.white,actions:[IconButton(onPressed:()=>setState((){if(!favorites.add(p.name))favorites.remove(p.name);}),icon:Icon(favorites.contains(p.name)?Icons.favorite:Icons.favorite_border))]),body:ListView(padding:const EdgeInsets.all(20),children:[const SizedBox(height:12),CircleAvatar(radius:54,backgroundColor:const Color(0xFFDCEEFF),child:Text(p.initials,style:const TextStyle(color:blue,fontSize:32,fontWeight:FontWeight.bold))),const SizedBox(height:14),Text(p.name,textAlign:TextAlign.center,style:const TextStyle(color:navy,fontSize:26,fontWeight:FontWeight.w900)),Text(p.job,textAlign:TextAlign.center),const SizedBox(height:15),panel(Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[Column(children:[Text('${p.distance} km',style:const TextStyle(color:blue,fontWeight:FontWeight.bold)),const Text('DISTÂNCIA*')]),Column(children:[Text('★ ${p.rating}',style:const TextStyle(color:blue,fontWeight:FontWeight.bold)),const Text('AVALIAÇÃO*')]),Column(children:[Text('${p.years} anos',style:const TextStyle(color:blue,fontWeight:FontWeight.bold)),const Text('EXPERIÊNCIA*')])])),section('Sobre o profissional'),Text(p.about),section('Especialidades'),const Wrap(spacing:8,children:[Chip(label:Text('Instalações')),Chip(label:Text('Reparos')),Chip(label:Text('Manutenção'))]),const SizedBox(height:25),primaryButton('Solicitar atendimento',()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>RequestForm(pro:p)))),const SizedBox(height:15),const Text('*Informações fictícias para demonstração.',style:TextStyle(fontSize:11,color:Colors.black54))]));}}

class RequestForm extends StatefulWidget{final Pro pro;const RequestForm({super.key,required this.pro});@override State<RequestForm> createState()=>_RequestFormState();}
class _RequestFormState extends State<RequestForm>{String service='Instalação / reparo';bool today=true;final description=TextEditingController(),address=TextEditingController();@override void dispose(){description.dispose();address.dispose();super.dispose();}
@override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Solicitar atendimento'),backgroundColor:navy,foregroundColor:Colors.white),body:ListView(padding:const EdgeInsets.all(20),children:[const Text('ETAPA 1 DE 2',style:TextStyle(color:blue,fontWeight:FontWeight.bold)),section('Como podemos ajudar?'),panel(ListTile(leading:CircleAvatar(child:Text(widget.pro.initials)),title:Text(widget.pro.name),subtitle:Text(widget.pro.job))),section('Serviço desejado'),DropdownButtonFormField<String>(initialValue:service,items:['Instalação / reparo','Manutenção','Diagnóstico','Outros'].map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(),onChanged:(v)=>setState(()=>service=v!)),section('Descreva o problema'),TextField(controller:description,maxLines:4,maxLength:500,decoration:const InputDecoration(hintText:'Ex.: Preciso de uma avaliação de algumas tomadas...')),section('Local do atendimento'),TextField(controller:address,decoration:const InputDecoration(prefixIcon:Icon(Icons.location_on_outlined),hintText:'Digite o endereço do atendimento')),section('Quando você precisa?'),Row(children:[Expanded(child:ChoiceChip(label:const Text('Hoje'),selected:today,onSelected:(_)=>setState(()=>today=true))),const SizedBox(width:12),Expanded(child:ChoiceChip(label:const Text('Agendar outro dia'),selected:!today,onSelected:(_)=>setState(()=>today=false)))]),const SizedBox(height:20),primaryButton('Enviar solicitação',(){if(description.text.trim().isEmpty||address.text.trim().isEmpty){message(context,'Informe o problema e o endereço.');return;}requests.add(Request(widget.pro.name,service,description.text,address.text,today?'Hoje':'A combinar'));Navigator.popUntil(context,(r)=>r.isFirst);message(context,'Solicitação salva nesta demonstração.');}),const SizedBox(height:10),const Text('O profissional deverá aceitar o pedido. Nesta versão, os dados ficam apenas na memória do aplicativo.',textAlign:TextAlign.center,style:TextStyle(fontSize:12,color:Colors.black54))]));}
class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      section('Meus pedidos'),
      if (requests.isEmpty) panel(const Text('Você ainda não enviou solicitações.')),
      ...requests.map((r) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: panel(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(r.professional, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(r.service),
          Text(r.description),
          Text('Status: ${r.status}', style: const TextStyle(color: blue)),
        ])),
      )),
    ],
  );
}
class FavoritesPage extends StatelessWidget{const FavoritesPage({super.key});@override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(20),children:[section('Favoritos'),if(favorites.isEmpty)panel(const Text('Você ainda não adicionou profissionais favoritos.')),...pros.where((p)=>favorites.contains(p.name)).map((p)=>ListTile(title:Text(p.name),subtitle:Text(p.job),onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>ProfessionalPage(pro:p)))))]);}
class AccountPage extends StatelessWidget{const AccountPage({super.key});@override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(20),children:[section('Meu perfil'),panel(const Text('Modo demonstração — sem conta persistida.')),const SizedBox(height:15),primaryButton('Entrar como prestador',()=>Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const ProviderPage()))),const SizedBox(height:10),TextButton(onPressed:()=>Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const LoginPage())),child:const Text('Voltar ao login'))]);}
class ProviderPage extends StatefulWidget{const ProviderPage({super.key});@override State<ProviderPage> createState()=>_ProviderPageState();}
class _ProviderPageState extends State<ProviderPage> {
  String status = 'Pendentes';
  bool available = true;
  @override
  Widget build(BuildContext context) {
    final list = requests.where((r) => status == 'Pendentes'
        ? r.status == 'Pendente'
        : status == 'Em andamento' ? r.status == 'Aceito' : r.status == 'Concluído').toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Área do profissional'),
        backgroundColor: navy,
        foregroundColor: Colors.white,
        actions: [IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage())), icon: const Icon(Icons.swap_horiz))],
      ),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('Olá, profissional!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: navy)),
        SwitchListTile(title: Text(available ? 'Disponível' : 'Indisponível'), value: available, onChanged: (v) => setState(() => available = v)),
        const SizedBox(height: 15),
        panel(Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text('Pendentes\n${requests.where((r) => r.status == 'Pendente').length}', textAlign: TextAlign.center),
          Text('Aceitos\n${requests.where((r) => r.status == 'Aceito').length}', textAlign: TextAlign.center),
          Text('Concluídos\n${requests.where((r) => r.status == 'Concluído').length}', textAlign: TextAlign.center),
        ])),
        section('Solicitações recebidas'),
        Wrap(spacing: 7, children: ['Pendentes', 'Em andamento', 'Concluídos'].map((s) => ChoiceChip(label: Text(s), selected: status == s, onSelected: (_) => setState(() => status = s))).toList()),
        const SizedBox(height: 12),
        if (list.isEmpty) panel(const Text('Nenhuma solicitação nesta etapa.')),
        ...list.map((r) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: panel(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(r.service, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(r.description),
            Text('Local: ${r.address}'),
            const SizedBox(height: 10),
            if (r.status == 'Pendente') Row(children: [
              Expanded(child: OutlinedButton(onPressed: () => setState(() => r.status = 'Recusado'), child: const Text('Recusar'))),
              const SizedBox(width: 10),
              Expanded(child: FilledButton(onPressed: () => setState(() => r.status = 'Aceito'), child: const Text('Aceitar'))),
            ]),
            if (r.status == 'Aceito') primaryButton('Concluir atendimento', () => setState(() => r.status = 'Concluído')),
          ])),
        )),
      ]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: TextButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage())), child: const Text('Sair')),
      ),
    );
  }
}
