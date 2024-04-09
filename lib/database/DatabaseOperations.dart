import 'package:basic_operations_firebase/AppRoutes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  Future<void> createNewUserFirebase(
      context, String email, String senha) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      if(credential != null){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
            Text('Conta Criada com Sucesso!')));
        Navigator.pushReplacementNamed(context, AppRoutes.homePage);
      }
    } on FirebaseAuthException catch (e) {
      print('O código é: ');
      print(e.code);
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'A senha é inferior a 8 digitos! Crie uma senha mais forte!')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Já existe uma conta com esse e-mail')));
      } else if (e.code == 'channel-error') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Campo Senha ou e-mail vazios, por favor preencha!')));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithEmailAndPassword(
      context, String email, String senha) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: senha);
    } on FirebaseAuthException catch (e) {
      print('O código é: ');
      print(e.code);
      if (e.code == 'user-not-found') {
        print('Nenhum usuário encontrado para esse e-mail');
      } else if (e.code == 'wrong-password') {
        print('Senha incorreta!.');
      } else if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Credencial Inválida ou senha inferior a 8 digitos!')));
      } else if (e.code == 'channel-error') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Campo Senha ou e-mail vazios, por favor preencha!')));
      }
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }
}
