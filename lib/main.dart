import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Konversi Suhu',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFB2DFDB), // Warna hijau toska muda sesuai gambar
      ),
      home: const KonversiSuhuPage(),
    );
  }
}

class KonversiSuhuPage extends StatefulWidget {
  const KonversiSuhuPage({super.key});

  @override
  State<KonversiSuhuPage> createState() => _KonversiSuhuPageState();
}

class _KonversiSuhuPageState extends State<KonversiSuhuPage> {
  double _inputSuhu = 10.0;
  String _satuanAsal = 'Celcius';
  final List<String> _satuanList = ['Celcius', 'Fahrenheit', 'Kelvin', 'Reamur'];
  
  // Controller agar angka 10 langsung muncul
  final TextEditingController _controller = TextEditingController(text: "10");

  // Logika Konversi Suhu
  double _getHasil(String target) {
    double celcius = 0;
    
    // 1. Jadikan input ke Celcius dulu sebagai patokan dasar
    switch (_satuanAsal) {
      case 'Celcius': celcius = _inputSuhu; break;
      case 'Fahrenheit': celcius = (_inputSuhu - 32) * 5 / 9; break;
      case 'Kelvin': celcius = _inputSuhu - 273.15; break;
      case 'Reamur': celcius = _inputSuhu * 5 / 4; break;
    }

    // 2. Dari Celcius, ubah ke target yang diminta masing-masing kotak
    switch (target) {
      case 'Celcius': return celcius;
      case 'Fahrenheit': return (celcius * 9 / 5) + 32;
      case 'Kelvin': return celcius + 273.15;
      case 'Reamur': return celcius * 4 / 5;
      default: return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.thermostat, color: Color(0xFF004D40)),
            SizedBox(width: 8),
            Text('Konversi Suhu', style: TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: Colors.transparent, // Transparan agar menyatu dengan background
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- KOTAK INPUT (ATAS) ---
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'MASUKKAN SUHU',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _inputSuhu = double.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      value: _satuanAsal,
                      decoration: const InputDecoration(
                        labelText: 'PILIH SATUAN',
                        border: OutlineInputBorder(),
                      ),
                      items: _satuanList.map((String s) {
                        return DropdownMenuItem(value: s, child: Text(s));
                      }).toList(),
                      onChanged: (val) => setState(() => _satuanAsal = val!),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // --- KOTAK HASIL (BAWAH - GRID 2x2) ---
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, 
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 5, // Biar kotaknya memanjang ke samping seperti di gambar
                children: [
                  _buildResultCard('Celcius', _getHasil('Celcius'), '°C', Icons.water_drop),
                  _buildResultCard('Fahrenheit', _getHasil('Fahrenheit'), '°F', Icons.local_fire_department),
                  _buildResultCard('Kelvin', _getHasil('Kelvin'), 'K', Icons.biotech),
                  _buildResultCard('Reamur', _getHasil('Reamur'), '°R', Icons.network_ping),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Desain template untuk ke-4 kotak hasil
  Widget _buildResultCard(String title, double value, String unit, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.teal[800], size: 30),
          const SizedBox(height: 5),
          Text(title, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
          const SizedBox(height: 5),
          Text(
            '${value.toStringAsFixed(1)}$unit',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
        ],
      ),
    );
  }
}