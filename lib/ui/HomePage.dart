import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class HomePage extends StatefulWidget {
    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    final nomeController = TextEditingController();
    final raController = TextEditingController();
    final mensagemController = TextEditingController();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            drawer: Drawer(
                child: ListView(
                    children: <Widget>[
                        DrawerHeader(
                            child: Text("Prova 2", style: TextStyle(fontSize: 30, color: Colors.white),),
                            decoration: BoxDecoration(color: Colors.black),
                        ),
                        ListTile(title:verificar()),
                        ListTile(title: criarBotaoEnviar(),)
                    ],
                ),
            ),
            appBar: AppBar(
                backgroundColor: Colors.black,
                centerTitle: true,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Icon(Icons.mail_outline, size: 30,),
                        SizedBox(width: 6,),
                        Text("Prova 2", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
                    ],
                ),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                        criarCampoTexto("Nome: ", TextInputType.text, nomeController),
                        criarCampoTexto("RA: ", TextInputType.emailAddress, raController),
                        criarBotaoEnviar(),
                        SizedBox(height: 10,),
                        verificar()
                    ],
                ),
            ),
        );
    }

    Widget criarCampoTexto(String texto, TextInputType teclado, TextEditingController controller) {
        return Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    labelText: texto,
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.black, fontSize: 16),
                keyboardType: teclado,
            ),
        );
    }

    Widget criarBotaoEnviar() {
        return Container(
            width: 200,
            child: RaisedButton(
                color: Colors.black,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Icon(Icons.send, color: Colors.white, size: 30,),
                            SizedBox(width: 6,),
                            Text("Enviar", style: TextStyle(color: Colors.white, fontSize: 26),),
                        ],
                    ),
                ),
                onPressed: enviarEmail,
            ),
        );
    }

    Widget verificar() {
        return Container(
            width: 200,
            child: RaisedButton(
                color: Colors.black,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Icon(Icons.send, color: Colors.white, size: 30,),
                            SizedBox(width: 6,),
                            Text("Verificar", style: TextStyle(color: Colors.white, fontSize: 26),),
                        ],
                    ),
                ),
                onPressed: verificarLogin,
            ),
        );
    }

    void verificarLogin() {
        if(nomeController.text == "Rômulo"  && raController.text == "9138")
        {
            showMensagem("Ateção", "Logado");
            return;
        } else {
            showMensagem("Atenção", "Usuario ou RA errado");
        }
    }

    void enviarEmail() async {
        if (nomeController.text.isEmpty) {
            showMensagem("Atenção", "Digite o seu nome!");
            return;
        }
        if (raController.text.isEmpty) {
            showMensagem("Atenção", "Digite seu RA");
            return;
        }

        String usuario = "romuloevil@gmail.com";
        String senha = "jjar134679159";

        final smtpServer = gmail(usuario, senha);

        final email = new Message()
            ..from = new Address(usuario, usuario)
            ..recipients.add(usuario)
            ..subject = "Contato do App Flutter"
            ..text = "Nome: ${nomeController.text}. RA: ${raController.text}";

        final sendEmail = await send(email, smtpServer);
    }

    void showMensagem(String titulo, String texto) {
        showDialog(
            context: context,
            builder: (context) {
                return AlertDialog(
                    title: Text(titulo, style: TextStyle(color: Colors.black, fontSize: 22),),
                    content: Text(texto, style: TextStyle(fontSize: 18),),
                    actions: <Widget>[
                        FlatButton(
                            child: Text("OK", style: TextStyle(color: Colors.black, fontSize: 22),),
                            onPressed: () {
                                Navigator.pop(context);
                            },
                        ),
                    ],
                );
            }
        );
    }
}