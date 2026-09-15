import 'package:flutter/material.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conversie Monedă',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade100), useMaterial3: true),      home: const CurrencyConverterPage(),
    );
  }
}
class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});
  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController _ctrl = TextEditingController();
  final List<String> _currencies = ['MDL', 'EUR', 'USD', 'RON'];
  String _from = 'MDL';
  String _to = 'EUR';
  String _result = '';
  final Map<String, double> _rates = {'MDL': 1.0, 'EUR': 20.0, 'USD': 18.0, 'RON': 4.0};
  void _convert() {
    final amount = double.tryParse(_ctrl.text);
    if (amount == null) {
      setState(() => _result = 'Introduceți o sumă validă!');
      return;
    }
    double inMDL = amount * _rates[_from]!;
    double finalAmount = inMDL / _rates[_to]!;
    setState(() {
      _result = '${amount.toStringAsFixed(2)} $_from = ${finalAmount.toStringAsFixed(2)} $_to';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversie Monedă'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _ctrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Introduceți suma',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildDropdown('Din moneda:', _from, (val) => setState(() => _from = val!))),
                const SizedBox(width: 20),
                Expanded(child: _buildDropdown('În moneda:', _to, (val) => setState(() => _to = val!))),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _convert,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              child: const Text('Convertește', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                _result,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.pink.shade300),                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildDropdown(String label, String currentVal, void Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: currentVal,
          items: _currencies.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ],
    );
  }
}