import 'package:flutter/material.dart';
import 'package:tabbar/PrimeiraPagina.dart';
import 'package:tabbar/SegundaPagina.dart';
import 'package:tabbar/TerceiraPagina.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  //Criar uma tabController
  late TabController _tabController;

  //Precisa iniciar a tabController
  @override
  void initState() {
    super.initState();

    _tabController = TabController(
        length: 3,
        vsync: this,
        initialIndex: 0,
    );

  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Abas"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              // text: "Home",
              icon: Icon(Icons.home),
            ),
            Tab(
              // text: "Email",
              icon: Icon(Icons.email),
            ),
            Tab(
              // text: "Conta",
                icon: Icon(Icons.account_circle)
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PrimeiraPagina(),
          SegundaPagina(),
          TerceiraPagina()
        ],
      ),
    );
  }
}
