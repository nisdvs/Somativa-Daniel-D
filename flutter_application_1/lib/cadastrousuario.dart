import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'dart:convert'; 
class cadastrousuario extends StatefulWidget {
  

  @override
  State<cadastrousuario> createState() => _CadastrousuarioState();
}

class _CadastrousuarioState extends State<cadastrousuario> {
  TextEditingController nome_n= TextEditingController();
  TextEditingController senha_n = TextEditingController();
  bool exibir = false;
  _cadastrarusuario(){
    Map<String,dynamic> users={
      "nome": nome_n.text,
      "senha": senha_n.text,
    };
    print(users);
    String url = "http://10.109.83.18:3000/Login";
    http.post(Uri.parse(url),
    headers:<String,String>{
      'Content-type': 'application/json; charset=UTF-8',
    } ,
    body: jsonEncode(users)
    );
    print("Usuario cadastrado");
    nome_n.text ="";
    senha_n.text = "";
    
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
      title: Text(
          "Cadastre",
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.name, 
                      style: TextStyle(color: Colors.white), 
                      decoration: InputDecoration(border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      icon: Icon(Icons.people_alt_outlined),iconColor: Colors.red,
                      hintText: "Digite seu nome",
                      hintStyle: TextStyle(color: Colors.white),
                      
                      ),
                      controller: nome_n,
                      
                        
                        
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      style: TextStyle(color: Colors.white), 
                      decoration: InputDecoration(border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      icon: Icon(Icons.key),iconColor: Colors.red,
                      hintText: "Digite sua senha",
                      hintStyle: TextStyle(color: Colors.white),
                      suffixIcon: IconButton(icon: Icon(exibir? Icons.visibility:Icons.visibility_off,
                       ),onPressed: (){
                        setState(() {
                          exibir =!exibir;
                        });
                      },
                       
                       ),                  
                      ),
                      obscureText: exibir ,
                      obscuringCharacter: "*",
                      controller: senha_n,
                      
                        
                        
                    ),
                  ),
      
                ],
              ),
      
            ),
           ElevatedButton(onPressed: _cadastrarusuario, child: Text("Cadastrar", style: TextStyle(color: Colors.red)),
           ),
          ],
         
        ),
      ),
    );
  }
}