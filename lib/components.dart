import 'package:flutter/material.dart';

class ComponentsPage extends StatefulWidget {
  const ComponentsPage({super.key});

  @override
  State<ComponentsPage> createState() => _ComponentsPageState();
}

class _ComponentsPageState extends State<ComponentsPage> {
  bool _chk = false;
  bool _sw = false;
  String _radio = 'A';
  double _slider = 40;
  int _seg = 0;
  String _txt = '';
  String? _drop = 'A';

  void _showAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alerta'),
        content: const Text('Exemplo de AlertDialog.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Componentes'),
        backgroundColor: Colors.deepPurple.shade200,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('1 - Card', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Card(
              elevation: 2,
              color: Colors.deepPurple.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Texto de exemplo.', style: TextStyle(fontSize: 16), textAlign: TextAlign.justify),
              ),
            ),
            const SizedBox(height: 20),

            const Text('2 - Container', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple, width: 2),
              ),
              child: const Text(
                'Este é um Container com margem externa (margin), espaçamento interno (padding) e borda (border).',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),

            const Text('3 - ListView', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(
              height: 120,
              child: Scrollbar(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    6,
                    (index) => Container(
                      width: 100,
                      margin: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[100 * ((index % 8) + 1)],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('Item ${index + 1}'),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text('4 - GridView', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                6,
                (index) => Card(
                  color: Colors.deepPurple.shade100,
                  child: Center(child: Text('Grid ${index + 1}')),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text('5 - Stack', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Container(
              margin: const EdgeInsets.all(8),
              height: 150,
              color: Colors.deepPurple.shade50,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(width: 150, height: 100, color: Colors.deepPurple.shade200),
                  const Positioned(top: 20, child: Icon(Icons.star, size: 40, color: Colors.white)),
                  const Text('Stack com elementos sobrepostos'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text('6 - Common Buttons', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.send), label: const Text('Elevated')),
                FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.check_circle), label: const Text('Filled')),
                OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.share), label: const Text('Outlined')),
                TextButton(onPressed: () {}, child: const Text('Text Button')),
              ],
            ),
            const SizedBox(height: 20),

            const Text('7 - SegmentedButton', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('A'), icon: Icon(Icons.looks_one)),
                ButtonSegment(value: 1, label: Text('B'), icon: Icon(Icons.looks_two)),
                ButtonSegment(value: 2, label: Text('C'), icon: Icon(Icons.looks_3)),
              ],
              selected: {_seg},
              onSelectionChanged: (v) => setState(() => _seg = v.first),
            ),
            const SizedBox(height: 20),

            const Text('8 - AlertDialog', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ElevatedButton(onPressed: _showAlert, child: const Text('Mostrar Alerta')),
            const SizedBox(height: 20),

            const Text('9 - Checkbox', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Row(
              children: [
                Checkbox(value: _chk, onChanged: (v) => setState(() => _chk = v!)),
                const Text('Aceito os termos'),
              ],
            ),
            const SizedBox(height: 20),

            const Text('10 - Radio', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Row(
              children: [
                Radio<String>(value: 'A', groupValue: _radio, onChanged: (v) => setState(() => _radio = v!)),
                const Text('A'),
                const SizedBox(width: 12),
                Radio<String>(value: 'B', groupValue: _radio, onChanged: (v) => setState(() => _radio = v!)),
                const Text('B'),
              ],
            ),
            const SizedBox(height: 20),

            const Text('11 - Slider', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Slider(
              value: _slider,
              min: 0,
              max: 100,
              divisions: 10,
              label: _slider.round().toString(),
              onChanged: (v) => setState(() => _slider = v),
            ),
            const SizedBox(height: 20),

            const Text('12 - TextField', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Digite algo...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
              onChanged: (v) => setState(() => _txt = v),
            ),
            const SizedBox(height: 8),
            Text('Você digitou: $_txt'),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}