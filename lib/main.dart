import 'package:flutter/material.dart';
import 'package:flutter_dapp_demo/contract_linking.dart';
import 'package:flutter_dapp_demo/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContractLinking>(
      create: (BuildContext context) {
        return ContractLinking();
      },
      child: MaterialApp(
        title: 'Flutter DApp',
        theme: ThemeData(),
        home: const HomePage(),
      ),
    );
  }
}
