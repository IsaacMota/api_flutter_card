import 'package:flutter/material.dart';

class TabelaPage extends StatefulWidget {
  final List<String> nomes;
  final List<int> vitorias;

  TabelaPage({required this.nomes, required this.vitorias});

  @override
  _TabelaPageState createState() => _TabelaPageState();
}

class _TabelaPageState extends State<TabelaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabela de Vitórias'),
      ),
      backgroundColor: Color.fromARGB(255, 45, 6, 63),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromARGB(255, 35, 6, 53),
                ),
                child: ListView.builder(
                  itemCount: widget.nomes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        widget.nomes[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PressStart2P',
                          fontSize: 16.0,
                        ),
                      ),
                      subtitle: Text(
                        'Vitórias: ${widget.vitorias[index]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PressStart2P',
                          fontSize: 12.0,
                        ),
                      ),
                      leading: Icon(
                        Icons.videogame_asset,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final nome = await showDialog<String>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Color.fromARGB(255, 45, 6, 63),
                      title: Text(
                        'Digite seu nome',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PressStart2P',
                        ),
                      ),
                      content: TextField(
                        onChanged: (value) {
                          // Você pode adicionar validações ou manipulações aqui se necessário
                        },
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PressStart2P',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PressStart2P',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, 'Nome');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(
                                    255, 45, 6, 63)), // Cor de fundo do botão
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.white), // Cor do texto do botão
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal:
                                            24)), // Preenchimento do botão
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Borda do botão
                                side: BorderSide(
                                    color:
                                        Colors.white), // Cor da borda do botão
                              ),
                            ),
                          ),
                          child: Text(
                            'Salvar',
                            style: TextStyle(
                              fontFamily: 'PressStart2P',
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
                if (nome != null && nome.isNotEmpty) {
                  setState(() {
                    widget.nomes.add(nome);
                    widget.vitorias.add(0); // Inicializa com 0 vitórias
                  });
                }
              },
              child: Text(
                'Adicionar Jogador',
                style: TextStyle(
                  fontFamily: 'PressStart2P',
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
