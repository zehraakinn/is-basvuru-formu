import 'package:flutter/material.dart';

void main() {
runApp(const JobApp());
}

class JobApp extends StatelessWidget {
const JobApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'İş Başvuru Formu',
theme: ThemeData(
primarySwatch: Colors.blue,
scaffoldBackgroundColor: const Color(0xFFF4F7FC),
fontFamily: 'Roboto',
),
home: const JobApplicationPage(),
);
}
}

class JobApplicationPage extends StatefulWidget {
const JobApplicationPage({super.key});

@override
State<JobApplicationPage> createState() => _JobApplicationPageState();
}

class _JobApplicationPageState extends State<JobApplicationPage> {
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// STATE değişkenleri
String fullName = "";
String email = "";
String phone = "";
String about = "";

bool accepted = false;

String selectedPosition = "Flutter Developer";

final List<String> positions = [
"Flutter Developer",
"Mobil Uygulama Geliştirici",
"UI/UX Designer",
"Backend Developer",
"Proje Yöneticisi",
 ];

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar( 
backgroundColor: const Color(0xFF1F2937),
elevation: 0,
centerTitle: true,
title: const Text(
"Kariyer Başvurusu",
style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
),
body: SingleChildScrollView(
padding: const EdgeInsets.all(18),
child: Column(
children: [

// ÜST BANNER
Container(
width: double.infinity,
padding: const EdgeInsets.symmetric(
  vertical: 22,
horizontal: 20,
),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(24),
gradient: const LinearGradient(
colors: [
Color(0xFF111827),
Color(0xFF374151),
 ],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
boxShadow: [
BoxShadow(
color: Colors.black.withValues(alpha: 0.15),
blurRadius: 30,
offset: const Offset(0, 15),
),
 ],
),
child: const Column(
children: [
Icon(
Icons.work,
color: Colors.white,
size: 40,
),
SizedBox(height: 15),
Text(
"İş Başvuru Formu",
style: TextStyle(
color: Colors.white,
fontSize: 24,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 10),
Text(
"Bilgilerinizi eksiksiz doldurunuz.",
textAlign: TextAlign.center,
style: TextStyle(
color: Colors.white70,
fontSize: 10,
),
),
 ],
),
),

const SizedBox(height: 25),

// FORM KARTI
Container(
padding: const EdgeInsets.all(22),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(24),
boxShadow: [
BoxShadow(
color: Colors.grey.withValues(alpha: 0.12),
blurRadius: 30,
offset: const Offset(0, 15),
),
 ],
),
child: Form(
key: _formKey,
child: Column(
children: [

// AD SOYAD
TextFormField(
decoration: _inputDecoration(
"Ad Soyad",
Icons.person,
),
validator: (value) {
if (value == null || value.trim().isEmpty) {
return "Ad Soyad boş bırakılamaz";
}
return null;
},
onChanged: (value) {
setState(() {
fullName = value;
});
},
),

const SizedBox(height: 20),

// EMAIL
TextFormField(
keyboardType: TextInputType.emailAddress,
decoration: _inputDecoration(
"E-Posta",
Icons.email,
),
validator: (value) {
if (value == null ||
value.isEmpty ||
!value.contains("@")) {
return "Geçerli bir e-posta giriniz";
}
return null;
},
onChanged: (value) {
setState(() {
email = value;
});
},
),

const SizedBox(height: 20),

// TELEFON
TextFormField(
keyboardType: TextInputType.phone,
decoration: _inputDecoration(
"Telefon",
Icons.phone,
),
validator: (value) {
if (value == null || value.length < 10) {
return "Geçerli bir telefon giriniz";
}
return null;
},
onChanged: (value) {
setState(() {
phone = value;
});
},
),

const SizedBox(height: 20),

// DROPDOWN
DropdownButtonFormField<String>(
initialValue: selectedPosition,
decoration: _inputDecoration(
"Pozisyon",
Icons.work_outline,
),
items: positions.map((String position) {
return DropdownMenuItem<String>(
value: position,
child: Text(position),
);
}).toList(),
onChanged: (String? value) {
if (value != null) {
setState(() {
selectedPosition = value;
});
}
},
),

const SizedBox(height: 20),

// AÇIKLAMA
TextFormField(
maxLines: 4,
decoration: _inputDecoration(
"Kendinizi Tanıtın",
Icons.description,
),
onChanged: (value) {
setState(() {
about = value;
});
},
),

const SizedBox(height: 20),

// CHECKBOX
CheckboxListTile(
value: accepted,
activeColor: const Color(0xFF374151),
title: const Text(
"Kişisel verilerimin değerlendirme sürecinde kullanılmasına ve başvuru şartlarını kabul ediyorum.",
style: TextStyle(fontSize: 15),
),
controlAffinity: ListTileControlAffinity.leading,
contentPadding: EdgeInsets.zero,
onChanged: (bool? value) {
setState(() {
accepted = value ?? false;
});
},
),

const SizedBox(height: 20),

// BUTTON
SizedBox(
width: double.infinity,
height: 58,
child: ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFF1F2937),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18),
),
),
onPressed: () {
if (_formKey.currentState!.validate()) {

if (!accepted) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
"Şartları kabul etmelisiniz",
),
),
);
return;
}

showDialog(
context: context,
builder: (context) {
return AlertDialog(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(20),
),
title: const Text("Başvuru Başarılı"),
content: Text(
"$fullName adına başvurunuz alınmıştır.",
),
actions: [
TextButton(
onPressed: () {
Navigator.pop(context);
},
child: Text("Tamam"),
),
 ],
);
},
);
}
},
child: const Text(
"Başvuruyu Gönder",
style: TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
),
),
],
),
),
),
],
),
),
);
}

// INPUT TASARIMI
InputDecoration _inputDecoration(String label, IconData icon) {
return InputDecoration(
labelText: label,
prefixIcon: Icon(icon),
filled: true,
fillColor: Colors.grey.shade100,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(16),
borderSide: BorderSide.none,
),
);
}
}