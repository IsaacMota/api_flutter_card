import 'package:api_flutter/home.dart';
import 'package:flutter/material.dart';
import 'tabela.dart';

void main() {
  runApp(BlackjackApp());
}

// Classe principal da aplicação
class BlackjackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blackjack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(), // Define a tela inicial como MainScreen
    );
  }
}

// Tela principal
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage(
      onStartGame: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  BlackjackScreen()), // Navega para a tela do jogo quando o jogo é iniciado
        );
      },
      onReadRules: () {
        // Navegar para a página de leitura de regras, se desejar
      },
    );
  }
}

// Tela do jogo de Blackjack
class BlackjackScreen extends StatefulWidget {
  @override
  _BlackjackScreenState createState() => _BlackjackScreenState();
}

class _BlackjackScreenState extends State<BlackjackScreen> {
  // Declaração de variáveis e estados do jogo
  List<String> deck = [];
  List<String> maoJogador = [];
  List<String> maoGambit = [];
  int pontuacaoJogador = 0;
  int pontuacaoGambit = 0;
  bool fimDeJogo = false;
  bool mostrarCartaGambit = true;
  bool mostrarCartaJogador = false;
  bool mostrarPontuacaoJogador = false;
  int vitoriasJogador = 0;
  int vitoriasGambit = 0;

  @override
  void initState() {
    super.initState();
    inicializarBaralho(); // Inicializa o baralho
    iniciarJogo(); // Inicia o jogo
  }

  // Função para inicializar o baralho
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

  // Função para iniciar o jogo
  void iniciarJogo() {
    maoJogador = [];
    maoGambit = [];
    pontuacaoJogador = 0;
    pontuacaoGambit = 0;
    fimDeJogo = false;
    mostrarCartaGambit = true;
    mostrarCartaJogador = false;
    mostrarPontuacaoJogador = false;
    for (var i = 0; i < 2; i++) {
      maoJogador.add(deck.removeAt(0));
      maoGambit.add(deck.removeAt(0));
    }
    atualizarPontuacoes();
  }

  // Função para calcular a pontuação
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

  // Função para atualizar as pontuações
  void atualizarPontuacoes() {
    pontuacaoJogador = calcularPontuacao(maoJogador);
    pontuacaoGambit = calcularPontuacao(maoGambit);
    if (pontuacaoJogador > 21 || pontuacaoGambit > 21) {
      setState(() {
        fimDeJogo = true;
        mostrarCartaGambit = true;
      });
    }
  }

  // Função para pedir uma carta
  void pedirCarta() {
    setState(() {
      mostrarCartaJogador = true;
      mostrarPontuacaoJogador = true;
      maoJogador.add(deck.removeAt(0));
      atualizarPontuacoes();
    });
  }

  // Função para parar o jogo
  void parar() {
    setState(() {
      mostrarCartaGambit = true;
    });
    while (pontuacaoGambit < 17) {
      maoGambit.add(deck.removeAt(0));
      atualizarPontuacoes();
    }
    setState(() {
      fimDeJogo = true;
      if ((pontuacaoJogador <= 21 && pontuacaoJogador > pontuacaoGambit) ||
          pontuacaoGambit > 21) {
        vitoriasJogador++;
      } else if ((pontuacaoGambit <= 21 &&
              pontuacaoGambit > pontuacaoJogador) ||
          pontuacaoJogador > 21) {
        vitoriasGambit++;
      }
    });
  }

  // Função para iniciar um novo jogo
  void novoJogo() {
    setState(() {
      iniciarJogo();
    });
  }

  // Função para obter o resultado da partida
  String getResultadoPartida() {
    if (pontuacaoJogador > 21 ||
        (pontuacaoGambit <= 21 && pontuacaoGambit > pontuacaoJogador)) {
      return 'GAMBIT VENCEU! :(';
    } else if (pontuacaoGambit > 21 ||
        (pontuacaoJogador <= 21 && pontuacaoJogador > pontuacaoGambit)) {
      return 'VOCÊ VENCEU! :)';
    } else {
      return 'EMPATE';
    }
  }

  // Função para mostrar o diálogo do nickname
  void mostrarDialogoNickname(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(
                  255, 33, 33, 33), // Cor de fundo estilo fliperama
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Insira um Nickname',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _controller,
                  maxLength: 3,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    counterText: '', // Remove o contador de caracteres
                    hintText: 'AAA', // Exemplo de 3 caracteres
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Obtém o nickname inserido
                    String nickname = _controller.text;
                    // Passa para a página da tabela junto com os dados do jogador e do Gambit
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TabelaPage(
                          nickname: nickname,
                          vitoriasJogador: vitoriasJogador,
                          vitoriasGambit: vitoriasGambit,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Confirmar',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 178, 111, 255),
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Estrutura da tela do jogo
      appBar: AppBar(
        title: Text('Blackjack'),
      ),
      backgroundColor: Color.fromARGB(255, 45, 6, 63),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('MÃO DO GAMBIT:',
                style: TextStyle(color: Color.fromARGB(255, 178, 111, 255))),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!mostrarCartaGambit)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        mostrarCartaGambit = true;
                      });
                    },
                    child: CardWidget(carta: 'Verso'),
                  )
                else
                  for (var carta in maoGambit) ...[
                    CardWidget(carta: carta),
                    SizedBox(width: 5),
                  ],
              ],
            ),
            SizedBox(height: 10),
            Text(
              'PONTUAÇÃO DO GAMBIT: ${mostrarCartaGambit ? pontuacaoGambit : '?'}',
              style: TextStyle(color: const Color.fromARGB(255, 178, 111, 255)),
            ),
            SizedBox(height: 40),
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
            SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'SUA PONTUAÇÃO: ${mostrarPontuacaoJogador ? pontuacaoJogador : '?'}',
                    style: TextStyle(color: Color.fromARGB(255, 144, 255, 246)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!mostrarCartaJogador)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            mostrarCartaJogador = true;
                            mostrarPontuacaoJogador = true;
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
                  height: 10,
                ),
                Text(
                  'SUA MÃO:',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 144, 255, 246)),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (!fimDeJogo)
              Column(
                children: [
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
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 177, 47, 38)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      mostrarDialogoNickname(context);
                    },
                    child: Text('Acabar Jogo'),
                  ),
                ],
              ),
            if (fimDeJogo)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: novoJogo,
                    child: Text('Novo Jogo'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Suas Vitórias: $vitoriasJogador',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 144, 255, 246)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Vitórias do Gambit: $vitoriasGambit',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 178, 111, 255)),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// Widget para exibir as cartas
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
