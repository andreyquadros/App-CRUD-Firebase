import 'package:flutter/material.dart';

import '../AppRoutes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Página Inicial',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
                onTap: () {
                  //DatabaseOperations().logoutEmailPass();
                  // Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
                },
                child: Icon(Icons.logout)),
          ),
        ],
        elevation: 5,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        // GridView.builder cria uma grade de itens
        child: GridView.builder(
          padding: EdgeInsets.all(20),
          // Define o número de colunas
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          // Define a quantidade de itens
          itemCount: 7,
          itemBuilder: (context, index) {
            // Lista de ícones
            List<IconData> icons = [
              Icons.person_add, // Cadastrar Pessoa
              Icons.add_shopping_cart, // Cadastrar Produto
              Icons.account_balance, // Cadastrar Fornecedor
              Icons.list_alt, // Listar Pessoas
              Icons.line_style_rounded, // Listar Produtos
              Icons.featured_play_list_outlined, // Listar Fornecedor
              Icons.support_outlined
            ];

            // Lista de títulos
            List<String> titles = [
              'Cadastrar Pessoa',
              'Cadastrar Produto',
              'Cadastrar Fornecedor',
              'Listar Pessoa',
              'Listar Produto',
              'Listar Fornecedor',
              'Suporte'
            ];
            // Retorna um GestureDetector para cada item da grade
            return GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, AppRoutes.registerPersonPage);
                    break;
                  //
                  // case 1: Navigator.pushNamed(context, AppRoutes.registerProductPage);
                  // break;
                  //
                  // case 2: Navigator.pushNamed(context, AppRoutes.registerSupplierPage);
                  // break;
                  //
                  case 3:
                    Navigator.pushNamed(context, AppRoutes.listPersonPage);
                    break;
                  //
                  // case 4: Navigator.pushNamed(context, AppRoutes.listProductsPage);
                  // break;
                  //
                  // case 5: Navigator.pushNamed(context, AppRoutes.listSupplierPage);
                  // break;

                  case 6:
                    Navigator.pushNamed(context, AppRoutes.websitePage);
                    break;
                }
                ;
                // Aqui você pode adicionar a navegação para cada página
                // Exemplo: Navigator.push(context, MaterialPageRoute(builder: (context) => SuaPaginaDeCadastro()));
                print('Navegando para ${titles[index]}');
              },
              child: Card(
                color: Colors.blueAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      icons[index],
                      size: 80,
                      color: Colors.white,
                    ),
                    Text(
                      titles[index],
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
