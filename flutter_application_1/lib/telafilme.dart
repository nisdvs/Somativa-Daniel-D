import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class FilmesScreen extends StatefulWidget {
  const FilmesScreen({Key? key}) : super(key: key);

  @override
  State<FilmesScreen> createState() => _FilmesScreenState();
}

class _FilmesScreenState extends State<FilmesScreen> {
  late Future<List<Filmes>> futureFilmes;

  @override
  void initState() {
    super.initState();
    futureFilmes = fetchFilmes();
  }

  Future<List<Filmes>> fetchFilmes() async {
    final response = await http.get(Uri.parse('https://raw.githubusercontent.com/danielvieira95/DESM-2/master/filmes.json'));
    if (response.statusCode == 200) {
      final List<dynamic> parsed = jsonDecode(response.body);
      return parsed.map((json) => Filmes.fromJson(json)).toList();
    } else {
      print(response.statusCode);
      throw Exception('Falha ao consumir a API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "FILMES - EM CARTAZ",
        style: TextStyle(color: Colors.red),
      ),
      backgroundColor: Colors.black,
      ),
      body: Center(
        child: FutureBuilder<List<Filmes>>(
          future: futureFilmes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return FilmesListItem(filmes: snapshot.data![index]);
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class Filmes {
  final String nome;
  final String imagem;
  final String duracao;
  final String ano;
  final String nota;

  Filmes({
    required this.nome,
    required this.imagem,
    required this.duracao,
    required this.ano,
    required this.nota
  });

  factory Filmes.fromJson(Map<String, dynamic> json) {
    return Filmes(
      nome: json['nome'],
      imagem: json['imagem'],
      duracao: json['duração'].toString(),
      ano: json['ano de lançamento'].toString(),
      nota: json['nota'].toString(),
    );
  }
}

class FilmesListItem extends StatelessWidget {
  final Filmes filmes;

  const FilmesListItem({Key? key, required this.filmes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(filmes.imagem),
      ),
      title: Text(
        filmes.nome,
        style: TextStyle(color: Colors.red),
      ),
      subtitle: Text(
        "Duração: ${filmes.duracao}\n"
        "Ano de Lançamento: ${filmes.ano}\n"
        "Nota: ${filmes.nota}",
        style: TextStyle(color: Colors.red), 
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                filmes.nome,
                style: TextStyle(color: Colors.red), 
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Image.network(filmes.imagem),
                    Text(
                      'Duração: ${filmes.duracao}',
                      style: TextStyle(color: Colors.red), 
                    ),
                    Text(
                      'Ano de Lançamento: ${filmes.ano}',
                      style: TextStyle(color: Colors.red), 
                    ),
                    Text(
                      'Nota: ${filmes.nota}',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Fechar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

