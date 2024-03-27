import 'package:flutter/material.dart';

void main() {
  runApp(BlackjackApp());
}

class BlackjackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blackjack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlackjackScreen(),
    );
  }
}

class BlackjackScreen extends StatefulWidget {
  @override
  _BlackjackScreenState createState() => _BlackjackScreenState();
}

class _BlackjackScreenState extends State<BlackjackScreen> {
  List<String> deck = [];
  List<String> maoJogador = [];
  List<String> maoDealer = [];
  int pontuacaoJogador = 0;
  int pontuacaoDealer = 0;
  bool fimDeJogo = false;
  bool mostrarCartaDealer = false;

  @override
  void initState() {
    super.initState();
    inicializarBaralho();
    iniciarJogo();
  }

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
    deck.shuffle();
  }

  void iniciarJogo() {
    maoJogador = [];
    maoDealer = [];
    pontuacaoJogador = 0;
    pontuacaoDealer = 0;
    fimDeJogo = false;
    mostrarCartaDealer = false;

    for (var i = 0; i < 2; i++) {
      maoJogador.add(deck.removeAt(0));
      maoDealer.add(deck.removeAt(0));
    }
    atualizarPontuacoes();
  }

  void atualizarPontuacoes() {
    pontuacaoJogador = calcularPontuacao(maoJogador);
    pontuacaoDealer = calcularPontuacao(maoDealer);
    if (pontuacaoJogador > 21 || pontuacaoDealer > 21) {
      setState(() {
        fimDeJogo = true;
        mostrarCartaDealer = true;
      });
    }
  }

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
    while (pontuacao > 21 && ases > 0) {
      pontuacao -= 10;
      ases -= 1;
    }
    return pontuacao;
  }

  void pedirCarta() {
    maoJogador.add(deck.removeAt(0));
    atualizarPontuacoes();
  }

  void parar() {
    setState(() {
      mostrarCartaDealer = true;
    });
    while (pontuacaoDealer < 17) {
      maoDealer.add(deck.removeAt(0));
      atualizarPontuacoes();
    }
    setState(() {
      fimDeJogo = true;
    });
  }

  void novoJogo() {
    setState(() {
      iniciarJogo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blackjack'),
      ),
      backgroundColor: Colors.green[900], // Definindo o fundo verde escuro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Mão do Dealer:', style: TextStyle(color: Colors.white)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  CardWidget(carta: maoDealer[0]),
                SizedBox(width: 5),
                if (mostrarCartaDealer)
                  for (var i = 1; i < maoDealer.length; i++) ...[
                    CardWidget(carta: maoDealer[i]),
                    SizedBox(width: 5),
                  ],
              ],
            ),
            SizedBox(height: 20),
            Text(
                'Pontuação do Dealer: ${mostrarCartaDealer ? pontuacaoDealer : '?'}'),
            SizedBox(height: 40),
            Text('Sua mão: ${maoJogador.join(', ')}'),
            SizedBox(height: 20),
            Text('Sua pontuação: $pontuacaoJogador'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var carta in maoJogador) ...[
                  SizedBox(width: 5),
                  CardWidget(carta: carta),
                ],
              ],
            ),
            SizedBox(height: 20),
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
            if (fimDeJogo)
              Column(
                children: [
                  Text(
                    'Fim de Jogo! ${pontuacaoJogador > 21 || (pontuacaoDealer <= 21 && pontuacaoDealer > pontuacaoJogador) ? 'Dealer venceu!' : 'Você venceu!'}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
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
