import 'package:flutter/material.dart';
import 'introducao.dart'; // Importe o arquivo introducao.dart

class HomePage extends StatelessWidget {
  final Function() onStartGame;
  final Function() onReadRules;

  const HomePage({
    required this.onStartGame,
    required this.onReadRules,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blackjack'),
      ),
      backgroundColor: Color.fromARGB(255, 45, 6, 63),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onStartGame,
              child: Text('Iniciar Jogo'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar para a página de introdução ao jogo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InstrucaoPage()),
                );
              },
              child: Text('Ler Regras'),
            ),
          ],
        ),
      ),
    );
  }
}
