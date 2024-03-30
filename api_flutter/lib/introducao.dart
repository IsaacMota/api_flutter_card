import 'package:flutter/material.dart';

class InstrucaoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instruções do Blackjack'),
      ),
      backgroundColor: Color.fromARGB(255, 45, 6, 63),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Introdução ao Jogo:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 215, 166, 255),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Bem-vindo ao Blackjack! Este é um jogo clássico de cartas, também conhecido como 21, onde o objetivo é obter uma mão com um valor o mais próximo possível de 21 sem ultrapassá-lo. Você estará competindo contra o dealer, conhecido como Gambit. Prepare-se para desafiar suas habilidades de estratégia e sorte enquanto tenta vencer o Gambit e acumular vitórias!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            _buildTopic(
              '1. Objetivo do Jogo:',
              'O objetivo do Blackjack é obter uma mão com um valor total mais próximo possível de 21, sem ultrapassar esse valor. Se sua mão ultrapassar 21, você perde automaticamente.',
            ),
            SizedBox(height: 10),
            _buildTopic(
              '2. Cartas e Valores:',
              'As cartas numéricas (2 a 10) têm o valor de face.\n'
                  'As cartas de figura (Valete, Rainha, Rei) têm o valor de 10.\n'
                  'O Ás pode valer 1 ou 11, dependendo da sua escolha e da situação do jogo.',
            ),
            SizedBox(height: 10),
            _buildTopic(
              '3. Início do Jogo:',
              'Cada jogador, incluindo você e o Gambit, recebe duas cartas.\n'
                  'Você pode virar suas duas cartas para revelar sua pontuação.\n'
                  'O Gambit jogará em seguida após seus decisões.',
            ),
            SizedBox(height: 10),
            _buildTopic(
              '4. Ação do Jogador:',
              'Você tem duas opções principais:\n'
                  'Pedir: Solicite uma carta adicional para tentar melhorar sua mão. Você pode pedir quantas cartas quiser, mas cuidado para não ultrapassar 21.\n'
                  'Parar: Decida que sua mão atual é forte o suficiente e não quer mais cartas.',
            ),
            SizedBox(height: 10),
            _buildTopic(
              '5. Ação do Gambit:',
              'Depois que você decidir parar, o Gambit revelará sua segunda carta e tomará suas próprias decisões com base nas regras do jogo.\n'
                  'O Gambit sempre pedirá cartas até que sua pontuação seja melhor no jogo.',
            ),
            SizedBox(height: 10),
            _buildTopic(
              '6. Vitória e Derrota:',
              'Se sua pontuação for mais próxima de 21 do que a do Gambit e não ultrapassar 21, você vence.\n'
                  'Se sua pontuação ultrapassar 21 ou a do Gambit for mais próxima de 21 do que a sua, você perde.',
            ),
            SizedBox(height: 10),
            _buildTopic(
              '7. Novo Jogo:',
              'Após cada rodada, você terá a opção de iniciar um novo jogo para desafiar novamente o Gambit.',
            ),
            SizedBox(height: 20),
            Text(
              'Prepare-se para mergulhar nesta emocionante partida de Blackjack e teste suas habilidades contra o Gambit! Boa sorte!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(221, 255, 100, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopic(String title, String content) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 229, 124, 255),
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(251, 255, 255, 255),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
