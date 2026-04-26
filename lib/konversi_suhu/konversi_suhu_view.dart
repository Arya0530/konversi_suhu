import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'konversi_suhu_cubit.dart';

class KonversiSuhuView extends StatefulWidget {
  const KonversiSuhuView({super.key});

  @override
  State<KonversiSuhuView> createState() => _KonversiSuhuViewState();
}

class _KonversiSuhuViewState extends State<KonversiSuhuView> {
  final TextEditingController _controller = TextEditingController(text: "10");
  final List<String> _satuanList = ['Celcius', 'Fahrenheit', 'Kelvin', 'Reamur'];

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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // KOTAK INPUT
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
                        // PANGGIL CUBIT: Update angka
                        final angkaBaru = double.tryParse(value) ?? 0;
                        context.read<KonversiSuhuCubit>().updateAngka(angkaBaru);
                      },
                    ),
                    const SizedBox(height: 15),
                    
                    // BUNGKUS DROPDOWN PAKAI BLOCBUILDER
                    BlocBuilder<KonversiSuhuCubit, SuhuState>(
                      builder: (context, state) {
                        return DropdownButtonFormField<String>(
                          value: state.satuanAsal,
                          decoration: const InputDecoration(
                            labelText: 'PILIH SATUAN',
                            border: OutlineInputBorder(),
                          ),
                          items: _satuanList.map((String s) {
                            return DropdownMenuItem(value: s, child: Text(s));
                          }).toList(),
                          onChanged: (val) {
                            // PANGGIL CUBIT: Update satuan
                            if (val != null) {
                              context.read<KonversiSuhuCubit>().updateSatuan(val);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // KOTAK HASIL (GRIDVIEW)
            Expanded(
              // BUNGKUS GRIDVIEW dengan BLOCBUILDER
              child: BlocBuilder<KonversiSuhuCubit, SuhuState>(
                builder: (context, state) {
                  return GridView.count(
                    crossAxisCount: 2, 
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5,
                    children: [
                      _buildResultCard('Celcius', state.getHasil('Celcius'), '°C', Icons.water_drop),
                      _buildResultCard('Fahrenheit', state.getHasil('Fahrenheit'), '°F', Icons.local_fire_department),
                      _buildResultCard('Kelvin', state.getHasil('Kelvin'), 'K', Icons.biotech),
                      _buildResultCard('Reamur', state.getHasil('Reamur'), '°R', Icons.network_ping),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

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