import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseOperationsFirebase {
  final db = FirebaseFirestore.instance;

  void createNewPersonFirebase(String nome, String email, String CPF,
      String data_nascimento, String telefone) {
    // Create a new user with a first and last name
    final person = <String, dynamic>{
      "nome": "$nome",
      "email": "$email",
      "CPF": "$CPF",
      "data_nascimento": "$data_nascimento",
      "telefone": "$telefone"
    };
// Add a new document with a generated ID
    db.collection("persons").add(person).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  Future<List<String>> listPersonsFirebase() async {
    List<String> nomes = [];
    await db.collection("persons").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
        nomes.add(doc.data()['nome']);
      }
    });
    return nomes;
  }

  deletePersonFirebase(String nome) async {
      // Referência à coleção 'Pessoas'
      var collection = FirebaseFirestore.instance.collection('persons');
      // Busca os documentos onde o campo 'nome' é igual ao nome fornecido
      var snapshot = await collection.where('nome', isEqualTo: nome).get();
      // Para cada documento encontrado, exclui o documento
      for (var doc in snapshot.docs) {
        print(doc.data());
        await collection.doc(doc.id).delete();
      }
  }

  Future<void> updatePersonNameFirebase(String oldName, String newName) async {
    // Referência à coleção 'Pessoas'
    var collection = FirebaseFirestore.instance.collection('persons');

    // Busca os documentos onde o campo 'nome' é igual ao oldName
    var snapshot = await collection.where('nome', isEqualTo: oldName).get();

    // Para cada documento encontrado, atualiza o campo 'nome' para newName
    for (var doc in snapshot.docs) {
      await collection.doc(doc.id).update({'nome': newName});
    }
  }

}
