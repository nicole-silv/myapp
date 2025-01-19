import 'package:flutter/material.dart';

void main() {
  runApp(const MeuAplicativo());
}

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFFFFC0CB,
          {
            50: Color(0xFFFFC0CB),
            100: Color(0xFFFFB3B3),
            200: Color(0xFFFF9999),
            300: Color(0xFFFF8080),
            400: Color(0xFFFF6666),
            500: Color(0xFFFF4D4D),
            600: Color(0xFFFF3333),
            700: Color(0xFFFF1A1A),
            800: Color(0xFFFF0000),
            900: Color(0xFFE60000),
          },
        ),
      ),
      home: const PrimeiraPagina(),
    );
  }
}

class PrimeiraPagina extends StatelessWidget {
  const PrimeiraPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Layout Superior
          Container(
            width: double.infinity,
            color: Colors.pink[100],
            padding: const EdgeInsets.all(12),
            child: const Text(
              'Calculadora Compacta',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          // Conteúdo principal (Calculadora)
          const Expanded(
            child: Calculadora(),
          ),
          // Layout Inferior
          Container(
            width: double.infinity,
            color: Colors.pink[200],
            padding: const EdgeInsets.all(12),
            child: const Text(
              'Layout Inferior',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _resultado = '0';
  String _entrada = '';
  String _operacao = '';
  double _primeiroNumero = 0;

  void _pressionarBotao(String valor) {
    setState(() {
      if (double.tryParse(valor) != null || valor == '.') {
        _entrada += valor;
        _resultado = _entrada;
      } else if (valor == 'C') {
        _resultado = '0';
        _entrada = '';
        _operacao = '';
        _primeiroNumero = 0;
      } else if (['+', '-', '*', '/'].contains(valor)) {
        _primeiroNumero = double.tryParse(_entrada) ?? 0;
        _entrada = '';
        _operacao = valor;
        _resultado = '$_primeiroNumero ${valor == '/' ? '÷' : valor}';
      } else if (valor == '=') {
        double segundoNumero = double.tryParse(_entrada) ?? 0;
        switch (_operacao) {
          case '+':
            _resultado = (_primeiroNumero + segundoNumero).toString();
            break;
          case '-':
            _resultado = (_primeiroNumero - segundoNumero).toString();
            break;
          case '*':
            _resultado = (_primeiroNumero * segundoNumero).toString();
            break;
          case '/':
            _resultado = segundoNumero == 0
                ? 'Erro'
                : (_primeiroNumero / segundoNumero).toString();
            break;
          default:
            _resultado = 'Erro';
        }
        _entrada = '';
        _operacao = '';
        _primeiroNumero = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Display da calculadora
          Container(
            alignment: Alignment.centerRight,
            color: Colors.pink[50],
            padding: const EdgeInsets.all(12),
            child: Text(
              _resultado,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          // Botões da calculadora
          Column(
            children: [
              _buildLinhaBotoes(['7', '8', '9', '÷']),
              _buildLinhaBotoes(['4', '5', '6', '*']),
              _buildLinhaBotoes(['1', '2', '3', '-']),
              _buildLinhaBotoes(['C', '0', '=', '+']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLinhaBotoes(List<String> valores) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: valores.map((valor) {
        return ElevatedButton(
          onPressed: () => _pressionarBotao(valor == '÷' ? '/' : valor),
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(60, 60),
            backgroundColor: Colors.pink[300],
          ),
          child: Text(
            valor,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }
}
