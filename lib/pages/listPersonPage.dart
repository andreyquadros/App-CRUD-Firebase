import 'package:basic_operations_firebase/database/DatabaseOperations.dart';
import 'package:flutter/material.dart';

class ListPersonPage extends StatefulWidget {
  const ListPersonPage({Key? key}) : super(key: key);

  @override
  State<ListPersonPage> createState() => _ListPersonPageState();
}

class _ListPersonPageState extends State<ListPersonPage> {
  List<String> pessoas = [];

  Future<void> buscarNomes() async {
    List<String>? listagemAuxiliarPessoas = [];
    listagemAuxiliarPessoas =
    await DatabaseOperationsFirebase().listPersonsFirebase();
    setState(() {
      pessoas = listagemAuxiliarPessoas!;
    });
  }

  void _showEditNameDialog(String nomeAtual, int index) {
    TextEditingController _nomeController = TextEditingController(text: nomeAtual);
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          height: 200, // Define a altura do Dialog
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Editar Nome'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent
                ),
                child: Text('Salvar', style: TextStyle(color: Colors.white),),
                onPressed: () {
                  setState(() {
                    pessoas[index] = _nomeController.text;
                    DatabaseOperationsFirebase().updatePersonNameFirebase(nomeAtual, _nomeController.text);
                  });

                  Navigator.pop(context); // Fecha o Dialog
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> excluirNome(String nome) async {
    await DatabaseOperationsFirebase().deletePersonFirebase(nome);
    setState(() {
      pessoas.removeWhere((pessoa) => pessoa == nome);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarNomes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Listar Pessoas',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 5,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: pessoas.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blueAccent,
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: GestureDetector(
                onTap: () {
                  _showEditNameDialog(pessoas[index], index);
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.tealAccent,
                ),
              ),
              trailing: GestureDetector(
                  onTap: () {
                    excluirNome(pessoas[index]);
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  )),
              title: Text(
                pessoas[index],
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          );
        },
      ),
    );
  }
}