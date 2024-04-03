import 'package:flutter/material.dart';
import 'introducao.dart'; // Importe o arquivo introducao.dart

// Classe responsável por construir a página inicial do aplicativo
class HomePage extends StatelessWidget {
  final Function() onStartGame; // Função chamada ao iniciar o jogo
  final Function() onReadRules; // Função chamada ao ler as regras

  // Construtor da classe HomePage, recebendo duas funções como parâmetros obrigatórios
  const HomePage({
    required this.onStartGame,
    required this.onReadRules,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold é um layout básico de uma página
      appBar: AppBar(
        // Barra de aplicativo
        title: Text('Blackjack'), // Título da barra de aplicativo
      ),
      backgroundColor: Color.fromARGB(255, 45, 6, 63), // Cor de fundo da página
      body: Center(
        // Conteúdo centralizado na página
        child: Column(
          // Widget de coluna para organizar os elementos verticalmente
          mainAxisAlignment: MainAxisAlignment
              .center, // Alinhamento principal no centro vertical
          children: [
            // Lista de widgets filhos da coluna
            ElevatedButton(
              // Botão elevado (com estilo) para iniciar o jogo
              onPressed:
                  onStartGame, // Função a ser chamada ao pressionar o botão
              child: Text('Iniciar Jogo'), // Texto exibido no botão
            ),
            SizedBox(height: 20), // Espaçamento vertical entre os botões
            ElevatedButton(
              // Botão elevado para ler as regras
              onPressed: () {
                // Função anônima para navegar para a página de instruções ao pressionar o botão
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          InstrucaoPage()), // Navegação para a página de instruções
                );
              },
              child: Text('Ler Regras'), // Texto exibido no botão
            ),
          ],
        ),
      ),
    );
  }
}
