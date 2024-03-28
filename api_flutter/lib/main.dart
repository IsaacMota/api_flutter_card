import 'package:flutter/material.dart';

void main() {
  runApp(BlackjackApp());
}

// Classe principal do aplicativo, responsável por iniciar o jogo
class BlackjackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blackjack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlackjackScreen(), // Define a tela inicial como BlackjackScreen
    );
  }
}

// Tela principal do jogo Blackjack
class BlackjackScreen extends StatefulWidget {
  @override
  _BlackjackScreenState createState() => _BlackjackScreenState();
}

class _BlackjackScreenState extends State<BlackjackScreen> {
  List<String> deck = []; // Baralho
  List<String> maoJogador = []; // Mão do jogador
  List<String> maoDealer = []; // Mão do dealer
  int pontuacaoJogador = 0; // Pontuação do jogador
  int pontuacaoDealer = 0; // Pontuação do dealer
  bool fimDeJogo = false; // Flag indicando o fim do jogo
  bool mostrarCartaDealer = true; // Flag para mostrar a carta do dealer
  bool mostrarCartaJogador = false; // Flag para mostrar a carta do jogador

  @override
  void initState() {
    super.initState();
    inicializarBaralho(); // Inicializa o baralho
    iniciarJogo(); // Inicia o jogo
  }

  // Inicializa o baralho com todas as cartas e embaralha
  void inicializarBaralho() {
    deck = [];
    for (var naipe in ['Copas', 'Ouros', 'Paus', 'Espadas']) {
      for (var valor in [
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        'J',
        'Q',
        'K',
        'A'
      ]) {
        deck.add('$valor de $naipe');
      }
    }
    deck.shuffle(); // Embaralha o baralho
  }

  // Inicia o jogo, distribuindo duas cartas para o jogador e duas para o dealer
  void iniciarJogo() {
    maoJogador = [];
    maoDealer = [];
    pontuacaoJogador = 0;
    pontuacaoDealer = 0;
    fimDeJogo = false;
    mostrarCartaDealer = true;
    mostrarCartaJogador = false;
    for (var i = 0; i < 2; i++) {
      maoJogador.add(deck.removeAt(0)); // Remove e adiciona carta ao jogador
      maoDealer.add(deck.removeAt(0)); // Remove e adiciona carta ao dealer
    }
    atualizarPontuacoes(); // Atualiza as pontuações após a distribuição inicial
  }

  // Atualiza as pontuações do jogador e do dealer
  void atualizarPontuacoes() {
    pontuacaoJogador = calcularPontuacao(maoJogador);
    pontuacaoDealer = calcularPontuacao(maoDealer);
    // Verifica se algum jogador ultrapassou 21 pontos
    if (pontuacaoJogador > 21 || pontuacaoDealer > 21) {
      setState(() {
        fimDeJogo = true;
        mostrarCartaDealer = true; // Mostra a carta do dealer
      });
    }
  }

  // Calcula a pontuação de uma mão de cartas
  int calcularPontuacao(List<String> mao) {
    var pontuacao = 0;
    var ases = 0;
    for (var carta in mao) {
      var valor = carta.split(' ')[0];
      if (valor == 'J' || valor == 'Q' || valor == 'K') {
        pontuacao += 10;
      } else if (valor == 'A') {
        pontuacao += 11;
        ases += 1;
      } else {
        pontuacao += int.parse(valor);
      }
    }
    // Trata o valor dos Ases para evitar estouro da pontuação
    while (pontuacao > 21 && ases > 0) {
      pontuacao -= 10;
      ases -= 1;
    }
    return pontuacao;
  }

  // Função para o jogador pedir uma nova carta
  void pedirCarta() {
    setState(() {
      mostrarCartaJogador = true; // Revela a carta do jogador
      maoJogador.add(deck.removeAt(0)); // Adiciona uma carta ao jogador
      atualizarPontuacoes(); // Atualiza as pontuações
    });
  }

  // Função para o jogador parar de pedir cartas
  void parar() {
    setState(() {
      mostrarCartaDealer = true; // Mostra a carta do dealer
    });
    // Dealer pede cartas até atingir pelo menos 17 pontos
    while (pontuacaoDealer < 17) {
      maoDealer.add(deck.removeAt(0)); // Adiciona uma carta ao dealer
      atualizarPontuacoes(); // Atualiza as pontuações
    }
    setState(() {
      fimDeJogo = true; // Marca o fim do jogo
    });
  }

  // Reinicia o jogo
  void novoJogo() {
    setState(() {
      iniciarJogo(); // Reinicia o jogo
    });
  }

  // Função para calcular o resultado da partida
  String getResultadoPartida() {
    if (pontuacaoJogador > 21 ||
        (pontuacaoDealer <= 21 && pontuacaoDealer > pontuacaoJogador)) {
      return 'DEALER VENCEU! :(';
    } else if (pontuacaoDealer > 21 ||
        (pontuacaoJogador <= 21 && pontuacaoJogador > pontuacaoDealer)) {
      return 'VOCÊ VENCEU! :)';
    } else {
      return 'EMPATE';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blackjack'),
      ),
      backgroundColor: Colors.green[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Título da mão do dealer
            Text('MÃO DO DEALER:', style: TextStyle(color: Colors.white)),
            SizedBox(height: 10),
// Cartas do dealer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lógica para mostrar a carta ou o verso
                if (!mostrarCartaDealer)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        mostrarCartaDealer = true;
                      });
                    },
                    child: CardWidget(carta: 'Verso'),
                  )
                else
                  for (var carta in maoDealer) ...[
                    CardWidget(carta: carta),
                    SizedBox(width: 5),
                  ],
              ],
            ),
            SizedBox(height: 10),
// Pontuação do dealer abaixo das cartas do dealer
            Text(
                'PONTUAÇÃO DO DEALER: ${mostrarCartaDealer ? pontuacaoDealer : '?'}',
                style: TextStyle(color: Colors.white)),
            SizedBox(height: 40),
            // Mensagem de fim de jogo
            if (fimDeJogo)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Center(
                  child: Text(
                    '${getResultadoPartida()}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

            SizedBox(height: 40), // Adiciona um pequeno espaçamento vertical

// Mão do jogador
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Pontuação do jogador acima das cartas
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 10), // Adiciona espaço apenas na parte inferior
                  child: Text(
                    'SUA PONTUAÇÃO: ${mostrarCartaDealer ? pontuacaoJogador : '?'}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                // Cartas do jogador
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Lógica para mostrar a carta ou o verso
                    if (!mostrarCartaJogador)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            mostrarCartaJogador = true;
                          });
                        },
                        child: CardWidget(carta: 'Verso'),
                      )
                    else
                      for (var carta in maoJogador) ...[
                        CardWidget(carta: carta),
                        SizedBox(width: 5),
                      ],
                  ],
                ),
                SizedBox(
                  height:
                      10, // Adiciona um espaço entre as cartas e o texto "Mão do jogador"
                ),
                // Texto "Mão do jogador"
                Text(
                  'MÃO DO JOGADOR:',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Botões de ação
            if (!fimDeJogo)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: pedirCarta,
                    child: Text('Pedir'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: parar,
                    child: Text('Parar'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ],
              ),
            // Botão para novo jogo após o fim da partida
            if (fimDeJogo)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: novoJogo,
                    child: Text('Novo Jogo'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// Widget para exibir uma carta
class CardWidget extends StatelessWidget {
  final String carta;

  const CardWidget({
    required this.carta,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          carta,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
