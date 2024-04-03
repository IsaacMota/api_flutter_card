import 'package:flutter/material.dart';

// Definição da classe TabelaPage, que é um StatelessWidget
class TabelaPage extends StatelessWidget {
  final String nickname; // Nome do jogador
  final int vitoriasJogador; // Número de vitórias do jogador
  final int vitoriasGambit; // Número de vitórias do Gambit

  // Construtor da classe TabelaPage
  const TabelaPage({
    required this.nickname,
    required this.vitoriasJogador,
    required this.vitoriasGambit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cálculo do número de derrotas do jogador (assumindo que é igual ao número de vitórias do Gambit)
    int derrotasJogador = vitoriasGambit;

    // Retorno do widget Scaffold, que é a estrutura básica de uma tela no Flutter
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabela'), // Título da AppBar
      ),
      backgroundColor: Color.fromARGB(255, 45, 6, 63), // Cor de fundo da tela
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Espaçamento interno
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Título da tabela
              Text(
                'Tabela de Pontuações',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0), // Espaçamento vertical
              // Tabela de dados
              DataTable(
                columns: [
                  // Coluna para exibir o nickname
                  DataColumn(
                    label: Text(
                      'Nickname',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Coluna para exibir o número de vitórias do jogador
                  DataColumn(
                    label: Text(
                      'Vitórias',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Coluna para exibir o número de derrotas do jogador
                  DataColumn(
                    label: Text(
                      'Derrotas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                rows: [
                  // Linha de dados
                  DataRow(
                    cells: [
                      // Célula com o nickname do jogador
                      DataCell(
                        Text(
                          nickname,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      // Célula com o número de vitórias do jogador
                      DataCell(
                        Text(
                          vitoriasJogador.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      // Célula com o número de derrotas do jogador
                      DataCell(
                        Text(
                          derrotasJogador.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Pode adicionar mais linhas de dados conforme necessário
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
